import Clibvisionworks

public func vxReleaseThreshold(_ threshold: vx_threshold) {
  var p: vx_threshold? = threshold
  vxReleaseThreshold(&p)
}
