require "term/ansicolor"
require "readline"
String.send(:include, Term::ANSIColor)

str = 'Ruby is not Gem!'

ATTRS = Term::ANSIColor.attributes
C = (ATTRS*" ")[/red.*?white/].split(" ")
puts %w(Hello, try interactive colors!).map.with_index { |w, i| w.send(C[i]) }.join(" ")

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
      puts ATTRS.map { |attr| "#{attr}".send(attr) }.join(" ")
      print "\nto set a string, input string with prepend '='. ex. = Is Ruby a Jam?\n"
      print "or try 'rainbow' to fun!\n"
    when /^rainbow$/
      s = [str.chars, str.split(/\b/), str.split(/\b/).reverse][rand(3)]
      puts s.inject("") { |mem, chr| mem << chr.send(C[rand(C.length)]) }
    else
      inputs = line.split(/[,\s]+/)
      raise unless (inputs.map(&:intern) - ATTRS).empty?
      puts inputs.inject(str) { |mem, color| mem.send color }
    end
  rescue
    puts "is that color?"
  end
end
