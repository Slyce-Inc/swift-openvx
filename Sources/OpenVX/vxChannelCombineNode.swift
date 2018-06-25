import Clibvisionworks


public func vxChannelCombineNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable?, _ input3: Imageable?, _ input4: Imageable?, _ output: Imageable) -> Node? {
  guard let reference = vxChannelCombineNode(graph.reference, input1.reference, input2?.reference, input3?.reference, input4?.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
