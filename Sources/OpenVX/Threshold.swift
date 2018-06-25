import Clibvisionworks


public protocol Threshold {
  var reference: vx_threshold { get }
}

public class BinaryThreshold<T:Thresholdable>: Referenceable, Threshold {
  public let reference: vx_threshold

  public required init(reference: vx_threshold) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context: Context, value: Int, trueValue: Int? = nil, falseValue: Int? = nil) {
    guard let dataType = DataType.from(type: T.self) else {
      return nil
    }
    guard let reference = vxCreateThreshold(context.reference, VX_THRESHOLD_TYPE_BINARY, dataType.vx_value) else {
      return nil
    }
    defer { vxReleaseThreshold(reference) }

    var v = Int32(value)
    guard VX_SUCCESS == vxSetThresholdAttribute(reference, VX_THRESHOLD_THRESHOLD_VALUE, &v, MemoryLayout.size(ofValue: v)) else {
      return nil
    }
    if let tv = trueValue {
      var v = Int32(tv)
      guard VX_SUCCESS == vxSetThresholdAttribute(reference, VX_THRESHOLD_TRUE_VALUE, &v, MemoryLayout.size(ofValue: v)) else {
        return nil
      }
    }
    if let fv = falseValue {
      var v = Int32(fv)
      guard VX_SUCCESS == vxSetThresholdAttribute(reference, VX_THRESHOLD_FALSE_VALUE, &v, MemoryLayout.size(ofValue: v)) else {
        return nil
      }
    }

    self.reference = reference
    vxRetainReference(reference)
  }

  deinit {
    vxReleaseThreshold(reference)
  }
}


public enum ThresholdType {
case Binary
case Range
}

extension ThresholdType {
  var vx_value: vx_int32 {
    switch self {
    case .Binary:
      return vx_int32(Clibvisionworks.VX_THRESHOLD_TYPE_BINARY.rawValue)
    case .Range:
      return vx_int32(Clibvisionworks.VX_THRESHOLD_TYPE_RANGE.rawValue)
    }
  }
}


public protocol Thresholdable {}
extension UInt8: Thresholdable {}
extension UInt32: Thresholdable {}
