
# require 'installpods/installpodsHelper'
require_relative 'installpods/installpodsHelper'
# 创建类
require_relative 'rbBasic/Person'
require_relative 'rbBasic/Block'
require_relative 'rbBasic/SupportModule'
require_relative 'rbBasic/String'
require_relative 'rbBasic/NSArray'
# 文件读写
require_relative 'file/FileHelper'



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
    # objc = Person.new
    # objc.sayHello
end

objc = Person.new("1223")
objc.sayHello
objc.sayGlobbal
objc.say_detail()
objc.say_const
objc.say_currentName

puts  objc.sayIOSCount
puts "=====begin========="
puts Person::MR_IOS_COUNT
puts ::MR_IOS_COUNT
puts "=====end=========\n\n\n\n"


objc.say_ifelse(1)

objc.say_condition
objc.say_unless(2)
objc.say_unless_more
objc.say_case(2)
objc.say_case(15)
objc.say_case(200)

objc.say_case_more


objc.say_while
objc.say_while_more
objc.say_until
objc.say_until_more
objc.say_for
objc.say_for_more

puts objc.returnFuncation

objc.samplefuncation("11","22","33","44")
objc.samplefuncation "55","66","77"

Person.classfuncation("qq","ww","ee","rr")

objc.AABBCC


block = Block.new
block.say_block{
    puts "在,modulepods.rb文件内"
}
puts "===================="
block.say_block_param { 
    |itemA,itemB|
    puts "block内部传入的参数循环,#{itemA}内\n"
    puts "block内部传入的参数循环,#{itemB}内"
}
block.say_block_input_parma{
    (0..5).each do |item|
        puts "向block内部传入的参数循环,#{item}内\n"
    end
}

SupportModulePlusInfo::SupportModulePlusContext.instance.say_module_sunshine
SupportModulePlusInfo.sayHello


objcStr = String.new
objcStr.say_string


objArray = NSArray.new
objArray.say_array.each do |item|
    puts "items,#{item}"
end


file = FileHelper.new
file.say_file

# file.say_read_config

