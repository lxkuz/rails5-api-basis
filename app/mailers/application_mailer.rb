# frozen_string_literal: true
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def message_strategy(email, data)
    # load_smtp_settings
    # @user = user
    mail(
      to: email,
      subject: 'BangBang Act Message',
      delivery_method_options: {},
      body: data
    )
  end
  # protected

  # def load_smtp_settings
  #   @settings = Settings.first
  #   @smtp_settings = {
  #     address: @settings.smtp_address,
  #     port: @settings.smtp_port,
  #     user_name: @settings.smtp_user,
  #     password: @settings.smtp_password
  #   }
  # end
end
