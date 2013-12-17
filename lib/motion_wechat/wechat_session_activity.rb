module MotionWechat
  class WechatSessionActivity < WechatActivity
  
    def init
      super
      self.scene = WXSceneSession
      self.activity_title = 'Wechat'
      self
    end
  
    def activityTitle
      self.activity_title
    end
  
    def activityImage
      UIImage.imageNamed('icon_session')
    end
  end
end