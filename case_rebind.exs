friend = "Ron Weasley"
enemy = "Voldermort"
knocking_on_door = "Voldermort"
respond = case knocking_on_door do
  friend -> "Come on inside, #{friend}"
  enemy -> "Expelliramus!"
end
 IO.puts "respond: #{respond}"

friend = "Ron Weasley"
enemy = "Voldermort"
knocking_on_door = "Voldermort"
respond = case knocking_on_door do
  ^friend -> "Come on inside, #{friend}"
  ^enemy -> "Expelliramus!"
end
 IO.puts "respond: #{respond}"
