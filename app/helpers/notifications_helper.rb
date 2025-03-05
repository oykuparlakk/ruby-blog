module NotificationsHelper
  def notification_text(notification)
    case notification.notifiable
    when Like
      "#{notification.notifiable.user.full_name} senin makaleni beğendi."
    when Recommendation
      "#{notification.notifiable.user.full_name} senin makaleni önerdi."
    when Article
      "#{notification.notifiable.user.full_name} yeni bir makale yazdı: '#{notification.notifiable.title}'"
    else
      "Yeni bir bildirimin var."
    end
  end
end
