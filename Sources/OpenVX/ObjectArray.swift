import Clibvisionworks


public class ObjectArray<T:ObjectArrayable>: Referenceable {
  public let reference: vx_object_array

  public required init(reference: vx_object_array) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init!(context: Context, exemplar: T, count: Int) {
    guard let reference = vxCreateObjectArray(context.reference, exemplar.reference, vx_size(count)) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }

  public subscript(index: Int) -> T {
    get {
      let reference = vxGetObjectArrayItem(self.reference, vx_uint32(index))
      precondition(reference != nil)
      return T(reference: reference!)
    }
    set(newValue) {
    }
  }
}

public protocol ObjectArrayable: Referenceable {
  init(reference: vx_reference)
}
extension Matrix: ObjectArrayable {}
extension Scalar: ObjectArrayable {}
