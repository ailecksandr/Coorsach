require 'polish'
require 'float_number'

class Formula
  include Polish, FloatNumber

  def initialize(view, params = nil)
    @view = form_normal_view(view)
    @params = params
  end

  def result
    begin
      calculate(with_placed_params)
    rescue
      return I18n.t :calculate_error
    end
  end

  def view
    form_view
  end

  def variables
    form_variables_view
  end

  private

  def form_normal_view(view)
    @view = view
    replacements = [ ['+', ' + '], ['-', ' - '], ['/', ' / '], ['*', ' * '],
                     ['^', ' ^ '], ['(', ' ( '], [')', ' ) '], ['.', '.'], [',',  ' / / '],
                     ['-  - ',  '- -'], ['(  - ', '( -'], ['+  - ', '( -'], ['/  - ', '( -'],
                     ['*  - ', '( -'], ['^  - ', '( -'] ]
    replacements.each {|replacement| @view.gsub!(replacement[0], replacement[1])}
    temp = @view.split
    if temp[0] == '-'
      temp.shift
      temp[0] = '-' + temp[0]
    end
    temp
  end

  def form_variables_view
    used_variables = Hash.new
    temp_params = (@params.nil?)? [] : @params.clone
    @view.each do |symbol|
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) ) ||
          (used_variables.keys.include?(symbol[1..-1]) && symbol[0] == '-') || used_variables.keys.include?(symbol)
        if temp_params[0].nil?
          if symbol[0] == '-'
            used_variables[symbol[1..-1]] = '0'
          else
            used_variables[symbol] = '0'
          end
        else
          if symbol[0] == '-'
            used_variables[symbol[1..-1]] = temp_params.shift
          else
            used_variables[symbol] = temp_params.shift
          end
        end
      end
    end
    used_variables
  end

  def select_used_params
    used_variables = Hash.new
    temp_params = (@params.nil?)? [] : @params.clone
    @view.each do |symbol|
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) ) ||
          (used_variables.keys.include?(symbol[1..-1]) && symbol[0] == '-') || used_variables.keys.include?(symbol)
        if temp_params[0].nil?
          if symbol[0] == '-'
            used_variables[symbol[1..-1]] = '0.0'
          else
            used_variables[symbol] = '0.0'
          end
        else
          if symbol[0] == '-'
            used_variables[symbol[1..-1]] = temp_params.shift
          else
            used_variables[symbol] = temp_params.shift
          end
        end
      end
    end
    used_variables
  end

  def with_placed_params
    temp = @view.clone
    used_variables = select_used_params
    temp.map! do |symbol|
      change = symbol
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) )
        if used_variables.keys.include? symbol
          change = used_variables[symbol]
        elsif used_variables.keys.include?(symbol[1..-1]) && symbol[0] == '-'
          change = (-used_variables[symbol[1..-1]].to_f).to_s
        end
      end
      change
    end
    temp
  end

  def form_view
    temp = @view.clone
    used_variables = select_used_params
    temp= temp.map do |symbol|
      change = symbol
      unless ('+-()*^/'.include? symbol) || ( is_number?(symbol) )
        if used_variables.keys.include? symbol
          change = used_variables[symbol]
        elsif used_variables.keys.include?(symbol[1..-1]) && symbol[0] == '-'
          change = (used_variables[symbol[1..-1]].to_f > 0)? '-' + used_variables[symbol[1..-1]] : (-used_variables[symbol[1..-1]].to_f).to_s
        end
      end
      change
    end
    puts temp.join(' ')
    temp.join(' ')
  end

end