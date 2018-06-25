import Clibvisionworks


public func vxCreateScalar(_ context: vx_context?, float32: Float32) -> vx_scalar? {
  var v = float32
  return vxCreateScalar(context, VX_TYPE_FLOAT32, &v)
}

public func vxCreateScalar(_ context: vx_context?, int32: Int32) -> vx_scalar? {
  var v = int32
  return vxCreateScalar(context, VX_TYPE_INT32, &v)
}

public func vxCreateScalar(_ context: vx_context?, bool: Bool) -> vx_scalar? {
  var v: Int32 = bool ? 1 : 0
  return vxCreateScalar(context, VX_TYPE_BOOL, &v)
}
