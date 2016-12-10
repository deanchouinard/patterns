use Mix.Config

config :email_students, EmailStudents.Mailer,
  adapter: Bamboo.TestAdapter
