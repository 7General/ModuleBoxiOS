

class FileHelper
    GZCONFIG_STD_CONFIG_LIST ||= %w[public.xcconfig core.xcconfig].freeze
    GZCONFIG_STD_CONFIG_LIST2 = %w[public.xcconfig core.xcconfig].freeze
    def say_file 
        puts __FILE__
        puts "=============文件==============="
        filePath = __dir__
        fileLocalPath = filePath + "/filte.json"
        puts File::exists?(fileLocalPath)

        File.open(fileLocalPath,"r") do |config_file|
            config_file.each_line do |lines|
                puts lines
            end
        end
    end


    # def say_read_config(installer)
    #     # puts GZCONFIG_STD_CONFIG_LIST
    #     # puts GZCONFIG_STD_CONFIG_LIST2
    #     puts "say_read_configsay_read_configsay_read_config"
    #     puts installer
    # end

end
