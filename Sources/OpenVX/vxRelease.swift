import Clibvisionworks

public func vxReleaseContext(_ context: vx_context) {
  var p: vx_context? = context
  vxReleaseContext(&p)
}

public func vxReleaseDelay(_ delay: vx_delay) {
  var p: vx_delay? = delay
  vxReleaseDelay(&p)
}

public func vxReleaseDistribution(_ distribution: vx_distribution) {
  var p: vx_distribution? = distribution
  vxReleaseDistribution(&p)
}

public func vxReleaseGraph(_ graph: vx_graph) {
  var p: vx_graph? = graph
  vxReleaseGraph(&p)
}

public func vxReleaseImage(_ image: vx_image) {
  var p: vx_image? = image
  vxReleaseImage(&p)
}

public func vxReleaseKernel(_ kernel: vx_kernel) {
  var p: vx_kernel? = kernel
  vxReleaseKernel(&p)
}

public func vxReleaseNode(_ node: vx_node) {
  var p: vx_image? = node
  vxReleaseNode(&p)
}

public func vxReleaseThreshold(_ threshold: vx_threshold) {
  var p: vx_threshold? = threshold
  vxReleaseThreshold(&p)
}
