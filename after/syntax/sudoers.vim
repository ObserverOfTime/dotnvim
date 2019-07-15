syn match sudoersIncludeDirective /^#include\(dir\)\?/
syn match sudoersCmndNameInSpec /\%(^#include\(dir\)\?\)\@<=.*$/

hi link sudoersIncludeDirective PreProc
