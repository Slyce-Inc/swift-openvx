import Clibvisionworks


public func vxCreateImageFromROI(_ image: Image, _ rect: Rectangle) -> Image? {
  var rectangle = rect
  guard let reference = vxCreateImageFromROI(image.reference, &rectangle) else {
    return nil
  }
  defer { vxReleaseImage(reference) }
  return Image(reference:reference)
}
