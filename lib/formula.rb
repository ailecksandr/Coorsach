require 'polish'

class Formula
  include Polish

  attr_accessor :view, :params

  def initialize(view, params = null)
    @view = form_normal_view(view)
    @params = params
  end

  def result
    place_params unless @params.nil?

    return 'Wrong formula' if @view.nil?
    return calculate(@view)

  end

  private

  def form_normal_view(view)
    @view = view.gsub(/[+-\/*^()]/, '+' => ' + ', '-' => ' - ',
                      '/' => ' / ', '*' => ' * ', '^' => ' ^ ',
                      '(' => ' ( ', ')' => ' ) ')
    @view.split
  end

  def place_params
    used_variables = Hash.new
    @view.map! do |symbol|
      change = symbol
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) )
        if used_variables.keys.include? symbol
          change = used_variables[symbol]
        else
          change = used_variables[symbol] = @params.shift
        end
      end
      change
    end
  end

  def is_number? string
    true if Float(string) rescue false
  end

end