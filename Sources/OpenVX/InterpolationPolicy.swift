import Clibvisionworks


public enum InterpolationPolicy {
case NearestNeighbor
case Bilinear
case Area
}


extension InterpolationPolicy {
  var vx_value: vx_int32 {
    switch self {
    case .NearestNeighbor:
      return vx_int32(Clibvisionworks.VX_INTERPOLATION_NEAREST_NEIGHBOR.rawValue)
    case .Bilinear:
      return vx_int32(Clibvisionworks.VX_INTERPOLATION_BILINEAR.rawValue)
    case .Area:
      return vx_int32(Clibvisionworks.VX_INTERPOLATION_AREA.rawValue)

    }
  }
}
