


public struct Pipeline {
  public let graph: Graph
  public let node: Node!
  public let width: Int
  public let height: Int
  public let border: Border!
  public let images: [Imageable]

  public var image: Imageable! {
    return images.last
  }

  public func virtualImageOrFail(type: ImageType) -> Imageable {
    guard let image = graph.createImage(width: self.width, height: self.height, type: type) else {
      preconditionFailure("TODO: Write me")
    }
    return image
  }

  public func lastImageOrFail(plus: Int = 0) -> Imageable {
    let index = images.count - plus - 1
    if index < 0 {
      preconditionFailure("TODO: Write me")
    }
    return images[index]
  }

  public func byChanging(node: Node?) -> Pipeline {
    if let border = self.border {
      node?.setBorder(border)
    }
    return Pipeline(
      graph: self.graph,
      node: node,
      width: self.width,
      height: self.height,
      border: self.border,
      images: self.images
    )
  }

  public func byChanging(images: [Imageable]) -> Pipeline {
    return Pipeline(
      graph: self.graph,
      node: self.node,
      width: self.width,
      height: self.height,
      border: self.border,
      images: images
    )
  }

  public func byChanging(width: Int, height: Int) -> Pipeline {
    return Pipeline(
      graph: self.graph,
      node: self.node,
      width: width,
      height: height,
      border: self.border,
      images: self.images
    )
  }

  public func byChanging(border: Border) -> Pipeline {
    return Pipeline(
      graph: self.graph,
      node: self.node,
      width: self.width,
      height: self.height,
      border: border,
      images: self.images
    )
  }
}

//  TODO: Do away with the need for this.
public extension Array where Element:Any {
  func appending(_ element: Element) -> [Element] {
    var copy = Array(self)
    copy.append(element)
    return copy
  }
}

public extension Pipeline {
  public func defineSize(width: Int, height: Int) -> Pipeline {
    return self
      .byChanging(width: width, height: height)
  }

  public func define(border: Border) -> Pipeline {
    return self
      .byChanging(border: border)
  }
}

public extension Pipeline {
  public func or(image: Imageable) -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxOrNode(graph, lastImageOrFail(), image, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }

  public func apply(lookupTable: LookupTable) -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxTableLookupNode(graph, lastImageOrFail(), lookupTable, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }

  public func apply(threshold: Threshold) -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxThresholdNode(graph, lastImageOrFail(), threshold, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }

  public func warpAffine(matrix: Matrix<Float>, interpolationPolicy: InterpolationPolicy) -> Pipeline {
    let targetImage = virtualImageOrFail(type: .U8)
    return self
      .byChanging(node:vxWarpAffineNode(graph, lastImageOrFail(), matrix, interpolationPolicy, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }

  public func sobel3x3() -> Pipeline {
    let targetImage1 = virtualImageOrFail(type: .S16)
    let targetImage2 = virtualImageOrFail(type: .S16)
    return self
      .byChanging(node:vxSobel3x3Node(graph, lastImageOrFail(), targetImage1, targetImage2))
      .byChanging(images:self.images.appending(targetImage1).appending(targetImage2))
  }

  public func magnitude() -> Pipeline {
    let targetImage = virtualImageOrFail(type: .S16)
    return self
      .byChanging(node:vxMagnitudeNode(graph, lastImageOrFail(plus:1), lastImageOrFail(plus:0), targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}
