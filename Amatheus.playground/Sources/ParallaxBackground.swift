/*import SpriteKit


class ParallaxBackground: SKNode {
  
  private let maxLayers = 30

  
  struct ParallaxLayer {
    let node: SKNode
    let rate: CGFloat
    let segmentHeight:CGFloat
  }
  
  var layers = [ParallaxLayer]()
  
  func addLayer(_ imageNamed: String, withRate rate: CGFloat)
  {
    let layer = SKNode()
    let parallaxLayer = ParallaxLayer(node: layer, rate: rate, segmentHeight: SKSpriteNode(imageNamed: imageNamed).frame.height)
    let minTiles = ceil(viewPortHeight / parallaxLayer.segmentHeight) + 1
    
    
    for i in 0..<Int(minTiles) {
      
      
      let spriteNode = SKSpriteNode(imageNamed: imageNamed)
      
      spriteNode.position = CGPoint(x: 0,y: -spriteNode.frame.height * CGFloat(i) - parallaxLayer.segmentHeight/2 )
      
      layer.addChild(spriteNode)
      
      
    }
    
    self.addChild(layer)
    
    
    layer.position = CGPoint(x: 0, y: viewPortHeight/2)
    layer.zPosition = CGFloat(self.layers.count) - CGFloat(maxLayers)
    
    self.layers.append(parallaxLayer)
    
    
  }
  
  func removeLayerAtIndex(_ index:Int)
  {
    let parallaxLayer = self.layers.remove(at: index)
    parallaxLayer.node.removeFromParent()
  }
  
  func update(withSpeed speed: CGFloat, andDeltaTime delta:CFTimeInterval)
  {
    
    for layer in self.layers
    {
      let deltaY = -CGFloat(delta) * speed * layer.rate
      
      
      let halfViewport = viewPortHeight/2 //Used to offset the coordinate system
      
      let nextYposition = layer.node.position.y + deltaY
      let layerFrame = layer.node.calculateAccumulatedFrame()
      
      
      let upperLimit = layerFrame.height - halfViewport
      let lowerLimit = halfViewport
      
      if nextYposition <= lowerLimit
      {
        let offsetY = layer.node.position.y - lowerLimit
        
        let y = max(layer.segmentHeight + halfViewport + offsetY + deltaY, lowerLimit)
        layer.node.position = CGPoint(x: 0, y: y)
        //print("shifted from bottom to top")
        
      }
      else if nextYposition >= upperLimit
      {
        
        let offsetY = upperLimit - layer.node.position.y
        
        
        let y = min(layerFrame.height - halfViewport - layer.segmentHeight - offsetY + deltaY, upperLimit )
        layer.node.position = CGPoint(x: 0, y: y)
        //print("shifted from top to bottom")
        
      }
      else
      {
        //print("no shift")
        layer.node.position = CGPoint(x: 0, y: layer.node.position.y + CGFloat(deltaY))
      }
      
    }
    
  }
  
  
  
  
}
*/
