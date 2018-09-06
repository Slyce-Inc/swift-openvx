import Foundation

// TODO: Better Name!
public class Frame {
  public let planes: [UnsafeMutableRawPointer]
  public let width: Int
  public let height: Int
  public let format: ImageType

  public init?(format:ImageType, width:Int, height:Int) {
    switch format {
    case .U8:
      guard let ptr = malloc(width * height) else {
        return nil
      }
      self.planes = [ptr]

    case .NV12:
      guard let ptr = malloc((width * height) + (width * (height >> 1))) else {
        return nil
      }
      self.planes = [
        ptr,
        ptr + (width * height)
      ]

    case .IYUV:
      guard let ptr = malloc((width * height) * 2) else {
        return nil
      }
      self.planes = [
        ptr,
        ptr + (width * height),
        ptr + (width * height) + (width / 2 * height / 2),
      ]

    case .RGB:
      guard let ptr = malloc(width * height * 3) else {
        return nil
      }
      self.planes = [ptr]

    default:
      preconditionFailure("ImageType (\(format)) is unimplemented")
    }
    self.width = width
    self.height = height
    self.format = format
  }

  deinit {
    free(planes[0])
  }
}
