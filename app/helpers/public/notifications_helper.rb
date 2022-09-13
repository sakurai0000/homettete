module Public::NotificationsHelper

  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
    when 'like'
       tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'がいいねされました'
    when 'great'
       tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'がすごいねされました'
    when 'amazing'
       tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'がえらいねされました'
    when 'comment' then
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_content =@comment.comment
      tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("褒めて！", href: post_path(notification.post_id)) + 'にコメントしました'
     end
  end
end