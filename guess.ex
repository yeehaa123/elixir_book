defmodule Chop do

  def guess(actual, a..b) do
    mid = div(a + b, 2)
    IO.puts mid
    guess(actual, a, b, mid)
  end
  
  def guess(actual, _a, _b, mid) when mid == actual, do: IO.puts mid

  def guess(actual, a, _b, mid) when mid > actual, do: guess(actual, a..(mid - 1))

  def guess(actual, _a, b, mid) when mid < actual, do: guess(actual, (mid + 1)..b)
end

Chop.guess(273, 1..1000)
Chop.guess(73, 1..1000)
Chop.guess(698, 1..1000)
Chop.guess(1000, 1..1000)
Chop.guess(1, 1..1000)
