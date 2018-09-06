import Clibvisionworks


public enum DataType {
case Float32
case Int32
case UInt32
case UInt8
case Bool
case Rectangle
}


extension DataType {
  static func from(type: Any.Type) -> DataType? {
    switch type {
    case is Float.Type:
      return .Float32
    case is Int32.Type:
      return .Int32
    case is UInt32.Type:
      return .UInt32
    case is UInt8.Type:
      return .UInt8
    case is Bool.Type:
      return .Bool
    case is vx_rectangle_t.Type:
      return .Rectangle
    default:
      print("Unsupported DataType: \(type)")
      return nil
    }
  }
}

extension DataType {
  var vx_value: vx_int32 {
    switch self {
    case .Float32:
      return vx_int32(Clibvisionworks.VX_TYPE_FLOAT32.rawValue)
    case .Int32:
      return vx_int32(Clibvisionworks.VX_TYPE_INT32.rawValue)
    case .UInt32:
      return vx_int32(Clibvisionworks.VX_TYPE_UINT32.rawValue)
    case .UInt8:
      return vx_int32(Clibvisionworks.VX_TYPE_UINT8.rawValue)
    case .Bool:
      return vx_int32(Clibvisionworks.VX_TYPE_BOOL.rawValue)
    case .Rectangle:
      return vx_int32(Clibvisionworks.VX_TYPE_RECTANGLE.rawValue)
    }
  }
}
