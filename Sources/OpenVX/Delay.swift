import Clibvisionworks


public class Delay<T:Referenceable>: Referenceable {
  public let reference: vx_delay

  public required init(reference: vx_delay) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context:Context, exemplar:T, slots:Int) {
    guard let reference = vxCreateDelay(context.reference, exemplar.reference, vx_size(slots)) else {
      return nil
    }
    self.reference = reference
  }

  public func reference(at index:Int) -> T? {
    guard let reference = vxGetReferenceFromDelay(self.reference, vx_int32(index)) else {
      return nil
    }
    return T(reference:reference)
  }

  public func age() {
    vxAgeDelay(self.reference)
  }

  deinit {
    vxReleaseDelay(self.reference)
  }
}
