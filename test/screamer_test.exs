defmodule ScreamerTest do
  use ExUnit.Case
  use Screamer
  doctest Screamer

  def! sum(x,y), do: x+y

  def! mul(x,y) do
    x*y
  end

  test "the truth" do
    assert 1 + 1 == 2
  end

  test "good sum!" do
    assert sum!(1,2) == 3
    assert sum!(-1,2) == 1
    assert sum!(0,5) == 5
    assert sum!(-5,0) == -5
  end

  test "bad sum!" do
    assert_raise ArithmeticError, fn ->
      sum!(1,"2")
    end
  end

  test "good sum" do
    assert sum(1,2) == {:ok,3}
    assert sum(-1,2) == {:ok,1}
    assert sum(0,5) == {:ok,5}
    assert sum(-5,0) == {:ok,-5}
  end

  test "bad sum" do
    assert elem(sum(1,"2"),0) == :error
  end

  test "checking mul" do
    assert mul!(2,3) == 6
    assert mul(-1,1) == {:ok,-1}
    assert_raise ArithmeticError, fn ->
      mul!(0,"5")
    end
    assert elem(mul(1,"2"),0) == :error
  end
end
