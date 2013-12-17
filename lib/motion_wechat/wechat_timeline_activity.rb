module MotionWechat
  class WechatTimelineActivity < WechatActivity
  
    def init
      super
      self.scene = WXSceneTimeline
      self.activity_title = 'Wechat Moments'
      self
    end
  
    def activityTitle
      self.activity_title
    end
  
    def activityImage
      UIImage.imageNamed('icon_timeline')
    end
  end
end