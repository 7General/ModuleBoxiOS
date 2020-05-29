module MBoxconfig
class MBoxconfigInfo
    attr_reader :macro_dict
    attr_reader :env_dict

    def initialize
        @env_dict = Hash.new { |h, k| h[k] = {} }
        @macro_dict = Hash.new { |h, k| h[k] = {} }
    end

    def add_env(key, val)
        @env_dict[key] = val
    end
    
    def add_macro(key,val)
        @macro_dict[key] = val
    end

    def merge(another_config)
        @env_dict.merge! another_config.env_dict
        @macro_dict.merge! another_config.macro_dict
      end

    def to_s
        "#{@env_dict}\n#{@macro_dict}"
    end
end
end