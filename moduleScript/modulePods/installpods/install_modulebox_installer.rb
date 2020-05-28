
require_relative 'install_boxconfig_configFile'
require_relative 'install_boxconfig_context'


###
# 参考 https://blog.csdn.net/ehyubewb/article/details/79954255
###

module MBoxconfig
    class MBoxconfigInstaller
        # installer 
        def inject(installer,config_file_list)
            inject_project config_file_list
        end

        # 配置文件路劲
        def inject_project(config_file_list)
            # 读取配置文件中内容合并返回
            config_file = load_configs config_file_list

            
            plist_set = Set[]

            MBoxconfigContext.instance.value_all_projects.uniq.each do |projec_name|
                puts "projec_name====>>>#{projec_name}"
                # 组装xcodeproj
                proj_path = "#{projec_name}.xcodeproj"
                # 获取pod中的xcodeproj的target（代表着整个工程）
                proj_ref = Xcodeproj::Project.open(proj_path)
                
                # 获取工程的基本配置（buildConfigurationList代表着针对target的配置项）
                proj_ref.build_configuration_list.build_configurations.each do |build_configuration_ref|  #(buildConfiguration属性为具体的配置)
                    
                    # 依赖的target-ModuleBox\ModuleBoxTests\ModuleBoxUITests
                    # 获取工程创建的target（代表工程创建的target）
                    proj_ref.targets.each do |target_ref|
                        # target 的配置项target_ref.build_configuration_list.build_configurations
                        target_ref.build_configurations.each do |config|
                            plist_set.add config.build_settings['INFOPLIST_FILE']
                        end
                        pod_target_xcconfig_file = "Pods/Target Support Files/"\
                                                    "Pods-#{target_ref.name}/"\
                                                    "Pods-#{target_ref.name}.#{build_configuration_ref.name}.xcconfig"\
                        # 拼接pod路径
                        pod_target_xcconfig_file = File.join(MBoxconfigContext.instance.self_work_path,pod_target_xcconfig_file)

                        next unless File.exist? pod_target_xcconfig_file

                        puts "\n\n\n 000:pod_target_xcconfig_file #{pod_target_xcconfig_file}===="
                        # 读取pod本身的xcconfig_file文件内容 
                        xcconfig_file_content = File.read(pod_target_xcconfig_file)
                        
                        # puts "\n\n\n 1:xcconfig_file_content #{xcconfig_file_content}===="
                        File.open(pod_target_xcconfig_file,'w') do |xcconfig_file|
                            puts "\n\n 1.xcconfig_file->#{xcconfig_file} "
                            xcconfig_file.puts xcconfig_file_content
                            puts "========"
                            
                        end

                        # file的puts，要和File.join配合使用
                        tempFiles= File.join(__dir__,"/temp")
                        # 创建file文件
                        t_files = File.new(tempFiles,'w')
                        # 对创建的文件，写入内容
                        t_files.puts "hello word"
                        File.open(tempFiles,'r') do |f_t_file|
                            puts "f_t_filef_t_file-->>#{f_t_file}"
                        end
                        # puts "\n\n\n 2:xcconfig_file_content #{xcconfig_file_content}===="
                        
                    end
                end
                
             
            end
        end

        def write_config(file,config_file,config_name)

        end

        def load_configs(config_file_list)
            box_config_file = MBoxconfigConfigFile.new
            # 遍历配置文件路径
            config_file_list.each do |config_file_path|
                next unless File.readable? config_file_path
                # 根据xcconfig路劲读取文件内容
                box_config_file.load_config config_file_path
                
            end
            box_config_file
        end
    end
end
