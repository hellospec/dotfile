require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:SAVE_HISTORY] = 200
IRB.conf[:PROMPT_MODE] = :SIMPLE