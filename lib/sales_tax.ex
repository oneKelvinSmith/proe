defmodule SalesTax do
  def calculate(orders, tax_rates) do
    for order <- orders do
      case order do
        [_, {:ship_to, :NC},  _] ->
          Keyword.get(tax_rates, :NC)
        [_, {:ship_to, :TX}, _] ->
          Keyword.get(tax_rates, :TX)
        otherwise -> 0
      end
      |> set_total_amount(order)
    end
  end

  defp set_total_amount(rate, order) do
    net = Keyword.get(order, :net_amount)
    total = net * (1 + rate)
    Keyword.put(order, :total_amount, total)
  end

  def parse(filename, tax_rates) do
    File.open!(filename)
    |> parse_contents
    |> calculate(tax_rates)
  end

  defp parse_contents(file) do
    headers = parse_headers file
    file
    |> IO.stream(:line)
    |> Enum.map(&create_row(headers, &1))
  end

  defp parse_headers(file) do
    IO.read(file, :line)
    |> parse_line(&String.to_atom/1)
  end

  defp parse_line(line, mapper) do
    line
    |> String.strip
    |> String.split(",")
    |> Enum.map(mapper)
  end

  defp create_row(headers, line) do
    values = parse_line(line, &parse_value/1)
    Enum.zip(headers, values)
  end

  defp parse_value(<< head::utf8, tail::binary >> = value) do
    cond do
      is_integer?(value) -> String.to_integer value
      is_float?(value)   -> String.to_float value
      is_atom? (head)    -> String.to_atom tail
      :default           -> value
    end
  end

  defp is_integer?(value) do
    Regex.match?(~r/^[0-9]+$/, value)
  end

  defp is_float?(value) do
    Regex.match?(~r/^[0-9]+\.[0-9]+$/, value)
  end

  defp is_atom?(head) do
    head == ?:
  end
end
