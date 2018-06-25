import Clibvisionworks


public protocol Imageable: Referenceable {
  var reference: vx_reference { get }
}


public extension Imageable {
  public var width: Int {
    var value: Int32 = 0
    guard VX_SUCCESS == vxQueryImage(self.reference, VX_IMAGE_WIDTH, &value, MemoryLayout<Int32>.size) else {
      return 0
    }
    return Int(value)
  }

  public var height: Int {
    var value: Int32 = 0
    guard VX_SUCCESS == vxQueryImage(self.reference, VX_IMAGE_HEIGHT, &value, MemoryLayout<Int32>.size) else {
      return 0
    }
    return Int(value)
  }
}
