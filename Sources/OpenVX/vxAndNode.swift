import Clibvisionworks


public func vxAndNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxAndNode(graph.reference, input1.reference, input2.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func and(image: Imageable) -> Pipeline {
    let targetImage = targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxAndNode(graph, lastImageOrFail(), image, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
