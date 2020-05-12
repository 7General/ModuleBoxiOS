# 
# 重写module函数用于加载本地module，通过Development Pod开发模块
#
def mods(module_name)
    pod module_name,path:module_name
end 

def say_mods(target)
    target.build_configurations.each do |configuration|
        puts "name----------------"+configuration.name
        # target.build_settings(configuration.name)['OTHER_CFLAGS'] = "$(inherited) #{cflags_string}" unless cflags_string.nil? || cflags_string.empty?
        # target.build_settings(configuration.name)['OTHER_CFLAGS'] = "$(inherited) \"${PODS_CONFIGURATION_BUILD_DIRtttt}/ModuleCommonUIttt\" "
        # $(inherited) -ObjC -l"ModuleAppMain" -l"ModuleCenter" -l"ModuleCommonUI" -l"ModuleHome" -l"ModuleUIStack" -framework "UIKit" 
        target.build_settings(configuration.name)['OTHER_CFLAGS'] = "$(inherited) -DBaiduWebLBSAPIAK=\@\"ugiPyPymt485B2LU3hjjHTzpT2ykSRyC\""

    end
end 