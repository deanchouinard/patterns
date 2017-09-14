#
# figure out a way to compare two lists, making the values used for
# chart indexes the same. Which index values from the first list
# are missing from the second; and add them to make them have the same
# index values.
#
defmodule ListDiff do
  
  @list_a [%{date: "2017-09-01", time: "06:00", value: 100},
  %{date: "2017-09-02", time: "06:00", value: 101},
  %{date: "2017-09-03", time: "06:00", value: 101},
  %{date: "2017-09-04", time: "06:00", value: 101},
  %{date: "2017-09-05", time: "06:00", value: 101},
  %{date: "2017-09-06", time: "06:00", value: 101},
  %{date: "2017-09-07", time: "06:00", value: 101},
  %{date: "2017-09-08", time: "06:00", value: 101}
  ]

  @list_b [%{date: "2017-09-01", time: "06:00", value: 100},
  %{date: "2017-09-02", time: "06:00", value: 101},
  %{date: "2017-09-04", time: "06:00", value: 101},
  %{date: "2017-09-07", time: "06:00", value: 101},
  %{date: "2017-09-08", time: "06:00", value: 101}
  ]

  def start() do
    list_a_dates = Enum.map(@list_a, &extract_dates(&1))
    IO.inspect list_a_dates

    new_list_b = Enum.map(@list_a, &match_lists(&1, @list_b))
    IO.inspect new_list_b

    new_list_b = Enum.reduce(@list_a, [],
      fn(x, acc) -> [match_lists(x, @list_b) | acc] end )
    |> Enum.reverse()

    IO.inspect new_list_b
  end


  def extract_dates(x) do
    %{date: date, time: _, value: _} = x
    date
  end

  def match_lists(aitem, listb) do
    found = Enum.find(listb, 0, &is_match(&1, aitem))
    IO.puts "after found"
    IO.inspect found, label: "found"
    case found do
      0 -> %{aitem | :value => nil}
      _ -> found
    end
  end

  def is_match(a, b) do
    %{date: adate, time: _, value: _} = a
    %{date: bdate, time: _, value: _} = b
    adate == bdate
  end

end

ListDiff.start()

