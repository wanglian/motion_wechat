module MotionWechat
  class WechatActivity < UIActivity
    attr_accessor :activity_title, :scene, :url, :image, :text
  
    def activityType
      self.class.name
    end
  
    def canPerformWithActivityItems(activity_items)
      activity_items.each do |item|
        if item.is_a? String
          return true
        elsif item.is_a? NSURL
          return true
        elsif item.is_a? UIImage
          return true
        end
      end
      false
    end

    def prepareWithActivityItems(activity_items)
      activity_items.each do |item|
        if item.is_a? String
          self.text = item
        elsif item.is_a? NSURL
          self.url = item
        elsif item.is_a? UIImage
          self.image = item
        end
      end
    end
  
    def activityCategory
      UIActivityCategoryShare
    end

    def performActivity
      req = SendMessageToWXReq.alloc.init
      req.scene = self.scene
      req.text = self.text
      
      if self.image || self.url
        
      else
        req.bText = true
      end
      
      WXApi.sendReq req
      self.activityDidFinish true
    end
  end
end