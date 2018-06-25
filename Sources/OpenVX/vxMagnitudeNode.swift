import Clibvisionworks


public func vxMagnitudeNode(_ graph: Graph, _ gradX: Imageable, _ gradY: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxMagnitudeNode(graph.reference, gradX.reference, gradY.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
