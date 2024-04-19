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
      profit_vector.push buy_day < sell_day ? sell_price - buy_price : nil
      day_vector.push [buy_day, sell_day]
    end
    max_profit = profit_vector.compact.max
    max_profit_array.push max_profit
    day_array.push day_vector[profit_vector.find_index max_profit]
  end
  max_profit = max_profit_array.compact.max
  buy_sell_day = day_array[max_profit_array.find_index max_profit]
end

stock_picker stock_prices
