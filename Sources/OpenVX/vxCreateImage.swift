import Clibvisionworks


public func vxCreateImage(_ context: Context, _ width: Int, _ height: Int, _ type: ImageType) -> Image? {
  guard let reference = vxCreateImage(context.reference, vx_uint32(width), vx_uint32(height), type.vx_value) else {
    return nil
  }
  defer { vxReleaseImage(reference) }
  return Image(reference:reference)
}
