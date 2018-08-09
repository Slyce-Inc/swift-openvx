import Clibvisionworks

public enum Usage {
case VX_WRITE_ONLY
case VX_READ_ONLY
case VX_READ_AND_WRITE
}

public typealias vx_map_id = Clibvisionworks.vx_map_id

extension Usage {
  var vx_value: vx_uint32 {
    switch self {
    case .VX_WRITE_ONLY:
      return Clibvisionworks.VX_WRITE_ONLY.rawValue
    case .VX_READ_ONLY:
      return Clibvisionworks.VX_READ_ONLY.rawValue
    case .VX_READ_AND_WRITE:
      return Clibvisionworks.VX_READ_AND_WRITE.rawValue
    }
  }
}

public func vxMapImagePatch(_ image:Image, _ rectangle: Rectangle?, _ plane: Int, _ map_id: inout vx_map_id, _ addr: inout Image.PatchAddressing, _ ptr: inout Image.Plane?, _ usage: Usage, _ memoryType: MemoryType, _ flags: UInt32) -> Int32 {
  var vrectangle: UnsafePointer<Rectangle>? = nil
  if var rectangle = rectangle {
    vrectangle = withUnsafePointer(to: &rectangle) { $0 }
  }
  return Clibvisionworks.vxMapImagePatch(image.reference, vrectangle, vx_uint32(plane), &map_id, &addr, &ptr, vx_enum(usage.vx_value), memoryType.vx_value, flags)
}


public func vxUnmapImagePatch(_ image:Image, _ map_id: vx_map_id) {
  vxUnmapImagePatch(image.reference, map_id)
}
