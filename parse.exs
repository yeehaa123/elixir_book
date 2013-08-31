defmodule Parse do

  def number([ ?- | tail ]), do: _number_digits(tail, 0) * -1
  def number([ ?+ | tail ]), do: _number_digits(tail, 0)
  def number(str),           do: _number_digits(str, 0)

  defp _number_digits([], value), do: value
  defp _number_digits([ digit | tail ], value)
  when digit in '0123456789' do
    _number_digits(tail, value*10 + digit - ?0)
  end
  defp _number_digits([ non_digit | _ ], _) do
    raise "invalid digit '#{[non_digit]}'"
  end

  def ascii?(str), do: _ascii?(str, true)

  def _ascii?([], true), do: true
  def _ascii?([ head | tail ], _value) when head >= 32 and head <=126, do: _ascii?(tail, true)
  def _ascii?(_str, _value), do: false 

  def anagram(str1, str2) do
    if Enum.sort(str1) == Enum.sort(str2) do
      true
    else
      false
    end
  end
end
