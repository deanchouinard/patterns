defmodule EmailStudentsTest do
  use ExUnit.Case
  use Bamboo.Test

  doctest EmailStudents

  test "run code" do
    EmailStudents.email("test/testfile.csv")

    # assert true
  end

  test "test emailer" do

    assigns = %{ f_first: "Ben", f_email: "ben@test.com",
      text_body: "Hello Ben", html_body: "Hello Ben" }
    
    email = EmailStudents.Email.send(assigns)
    email = EmailStudents.Mailer.deliver_now(email)

    assert_delivered_email(email)
  end

  test "the truth" do
    assert 1 + 1 == 2
  end
end
