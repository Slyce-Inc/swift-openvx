import Clibvisionworks


public func vxHistogramNode(_ graph: Graph, _ input: Imageable, _ distribution: Distribution) -> Node? {
  guard let reference = vxHistogramNode(graph.reference, input.reference, distribution.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func histogram(_ distribution: Distribution) -> Pipeline {
    return self
      .byChanging(node:vxHistogramNode(graph, lastImageOrFail(), distribution))
  }
}
