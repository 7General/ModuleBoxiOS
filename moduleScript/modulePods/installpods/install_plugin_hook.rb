# 
# 重写module函数用于加载本地module，通过Development Pod开发模块
#

require_relative 'install_boxconfig_context'
require_relative 'install_boxconfig_xcconfig'
require_relative 'install_modulebox_installer'

def mods(module_name)
    MBoxconfig::MBoxconfigContext.instance.add_modules(module_name)
    pod module_name,path:module_name
end 

# 读取modules
def read_self_mods
    MBoxconfig::MBoxconfigContext.instance.value_all_modules
end


# 保存工程路径
def _module_self_work_path(path)
    MBoxconfig::MBoxconfigContext.instance.self_work_path = path
end

# 读取工程路径
def read_self_work_path 
    puts MBoxconfig::MBoxconfigContext.instance.self_work_path
end

# 设置工程名
def _self_project(project)
    MBoxconfig::MBoxconfigContext.instance.add_project(project)
    puts read_self_project
end
# 读取工程名
def read_self_project 
    puts MBoxconfig::MBoxconfigContext.instance.value_all_projects
end


def _self_enviromennt(enviroment_name)
    MBoxconfig::MBoxconfigXcconfig.read_init_xcconfig_file_name enviroment_name
end


def _self_module_installer(installer)
    MBoxconfig::MBoxconfigInstaller.new.inject(installer,MBoxconfig::MBoxconfigContext.instance.config_file_list)
end
