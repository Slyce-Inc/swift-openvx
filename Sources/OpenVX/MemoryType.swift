import Clibvisionworks


public enum MemoryType {
case None
case Host
}

extension MemoryType {
  var vx_value: vx_int32 {
    switch self {
    case .None:
      return vx_int32(Clibvisionworks.VX_MEMORY_TYPE_NONE.rawValue)
    case .Host:
      return vx_int32(Clibvisionworks.VX_MEMORY_TYPE_HOST.rawValue)
    }
  }
}
