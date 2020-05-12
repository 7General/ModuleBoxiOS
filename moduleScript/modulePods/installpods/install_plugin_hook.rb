# 
# 重写module函数用于加载本地module，通过Development Pod开发模块
#
def mods(module_name)
    pod module_name,path:module_name
end 

def say_mods(installer)
    puts "say_modssay_modssay_modssay_mods"
    # pod targetName
    # puts "#{target.name}"
end 