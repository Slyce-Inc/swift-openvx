import Clibvisionworks

public protocol Referenceable {
  var reference: vx_reference { get }
  init(reference:vx_reference)
}
