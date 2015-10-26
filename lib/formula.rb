require 'polish'
require 'float_number'

class Formula
  include Polish, FloatNumber

  def initialize(view, params = nil)
    @view = form_normal_view(view)
    @params = params
    @used_variables = Hash.new
  end

  def result
    begin
      calculate(with_placed_params)
    rescue
      return I18n.t :calculate_error
    end
  end

  def view
    with_placed_params.join(' ')
  end

  def variables
    with_placed_params
    @used_variables
  end

  def with_placed_params
    temp = @view.clone
    temp_params = (@params.nil?)? [] : @params.clone
      temp.map! do |symbol|
        change = symbol
        unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) )
            if @used_variables.keys.include? symbol
              change = @used_variables[symbol]
            else
              change = (temp_params[0].nil?)? @used_variables[symbol] = '0' : @used_variables[symbol] = temp_params.shift
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

end