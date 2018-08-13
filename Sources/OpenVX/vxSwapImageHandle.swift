import Clibvisionworks


fileprivate var no_ptrs = [UnsafeMutableRawPointer?]()

public func vxSwapImageHandle(_ image: Image, _ new_ptrs: [UnsafeMutableRawPointer?], _ numPlanes: Int) -> vx_status {
  var new_ptrs = new_ptrs
  return Clibvisionworks.vxSwapImageHandle(image.reference, &new_ptrs, nil, vx_size(numPlanes))
}

public func vxSwapImageHandle(_ image: Image, _ new_ptrs: [UnsafeMutableRawPointer?]?, _ prev_ptrs: inout [UnsafeMutableRawPointer?], _ numPlanes: Int) -> vx_status {
  if var new_ptrs = new_ptrs {
    var prev_ptrs = prev_ptrs
    return Clibvisionworks.vxSwapImageHandle(image.reference, &new_ptrs, &prev_ptrs, vx_size(numPlanes))
  } else {
    var prev_ptrs = prev_ptrs
    return Clibvisionworks.vxSwapImageHandle(image.reference, nil, &prev_ptrs, vx_size(numPlanes))
  }
}
