require "termcolor"

str = 'Ruby is not Gem!'

c = %w(red blue yellow green)
print %w(Hello, try interactive colors!).inject("") { |mem, w| mem << "<#{t=c.shift}>#{w}</#{t}> " }.termcolor, "\n> "

while line = gets.chomp!
  begin
    case line
    when /^(q|quit|exit|bye)$/
      print "bye!\n"
      exit
    when /^\s*=\s*/
      str = line.sub($&, '')
      print str, "\n> "
    when /^(help|colors|attrs)$/
      colors = HighLine.constants[7..-3]
      print colors.inject("") { |mem, color| mem << "<#{color}>#{color}</#{color}> " }.termcolor, "\n> "
    else
      print line.split(/[,\s]+/).inject(str) { |mem, color| "<#{color}>#{mem}</#{color}>" }.termcolor, "\n> "
    end
  rescue
    print "is that color?\n> "
  end
end

