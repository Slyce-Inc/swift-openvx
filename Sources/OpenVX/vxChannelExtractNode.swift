import Clibvisionworks


public func vxChannelExtractNode(_ graph: Graph, _ input: Imageable, _ channel: ImageChannel, _ output: Imageable) -> Node? {
  guard let reference = vxChannelExtractNode(graph.reference, input.reference, channel.vx_value, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  func extract(channel: ImageChannel, into target: Imageable? = nil) -> Pipeline {
    let targetImage = target ?? targetImageOrFail(type: .U8)
    return self
      .byChanging(node:vxChannelExtractNode(graph, lastImageOrFail(), channel, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
