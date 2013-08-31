defmodule MyList do
  def span(from, to), do: _span(from, to, [])
  defp _span(from, to, list) when from <= to, do: [ from | _span(from + 1, to, list) ]
  defp _span(_, _, list), do: list

  def all?([], func), do: true
  def all?([head | tail], func) do
    if func.(head), do: all?(tail, func), else: false
  end

  def each([], func), do: []
  def each([head | tail], func) do
    func.(head)
    each(tail, func)
  end

  def split(list, target), do: split(list, target, 1, [])
  def split([ head | tail ], target, index, output_list) do 
    if index <= target do
      split(tail, target, index + 1, [ head | output_list ])
    else
      { output_list, tail }
    end
  end

  def take(list, target), do: take(list, target, 1, [])
  def take([ head | tail ], target, index, output_list) do
    if index <= target  do
      take(tail, target, index + 1, [ head | output_list ])
    else
      Enum.reverse(output_list)
    end
  end
end
