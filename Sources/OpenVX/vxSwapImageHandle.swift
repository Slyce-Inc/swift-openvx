import Clibvisionworks


public func vxSwapImageHandle(_ image: Image, _ new_ptrs: [UnsafeMutableRawPointer?]?, _ prev_ptrs: inout [UnsafeMutableRawPointer?]?, _ numPlanes: Int) -> vx_status {
  if var new_ptrs = new_ptrs {
    if var prev_ptrs = prev_ptrs {
      return Clibvisionworks.vxSwapImageHandle(image.reference, &new_ptrs, &prev_ptrs, vx_size(numPlanes))
    } else {
      return Clibvisionworks.vxSwapImageHandle(image.reference, &new_ptrs, nil, vx_size(numPlanes))
    }
  } else {
    if var prev_ptrs = prev_ptrs {
      return Clibvisionworks.vxSwapImageHandle(image.reference, nil, &prev_ptrs, vx_size(numPlanes))
    } else {
      return Clibvisionworks.vxSwapImageHandle(image.reference, nil, nil, vx_size(numPlanes))
    }
  }
}
