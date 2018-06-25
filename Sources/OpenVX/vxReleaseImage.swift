import Clibvisionworks

public func vxReleaseImage(_ image: vx_image) {
  var p: vx_image? = image
  vxReleaseImage(&p)
}
