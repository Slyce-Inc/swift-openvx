import Clibvisionworks


public func vxWarpAffineNode(_ graph: Graph, _ input: Imageable, _ matrix: Matrix<Float>, _ interpolationPolicy: InterpolationPolicy, _ output: Imageable) -> Node? {
  guard let reference = vxWarpAffineNode(graph.reference, input.reference, matrix.reference, interpolationPolicy.vx_value, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
