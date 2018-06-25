import Clibvisionworks


public func vxCreateImageFromHandle(_ context: Context, _ type: ImageType, _ addrs: [vx_imagepatch_addressing_t], _ ptrs: [UnsafeMutableRawPointer?], _ memoryType: MemoryType) -> Image? {
  var vaddrs = addrs
  var vptrs = ptrs
  guard let reference = vxCreateImageFromHandle(context.reference, type.vx_value, &vaddrs, &vptrs, memoryType.vx_value) else {
    return nil
  }
  return Image(reference:reference)
}
