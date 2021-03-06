module MotionWechat
  module Interface

    def send_image_content(image_path = '', image_data = nil, opts = {})
      sendImageContent(image_path, image_data, opts = {})
    end

    def send_news_content(page_url, opts = {})
      sendNewsContent(page_url, opts = {})
    end

    def send_music_content(music_url, opts = {})
      sendMusicContent(music_url, opts = {})
    end

    def send_video_content(video_url, opts = {})
      sendVideoContent(video_url, opts = {})
    end

    def send_text_content(message)
      sendTextContent(message)
    end

    def send_app_content(ext_info, url, data, opts = {})
      sendAppContent(ext_info, url, data, opts = {})
    end

    def sendImageContent(image_path = '', image_data = nil, opts = {})
      message = media_message(opts)

      ext = WXImageObject.object
      ext.imageData = NSData.dataWithContentsOfFile(image_path) if image_path
      ext.imageData = image_data if image_data
      
      message.mediaObject = ext

      req = wrap_req(message)
      
      WXApi.sendReq(req)
    end

    def sendNewsContent(page_url, opts = {})
      message = media_message(opts)
      
      ext = WXWebpageObject.object
      ext.webpageUrl = page_url
      
      message.mediaObject = ext

      req = wrap_req(message)
      
      WXApi.sendReq(req)
    end

    def sendMusicContent(music_url, opts = {})
      message = media_message(opts)
      
      ext = WXMusicObject.object
      ext.musicUrl = music_url
      
      message.mediaObject = ext
      
      req = wrap_req(message)
      
      WXApi.sendReq(req)
    end

    def sendVideoContent(video_url, opts = {})
      message = media_message(opts)
      
      ext = WXVideoObject.object
      ext.videoUrl = video_url
      
      message.mediaObject = ext
      
      req = wrap_req(message)
      
      WXApi.sendReq(req)
    end

    def sendTextContent(message)
      req = wrap_req(message, is_text: true)
      
      WXApi.sendReq(req)
    end

    def sendAppContent(ext_info, url, data, opts = {})
      message = media_message
      
      ext = WXAppExtendObject.object
      ext.extInfo = ext_info
      ext.url = url
      ext.fileData = data

      message.mediaObject = ext
      
      req = wrap_req(message)

      WXApi.sendReq(req)
    end

    def getWXAppInstallUrl
      WXApi.getWXAppInstallUrl
    end

    def isWXAppInstalled
      WXApi.isWXAppInstalled
    end

    def isWXAppSupportApi
      WXApi.isWXAppSupportApi
    end

    def openWXApp
      WXApi.openWXApp
    end


    private
    def wrap_req(message, opts = {})
      req = SendMessageToWXReq.alloc.init
      is_text = opts[:is_text] || false
      if is_text
        req.bText = true
        req.text = message
      else
        req.bText = false
        req.message = message
      end

      #[WXSceneSession, WXSceneTimeline]
      req.scene = WXSceneSession
      req
    end

    def media_message(opts = {})
      message = WXMediaMessage.message

      message.title = opts[:title] || ""
      message.description = opts[:description] || ""

      if opts[:thumb_image]
        image = UIImage.imageNamed(opts[:thumb_image])
        message.setThumbImage(image)
      end

      if opts[:thumb_data_url]
        errorPointer = Pointer.new(:object)
        data = NSData.dataWithContentsOfURL(opts[:thumb_data_url], options:NSDataReadingMappedIfSafe, error:errorPointer)

        if errorPointer && errorPointer[0]
          raise errorPointer[0]
        else
          message.thumbData = data
        end
      end

      message
    end

  end
end