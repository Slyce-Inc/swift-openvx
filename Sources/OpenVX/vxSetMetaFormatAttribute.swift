import Clibvisionworks


public func vxSetMetaFormatAttribute(_ meta: vx_meta_format, _ attribute: MetaFormatAttribute) throws {
  let ptr: UnsafeMutablePointer<UInt8>
  let size: vx_size
  var v1: Int32 = 0
  var v2: vx_size = 0
  switch attribute {
    case .ImageFormat(let type):
      v1 = Int32(type.vx_value)
      size = MemoryLayout.size(ofValue:v1)
      ptr = UnsafeMutableRawPointer(&v1).assumingMemoryBound(to: UInt8.self)
    case .LookupTableType(let type), .ScalarType(let type), .ArrayItemType(let type):
      v1 = type.vx_value
      size = MemoryLayout.size(ofValue:v1)
      ptr = UnsafeMutableRawPointer(&v1).assumingMemoryBound(to: UInt8.self)
    case .LookupTableCount(let count), .ArrayCapacity(let count):
      v2 = vx_size(count)
      size = MemoryLayout.size(ofValue:v2)
      ptr = UnsafeMutableRawPointer(&v2).assumingMemoryBound(to: UInt8.self)
    case .ImageWidth(let v), .ImageHeight(let v):
      v1 = Int32(v)
      size = MemoryLayout.size(ofValue:v1)
      ptr = UnsafeMutableRawPointer(&v1).assumingMemoryBound(to: UInt8.self)
  }
  let status = vxSetMetaFormatAttribute(meta, attribute.vx_value, ptr, size)
  if status != VX_SUCCESS {
    throw MetaFormatAttributeError.FailedToSetAttribute(meta: meta, status: status)
  }
}

public enum MetaFormatAttributeError: Error {
case FailedToSetAttribute(meta: vx_meta_format, status: Int32)
}

public enum MetaFormatAttribute {
case LookupTableType(type: DataType)
case LookupTableCount(count: Int)
case ScalarType(type: DataType)
case ArrayItemType(type: DataType)
case ArrayCapacity(capacity: Int)
case ImageFormat(type: ImageType)
case ImageWidth(width: Int)
case ImageHeight(height: Int)
}

extension MetaFormatAttribute {
  var vx_value: vx_int32 {
    switch self {
    case .LookupTableType:
      return VX_LUT_TYPE
    case .LookupTableCount:
      return VX_LUT_COUNT
    case .ScalarType:
      return VX_SCALAR_TYPE
    case .ArrayItemType:
      return VX_ARRAY_ITEMTYPE
    case .ArrayCapacity:
      return VX_ARRAY_CAPACITY
    case .ImageFormat:
      return VX_IMAGE_FORMAT
    case .ImageWidth:
      return VX_IMAGE_WIDTH
    case .ImageHeight:
      return VX_IMAGE_HEIGHT
    }
  }
}
