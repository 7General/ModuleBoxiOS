# 读取xcconfig文件

require 'fileutils'
require 'CSV'

module MBoxconfig
    class MBoxconfigXcconfig


        GZCONFIG_STD_CONFIG_LIST ||= %w[Version.xcconfig].freeze

        GZCONFIG_GLB_CONFIG_LIST ||= %w[Public.xcconfig].freeze
        GZCONFIG_EXT_CONFIG_FILE ||= 'Pods/extend.xcconfig'.freeze
        GZCONFIG_PACKAGE_INFO_FILE ||= '/Pods/packageinfo'.freeze

        CONFIG_REPLACEMENT_PACK_PATH ||= 'env_replacement'.freeze
        CONFIG_PACK_PATH ||= 'env'.freeze
        CONFIG_DIR_NAME ||= 'config'.freeze

        # 获取代码信息和git信息
        def MBoxconfigXcconfig.read_init_xcconfig_file_name(packname)

            config_list = []
            
            # /Users/zzg/Desktop/Study/组件化搭建之路
            module_work_path = MBoxconfig::MBoxconfigContext.instance.self_work_path
            # /Users/zzg/Desktop/Study/组件化搭建之路/env_replacement
            replacement_path = File.join(module_work_path,CONFIG_REPLACEMENT_PACK_PATH)
            
            # replacement_path 对应的路劲不存在文件夹
            if File.directory? replacement_path
                pack_path = replacement_path
            else
                pack_path = File.join(module_work_path,CONFIG_PACK_PATH,packname)
            end
            # pack_path=>/Users/zzg/Desktop/Study/组件化搭建之路/env/main

            config_file_dir = File.join(module_work_path,CONFIG_DIR_NAME)
            

            puts "============================================="
            puts __dir__
            puts "1:pack_path---->#{pack_path}"
            puts "2:config_file_dir------>#{config_file_dir}"
            puts "============================================="

            config_list.concat(GZCONFIG_GLB_CONFIG_LIST.map {|cfg|
                File.join(module_work_path,CONFIG_PACK_PATH,cfg)
            })
            puts "3:config_list------>#{config_list}"

            config_list.concat(GZCONFIG_STD_CONFIG_LIST.map {|cfg|
                File.join(pack_path,cfg)
            })
            puts "4:config_list------>#{config_list}"
            # Users/zzg/Desktop/Study/组件化搭建之路/Pods/extend.xcconfig
            ext_cfg_path = File.join(module_work_path,GZCONFIG_EXT_CONFIG_FILE)
            # if File.exists？ext_cfg_path?(ext_cfg_path)
            #     puts "ext_cfg_pathext_cfg_pathext_cfg_pathext_cfg_pathext_cfg_pathext_cfg_path"
            # end
            # puts "ext_cfg_pathext_cfg_pathext_cfg_path#{ext_cfg_path}"
            # puts "directorydirectorydirectory" if File::directory?(module_work_path)
            #  puts "directorydirectorydirectory" unless File::directory?(ext_cfg_path)
            # puts "existsexistsexists" if File::exists?(ext_cfg_path)

            `rm -r -f #{ext_cfg_path}` if File::exists?(ext_cfg_path)

            package_builder = `git config user.name`.strip
            package_builder = `whoami` if package_builder.nil? || package_builder.empty?
            package_env = packname

            hash = `git rev-parse --short HEAD`.strip
            hash = rand(0xffffff) if hash.start_with?('fatal') || hash.empty?

            branch = `git symbolic-ref --short -q HEAD`.strip
            branch = rand 0xffffff if branch.start_with?('fatal') || branch.empty?

            package_id = "#{branch}_#{hash}"
            package_desc = ''

            puts "5:ext_cfg_path------>#{ext_cfg_path}"

            package_info_path = File.join(module_work_path,GZCONFIG_PACKAGE_INFO_FILE)
            puts "6:package_info_path------>#{package_info_path}"
            if File.readable? package_info_path
            CSV.foreach(File.join(working_path, GZCONFIG_PACKAGE_INFO_FILE)) do |row|

                next if row[0].nil? || row[1].nil?

                key = row[0].strip
                val = row[1].strip

                case key
                when 'GZ_PACKAGE_ID'
                package_id = val unless val.empty?
                when 'GZ_PACKAGE_DESC'
                package_desc = val unless val.empty?
                when 'GZ_PACKAGE_BUILDER'
                package_builder = val unless val.empty?
                when 'GZ_PACKAGE_BRANCH'
                branch = val unless val.empty?
                when 'GZ_PACKAGE_ENV'
                package_env = val unless val.empty?
                else
                puts "unknown package info type:#{key}"
                end

            end
            end

            File.open(ext_cfg_path,'w') do |extenFile|
                extenFile.puts "GZ_PACKAGE_BUILDER |= \\@\\\"#{package_builder}\\\""
                extenFile.puts "GZ_PACKAGE_ENV |= \\@\\\"#{package_env}\\\""
                extenFile.puts "GZ_PACKAGE_ID |= \\@\\\"#{package_id}\\\""
                extenFile.puts "GZ_PACKAGE_DESC |= \\@\\\"#{package_desc}\\\""
                extenFile.puts "GZ_CODE_IDENTIFIER |= \\@\\\"#{branch}_#{hash}\\\""
            end
            config_list.push ext_cfg_path

            MBoxconfig::MBoxconfigContext.instance.environment_name = packname
            MBoxconfig::MBoxconfigContext.instance.config_file_list = config_list
        end
    end
end
