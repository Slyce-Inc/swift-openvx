import Clibvisionworks

public func vxReleaseDistribution(_ distribution: vx_distribution) {
  var p: vx_graph? = distribution
  vxReleaseDistribution(&p)
}
