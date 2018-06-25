import Clibvisionworks


public func vxThresholdNode(_ graph: Graph, _ input: Imageable, _ threshold: Threshold, _ output: Imageable) -> Node? {
  guard let reference = vxThresholdNode(graph.reference, input.reference, threshold.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
