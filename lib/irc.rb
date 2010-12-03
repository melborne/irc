require "term/ansicolor"
require "readline"
String.send(:include, Term::ANSIColor)

class Irc
  ATTRS = Term::ANSIColor.attributes
  COLORS = (ATTRS*" ")[/red.*?white/].split(" ")

  def initialize(str='Ruby is not Gem!')
    @str = @str_defo = str
  end

  def run
    puts welcome_message("Hello, try interactive colors!")

    while line = Readline.readline("> ", true)
      begin
        case line.strip
        when quit?
          puts "bye bye!".blink.cyan
          exit
        when set_string?
          @str = line.sub($&, '')
          puts @str
        when reset?
          @str = @str_defo
          puts @str
        when help?
          print help_manual
        when rainbow?
          puts sample_chars.inject("") { |mem, chr| mem << chr.send(COLORS.sample) }
        else
          inputs = line.split(/[,\s]+/)
          raise unless (inputs.map(&:intern) - ATTRS).empty?
          puts inputs.inject(@str) { |mem, color| mem.send color }
        end
      rescue
        puts "is that color?"
      end
    end
  end

  private
  def welcome_message(msg)
    msg.split(" ").map.with_index { |w, i| w.send(COLORS[i]) }.join(" ")
  end

  def quit?
    /^(q|quit|exit|bye)$/i
  end

  def set_string?
    /^\s*=\s*/
  end

  def reset?
    /^reset/i
  end

  def help?
    /^(help|h|colors|attrs)$/i
  end

  def rainbow?
    /^rainbow/i
  end

  def help_manual
    <<-EOS
     Input one or more attributes from followings: ex. bold red on_green

     #{ATTRS.map { |attr| "#{attr}".send(attr) }.join(" ")}

     To set a string, input string with prepend '='. ex. = Is Ruby a Jam?
     Or try 'rainbow' to fun!
    EOS
  end

  def sample_chars
    [ @str.chars, 
      @str.split(/\b/),
      @str.split(/\b/).reverse
     ].sample
  end
end

if __FILE__ == $0
  Irc.new.run
end
