import Clibvisionworks


public func vxCreateImageFromHandle(_ context: Context, _ type: ImageType, _ addrs: [vx_imagepatch_addressing_t], _ ptrs: [UnsafeMutableRawPointer?]?, _ memoryType: MemoryType) -> Image? {
  guard let reference = vxCreateImageFromHandle(context.reference, type.vx_value, addrs, ptrs, memoryType.vx_value) else {
    return nil
  }
  defer { vxReleaseImage(reference) }
  return Image(reference:reference)
}
