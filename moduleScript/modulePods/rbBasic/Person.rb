

$p_agment=22
$CORDION = 3
$BOOLEFALSE = 1

MR_IOS_COUNT = "OUT THERE"
class Person 
    # 类变量
    # $开头：全局变量（Global variable）。
    # @开头：实例变量（Instance variable）。
    # @@开头：类变量（Class variable）类变量被共享在整个继承链中
    # 大写字母开头：常数（Constant）
    #
    @@p_age=10
    # 常量
    VERSION_SELF = 300
    # 初始化类函数
    def initialize(ages)
        @cust_name=ages
    end

    # 自定义函数
    def sayHello
        puts "cust_name,#@cust_name"
        puts "p_age,#@@p_age"
        puts "p_agment,#$p_agment"
    end

    def sayGlobbal 
        puts "输入全局变量p_agment，#$p_agment"
    end

    def say_detail()
        puts "实例变量cust_name，#@cust_name"
    end

    def say_const 
        puts "常量VERSION_SELF，#{VERSION_SELF}"
    end

    def say_currentName
        puts "当前文件路径，#{__FILE__}"
    end

    # ##########
    # 运算符 "." 和双冒号运算符 "::"
    ##############
    MR_COUNT = 0
    module Footer
        MR_COUNT = 11
        ::MR_COUNT = 22
        MR_COUNT = 33
    end
    puts "MR_COUNT=========="
    puts MR_COUNT
    puts Footer::MR_COUNT



    MR_IOS_COUNT = proc {' in beijinng '}
    def sayIOSCount 
        ::MR_IOS_COUNT + " #@cust_name" + ' 河南省信阳市' 
    end

    ### 注释
=begin
这是多行注释
这是多行注释
这是多行注释
=end
    ### 条件判断if....else 
    def say_ifelse(x)
        if x > 2
            puts "x 大于 2"
        elsif x<= 2 and x!= 0
            puts "x == 1"
        else 
            puts "无法得知"
        end
       

    end
    ### 条件判断if修饰符
    def say_condition 
        #code if condition
        #  if修饰词组表示当 if 右边之条件成立时才执行 if 左边的式子。即如果 conditional 为真，则执行 code。
       puts 'CORDION\n' if $CORDION
       print 'CORDION  > 2\n' if $CORDION > 2
       puts "\n===================\n"
    end


    ### unless
    def say_unless(inputs)

        # unless式和 if式作用相反，即如果 conditional 为假，则执行 code。
        # 如果 conditional 为真，则执行 else 子句中指定的 code。
        puts "say_unlesssay_unlesssay_unless" unless inputs > 1
        
        unless inputs > 2
            puts "inputs > 2"
        else
            puts "inputs < 2"
        end
    end
    ### unless 修饰符
    def say_unless_more
        puts "1---这一行输出\n" if $BOOLEFALSE
        $BOOLEFALSE = false
        puts "2---这一行不输出\n" if $BOOLEFALSE
    end


    ### case 语句
    def say_case(inputs)
        case inputs
        when 0..2
        puts "婴儿"
        when 3..6
            puts "小孩"
        when 7..12
            puts "child"
        when 13..18
            puts "少年"
        else 
            puts "其他年龄段"
        end
    end
    ### case 语句修饰符
    def say_case_more 
        foo = false
        bar = true
        quu = false
        case 
            when foo then 'foo is true'
            when bar then puts 'bar is true'
            when quu then puts 'quu is true'
        end
    end

    ### while 语句
    def say_while 
        foo = 12
        while foo >= 0 do
            puts "while语句，#{foo}"
            foo -= 1
        end
    end
    ### while 修饰符
    # 语法
# code while condition
 
# 或者
 
# begin 
#   code 
# end while conditional
    def say_while_more
        foo = 12
        begin
            puts "say_while_more->while语句，#{foo}"
            foo -= 1
        end while foo >= 0
    end
    ### until 语句
    # until conditional [do]
    #     code
    #  end
    #  当 conditional 为假时，执行 code。
    # 语法中 do 可以省略不写。但若要在一行内写出 until 式，则必须以 do 隔开条件式或程式区块。
    def say_until
        foo = 0
        until foo >= 5 do
            puts "say_until->until,#{foo}"
            foo += 1;
        end
    end
    ### until 语句修饰符
    # code until conditional
    # 或者
    # begin
    # code
    # end until conditional
    # 当 conditional 为 false 时，执行 code。
    # 如果 until 修饰符跟在一个没有 rescue 或 ensure 子句的 begin 语句后面，code 会在 conditional 判断之前执行一次
    def say_until_more
        foo = 0
        begin
            puts "say_until_more->until,#{foo}"
            foo += 1;
        end until foo >= 5
    end

    ### for 语句修饰符
    # for variable [, variable ...] in expression [do]
    #     code
    #  end
     
    # 0...5->0,1,2,3,4
    # 0..5->0,1,2,3
    def say_for
        for i in 0...5
            puts "say_for局部变量，#{i}"
        end
    end
    # for...in 循环几乎是完全等价于：
    # (expression).each do |variable[, variable...]| code end
    # 但是，for 循环不会为局部变量创建一个新的作用域。
    # 语法中 do 可以省略不写。但若要在一行内写出 for 式，则必须以 do 隔开条件式或程式区块。
    def say_for_more 
        (0..5).each do |item|
            puts "say_for_more局部变量，#{item}"
        end
    end


    ### 方法返回值
    def returnFuncation
        return 200
    end
    ### 可变数量的参数
    def samplefuncation(*param)
        puts "参数个数为#{param.length}"
        param.each do |item|
            puts "参数为#{item}"
        end
    end

    ### 类方法
    def Person.classfuncation(*param)
        puts "参数个数为#{param.length}"
        param.each do |item|
            puts "参数为#{item}"
        end
    end

    ### alias 语句
    # 这个语句用于为方法或全局变量起别名。别名不能在方法主体内定义。即使方法被重写，方法的别名也保持方法的当前定义。
    # 为编号的全局变量（$1, $2,...）起别名是被禁止的。重写内置的全局变量可能会导致严重的问题。
    # 语法
    # alias 方法名 方法名
    # alias 全局变量 全局变量
    # 实例
    # alias foo bar
    # alias $MATCH $&
    # 在这里，我们已经为 bar 定义了别名为 foo，为 $& 定义了别名为 $MATCH。
    def say_alias
        (0..5).each do |item|
            puts "say_alias,#{item}"
        end
    end
    alias AABBCC  say_alias




    ### undef 语句
    # 这个语句用于取消方法定义。undef 不能出现在方法主体内。
    # 通过使用 undef 和 alias，类的接口可以从父类独立修改，但请注意，在自身内部方法调用时，它可能会破坏程序。
    # undef 方法名
    # 下面的实例取消名为 bar的方法定义：
    # undef bar
end