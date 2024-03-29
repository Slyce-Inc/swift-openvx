import Clibvisionworks


public func vxDilate3x3Node(_ graph: Graph, _ input: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxDilate3x3Node(graph.reference, input.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func dilate3x3() -> Pipeline {
    let targetImage = targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxDilate3x3Node(graph, lastImageOrFail(), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
