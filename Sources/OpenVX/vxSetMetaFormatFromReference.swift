import Clibvisionworks


public func vxSetMetaFormatFromReference(_ meta: vx_meta_format, _ exemplar: Referenceable) throws {
  let status = vxSetMetaFormatFromReference(meta, exemplar.reference)
  if status != VX_SUCCESS {
    throw MetaFormatAttributeError.FailedToSetAttribute(meta: meta, status: status)
  }
}
