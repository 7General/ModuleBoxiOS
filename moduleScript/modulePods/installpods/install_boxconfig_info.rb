module MBoxconfig
class MBoxconfigInfo
    attr_reader :macro_dict

    def initialize
        @macro_dict = Hash.new { |h, k| h[k] = {} }
    end
    
    def add_macro(key,val)
        @macro_dict[key] = val
    end

    def merge(another_config)
        #@env_dict.merge! another_config.env_dict
        @macro_dict.merge! another_config.macro_dict
      end

    def to_s
        "#{@macro_dict}"
    end
end
end