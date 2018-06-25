import Clibvisionworks


public func vxCreateRangeThreshold(_ context: vx_context?, min: UInt32, max: UInt32) -> vx_threshold? {
  guard let threshold = vxCreateThreshold(context, VX_THRESHOLD_TYPE_RANGE, VX_TYPE_UINT8) else {
    return nil
  }
  vxSetThresholdAttribute(threshold, VX_THRESHOLD_THRESHOLD_LOWER, min)
  vxSetThresholdAttribute(threshold, VX_THRESHOLD_THRESHOLD_UPPER, max)
  return threshold
}
