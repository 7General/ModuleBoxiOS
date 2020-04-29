
# require 'installpods/installpodsHelper'
require_relative 'installpods/installpodsHelper'


print("Hello,Ruby!\n")

puts "================="

puts "=================#{(20 * 2)}"

# 数组循环输出
Arry = ["f",1,2,"last"]

Arry.each do |i|
   puts i
end

# 字典循环输出
colors = {"c"=>1,"d"=>2}
colors.each do |key,value|
	print key," Is ",value,"\n"
end

# 范围类型输出
(10..15).each do |n|
	puts n,"\n"
        print n,"\n\n"
end

# 定义一个方法，可在podfile文件中调用,后面加()，都可以
def setup_common()
    puts "setup_commonsetup_common"
    setup_common_child
end

def setup_common_child
    puts "setup_common_child"
end
