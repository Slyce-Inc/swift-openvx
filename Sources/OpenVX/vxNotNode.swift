import Clibvisionworks


public func vxNotNode(_ graph: Graph, _ input: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxNotNode(graph.reference, input.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func not() -> Pipeline {
    let targetImage = targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxNotNode(graph, lastImageOrFail(), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
