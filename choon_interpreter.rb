# Choon interpreter

prog = $<.readlines
transpose = 0
lastval = 0
outbuf = []
tokens = []
prog.each {|line|
  line.scan(/([A-G][#b]?)|([~%?\-+.])|(=?[a-z]+\d*)|(=[-\d]\d*)|(:\|\|)|(\|\|:)|(\/\/.*)/) {
    # puts $&
    tokens << $&
  }
}
progposition = 0
repeatstarts = []
repeatcounts = []
markers = Hash.new
lastmarker = Hash.new
while (tokens[progposition])
  t = tokens[progposition]
  if (t =~ /^[A-G]/)
    val = "G A BC D EF".index(t[0]) - 5
    if (t[1])
      if (t[1]== ?#)
        val += 1
      elsif (t[1]== ?b)
        if (val==-5)
          val = 6
        else
          val -= 1
        end
      end
    end
    lastval = val + transpose
    outbuf<< lastval
    # puts lastval
  elsif (t =~ /^[a-z]+\d*/)
    # print t
    # puts " as variable"
    if (markers[t])   # save for the x=x case
      lastmarker = {t => markers[t]}
    end
    markers[t] = outbuf.size
  elsif (t =~ /^=[-\d]\d*/)
    lastval = outbuf[t[1..-1].to_i - 1] + transpose
    outbuf << lastval
    # puts lastval
  elsif (t =~ /^=[a-z]+\d*/)
    m = markers[t[1..-1]]
    if (m && m < outbuf.size)
      lastval = outbuf[m] + transpose
    elsif (lastmarker[t[1..-1]])
      lastval = outbuf[lastmarker[t[1..-1]]] + transpose
    else
      $stderr.print "Marker \"#{t[1..-1]}\" was used before being set\n"
      exit(1)
    end
    outbuf << lastval
    # puts lastval
  else
    case t
    when "-"
      transpose -= lastval if lastval
    when "+"
      transpose += lastval if lastval
    when "."
      transpose = 0
    when "||:"
      if (lastval == nil || lastval > 0)
        repeatstarts << progposition
        if lastval 
          repeatcounts << lastval
        else
          repeatcounts << -1  # nil means forever
        end
      else # jump to end of this repeat
        incounts=1
        while (tokens[progposition] && incounts > 0)
          while (tokens[progposition] && tokens[progposition] != ":||")
            if (tokens[progposition] == "||:")
              incounts += 1
            end
            progposition+=1
          end
          incounts -= 1
        end
      end
    when ":||"
      repeatcounts[-1] -= 1
      if (repeatcounts[-1] == 0)
        repeatstarts.pop
        repeatcounts.pop
      else
        progposition=repeatstarts[-1]      
      end
    when "~"
      if (lastval == 0)
        incounts=1
        while (tokens[progposition] && incounts > 0)
          while (tokens[progposition] && tokens[progposition] != ":||")
            if (tokens[progposition] == "||:")
              incounts += 1
            end
            progposition+=1
          end
          incounts -= 1
        end
        repeatstarts.pop
        repeatcounts.pop
      end
    when "%"
      outbuf << nil
      # puts "nil"
      lastval = nil
    when "?"
      r=[]
      12.times {
        while (r.index(n=rand(12) - 9 + transpose))
        end
        r << n
        outbuf << n
        # puts n
      }
      lastval = outbuf[-1]
    end
  end
  progposition+=1
end

outbuf.each {|o|
  # print "\nT100"
  # print ";",o if o
  print "\n"
  o ? print(o) : print("R")
}
