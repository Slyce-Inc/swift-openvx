import Clibvisionworks


public typealias LogCallback = (vx_reference?, Int32, String?) -> ()
fileprivate var registry: [vx_context:LogCallback] = [:]

public typealias KernelHostSideFunction = vx_kernel_f
public typealias KernelValidatorFunction = vx_kernel_validate_f


public class Context {
  public let reference: vx_context

  public var logCallback: LogCallback? {
    set {
      if nil != newValue && registry[reference] == nil {
        registry[reference] = newValue
        vxRegisterLogCallback(reference, { registry[$0!]?($1, $2, $3 != nil ? String(cString: $3!) : nil) }, vx_false_e)
      } else if nil == newValue {
        vxRegisterLogCallback(reference, nil, vx_false_e)
        registry.removeValue(forKey: reference)
      }
    }
    get {
      return registry[reference]
    }
  }

  public init(reference: vx_reference) {
    vxRetainReference(reference)
    self.reference = reference
  }

  public init?() {
    guard let reference = vxCreateContext() else {
      return nil
    }
    self.reference = reference
  }

  deinit {
    vxReleaseContext(reference)
  }

  public func allocateKernelId() -> Int32 {
    var id: Int32 = 0
    guard VX_SUCCESS == vxAllocateUserKernelId(self.reference, &id) else {
      return -1
    }
    return id
  }

  public func addUserKernel(name: String, function: @escaping KernelHostSideFunction, validator: @escaping KernelValidatorFunction, parameters: [KernelParameterDescription]) throws -> Kernel {
    guard let reference = vxAddUserKernel(
      self.reference,
      name,
      allocateKernelId(),
      function,
      vx_uint32(parameters.count),
      validator,
      nil,
      nil
    ) else {
      throw ContextError.FailedToAddUserKernel(name: name)
    }
    defer { vxReleaseKernel(reference) }
    let kernel = Kernel(reference:reference)
    try kernel.addParameters(parameters)
    try kernel.finalize()
    return kernel
  }
}

public extension Context {
  public func kernel(byName name: String) throws -> Kernel {
    guard let reference = vxGetKernelByName(self.reference, name) else {
      throw ContextError.FailedToGetKernelWithName(name:name)
    }
    return Kernel(reference:reference)
  }

  public func kernel(byEnum value: Int) throws -> Kernel {
    guard let reference = vxGetKernelByEnum(self.reference, vx_int32(value)) else {
      throw ContextError.FailedToGetKernelWithEnum(value:value)
    }
    return Kernel(reference:reference)
  }
}

public extension Context {
  public func image(width: Int, height: Int, type: ImageType) -> Image! {
    return Image(context: self, width: width, height: height, type: type)
  }
}

public enum ContextError: Error {
case FailedToAddUserKernel(name: String)
case FailedToGetKernelWithName(name: String)
case FailedToGetKernelWithEnum(value: Int)
}
