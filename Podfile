
require_relative './moduleScript/modulePods/modulepods'

def setup_module_common
     mods 'ModuleCenter' # 模块中心
     mods 'ModuleUIStack' # UIStak
     mods 'ModuleAppMain' # main模块
     mods 'ModuleCommonUI' # 基础UI模块
     mods 'ModuleHome' # 首页
     mods 'ModuleMine' # 个人中心
     
end


target 'ModuleBox' do
  setup_common
  setup_module_common

end


#post_install do |installer|
#  installer.pods_project.targets.each do |target|
#    puts "#{target.name}"
#  end
#  plugin_installer installer
#end



