class RecommendationMailer < ApplicationMailer
  def recommendation_email(recommendation)
    @recommendation = recommendation
    mail(
      to: @recommendation.recommended_user.email,
      subject: "Yeni bir öneriniz var!"
    )
  end
end
