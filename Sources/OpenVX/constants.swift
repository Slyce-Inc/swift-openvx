import Clibvisionworks

public let VX_THRESHOLD_THRESHOLD_VALUE = Int32((VX_ID_KHRONOS.rawValue ) << 20) | (VX_TYPE_THRESHOLD << 8) + 0x1
public let VX_THRESHOLD_THRESHOLD_LOWER = Int32((VX_ID_KHRONOS.rawValue ) << 20) | (VX_TYPE_THRESHOLD << 8) + 0x2
public let VX_THRESHOLD_THRESHOLD_UPPER = Int32((VX_ID_KHRONOS.rawValue ) << 20) | (VX_TYPE_THRESHOLD << 8) + 0x3
public let VX_THRESHOLD_TRUE_VALUE      = Int32((VX_ID_KHRONOS.rawValue ) << 20) | (VX_TYPE_THRESHOLD << 8) + 0x4
public let VX_THRESHOLD_FALSE_VALUE     = Int32((VX_ID_KHRONOS.rawValue ) << 20) | (VX_TYPE_THRESHOLD << 8) + 0x5

public let VX_THRESHOLD_TYPE_BINARY = Int32(Clibvisionworks.VX_THRESHOLD_TYPE_BINARY.rawValue)
public let VX_THRESHOLD_TYPE_RANGE  = Int32(Clibvisionworks.VX_THRESHOLD_TYPE_RANGE.rawValue)

public let VX_DF_IMAGE_VIRT = Clibvisionworks.VX_DF_IMAGE_VIRT.rawValue
public let VX_DF_IMAGE_NV12 = Clibvisionworks.VX_DF_IMAGE_NV12.rawValue
public let VX_DF_IMAGE_U8   = Clibvisionworks.VX_DF_IMAGE_U8.rawValue
public let VX_DF_IMAGE_S16  = Clibvisionworks.VX_DF_IMAGE_S16.rawValue
public let VX_DF_IMAGE_RGB  = Clibvisionworks.VX_DF_IMAGE_RGB.rawValue
public let VX_DF_IMAGE_IYUV = Clibvisionworks.VX_DF_IMAGE_IYUV.rawValue
public let VX_DF_IMAGE_YUV4 = Clibvisionworks.VX_DF_IMAGE_YUV4.rawValue

public let VX_SUCCESS = Clibvisionworks.VX_SUCCESS.rawValue
public let VX_FAILURE = Clibvisionworks.VX_FAILURE.rawValue

public let VX_READ_ONLY      = Int32(Clibvisionworks.VX_READ_ONLY.rawValue)
public let VX_READ_AND_WRITE = Int32(Clibvisionworks.VX_READ_AND_WRITE.rawValue)
public let VX_WRITE_ONLY     = Int32(Clibvisionworks.VX_WRITE_ONLY.rawValue)

public let VX_CONVERT_POLICY_WRAP     = Int32(Clibvisionworks.VX_CONVERT_POLICY_WRAP.rawValue)
public let VX_CONVERT_POLICY_SATURATE = Int32(Clibvisionworks.VX_CONVERT_POLICY_SATURATE.rawValue)

public let VX_ROUND_POLICY_TO_ZERO         = Int32(Clibvisionworks.VX_ROUND_POLICY_TO_ZERO.rawValue)
public let VX_ROUND_POLICY_TO_NEAREST_EVEN = Int32(Clibvisionworks.VX_ROUND_POLICY_TO_NEAREST_EVEN.rawValue)

public let VX_INTERPOLATION_TYPE_NEAREST_NEIGHBOR = Int32(VX_INTERPOLATION_NEAREST_NEIGHBOR.rawValue)
public let VX_INTERPOLATION_TYPE_BILINEAR         = Int32(VX_INTERPOLATION_BILINEAR.rawValue)
public let VX_INTERPOLATION_TYPE_AREA             = Int32(VX_INTERPOLATION_AREA.rawValue)

public let VX_IMAGE_WIDTH  = Int32(Clibvisionworks.VX_IMAGE_WIDTH.rawValue)
public let VX_IMAGE_HEIGHT = Int32(Clibvisionworks.VX_IMAGE_HEIGHT.rawValue)
public let VX_IMAGE_FORMAT = Int32(Clibvisionworks.VX_IMAGE_FORMAT.rawValue)

public let VX_CHANNEL_Y = Int32(Clibvisionworks.VX_CHANNEL_Y.rawValue)
public let VX_CHANNEL_U = Int32(Clibvisionworks.VX_CHANNEL_U.rawValue)
public let VX_CHANNEL_V = Int32(Clibvisionworks.VX_CHANNEL_V.rawValue)
public let VX_CHANNEL_R = Int32(Clibvisionworks.VX_CHANNEL_R.rawValue)
public let VX_CHANNEL_G = Int32(Clibvisionworks.VX_CHANNEL_G.rawValue)
public let VX_CHANNEL_B = Int32(Clibvisionworks.VX_CHANNEL_B.rawValue)

public let VX_INPUT   = Int32(Clibvisionworks.VX_INPUT.rawValue)
public let VX_OUTPUT  = Int32(Clibvisionworks.VX_OUTPUT.rawValue)

public let VX_TYPE_IMAGE        = Int32(Clibvisionworks.VX_TYPE_IMAGE.rawValue)
public let VX_TYPE_RECTANGLE    = Int32(Clibvisionworks.VX_TYPE_RECTANGLE.rawValue)
public let VX_TYPE_ARRAY        = Int32(Clibvisionworks.VX_TYPE_ARRAY.rawValue)
public let VX_TYPE_SCALAR       = Int32(Clibvisionworks.VX_TYPE_SCALAR.rawValue)
public let VX_TYPE_OBJECT_ARRAY = Int32(Clibvisionworks.VX_TYPE_OBJECT_ARRAY.rawValue)
public let VX_TYPE_THRESHOLD    = Int32(Clibvisionworks.VX_TYPE_THRESHOLD.rawValue)
public let VX_TYPE_DISTRIBUTION = Int32(Clibvisionworks.VX_TYPE_DISTRIBUTION.rawValue)
public let VX_TYPE_FLOAT32      = Int32(Clibvisionworks.VX_TYPE_FLOAT32.rawValue)
public let VX_TYPE_UINT8        = Int32(Clibvisionworks.VX_TYPE_UINT8.rawValue)
public let VX_TYPE_INT32        = Int32(Clibvisionworks.VX_TYPE_INT32.rawValue)
public let VX_TYPE_MATRIX       = Int32(Clibvisionworks.VX_TYPE_MATRIX.rawValue)
public let VX_TYPE_BOOL         = Int32(Clibvisionworks.VX_TYPE_BOOL.rawValue)
public let VX_TYPE_LUT          = Int32(Clibvisionworks.VX_TYPE_LUT.rawValue)

public let VX_PARAMETER_STATE_REQUIRED = Int32(Clibvisionworks.VX_PARAMETER_STATE_REQUIRED.rawValue)
public let VX_PARAMETER_STATE_OPTIONAL = Int32(Clibvisionworks.VX_PARAMETER_STATE_OPTIONAL.rawValue)

public let VX_MEMORY_TYPE_HOST = Int32(Clibvisionworks.VX_MEMORY_TYPE_HOST.rawValue)


public let VX_ARRAY_CAPACITY        = Int32(Clibvisionworks.VX_ARRAY_CAPACITY.rawValue)
public let VX_ARRAY_ITEMTYPE        = Int32(Clibvisionworks.VX_ARRAY_ITEMTYPE.rawValue)
public let VX_ARRAY_NUMITEMS        = Int32(Clibvisionworks.VX_ARRAY_NUMITEMS.rawValue)

public let VX_DISTRIBUTION_BINS     = Int32(Clibvisionworks.VX_DISTRIBUTION_BINS.rawValue)

public let VX_OBJECT_ARRAY_NUMITEMS = Int32(Clibvisionworks.VX_OBJECT_ARRAY_NUMITEMS.rawValue)
public let VX_OBJECT_ARRAY_ITEMTYPE = Int32(Clibvisionworks.VX_OBJECT_ARRAY_ITEMTYPE.rawValue)

public let VX_SCALAR_TYPE           = Int32(Clibvisionworks.VX_SCALAR_TYPE.rawValue)
public let VX_MATRIX_TYPE           = Int32(Clibvisionworks.VX_MATRIX_TYPE.rawValue)

public let VX_THRESHOLD_TYPE        = Int32(Clibvisionworks.VX_THRESHOLD_TYPE.rawValue)

public let VX_VALID_RECT_CALLBACK   = Int32(Clibvisionworks.VX_VALID_RECT_CALLBACK.rawValue)

public let VX_NORM_L2   = Int32(Clibvisionworks.VX_NORM_L2.rawValue)

public let VX_LUT_TYPE = Int32(Clibvisionworks.VX_LUT_TYPE.rawValue)
public let VX_LUT_COUNT = Int32(Clibvisionworks.VX_LUT_COUNT.rawValue)

public let VX_PARAMETER_REF = Int32(Clibvisionworks.VX_PARAMETER_REF.rawValue)

public let VX_KERNEL_COLOR_CONVERT = Int32(Clibvisionworks.VX_KERNEL_COLOR_CONVERT.rawValue)
public let VX_KERNEL_CHANNEL_COMBINE = Int32(Clibvisionworks.VX_KERNEL_CHANNEL_COMBINE.rawValue)

public let VX_ACTION_ABANDON = Int32(Clibvisionworks.VX_ACTION_ABANDON.rawValue)
public let VX_ACTION_CONTINUE = Int32(Clibvisionworks.VX_ACTION_CONTINUE.rawValue)

public let VX_BORDER_CONSTANT = Int32(Clibvisionworks.VX_BORDER_CONSTANT.rawValue)

public let VX_ERROR_GRAPH_ABANDONED = Int32(Clibvisionworks.VX_ERROR_GRAPH_ABANDONED.rawValue)
