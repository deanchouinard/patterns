defmodule EmailStudents do
  @text_body  "First name: <%= assigns[:f_firstname] %>"
  @html_body  "<html><%= assigns[:f_firstname] %> </html>"
  
  def email(file_name) do
    file_name
    |> get_raw_data
    |> Enum.map(&convert_keys/1)
    |> Enum.map(&convert_body/1)
    |> Enum.map(&send_email/1)
  end

  defp get_raw_data(file_name) do
    file_name
    |> File.open!([:utf8])
    |> IO.stream(:line)
    |> CSV.decode(headers: true)
  end

  defp convert_keys(map) do
    map
    |> Enum.map(fn {k, v} -> {convert_key(k), v} end)
  end

  defp convert_key(key) do
    key
    |> String.downcase
    |> String.replace(~r{[^a-z0-9]+}, "")
    |> String.replace(~r{^}, "f_")
    |> String.to_atom
  end

  defp convert_body(assigns) do
    assigns
    |> Enum.into(%{})
    |> put_in([:text_body], EEx.eval_string(@text_body, assigns: assigns))
    |> put_in([:html_body], EEx.eval_string(@html_body, assigns: assigns))
    |> IO.inspect
  end

  defp send_email(assigns) do
    assigns
    |> log
    |> EmailStudents.Email.send
    |> EmailStudents.Mailer.deliver_now
    Process.sleep(5000)
  end

  defp log(assigns) do
    IO.puts "Sending to #{assigns.f_firstname} #{assigns.f_email}"
    assigns
  end

end
