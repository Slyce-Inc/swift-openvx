import Clibvisionworks


public func vxOrNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxOrNode(graph.reference, input1.reference, input2.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
