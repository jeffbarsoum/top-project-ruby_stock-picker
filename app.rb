def stock_prices
  [17,3,6,9,15,8,6,1,10]
end

def stock_picker stock_prices
  max_profit_array = []
  day_array = []
  stock_prices.each_with_index do | buy_price, buy_day |
    profit_vector = []
    day_vector = []
    stock_prices.each_with_index do |sell_price, sell_day|
      profit_vector << buy_day < sell_day ? sell_price - buy_price : nil
      day_vector << [buy_day, sell_day]
    end
    max_profit_day = profit_vector.each_with_index.max
    max_profit_array <<  max_profit_day[0]
    day_array << day_vector[max_profit_day[1]]
  end
  max_profit = max_profit_array.each_with_index.max
  buy_sell_day = day_array[max_profit[1]]
end

stock_picker stock_prices
