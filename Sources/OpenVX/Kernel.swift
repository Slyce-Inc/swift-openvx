import Clibvisionworks


public class Kernel: Referenceable {
  public let reference: vx_kernel

  public required init(reference: vx_kernel) {
    vxRetainReference(reference)
    self.reference = reference
  }

  deinit {
    vxReleaseKernel(reference)
  }

  func addParameters(_ parameters: [KernelParameterDescription]) throws {
    for (index, descriptor) in parameters.enumerated() {
      try self.addParameter(at:index, direction:descriptor.direction, type:descriptor.type, optional:descriptor.optional)
    }
  }

  func addParameter(at index: Int, direction: KernelParameterDirection, type: KernelParameterType, optional: Bool = false) throws {
    guard VX_SUCCESS == vxAddParameterToKernel(
      self.reference,
      vx_uint32(index),
      direction == .Input ? VX_INPUT : VX_OUTPUT,
      type.vx_value,
      !optional ? VX_PARAMETER_STATE_REQUIRED : VX_PARAMETER_STATE_OPTIONAL
    ) else {
      throw KernelError.FailedToAddParameter
    }
  }

  func finalize() throws {
    guard VX_SUCCESS == vxFinalizeKernel(self.reference) else {
      throw KernelError.FailedToFinalize
    }
  }
}

public enum KernelError: Error {
  case FailedToAddParameter
  case FailedToFinalize
}

public enum KernelParameterDirection {
  case Input
  case Output
}

public enum KernelParameterType {
  case Distribution
  case LookupTable
  case Image
  case Array
  case Scalar
  case Matrix
}

extension KernelParameterType {
  var vx_value: vx_int32 {
    switch self {
    case .Distribution:
      return VX_TYPE_DISTRIBUTION
    case .LookupTable:
      return VX_TYPE_LUT
    case .Image:
      return VX_TYPE_IMAGE
    case .Array:
      return VX_TYPE_ARRAY
    case .Scalar:
      return VX_TYPE_SCALAR
    case .Matrix:
      return VX_TYPE_MATRIX
    }
  }
}

public typealias KernelParameterDescription = (
  direction: KernelParameterDirection,
  type: KernelParameterType,
  optional: Bool
)
