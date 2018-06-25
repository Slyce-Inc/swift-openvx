import Clibvisionworks


public class LookupTable: Referenceable {
  public let reference: vx_lut

  public init!(context: Context, dataType: DataType, size: Int) {
    guard let reference = vxCreateLUT(context.reference, dataType.vx_value, vx_size(size)) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}
