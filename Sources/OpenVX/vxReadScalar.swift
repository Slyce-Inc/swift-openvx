import Clibvisionworks

public func vxReadScalar(_ scalar: vx_scalar?) -> Float {
  var value: Float = 0
  vxCopyScalar(scalar, &value, VX_READ_ONLY, VX_MEMORY_TYPE_HOST)
  return value
}

public func vxReadScalar(_ scalar: vx_scalar?) -> Bool {
  var value: Int32 = 0
  vxCopyScalar(scalar, &value, VX_READ_ONLY, VX_MEMORY_TYPE_HOST)
  return value != 0
}
