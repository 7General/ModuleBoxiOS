require 'singleton'


# 基本配置文件和配置信息

module MBoxconfig
   
    class MBoxconfigContext
        include Singleton

         # 初始化
        def initialize
            # 工程路径
            @self_work_path = nil
            # 项目名称
            @projects = []
            # 模块名称
            @modules = []
            # 配置文件list
            @config_file_list = []
            @environment_name = nil
        end

        ## 申明可读可写的变量（注意 :位置）
        attr_accessor :self_work_path
        attr_accessor :config_file_list
        attr_accessor :environment_name

        def add_project(project)
            @projects.push(project)
        end

        def value_all_projects
            @projects.map {
                |project|
                File.join(self_work_path,project)
            }
        end

        def add_modules(self_module)
            @modules.push(self_module)
        end

        def value_all_modules 
            @modules
        end
        
    end



    

end