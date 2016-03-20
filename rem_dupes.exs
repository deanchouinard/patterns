lst = [1, 2, 3, 4, 4, 5, 6]

defmodule Pat do

def rem_dupes([]), do: []
def rem_dupes([first | t]), do: [first | rem_dupes(t, first)]

def rem_dupes([], _), do: []
def rem_dupes([same | t], same), do: rem_dupes(t, same)
def rem_dupes([next | t], _last), do: [next | rem_dupes(t, next)]
end

lst2 = Pat.rem_dupes(lst)
IO.inspect(lst2)

defmodule Pat2 do

  def rem_dupes([]), do: []
  def rem_dupes([first | t]), do: [first | _rem_dupes(t, first)]

  def _rem_dupes([], _), do: []
  def _rem_dupes([same | t], same), do: _rem_dupes(t, same)
  def _rem_dupes([next | t], _last), do: [next | _rem_dupes(t, next)]
end

lst2 = Pat2.rem_dupes(lst)
IO.inspect(lst2)
