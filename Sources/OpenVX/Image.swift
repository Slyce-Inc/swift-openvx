import Clibvisionworks


public class Image: Referenceable, Imageable {
  public typealias Planes = [UnsafeMutableRawPointer?]

  public let reference: vx_image
  private var planes: Planes? = nil

  public init(reference: vx_image) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context: Context, width: Int, height: Int, type: ImageType, memoryType: MemoryType = .None) {
    if type == .Virtual {
      fatalError("OpenVX.Image should never be created with type .Virtual")
    }
    switch memoryType {
      case .None:
        guard let reference = vxCreateImage(context.reference, vx_uint32(width), vx_uint32(height), type.vx_value) else {
          return nil
        }
        self.reference = reference

      case .Host:
        let addrs = type.vx_imagepatch_addressing(width: width, height:height)
        guard let planes = type.allocatePlanes(width:width, height:height) else {
          return nil
        }
        guard let reference = vxCreateImageFromHandle(context.reference, type.vx_value, addrs, planes, memoryType.vx_value) else {
          return nil
        }
        self.planes = planes
        self.reference = reference
    }
  }

  deinit {
    vxReleaseImage(reference)
    if let planes = self.planes {
      free(planes[0])
    }
  }

  public func from(regionOfInterest rectangle: Rectangle) -> Image? {
    var r = rectangle
    guard let reference = vxCreateImageFromROI(self.reference, &r) else {
      return nil
    }
    return Image(reference: reference)
  }

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

private extension ImageType {
  func vx_imagepatch_addressing(width:Int, height:Int) -> [vx_imagepatch_addressing_t] {
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

private extension ImageType {
  func allocatePlanes(width:Int, height:Int) -> Image.Planes? {
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
