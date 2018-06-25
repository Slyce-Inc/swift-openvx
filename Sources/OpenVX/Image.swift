import Clibvisionworks


public class Image: Referenceable, Imageable {
  public let reference: vx_image

  public init(reference: vx_image) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context: Context, width: Int, height: Int, type: ImageType) {
    if type == .Virtual {
      return nil
    }
    guard let reference = vxCreateImage(context.reference, vx_uint32(width), vx_uint32(height), type.vx_value) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    vxReleaseImage(reference)
  }

  public func create(fromROI rectangle: Rectangle) -> Image? {
    var r = rectangle
    guard let reference = vxCreateImageFromROI(self.reference, &r) else {
      return nil
    }
    return Image(reference: reference)
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
