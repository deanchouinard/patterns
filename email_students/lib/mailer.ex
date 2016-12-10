# Somewhere in your application. Maybe lib/my_app/mailer.ex
defmodule EmailStudents.Mailer do
  # Adds deliver_now/1 and deliver_later/1
  #use Bamboo.Mailer, otp_app: :my_app
  use Bamboo.Mailer, otp_app: :email_students
end

# Set up your emails
defmodule EmailStudents.Email do
  import Bamboo.Email

  def send(assigns) do
    new_email(
      to: assigns.f_email,
      from: "me@example.com",
      subject: "Welcome!!!",
      html_body: assigns.html_body,
      text_body: assigns.text_body
    )
  end

  # def welcome_email do
  #   new_mail(
  #     to: "foo@example.com",
  #     from: "me@example.com",
  #     subject: "Welcome!!!",
  #     html_body: "<strong>WELCOME</strong>",
  #     text_body: "WELCOME"
  #   )
  # end
end
