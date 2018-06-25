import Clibvisionworks

public func vxReleaseContext(_ context: vx_context) {
  var p: vx_context? = context
  vxReleaseContext(&p)
}
