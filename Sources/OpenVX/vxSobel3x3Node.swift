import Clibvisionworks


public func vxSobel3x3Node(_ graph: Graph, _ input: Imageable, _ outputX: Imageable, _ outputY: Imageable) -> Node? {
  guard let reference = vxSobel3x3Node(graph.reference, input.reference, outputX.reference, outputY.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
