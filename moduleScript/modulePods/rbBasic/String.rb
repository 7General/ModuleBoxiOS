class String
    def say_string
        name = "strirng"
        puts "say_string->你好，#{name}"

        x, y, z = 12, 36, 72
        puts "x 的值为 #{ x }"
        puts "x + y 的值为 #{ x + y }"
        puts "x + y + z 的平均值为 #{ (x + y + z)/3 }"
    end
end