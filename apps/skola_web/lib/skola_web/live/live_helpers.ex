defmodule SkolaWeb.LiveHelpers do
  
  def convert_date(date) do
    srb = ['Januar', 'Februar', 'Mart', 'April', 'Maj', 'Jun', 'Jul', 'Avgust', 'Septembar', 'Okobar', 'Novembar', 'Decembar']
    Enum.join([Enum.at(srb, date.month - 1), " ", Integer.to_string(date.day)])
  end
end
