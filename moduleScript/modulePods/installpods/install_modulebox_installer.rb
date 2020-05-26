
require_relative 'install_boxconfig_configFile'

module MBoxconfig
    class MBoxconfigInstaller
        # installer 
        def inject(installer,config_file_list)
            inject_project config_file_list
        end

        # 
        def inject_project(config_file_list)
            config_file = load_configs config_file_list
        end

        def load_configs(config_file_list)
            puts "config_file_listconfig_file_list#{config_file_list}";
            box_config_file = MBoxconfigConfigFile.new

            config_file_list.each do |config_file_path|
                
                box_config_file.load_config config_file_path
                
            end
        end
    end
end
