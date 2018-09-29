import Clibvisionworks


public func vxMultiplyNode(_ graph: Graph, _ input1: Imageable, _ input2: Imageable, _ scale:Scalar<Float>, _ overflowPolicy: ConversionPolicy, _ roundingPolicy: RoundingPolicy, _ output: Imageable) -> Node? {
  guard let reference = vxMultiplyNode(graph.reference, input1.reference, input2.reference, scale.reference, vx_enum(overflowPolicy.vx_value), roundingPolicy.vx_value, output.reference) else {
    return nil
  }
  defer { vxReleaseNode(reference) }
  return Node(reference: reference)
}

public extension Pipeline {
  public func multiply(format:ImageType = .U8, scale:Scalar<Float>, overflowPolicy:ConversionPolicy, roundingPolicy:RoundingPolicy) -> Pipeline {
    let targetImage = targetImageOrFail(type:format)
    return self
      .byChanging(node:vxMultiplyNode(graph, lastImageOrFail(plus:1), lastImageOrFail(), scale, overflowPolicy, roundingPolicy, targetImage))
      .byChanging(images:self.images.appending(targetImage))
  }
}

public enum RoundingPolicy {
case TO_ZERO
case TO_NEAREST_EVEN
}

extension RoundingPolicy {
  var vx_value: vx_enum {
    switch self {
    case .TO_ZERO:          return vx_int32(Clibvisionworks.VX_ROUND_POLICY_TO_ZERO.rawValue)
    case .TO_NEAREST_EVEN:  return vx_int32(Clibvisionworks.VX_ROUND_POLICY_TO_NEAREST_EVEN.rawValue)
    }
  }
}
