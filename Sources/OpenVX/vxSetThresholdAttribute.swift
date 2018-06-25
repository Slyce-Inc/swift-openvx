import Clibvisionworks


@discardableResult
public func vxSetThresholdAttribute(_ context: vx_context?, _ attribute: Int32, _ value: UInt32) -> vx_status {
  var v = value
  return vxSetThresholdAttribute(context, attribute, &v, MemoryLayout.size(ofValue: v.self))
}
