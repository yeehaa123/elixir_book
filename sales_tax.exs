defmodule SalesTax do

  def calculates_taxes(orders, tax_rates) do 
    lc order inlist orders do
      total_amount = _calculate_tax(order.ship_to, order.net_amount, tax_rates)
      order.update_total_amount fn(_) -> total_amount end
    end
  end

  defp _calculate_tax(:NC, net_amount, tax_rate) do 
    tax = net_amount * tax_rate[:NC]
    net_amount + tax
  end

  defp _calculate_tax(:TX, net_amount, tax_rate) do
    tax = net_amount * tax_rate[:NC]
    net_amount + tax
  end

  defp _calculate_tax(_, net_amount, _),  do: net_amount
end

defrecord SalesData, id: nil, ship_to: nil, net_amount: nil, total_amount: nil

defmodule Formatter do
  def output_sales_data(sales_data) do
    Enum.each sales_data, fn(record) ->
      record |> output_sales_record
    end
  end

  def output_sales_record(r) do
    IO.puts "#{ r.id }\t#{ r.ship_to }\t#{ r.net_amount }\t#{ r.total_amount }"
  end
end

defmodule Parse do

  def ok!({:ok, data}), do: data
  def ok!({:error, message}), do: raise "#{message}"

  def parse_csv(file_name) do
    ok! File.open file_name, fn(pid) ->
      pid |> IO.read(:line)
      pid |> convert_to_orders
    end
  end

  def convert_to_orders(pid) do
    Enum.map IO.stream(pid, :line), fn(line) ->
      line |> parse_line
    end
  end

  def parse_line(line) do
    line
    |> String.strip
    |> String.split(",")
    |> convert_to_order
  end 

  def convert_to_order([id, ship_to, net_amount]) do
    ship_to = ship_to |> convert_ship_to
    id = id |> binary_to_integer
    net_amount = net_amount |> binary_to_float
    SalesData[id: id, ship_to: ship_to, net_amount: net_amount]
  end

  def convert_ship_to(ship_to) do
    ship_to
    |> String.replace(":", "")
    |> binary_to_atom
  end
end

tax_rates = [ NC: 0.075, TX: 0.08 ]

orders = Parse.parse_csv("shipping.csv") 
totals = SalesTax.calculates_taxes(orders, tax_rates) 
Formatter.output_sales_data(totals)
