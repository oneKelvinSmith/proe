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
end
