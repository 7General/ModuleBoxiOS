# 读取xcconfig文件
module MBoxconfig
    class MBoxconfigXcconfig


        GZCONFIG_STD_CONFIG_LIST ||= %w[Version.xcconfig].freeze

        GZCONFIG_GLB_CONFIG_LIST ||= %w[Public.xcconfig].freeze
        GZCONFIG_EXT_CONFIG_FILE ||= 'Pods/extend.xcconfig'.freeze
        GZCONFIG_PACKAGE_INFO_FILE ||= '/Pods/packageinfo'.freeze

        CONFIG_REPLACEMENT_PACK_PATH ||= 'env_replacement'.freeze
        CONFIG_PACK_PATH ||= 'env'.freeze
        CONFIG_DIR_NAME ||= 'config'.freeze

        def MBoxconfigXcconfig.read_init_xcconfig_file_name(packname)
            puts "packname"+packname

            config_list = []
            module_work_path = MBoxconfig::MBoxconfigContext.instance.self_work_path

            replacement_path = File.join(module_work_path,CONFIG_REPLACEMENT_PACK_PATH)

            
            if File.directory? replacement_path
                
                pack_path = replacement_path
            else
                pack_path = File.join(module_work_path,CONFIG_PACK_PATH,packname)
                
            end

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
            ext_cfg_path = File.join(module_work_path,GZCONFIG_EXT_CONFIG_FILE)
            puts "5:ext_cfg_path------>#{ext_cfg_path}"

            package_info_path = File.join(module_work_path,GZCONFIG_PACKAGE_INFO_FILE)
            puts "6:package_info_path------>#{package_info_path}"

            puts "config_listconfig_listconfig_list->>#{config_list}"

            MBoxconfig::MBoxconfigContext.instance.environment_name = packname
            MBoxconfig::MBoxconfigContext.instance.config_file_list = config_list
        end
    end
end
