import Clibvisionworks

public func vxWriteScalar(_ scalar: vx_scalar?, _ float32: Float) {
  var value = float32
  vxCopyScalar(scalar, &value, VX_WRITE_ONLY, VX_MEMORY_TYPE_HOST)
}

public func vxWriteScalar(_ scalar: vx_scalar?, _ bool: Bool) {
  var value: Int32 = bool ? 1 : 0
  vxCopyScalar(scalar, &value, VX_WRITE_ONLY, VX_MEMORY_TYPE_HOST)
}

public func vxWriteScalar(_ scalar: vx_scalar?, _ uint8: UInt8) {
  var value = uint8
  vxCopyScalar(scalar, &value, VX_WRITE_ONLY, VX_MEMORY_TYPE_HOST)
}
