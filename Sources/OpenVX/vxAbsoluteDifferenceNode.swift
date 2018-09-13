import Clibvisionworks


public func vxAbsDiffNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxAbsDiffNode(graph.reference, input1.reference, input2.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func absoluteDifference(format:ImageType = .U8) -> Pipeline {
    let input1 = lastImageOrFail(plus:1)
    let input2 = lastImageOrFail(plus:0)
    let targetImage = targetImageOrFail(type:format)
    return self
      .byChanging(node:vxAbsDiffNode(graph, input1, input2, targetImage))
      .byAppending(image:targetImage)
  }
}
