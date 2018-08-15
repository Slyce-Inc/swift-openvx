import Clibvisionworks


public class Image: Referenceable, Imageable {
  public typealias Plane = UnsafeMutableRawPointer
  public typealias Planes = [Plane?]
  public typealias PatchAddressing = vx_imagepatch_addressing_t

  public let reference: vx_image
  private var planes: Planes? = nil

  public init(reference: vx_image) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context: Context, width: Int, height: Int, type: ImageType) {
    assert(type != .Virtual, "OpenVX.Image should never be created with type .Virtual")
    guard let reference = vxCreateImage(context.reference, vx_uint32(width), vx_uint32(height), type.vx_value) else {
      return nil
    }
    self.reference = reference
  }

  public init?(context: Context, width: Int, height: Int, type: ImageType, memoryType: MemoryType) {
    assert(type != .Virtual, "OpenVX.Image should never be created with type .Virtual")
    guard let reference = vxCreateImageFromHandle(context.reference, type.vx_value, type.calculateImagePatchAddressing(width:width, height:height), nil, memoryType.vx_value) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    vxReleaseImage(reference)
  }

  public func from(regionOfInterest rectangle: Rectangle) -> Image? {
    var r = rectangle
    guard let reference = vxCreateImageFromROI(self.reference, &r) else {
      return nil
    }
    defer { vxReleaseImage(reference) }
    return Image(reference: reference)
  }

  @discardableResult
  public func swap(planes: Planes) -> Planes? {
    var newPlanes = planes
    var nowPlanes = Planes(repeating: nil, count: planes.count)
    guard VX_SUCCESS == vxSwapImageHandle(self.reference, &newPlanes, &nowPlanes, vx_size(planes.count)) else {
      return nil
    }
    return nowPlanes
  }
}



public extension Image {
  public func accessPatch<T>(plane: Int, accessType: Int32, _ block: (vx_imagepatch_addressing_t, UnsafeMutableRawPointer) -> T) throws -> T {
    var base: UnsafeMutableRawPointer?
    var addr = vx_imagepatch_addressing_t()
    if case let status = vxAccessImagePatch(self.reference, nil, vx_uint32(plane), &addr, &base, accessType), VX_SUCCESS != status {
      throw OpenVXError.unableToAccessImagePatch
    }
    defer { vxCommitImagePatch(self.reference, nil, vx_uint32(plane), &addr, base) }
    let x = block(addr, base!)
    return x
  }
}

public extension Image {
  public class Mapping {
    let image: Image
    let mapId: vx_map_id
    public let memory: Plane?
    public let addressing: PatchAddressing

    init(image:Image, mapId: vx_map_id, memory:Plane?, addressing:PatchAddressing) {
      self.image = image
      self.mapId = mapId
      self.memory = memory
      self.addressing = addressing
    }

    deinit {
      vxUnmapImagePatch(image.reference, mapId)
    }
  }

  public func map(rectangle: Rectangle? = nil, plane:Int, usage:Usage) -> Mapping? {
    var addr = Image.PatchAddressing()
    var ptr: Image.Plane?
    var map_id: vx_map_id = 0
    guard VX_SUCCESS == vxMapImagePatch(self, rectangle, plane, &map_id, &addr, &ptr, usage, .Host, 0) else {
      return nil
    }
    return Mapping(image:self, mapId:map_id, memory:ptr, addressing:addr)
  }
}

extension ImageType {
  public func calculateImagePatchAddressing(width:Int, height:Int) -> [vx_imagepatch_addressing_t] {
    switch self {
      case .U8:
        return [
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width), dim_y: vx_uint32(height), stride_x: 1, stride_y: vx_int32(width), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0)
        ]
      case .NV12:
        return [
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width), dim_y: vx_uint32(height), stride_x: 1, stride_y: vx_int32(width), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0),
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width / 2), dim_y: vx_uint32(height / 2), stride_x: 2, stride_y: vx_int32(width), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0)
        ]
      case .IYUV:
        return [
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width), dim_y: vx_uint32(height), stride_x: 1, stride_y: vx_int32(width), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0),
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width / 2), dim_y: vx_uint32(height / 2), stride_x: 1, stride_y: vx_int32(width / 2), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0),
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width / 2), dim_y: vx_uint32(height / 2), stride_x: 1, stride_y: vx_int32(width / 2), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0)
        ]
      case .RGB:
        return [
          vx_imagepatch_addressing_t(dim_x: vx_uint32(width), dim_y: vx_uint32(height), stride_x: 3, stride_y: vx_int32(width * 3), scale_x: 0, scale_y: 0, step_x: 0, step_y: 0)
        ]
      default:
        preconditionFailure("ImageType (\(self)) is unimplemented")
    }
  }
}

extension ImageType {
  public func allocatePlanes(width:Int, height:Int) -> Image.Planes? {
    switch self {
      case .U8:
        guard let ptr = malloc(width * height) else {
          return nil
        }
        return [ptr]

      case .NV12:
        guard let ptr = malloc((width * height) + (width * (height >> 1))) else {
          return nil
        }
        return [
          ptr,
          ptr + (width * height)
        ]

      case .IYUV:
        guard let ptr = malloc((width * height) * 2) else {
          return nil
        }
        return [
          ptr,
          ptr + (width * height),
          ptr + (width * height) + (width / 2 * height / 2),
        ]

      case .RGB:
        guard let ptr = malloc(width * height * 3) else {
          return nil
        }
        return [ptr]

      default:
        preconditionFailure("ImageType (\(self)) is unimplemented")
    }
  }
}

extension ImageType {
  public var numberOfPlanes:Int {
    switch self {
    case .U8, .RGB:
      return 1
    case .NV12:
      return 2
    case .IYUV:
      return 3
    default:
      fatalError("Unimplemented ImageType")
    }
  }
}
