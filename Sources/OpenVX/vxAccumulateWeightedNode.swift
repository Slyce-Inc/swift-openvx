import Clibvisionworks


public func vxAccumulateWeightedImageNode(_ graph: Graph, _ input: Imageable, _ alpha: Scalar<Float>, _ output: Imageable) -> Node? {
  guard let reference = vxAccumulateWeightedImageNode(graph.reference, input.reference, alpha.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func accumulateWeighted(into image: Imageable, alpha: Scalar<Float>) -> Pipeline {
    return self
      .byChanging(node:vxAccumulateWeightedImageNode(graph, lastImageOrFail(), alpha, image))
      .byAppending(image:image)
  }
}
