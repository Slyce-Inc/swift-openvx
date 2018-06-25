import Clibvisionworks


public func vxScaleImageNode(_ graph: Graph, _ input: Imageable, _ output: Imageable, _ interpolationPlicy: InterpolationPolicy) -> Node? {
  guard let reference = vxScaleImageNode(graph.reference, input.reference, output.reference, interpolationPlicy.vx_value) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
