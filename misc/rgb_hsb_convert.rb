#!/usr/bin/env ruby
include Math
class Float
  def to_degree
    res = self * (180 / PI)
    res < 0 ? res + 360 : res  
  end

  def round_to(n)
    (self * 10**n).round / 10.0**n
  end
end

def rgb_to_hsb(*rgb)
  rgb = rgb.map(&:to_f)
  [hue(rgb), saturation(rgb), brightness(rgb)].map { |v| v.round_to(2) }
end

def hue(rgb)
  r, g, b = rgb
  atan2(sqrt(3) * (g - b), 2 * r - g - b).to_degree
end

def saturation(rgb)
  max, min = rgb.max, rgb.min
  if max.zero? && min.zero?
    0.0
  else
    (max - min) / max * 100
  end
end

def brightness(rgb)
  rgb.max / 2.55
end

def hsb_to_rgb(*hsb)
  hue, sat, bri = hsb
  max = bri * 2.55
	min = (1 - sat/100) * max
	decimal = hue/60.0 - (hue/60.0).floor
	dec = max * (1 - decimal * sat/100)
	inc = max * (1 - (1 - decimal) * sat/100)
  rgb =
  	case (hue/60).to_i
  	when 0 then [max, inc, min]
  	when 1 then [dec, max, min]
  	when 2 then [min, max, inc]
  	when 3 then [min, dec, max]
  	when 4 then [inc, min, max]
  	when 5 then [max, min, inc]
  	end
  rgb.map { |v| v.round_to(2) }
end
