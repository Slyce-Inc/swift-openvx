import Clibvisionworks


public class Distribution: Referenceable {
  public let reference: vx_distribution

  public init!(context: Context, numberOfBins: Int, offset: Int, range: Int) {
    guard let reference = vxCreateDistribution(context.reference, vx_size(numberOfBins), vx_int32(offset), vx_uint32(range)) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}
