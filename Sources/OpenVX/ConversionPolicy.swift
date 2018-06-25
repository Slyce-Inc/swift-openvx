import Clibvisionworks


public enum ConversionPolicy {
case Wrap
case Saturate
}


extension ConversionPolicy {
  var vx_value: vx_int32 {
    switch self {
    case .Wrap:
      return vx_int32(Clibvisionworks.VX_CONVERT_POLICY_WRAP.rawValue)
    case .Saturate:
      return vx_int32(Clibvisionworks.VX_CONVERT_POLICY_SATURATE.rawValue)
    }
  }
}
