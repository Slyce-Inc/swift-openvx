import Clibvisionworks

public func vxReleaseGraph(_ graph: vx_graph) {
  var p: vx_graph? = graph
  vxReleaseGraph(&p)
}
