import Clibvisionworks


public func vxTableLookupNode(_ graph: Graph, _ input: Imageable, _ lookupTable: LookupTable, _ output: Imageable) -> Node? {
  guard let reference = vxTableLookupNode(graph.reference, input.reference, lookupTable.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}
