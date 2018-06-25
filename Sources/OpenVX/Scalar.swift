import Clibvisionworks


public class Scalar<T:Scalarable>: Referenceable {
  public let reference: vx_scalar

  public required init(reference: vx_reference) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?(context: Context, value: T) {
    guard let dataType = DataType.from(type: T.self) else {
      return nil
    }

    var bp = bitPatternFor(value: value)
    guard let reference = vxCreateScalar(context.reference, dataType.vx_value, &bp) else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    var r: vx_reference? = self.reference
    vxReleaseReference(&r)
  }

  public var value: T {
    get {
      var bp: UInt32 = 0
      vxCopyScalar(self.reference, &bp, VX_READ_ONLY, VX_MEMORY_TYPE_HOST)
      return valueFor(bitPattern: bp)
    }
    set {
      var bp = bitPatternFor(value: newValue)
      vxCopyScalar(self.reference, &bp, VX_WRITE_ONLY, VX_MEMORY_TYPE_HOST)
    }
  }

}

fileprivate func bitPatternFor<T>(value: T) -> UInt32 {
  switch value {
  case let value as Bool:
    return value ? 1 : 0
  case let value as Int32:
    return UInt32(value)
  case let value as Float:
    return value.bitPattern
  case let value as UInt8:
    return UInt32(value)
  default:
    preconditionFailure("Unsupported")
  }
}

fileprivate func valueFor<T>(bitPattern: UInt32) -> T {
  switch T.self {
  case is Bool.Type:
    return (bitPattern > 0) as! T
  case is Int32.Type:
    return Int32(bitPattern) as! T
  case is Float.Type:
    return Float(bitPattern: bitPattern) as! T
  case is UInt8.Type:
    return UInt8(bitPattern) as! T
  default:
    preconditionFailure("Unsupported")
  }
}

public protocol Scalarable {
  init()
}

extension Bool: Scalarable {}
extension Float: Scalarable {}
extension Int32: Scalarable {}
extension UInt8: Scalarable {}
