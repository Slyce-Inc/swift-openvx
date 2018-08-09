import Clibvisionworks


public enum ImageType {
  case U8
  case S16
  case RGB
  case NV12
  case IYUV
  case YUV4
  case Virtual
}

extension ImageType {
  var vx_value: vx_df_image {
    switch self {
    case .U8:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_U8.rawValue)
    case .S16:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_S16.rawValue)
    case .RGB:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_RGB.rawValue)
    case .NV12:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_NV12.rawValue)
    case .IYUV:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_IYUV.rawValue)
    case .YUV4:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_YUV4.rawValue)
    case .Virtual:
      return vx_df_image(Clibvisionworks.VX_DF_IMAGE_VIRT.rawValue)
    }
  }
}
