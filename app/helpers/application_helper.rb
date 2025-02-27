module ApplicationHelper
  include Pagy::Frontend


  def turbo_notification(message)
    turbo_stream.append "notifications", partial: "layouts/notification", locals: { message: message }
  end
end
