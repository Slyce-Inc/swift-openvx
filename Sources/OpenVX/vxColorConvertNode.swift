import Clibvisionworks


public func vxColorConvertNode(_ graph: Graph, _ input: Imageable, _ output: Imageable) -> Node? {
  guard let reference = vxColorConvertNode(graph.reference, input.reference, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func colorConvert(to imageType: ImageType) -> Pipeline {
    let targetImage = virtualImageOrFail(type: imageType)
    return self
      .byChanging(node:vxColorConvertNode(graph, lastImageOrFail(), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
