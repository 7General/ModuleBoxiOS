

$nameArray = []

class NSArray
    def say_array

        $nameArray = ["w","h","z"]
        puts "say_array, #{$nameArray}"



        # 您可以给数组中的每个元素赋值，
        name1 = Array.new(10,"mac")
        puts name1

        name2 = Array.new(10) {|e| e = e * 2}
        puts name2

        # 其他写法
        name2 = Array.[](1,2,3,4,5,nil,7)
        name3 = Array[1,2,3,4,5]
        name4 = Array(0..9)
        puts "name2,#{name2},name3,#{name3},name4,#{name4}"



        puts "index 2,#{name4.at(2)}" 
        name3.clear
        puts "name3,#{name3}" 
        name2.compact
        puts "name2,#{name2}" 
        return $nameArray
    end
end
