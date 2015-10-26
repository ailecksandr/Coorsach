require 'fileutils'
require 'json'
require 'float_number'

class MainController < ApplicationController
  include FloatNumber

  def comparator
    if params[:first_formula].to_s.length == 0 || params[:second_formula].to_s.length == 0
      flash.now[:warning] = t(:formulas_not_found) if @formulas.nil? && request.post?
    else
      if params[:file_name].to_s.length != 0
        if File.exist?('params-folder/' + params[:file_name] + '.json')
          first_params = []
          second_params = []
          json_temp = JSON.parse( File.read('params-folder/' + params[:file_name] + '.json') )
          json_temp.each_with_index do |formula, index|
            formula.each_value do |params|
              params.each do |param|
                if index == 0 then first_params << param['param'] else second_params << param['param'] end
              end
            end
          end
          @formulas = [Formula.new(params[:first_formula], first_params), Formula.new(params[:second_formula], second_params)]
        else
          flash.now[:error] = t(:file_not_found) if request.post?
        end
      else
        @formulas = [Formula.new(params[:first_formula], nil), Formula.new(params[:second_formula], nil)]
      end
    end
  end

  def create_params
    message = nil
    catch :data_error do
      if params[:first_params].to_s.length == 0 || params[:second_params].to_s.length == 0 ||
          params[:file_name].to_s.length == 0
        message = { :warning => t(:fields_not_filled) }
        throw :data_error
      else
        message = { :error => t(:wrong_arguments) }
        params[:first_params].split.each{ |param| throw :data_error unless is_number?(param) }
        params[:second_params].split.each{ |param| throw :data_error unless is_number?(param) }
      end
      FileUtils.mkdir_p('params-folder') unless File.directory?('params-folder')
      first_params = params[:first_params].split.map{ |x| { param: x } }
      second_params = params[:second_params].split.map{ |x| { param: x } }
      temp_json = [first_params, second_params].map{ |x| { formula: x} }
      File.open('params-folder/' + params[:file_name] + '.json', 'w+') do |file|
        file.write( JSON.pretty_generate(temp_json) );
      end
      message = { :notice => t(:succesfully_created) }
    end
    flash[message.keys[0]] = message.values[0]
    redirect_to :back
  end

end
