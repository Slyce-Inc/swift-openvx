import Clibvisionworks


public func vxCreateBinaryThreshold(_ context: vx_context?, value: UInt8, trueValue: UInt8? = nil, falseValue: UInt8? = nil) -> vx_threshold? {
  guard let threshold = vxCreateThreshold(context, VX_THRESHOLD_TYPE_BINARY, VX_TYPE_UINT8) else {
    return nil
  }
  defer { vxReleaseThreshold(threshold) }

  var v = UInt32(value)
  guard VX_SUCCESS == vxSetThresholdAttribute(threshold, VX_THRESHOLD_THRESHOLD_VALUE, &v, MemoryLayout.size(ofValue: v.self)) else {
    return nil
  }
  if let tv = trueValue {
    var v = UInt32(tv)
    guard VX_SUCCESS == vxSetThresholdAttribute(threshold, VX_THRESHOLD_TRUE_VALUE, &v, MemoryLayout.size(ofValue: v.self)) else {
      return nil
    }
  }
  if let fv = falseValue {
    var v = UInt32(fv)
    guard VX_SUCCESS == vxSetThresholdAttribute(threshold, VX_THRESHOLD_FALSE_VALUE, &v, MemoryLayout.size(ofValue: v.self)) else {
      return nil
    }
  }

  vxRetainReference(threshold)
  return threshold
}
