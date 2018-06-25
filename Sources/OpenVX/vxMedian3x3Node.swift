import Clibvisionworks


public func vxMedian3x3Node(_ graph: Graph, _ from: Imageable, _ to: Imageable) -> Node? {
  guard let reference = vxMedian3x3Node(graph.reference, from.reference, to.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func median3x3() -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxMedian3x3Node(graph, lastImageOrFail(), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
