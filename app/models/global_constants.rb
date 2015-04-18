module GlobalConstants
  # also notice the call to 'freeze'
  # API = Hash["username" => "aaaaaaa", "password" => "aaaaaaaaaaaa"].freeze 
  COLORS = ["#f39c12", "#7f8c8d", "#3498db", "#8e44ad","#9b59b6", "#c0392b",
            "#1abc9c", "#27ae60", "#16a085",
             "#34495e", "#e67e22", "#d35400", "#A2A2A2"].freeze
  CARRIER = ["@txt.att.net", "@txt.att.net", "@mms.att.net", "@tmomail.net",
     "@vtext.com", "@vzwpix.com", "@messaging.sprintpcs.com", 
     "@mymetropcs.com", "@message.alltel.com", "@vmobl.com"].freeze
end