#!/usr/bin/ruby

class Block
    ### 普通的block
    def say_block
        puts "在 say_block方法内"
        yield
        puts "又回到了say_block方法内"
        yield
    end

    ### block带参数外传
    def say_block_param
        yield 5
        puts "在 say_block_param方法内"
        yield 100,200
    end

    ### 块和方法
    ### block带参数内传
    # 但是如果方法的最后一个参数前带有 &，
    # 那么您可以向该方法传递一个块，且这个块可被赋给最后一个参数。
    # 如果 * 和 & 同时出现在参数列表中，& 应放在后面。
    def say_block_input_parma(&block)
        puts "\n=====say_block_input_parma======begin\n"
        block.call
        puts "\n=====say_block_input_parma======bend\n"
    end

    ### BEGIN 和 END 块
   
    # BEGIN { 
    #     # BEGIN 代码块
    #     puts "BEGIN 代码块"
    # } 
    END { 
        # END 代码块
        puts "================================END 代码块"
    }
    puts "================================================MAIN 代码块"
    

end