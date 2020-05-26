module MBoxconfig
    class MBoxconfigConfigFile

        # def initialize 
        #     # @configuration_dict = Hash.new {|h,k| h[k] = }
        # end

        ## 根据xcconfig路劲读取年内容
        def load_config(config_file_path)
            puts "load_configload_config#{config_file_path}"
            
            config_file_info = _load_config_file config_file_path
        end

        def _load_config_file(file_path)
            
            raise "#{file_path} unreadable" unless File.readable? file_path

            File.open(file_path,'r') do |xconfig_file|
                xconfig_file.each_line do |line|
                puts "1----line：#{line}"
                next unless line != "\n"
                
                puts "2----line：#{line}"
                is_macro = true
            
                line_data = if line =~ /[^= ]*\[.*\]\s*=.*/
                                /\s*(?<key>[^= ]*\s*\[.*\])\s*\|=\s*(?<value>.*)\s*/.match line
                            else
                                /\s*(?<key>[^= ]*)\s*\|=\s*(?<value>.*)\s*/.match line
                            end
        
                if line_data.nil?
        
                    line_data = if line =~ /[^= ]*\[.*\]\s*=.*/
                                /\s*(?<key>[^= ]*\s*\[.*\])\s*=\s*(?<value>.*)\s*/.match line
                                else
                                /\s*(?<key>[^= ]*)\s*=\s*(?<value>.*)\s*/.match line
                                end
        
                    is_macro = false
                end

                next if line_data.nil?
                puts "lineData---#{line_data}"
                raise "syntax error1 in #{file_path}:#{line}" if line_data.nil?

                key = line_data['key']
                value = line_data['value']
                
                raise "syntax error1 in #{file_path}:#{line}" if key.nil?
                raise "syntax error1 in #{file_path}:#{line}" if value.nil?
                puts "1.====================="
                if key =~ /\[.*config\s*=\s*.*\]/
                  puts "2.====================="
                    matched = /(?<key>.*)\[\s*(?<property>.*)\s*\]/.match(key)
                    raise "syntax error2 in #{file_path}:#{line}" if matched.nil?
                    
                    key = matched['key']
                    property_string = matched['property']
                    raise "syntax error3 in #{file_path}:#{line}" if key.nil?
                    raise "syntax error4 in #{file_path}:#{line}" if property_string.nil?
          
                    new_property_list = []
                    property_list = property_string.split(/\s*,\s*/)
                    property_list.each do |property|
                      unless property.start_with? 'config'
                        new_property_list.push property
                        next
                      end
          
                      config_property = property.split(/\s*=\s*/)
                      raise "syntax error5 in #{file_path}:#{line}" if config_property.length != 2
                      raise "syntax error6 in #{file_path}:#{line}" if config_property[0] != 'config'
          
                      config_string = config_property[1]
                      all_config_name = config_string.split(/\s*\|\s*/)
                      all_config_name.each do |config_name|
                        config = config_file.config_with_type(config_name)
          
                        key = "#{key}#{new_property_list.empty? ? '' : "[#{new_property_list.join(',')}]"}"
                        # if is_macro
                        #   config.add_macro(key, value)
                        # else
                        #   config.add_env(key, value)
                        # end
                      end
                    end
          
                  else
                    puts "3.====================="
                    # config = config_file.common_config
                    # if is_macro
                    #   config.add_macro(key, value)
                    # else
                    #   config.add_env(key, value)
                    # end
                  end
                    
                end
            end
            # config_file
        end

    end
end