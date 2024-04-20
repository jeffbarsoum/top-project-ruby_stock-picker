def stock_prices
  [17,3,6,9,15,8,6,1,10]
end
###############################################################################
## Helper Functions
###############################################################################
# Price is only valid if it's a numerical value greater than 0
def is_price? input
  (Float(input) rescue false || Integer(input) rescue false) && input.to_f > 0
end

def is_quit? input
  input == ":q"
end

def is_valid_input? input
  return is_price?(input) || is_quit?(input)
end


# A function to pull input from the user
# Can choose to print spacing, or get input, either or both
def get_user_input print_spacing = false, get_input = true

  # an indicator to mark the user's input in the console
  print "--> "

  result = gets.chomp if get_input

  if print_spacing
      print "\n"
      print "###############################################################################\n"
      print "\n"
  end

  # Only return the result if we got user input (get_input == true)
  result if get_input
end

def gets_prices
  print "-> Enter each stock price for each day IN ORDER.\n"
  print "   E.g.: Entering the sequence '5, 7, 3' indicates a price\n"
  print "   of $5 on day 0, $7 on day 1, and $3 on day 2.\n"
  print "   Input ':q' when you have entered all of your substrings:\n\n"

  user_dictionary_entry = nil
  dictionary = []

  # ask for input and push it to the dictionary until the ':q' command is entered
  until user_dictionary_entry == ":q" do
    user_dictionary_entry = get_user_input
    # keep asking the user for a number or a quit command until they give us one
    until is_valid_input? user_dictionary_entry do
      print "-> ERROR: Please enter a number greater than 0 for price!\n"
      print "   Enter ':q' to quit\n"
      user_dictionary_entry = get_user_input
    end
    dictionary << user_dictionary_entry.to_f if is_price? user_dictionary_entry
  end

  # just printing some spacing
  get_user_input true, false

  # return the dictionary for processing
  dictionary
end

###############################################################################
## Main Function
###############################################################################
def stock_picker
  # Print a nice intro message
  print "###############################################################################\n"
  print "##################################Stock Picker#################################\n"
  print "###############################################################################\n\n"

  # create the price array with user input
  stock_prices = gets_prices

  # empty dictionaries to store max profit and days associated with those profits
  max_profit_array = []
  day_array = []

  stock_prices.each_with_index do | buy_price, buy_day |
    profit_vector = []
    day_vector = []
    stock_prices.each_with_index do |sell_price, sell_day|
      # can only sell stocks after you buy them, so only calc proft for days after purchase
      profit_vector.push buy_day < sell_day && sell_price ? sell_price - buy_price : nil
      # for each possible profit, need to keep track of the day purchased and the day sold
      day_vector.push [buy_day, sell_day]
    end
    # max profit is the buy-day / sell day combination that maximizes profit
    max_profit = profit_vector.compact.max
    max_profit_array.push max_profit
    day_array.push day_vector[profit_vector.find_index max_profit]
  end
  max_profit = max_profit_array.compact.max
  buy_sell_day = day_array[max_profit_array.find_index max_profit]

  # print the results to screen
  print "BUY BUY BUY on day #{buy_sell_day[0]}!!!\n"
  print "SELL SELL SELL on day #{buy_sell_day[1]}!!!\n"

  # also return the day vector
  buy_sell_day
end


###############################################################################
## Call Function
###############################################################################
stock_picker
