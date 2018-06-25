import Clibvisionworks


public enum ImageChannel {
  case Y
  case U
  case V
  case R
  case G
  case B
}

extension ImageChannel {
  var vx_value: vx_int32 {
    switch self {
    case .Y:
      return vx_int32(Clibvisionworks.VX_CHANNEL_Y.rawValue)
    case .U:
      return vx_int32(Clibvisionworks.VX_CHANNEL_U.rawValue)
    case .V:
      return vx_int32(Clibvisionworks.VX_CHANNEL_V.rawValue)
    case .R:
      return vx_int32(Clibvisionworks.VX_CHANNEL_R.rawValue)
    case .G:
      return vx_int32(Clibvisionworks.VX_CHANNEL_G.rawValue)
    case .B:
      return vx_int32(Clibvisionworks.VX_CHANNEL_B.rawValue)
    }
  }
}
