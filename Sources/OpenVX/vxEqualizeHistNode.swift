import Clibvisionworks


public func vxEqualizeHistNode(_ graph: Graph, _ from: Imageable, _ to: Imageable) -> Node? {
  guard let reference = vxEqualizeHistNode(graph.reference, from.reference, to.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func equalizeHist() -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxEqualizeHistNode(graph, lastImageOrFail(), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
