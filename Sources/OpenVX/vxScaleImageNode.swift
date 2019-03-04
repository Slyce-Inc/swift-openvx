import Clibvisionworks


public func vxScaleImageNode(_ graph: Graph, _ input: Imageable, _ output: Imageable, _ interpolationPolicy: InterpolationPolicy) -> Node? {
  guard let reference = vxScaleImageNode(graph.reference, input.reference, output.reference, interpolationPolicy.vx_value) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func scale(to targetImage:Imageable? = nil, interpolationPolicy:InterpolationPolicy) -> Pipeline {
    let sourceImage = lastImageOrFail()
    let targetImage = targetImage ?? targetImageOrFail(type:.U8)
    return self
      .byChanging(node:vxScaleImageNode(graph, sourceImage, targetImage, interpolationPolicy))
      .byChanging(images:self.images.appending(targetImage))
      .byChanging(width:targetImage.width, height:targetImage.height)
  }

  public func scale(width:Int, height:Int, interpolationPolicy:InterpolationPolicy) -> Pipeline {
    let sourceImage = lastImageOrFail()
    let targetImage = graph.createImage(width: width, height: height, type: .U8)!
    return self
      .byChanging(node:vxScaleImageNode(graph, sourceImage, targetImage, interpolationPolicy))
      .byChanging(images:self.images.appending(targetImage))
      .byChanging(width:width, height:height)
  }
}
