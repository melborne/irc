Shoes.app :title => 'Shoes Colors', :width => 600, :height => 600 do
  colors = Shoes::COLORS.to_a.sort_by { |k, v| v.to_s }
  colors.each do |name, color|
    flow :width => 0.33 do
      background color
      para strong(name), "\n", color, :stroke => (color.dark? ? white : black),
        :margin => 4, :align => 'center'
    end
  end
end
