
require_relative 'install_boxconfig_configFile'
require_relative 'install_boxconfig_context'


###
# 参考 https://blog.csdn.net/ehyubewb/article/details/79954255
###

module MBoxconfig
    class MBoxconfigInstaller
        # installer 
        def inject(installer,config_file_list)
            # 首先向壳工程添加注入信息
            inject_project config_file_list
        end



        

        # 配置文件路劲-》向壳工程（主工程中添加注入信息）
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
                        
                        puts "\n\n\n 1:xcconfig_file_content #{xcconfig_file_content}===="

                        # =============================================================================
                        # 此处已经读取config内容，问题是为什么非要在此读取之后村存入
                        # temp_config_file = File.join(MBoxconfigContext.instance.self_work_path,'/test.text')
                        # temp_config_read = File.read(temp_config_file)
                        # temp_config_read = temp_config_read.concat("werrwerwer")
                        # puts "temp_config_readtemp_config_read#{temp_config_read}"
                        # File.open(temp_config_file,'w') do |temp_x_file|
                        #     temp_x_file.puts temp_config_read
                        #     # temp_x_file.puts "sdfsdfsd"
                        #     puts "temp_x_filetemp_x_file#{temp_x_file}"
                        # end
                        # =============================================================================

                        File.open(pod_target_xcconfig_file,'w') do |xcconfig_file|
                            xcconfig_file.puts xcconfig_file_content
                            # puts "\n\n 1.xcconfig_file->#{xcconfig_file} "
                            write_config(xcconfig_file,config_file,build_configuration_ref.name)
                        end

                        # xcconfig_file_content = File.read(pod_target_xcconfig_file)
                        # puts "\n\n\n 222:xcconfig_file_content #{xcconfig_file_content}===="

                        # # file的puts，要和File.join配合使用
                        # tempFiles= File.join(__dir__,"/temp")
                        # # 创建file文件
                        # t_files = File.new(tempFiles,'w')
                        # # 对创建的文件，写入内容
                        # t_files.puts "hello word"
                        # File.open(tempFiles,'r') do |f_t_file|
                        #     puts "f_t_filef_t_file-->>#{f_t_file}"
                        # end
                        # puts "\n\n\n 2:xcconfig_file_content #{xcconfig_file_content}===="
                        
                    end
                end
                proj_ref.save
            end
            plist_set.each do |plist|
                puts "plistplistplist>#{plist}"
                # 返回 path 的绝对路径，扩展 ~ 为进程所有者的主目录，~user 为用户的主目录。相对路径是相对于 dir 指定的目录，如果 dir 被省略则相对于当前工作目录。
                plist_path = File.expand_path(plist)
                # 更新文件中的修改时间（mtime）和访问时间（atime）list。如果文件不存在，则会创建文件。
                FileUtils.touch plist_path if File.exist? plist_path
                
            end
        end

        ##
        # file - open(w)打开的文件
        # config_file - MBoxconfigConfigFile
        # config_name - debug/release
        def write_config(file,config_file,config_name)
            
            config_info = config_file.final_config_with_type config_name
            
            
            cflags_string = cgflag_with_config config_info.macro_dict
            cflags_string = cflags_string.strip!


            # env_dict 为空
            config_dict = config_info.env_dict.clone
            config_dict['OTHER_CFLAGS'] = "$(inherited) #{cflags_string}" unless cflags_string.nil? || cflags_string.empty?
            puts "cflags_stringcflags_string>#{cflags_string}"

            config_dict.each do |key,value|
                value_string = value or ' '
                file.puts "#{key} = #{value_string}"
            end

        end

        # 拼接字符格式添加other_c_link
        def cgflag_with_config(config)
            cflags = ' '
            config.each do |key,value|
             if !value.nil? && value != ''
                cflags << '-D' << key.to_s << '=' << value.to_s << ' '
             else
                cflags << '-D' << key.to_s << ' '
             end
            end

            cflags
        end

        # 读取xcconfig文件内容形成MBoxconfigConfigFile类文件
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
