module NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @message = nil
    your_item = link_to 'あなたの投稿', room_path(notification), style: "font-weight: bold;"
    @visitor_message = notification.message_id

    case notification.action
      when 'follow' then
        tag.a(@visitor.username, href: user_path(@visitor), style: "font-weight: bold;")+"があなたをフォローしました"
      when 'favorite' then
        tag.a(@visitor.username, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: post_c_path(notification.post_c_id), style: "font-weight: bold;")+"にいいねしました"
      when 'favorite_sitter' then
        tag.a(@visitor.username, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: post_sitter_path(notification.post_sitter_id), style: "font-weight: bold;")+"にいいねしました"
      when 'message' then
        @message = Message.find_by(id: @visitor_message)&.content
        tag.a(@visitor.username, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('あなたの投稿', href: room_path(notification.room_id), style: "font-weight: bold;")+"にコメントしました"
      when 'review' then
        tag.a(@visitor.username, href: user_path(@visitor), style: "font-weight: bold;")+"が"+tag.a('レビューしました', href: user_reviews_path(user_id: current_user.id), style: "font-weight: bold;")
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
