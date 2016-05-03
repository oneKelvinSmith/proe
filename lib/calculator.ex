defmodule Calculator do
  def calculate(formula) when is_binary(formula) do
    String.to_char_list(formula)
    |> shunt([], [])
  end

  defp shunt([head | tail] = tokens, operators, numbers) do
    case head do
      token when token in '*+-/' ->
        shunt(tail, [<<token>> | operators], numbers)
      token when token in '0123456789' ->
        {new_tail, number} = pop_number(tokens, 0)
        shunt(new_tail, operators, [number | numbers])
      token ->
        shunt(tail, operators, numbers)
    end
  end
  defp shunt([], operators, numbers) do
    solve(operators, Enum.reverse(numbers))
  end

  defp solve([operator | operators], [first, second | numbers]) do
    result =
      case operator do
        "*" -> Kernel.*(first, second)
        "+" -> Kernel.+(first, second)
        "-" -> Kernel.-(first, second)
        "/" -> Kernel./(first, second)
      end
    solve(operators, [result | numbers])
  end
  defp solve([], [result | []]), do: result
  defp solve(_, _), do: raise(ArgumentError, message: "Invalid formula")

  defp pop_number([digit | tail], number) when digit in '0123456789' do
    pop_number(tail, number * 10 + digit - ?0)
  end
  defp pop_number(tokens, number), do: {tokens, number}
end
