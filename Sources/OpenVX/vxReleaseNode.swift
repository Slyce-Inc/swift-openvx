import Clibvisionworks

public func vxReleaseNode(_ node: vx_node) {
  var p: vx_image? = node
  vxReleaseNode(&p)
}
