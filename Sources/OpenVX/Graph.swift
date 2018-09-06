import Clibvisionworks


public class Graph: Referenceable {
  public let reference: vx_graph
  public let context: Context

  public init?(context: Context) {
    guard let reference = vxCreateGraph(context.reference) else {
      return nil
    }
    self.reference = reference
    self.context = context
  }

  deinit {
    vxReleaseGraph(reference)
  }

  public func createNode(withKernelName name: String, parameters: [Referenceable?] = []) throws -> Node {
    let kernel = try self.context.kernel(byName: name)
    let node = try self.createNode(kernel: kernel)
    if parameters.count > 0 {
      try node.setParameters(parameters)
    }
    return node
  }

  public func createNode(kernel: Kernel) throws -> Node {
    guard let node = Node(graph: self, kernel: kernel) else {
      throw GraphError.FailedToCreateNodeWithKernel(kernel:kernel)
    }
    return node
  }

  public func verify() -> Int32 {
    return vxVerifyGraph(reference)
  }

  @discardableResult
  public func process() -> Int32 {
    return vxProcessGraph(reference)
  }
}

public extension Graph {
  public func createImage(width: Int = 0, height: Int = 0, type: ImageType = .Virtual) -> VirtualImage! {
    return VirtualImage(graph: self, width: width, height: height, type: type)
  }
}

public extension Graph {
  public func pipe(image: Imageable) -> Pipeline {
    return Pipeline(graph: self, node: nil, width: image.width, height: image.height, border: nil, images: [image], targetImage: nil)
  }
}

public enum GraphError: Error {
case FailedToCreateNodeWithKernel(kernel:Kernel)
}
