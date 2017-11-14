require "textament/version"

module Textament

  class Theme
    def vert_separator
      "+"
    end
    def horz_separator
      "-"
    end
    def vert_separator_big
      "="
    end
    def horz_separator_big
      "="
    end
    def vert
      "|"
    end
    def numbers
      true
    end
  end

  class DotTheme
    def vert_separator
      ":"
    end
    def horz_separator
      "."
    end
    def vert_separator_big
      ";"
    end
    def horz_separator_big
      ":"
    end
    def vert
      ":"
    end
    def numbers
      false
    end
  end

  class LineTheme
    def vert_separator
      " "
    end
    def horz_separator
      "-"
    end
    def vert_separator_big
      " "
    end
    def horz_separator_big
      "="
    end
    def vert
      " "
    end
    def numbers
      false
    end
  end

  def self.row(columns:, column_sizes:, content:, theme: )

    if content == :separator
      vert = theme.vert_separator
      horz = theme.horz_separator
    elsif content == :separator_big
      vert = theme.vert_separator_big
      horz = theme.horz_separator_big
    else
      vert = theme.vert
      horz = " "
    end

    print vert
    columns.keys.each_with_index do |k,ci|
      size = column_sizes[ci]
      if ci != 0
        print vert
      end

      # reduce size by full width chars
      a = "#{content[ci]}".scan(/[\p{Hiragana}\p{Katakana}\p{Han}]/)
      size -= a.length

      for i in 1..size
        char = horz

        if content.is_a? Array
          str = " #{content[ci]} "
          if str.length > i-1
            char = str[i-1]
          end
        end
        print char
      end
    end
    print "#{vert}\n"
  end

  def self.table(data:, width: 80, theme: Textament::Theme.new, spread: :even)
    columns = {}
    data.each do |x|
      x.each do |key,value|
        length = "#{value}".length
        length += "#{value}".scan(/[\p{Hiragana}\p{Katakana}\p{Han}]/).length

        if length > "#{columns[key]}".to_i
          columns[key] = length
        end
      end
    end

    column_separators = 2 + columns.count - 1
    content_space = width - column_separators

    column_sizes = []
    total_column = columns.values.inject(0){|sum,x| sum + x }

    columns.each do |key,value|
      if spread == :even
        column_sizes << content_space / columns.count
      elsif spread == :content
        column_sizes << (value.to_f / total_column * content_space).to_i
      end
    end

    slack = width - (column_sizes.inject(0){|sum,x| sum + x } + column_separators)
    column_sizes[column_sizes.length-1] += slack

    if theme.numbers
      for i in 1..width
        print (i / 10) % 10
      end
      print "\n"
      for i in 1..width
        print i % 10
      end
      print "\n"
    end

    self.row(columns: columns, column_sizes: column_sizes, content: :separator, theme: theme)

    self.row(columns: columns, column_sizes: column_sizes, content: columns.keys, theme: theme)

    self.row(columns: columns, column_sizes: column_sizes, content: :separator_big, theme: theme)

    data.each do |x|
      self.row(columns: columns, column_sizes: column_sizes, content: columns.keys.map{|k| "#{x[k]}"}, theme: theme)

      self.row(columns: columns, column_sizes: column_sizes, content: :separator, theme: theme)
    end

    print "\n"

  end

end

