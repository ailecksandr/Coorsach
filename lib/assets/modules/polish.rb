module Polish
  PRIORITIES = {
      '^' => 4,
      '*' => 3, '/' => 3,
      '+' => 2, '-' => 2,
      '(' => 1, ')' => 1
  }

  def form_polish_view(view)
    stack = Array.new
    result = Array.new
    puts view
    view.each do |symbol|
      case symbol
        when '(' then stack.unshift symbol
        when ')'
          result << stack.shift while stack[0] != '('
          stack.shift
        when '+', '-', '/', '*', '^'
          while !stack.empty?
            if PRIORITIES[symbol] <= PRIORITIES[stack[0]] then result << stack.shift else break end
          end
          stack.unshift symbol
        else result << symbol
      end
    end
    (result << stack).join(' ')
  end

  def calculate_polish_view(view)
    stack = Array.new

    view.split.each do |symbol|
      case symbol
        when '+'
          temp = stack.shift
          stack[0] += temp
        when '-'
          temp = stack.shift
          stack[0] -= temp
        when '/'
          temp = stack.shift
          stack[0] /= temp
        when '*'
          temp = stack.shift
          stack[0] *= temp
        when '^'
          temp = stack.shift
          stack[0] **= temp
        else stack.unshift symbol.to_f
      end
    end

    stack[0].round(3).to_s
  end

  def calculate(view)
    calculate_polish_view( form_polish_view(view) )
  end

end