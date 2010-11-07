require "term/ansicolor"
require "readline"
String.send(:include, Term::ANSIColor)

str = 'Ruby is not Gem!'

c = %w(red blue yellow green)
puts %w(Hello, try interactive colors!).map { |w| w.send(c.shift) }.join(" ")

while line = Readline.readline("> ", true)
  begin
    case line.strip
    when /^(q|quit|exit|bye)$/
      puts "bye bye!".blink.cyan
      exit
    when /^\s*=\s*/
      str = line.sub($&, '')
      puts str
    when /^(help|h|colors|attrs)$/
      print "input one or more attributes from followings: ex. bold red on_green\n\n"
      puts Term::ANSIColor.attributes.map { |attr| "#{attr}".send(attr) }.join(" ")
      print "\nto set a string, input string with prepend '='. ex. = Color is fun!\n"
    when /^rainbow$/
      c = %w(red green yellow blue magenta cyan white)
      s = rand(2) < 1 ? str.chars : str.split(/\b/)
      puts s.inject("") { |mem, chr| mem << chr.send(c[rand(c.length)]) }
    else
      puts line.split(/[,\s]+/).inject(str) { |mem, color| mem.send color }
    end
  rescue
    puts "is that color?"
  end
end
