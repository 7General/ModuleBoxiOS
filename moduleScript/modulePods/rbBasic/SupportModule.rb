

# require 'singleton'

module SupportModulePlusInfo
    VERSION_CAR_POSTION = 12
    VERSION_CAR_NAME = "别克"

    def SupportModulePlusInfo.sayHello
        puts "gogogogoggog"
    end
    


    class SupportModulePlusContext

        include  Singleton


        def say_module_sunshine
            puts "模块中的方法"
        end
    end

    
end