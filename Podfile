
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
  _module_self_work_path __dir__
  _self_project 'ModuleBox'
  # 该方法必须调用，要获取xcconfig文件路径信息
  _self_enviromennt 'main'
  
  setup_common
  setup_module_common
  pod 'MSProgress'
end


post_install do |installer|
  _self_module_installer installer
#  installer.pods_project.targets.each do |target|
##    puts "============installerinstallerinstallerinstallerinstaller"
#    puts "#{target.name}"
#    say_mods target
#  end
end




