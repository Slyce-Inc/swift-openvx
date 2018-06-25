import Clibvisionworks


public class Matrix<T:Matrixable>: Referenceable {
  public let reference: vx_image

  public required init(reference: vx_reference) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init!(context: Context, columns: Int = 0, rows: Int = 0) {
    guard let dataType = DataType.from(type: T.self) else {
      return nil
    }
    guard let reference = vxCreateMatrix(context.reference, dataType.vx_value, vx_size(columns), vx_size(rows)) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }
}


public protocol Matrixable {}
extension Float: Matrixable {}
