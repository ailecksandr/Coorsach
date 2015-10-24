require 'fileutils'

class MainController < ApplicationController
  
  def index
    unless params[:first_formula].to_s.length == 0 || params[:second_formula].nil?.to_s.length == 0
      if File.file?('params-folder/' + params[:file_name] + '.txt')
        first_params = nil
        second_params = nil
        index = 0
        File.open('params-folder/' + params[:file_name] + '.txt').each_line do |line|
          if index == 0 then first_params = line.split else second_params = line.split end
          index += 1
        end
      end
      @formulas = [Formula.new(params[:first_formula], first_params), Formula.new(params[:second_formula], second_params)]
      @decision = @formulas[0].result == @formulas[1].result
    end
    flash[:warning] = 'Enter formulas' if @formulas.nil? && request.post?
  end

  def create_params
    message = { :error => 'Something goes wrong..' }
    unless params[:file_name].length == 0
      FileUtils.mkdir_p('params-folder') unless File.directory?('params-folder')
      File.open('params-folder/' + params[:file_name] + '.txt', 'w+') do |file|
        file.puts(params[:first_params])
        file.puts(params[:second_params])
      end
      message = { :notice => 'Succesfully created' }
    end
    flash[message.keys[0]] = message.values[0]
    redirect_to :back
  end

end
