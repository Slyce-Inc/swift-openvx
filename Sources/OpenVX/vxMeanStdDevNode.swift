import Clibvisionworks


public func vxMeanStdDevNode(_ graph:Graph, _ input:Imageable, _ mean:Scalar<Float>, _ stddev:Scalar<Float>) -> Node? {
  guard let reference = vxMeanStdDevNode(graph.reference, input.reference, mean.reference, stddev.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func meanStdDev(_ mean:Scalar<Float>, _ stddev:Scalar<Float>) -> Pipeline {
    return self
      .byChanging(node:vxMeanStdDevNode(graph, lastImageOrFail(), mean, stddev))
  }
}
