defmodule EmailStudentsTest do
  use ExUnit.Case
  doctest EmailStudents

  test "email students first test" do
    EmailStudents.email("test/testfile.csv")

    assert true
  end

  test "the truth" do
    assert 1 + 1 == 2
  end
end
