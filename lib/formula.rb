require 'polish'

class Formula
  include Polish

  def initialize(view, params = nil)
    @view = form_normal_view(view)
    @params = params
  end

  def result
    begin
      calculate(with_placed_params)
    rescue
      return 'Error'
    end
  end

  def view
    with_placed_params.join(' ')
  end

  def with_placed_params
    used_variables = Hash.new
    temp = @view.clone
    temp_params = @params.clone
    temp.map! do |symbol|
      change = symbol
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) )
        if used_variables.keys.include? symbol
          change = used_variables[symbol]
        else
          change = used_variables[symbol] = temp_params.shift
        end
      end
      change
    end
    temp
  end

  private

  def form_normal_view(view)
    @view = view.gsub(/[+-\/*^()]/, '+' => ' + ', '-' => ' - ',
                      '/' => ' / ', '*' => ' * ', '^' => ' ^ ',
                      '(' => ' ( ', ')' => ' ) ')
    @view.split
  end

  def is_number? string
    true if Float(string) rescue false
  end

end