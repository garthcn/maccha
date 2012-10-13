module ItemsHelper
  def items_pagination(url, current, total, num)
    result = ''
    if total <= 5
      result << "<ul>"
      if current > 1
        result << "<li><a href=#{url}&page=#{current - 1}" +
          "&num=#{num}>&laquo;</a></li>"
      else
        # result << "<li class=\"disabled\"><span>&laquo;</span></li>"
      end
      (1..total).each do |i|
        result << "<li"
        if current == i
          result << " class=\"active\"><span>#{i}</span></li>"
        else
          result << "><a href=#{url}&page=#{i}&num=#{num}>#{i}</a></li>"
        end
      end
      if current < total
        result << "<li><a href=#{url}&page=#{current + 1}" +
          "&num=#{num}>&raquo;</a></li>"
      else
        # result << "<li class=\"disabled\"><span>&raquo;</span></li>"
      end
      raw result << "</ul>"

    else # total > 5
      result << "<ul>"
      if current > 3
        result << "<li><a href=#{url}&page=1&num=#{num}>First</a></li>"
      else
        # result << "<li class=\"disabled\"><span>First</span></li>"
      end
      if current > 1
        result << "<li><a href=#{url}&page=#{current - 1}" +
          "&num=#{num}>&laquo;</a></li>"
      else
        # result << "<li class=\"disabled\"><span>&laquo;</span></li>"
      end

      i = current - 2
      i = 1 if i < 1
      j = current + 2
      j = total if j > total
      (i..j).each do |i|
        result << "<li"
        if current == i
          result << " class=\"active\"><span>#{i}</span></li>"
        else
          result << "><a href=#{url}&page=#{i}&num=#{num}>#{i}</a></li>"
        end
      end

      if current < total
        result << "<li><a href=#{url}&page=#{current + 1}" +
          "&num=#{num}>&raquo;</a></li>"
      else
        # result << "<li class=\"disabled\"><span>&raquo;</span></li>"
      end
      if current < total - 2
        result << "<li><a href=#{url}&page=#{total}&num=#{num}>Last</a></li>"
      else
        # result << "<li class=\"disabled\"><span>Last</span></li>"
      end
      raw result << "</ul>"
    end
  end
end
