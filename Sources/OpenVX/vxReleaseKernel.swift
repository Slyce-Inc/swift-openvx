import Clibvisionworks

public func vxReleaseKernel(_ kernel: vx_kernel) {
  var p: vx_kernel? = kernel
  vxReleaseKernel(&p)
}
