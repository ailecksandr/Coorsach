require 'fileutils'

class MainController < ApplicationController
  
  def index
    unless params[:first_formula].nil? && params[:second_formula].nil? && params[:file_name].nil?
      if File.file?('params-folder/' + params[:file_name] + '.txt')
        first_params = nil
        second_params = nil
        index = 0
        File.open('params-folder/' + params[:file_name] + '.txt').each_line do |line|
          if index == 0 then first_params = line.split else second_params = line.split end
          index += 1
        end
        puts first_params.join(' ') + second_params.join(' ')
        @formulas = [Formula.new(params[:first_formula], first_params), Formula.new(params[:second_formula], second_params)]
      end
    end
  end

  def create_params
    message = 'Something goes wrong..'
    unless params[:file_name].nil? || params[:first_params].nil? || params[:second_params].nil?
      FileUtils.mkdir_p('params-folder') unless File.directory?('params-folder')
      File.open('params-folder/' + params[:file_name] + '.txt', 'w+') do |file|
        file.puts(params[:first_params])
        file.puts(params[:second_params])
      end
      message = 'Succesfully created'
    end
    redirect_to :back, notice: message
  end



end
