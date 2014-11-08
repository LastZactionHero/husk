class ExceptionMailer < ActionMailer::Base
  default from: "zach@localfavorite.me"

  def exception_email(exception, user)
    @user = user
    @class = exception.class.to_s
    @message = exception.message
    @backtrace = exception.backtrace.join("\n")

    mail(to: "zdicklin@gmail.com", subject: "Exception: #{@class}")
  end
end
