import Clibvisionworks


public func vxConvertDepthNode(_ graph: Graph, _ input: Imageable, _ output: Imageable, _ policy: ConversionPolicy, _ shift: Scalar<Int32>) -> Node? {
  guard let reference = vxConvertDepthNode(graph.reference, input.reference, output.reference, policy.vx_value, shift.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func convertDepth(to imageType: ImageType = .U8, policy: ConversionPolicy, shift: Scalar<Int32>) -> Pipeline {
    let targetImage = targetImageOrFail(type: imageType)
    return self
      .byChanging(node:vxConvertDepthNode(graph, lastImageOrFail(), targetImage, policy, shift))
      .byChanging(images:self.images.appending(targetImage))
  }
}
