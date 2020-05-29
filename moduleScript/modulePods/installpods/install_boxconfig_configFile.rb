
require_relative 'install_boxconfig_info'

module MBoxconfig
class MBoxconfigConfigFile

  COMMON_CONFIG_KEY = :BOX_XCCONFIG_COMMON_CONFIG_KEY
  def initialize 
      @configuration_dict = Hash.new {|h,k| h[k] = MBoxconfigInfo.new}
  end


  def common_config
    @configuration_dict[COMMON_CONFIG_KEY]
  end


  def config_with_type(type)
    @configuration_dict[type]
  end


  def final_config_with_type(type)
    # type - debug/release
    # puts "1.common_config>#{common_config}"
    common_config_info = common_config.clone
    # puts "2.common_config_info>#{common_config_info}"
    # puts "3.config_with_type>#{config_with_type(type)}"
    specific_config_info = config_with_type(type).clone
    # puts "4.specific_config_info>#{specific_config_info}"
    # merge 合并
    common_config_info.merge specific_config_info
    common_config_info
  end

  # 当前已经读取内容的数据源
  def config_info_dict
    @configuration_dict
  end
  ## 根据xcconfig路劲读取文件内容
  def load_config(config_file_path)
      config_file_info = _load_config_file config_file_path
      # puts "1.config_file_infoconfig_file_info#{config_file_info}"
      merge config_file_info
      # puts "2.config_file_infoconfig_file_info#{config_file_info}"
      # puts "3.configuration_dict#@configuration_dict"
  end

  def merge(config_file_info)
    config_file_info.config_info_dict.each do |name,config|
       @configuration_dict[name].merge config
    end
  end

  #任意对象都能直接使用to_s()去描述自身
  # 中重写了to_s()，使之转换成字符串格式的数值描述形式
  def to_s
    @configuration_dict.to_s
  end

  def _load_config_file(file_path)
      raise "#{file_path} unreadable" unless File.readable? file_path
      # 实例化自己本类
      config_file = MBoxconfigConfigFile.new

      File.open(file_path,'r') do |xconfig_file|
          xconfig_file.each_line do |line|
          ret = (/^\/\/.*/ =~ line)
          next unless ret.nil?
          next unless line != "\n"
          
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
          
          raise "syntax error1 in #{file_path}:#{line}" if line_data.nil?

          key = line_data['key']
          value = line_data['value']
          
          raise "syntax error1 in #{file_path}:#{line}" if key.nil?
          raise "syntax error1 in #{file_path}:#{line}" if value.nil?
          
          if key =~ /\[.*config\s*=\s*.*\]/
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
                if is_macro
                  config.add_macro(key, value)
                else
                  config.add_env(key, value)
                end
                end
              end
            else
              # 暂且只走这里
              config = config_file.common_config
              config.add_macro(key,value)
              # if is_macro
              #   config.add_macro(key, value)
              # else
              #   config.add_env(key, value)
              # end
            end
          end
      end
      #{:GZC_XCCONFIG_COMMON_CONFIG_KEY=>#<GZXCConfigPlugin::GZXCConfigInfo:0x00007f8c557e2dc0 @env_dict={}, @macro_dict={"GZ_PACKAGE_BUILDER"=>"\\@\\\"wanghuizhou\\\"", "GZ_PACKAGE_ENV"=>"\\@\\\"main\\\"", "GZ_PACKAGE_ID"=>"\\@\\\"dev_730_ebc86c3a9\\\"", "GZ_PACKAGE_DESC"=>"\\@\\\"\\\"", "GZ_CODE_IDENTIFIER"=>"\\@\\\"dev_730_ebc86c3a9\\\""}>}
      #config_file>>>>{:BOX_XCCONFIG_COMMON_CONFIG_KEY=>#<MBoxconfig::MBoxconfigInfo:0x00007fe91c261d78 @macro_dict={"GZC_BUILD_NUMBER"=>"0"}>}
      #
      # puts "config_file>>>>#{config_file}"
      config_file
  end

end
end