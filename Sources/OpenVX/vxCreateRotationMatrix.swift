import Clibvisionworks
import Glibc


public func vxCreateRotationMatrix(_ context: vx_context, radians: Float, scale: Float, centerX: Int, centerY: Int) -> vx_matrix? {
  guard let matrix = vxCreateMatrix(context, VX_TYPE_FLOAT32, 2, 3) else {
    return nil
  }
  let a = scale * cos(radians)
  let b = scale * sin(radians)
  let cx = Float(centerX)
  let cy = Float(centerY)
  var mat: [Float] = [
    a, -b,
    b,  a,
    ((1.0 - a) * cx) - (b * cy), (b * cx) + ((1.0 - a) * cy)
  ]
  vxWriteMatrix(matrix, &mat)
  return matrix
}
