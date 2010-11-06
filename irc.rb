require "term/ansicolor"
String.send(:include, Term::ANSIColor)

str = 'Ruby is not Gem!'

c = %w(red blue yellow green)
print %w(Hello, try interactive colors!).map { |w| w.send(c.shift) }.join(" "), "\n> "

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
      print "input one or more attributes from followings: ex. bold red on_green\n\n"
      puts Term::ANSIColor.attributes.map { |attr| "#{attr}".send(attr) }.join(" ")
      print "\nto set a string, input string with prepend '='. ex. = Color is fun!\n> "
    else
      print line.split(/[,\s]+/).inject(str) { |mem, color| mem.send color }, "\n> "
    end
  rescue
    print "is that color?\n> "
  end
end
