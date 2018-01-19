
local TIME_CHECK = 2
function exi_files(cpath)
    local files = {}
    local pth = cpath
    for k, v in pairs(scandir(pth)) do
		table.insert(files, v)
    end
    return files
end

 function file_exi(name, cpath)
    for k,v in pairs(exi_files(cpath)) do
        if name == v then
            return true
        end
    end
    return false
end
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
local function index_function(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v[1] then
    	print(k)
      return k
    end
  end
  -- If not found
  return false
end
local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 
local function already_sudo(user_id)
  for k,v in pairs(_config.sudo_users) do
    if user_id == v then
      return k
    end
  end
  -- If not found
  return false
end
local function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end
local function sudolist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '\n `🚸•  قائمه المطورين •🚸`\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n'
   else
 text = '\n `🚸•  قائمه المطورين •🚸`\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n'
  end
for i=1,#sudo_users do
    text = text..i.." • "..sudo_users[i].."\n"
end
return text
end

local function adminlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local sudo_users = _config.sudo_users
  if not lang then
 text = '\n `🚸•  قائمه الاداريين •🚸`\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n'
   else
 text = '\n `🚸•  قائمه الاداريين •🚸`\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n'
  end
		  	local compare = text
		  	local i = 1
		  	for v,user in pairs(_config.admins) do
			    text = text..i..' • '..(user[2] or '')..' 〰('..user[1]..')\n'
		  	i = i +1
		  	end
		  	if compare == text then
   if not lang then
		  		text = '📮 | • لا يوجد اداريين في المجموعه •'
      else
		  		text = '📮 | • لا يوجد اداريين في المجموعه •'
           end
		  	end
		  	return text
    end
	local function storm_chat(msg)
i = 1
local data = load_data(_config.moderation.data)
local groups = 'groups'
if not data[tostring(groups)] then
return '📮 | • لا توجد مجموعات مفعله'
end
local message = ' 📮 | • المجموعات •\n\n'
for k,v in pairsByKeys(data[tostring(groups)]) do
local group_id = v
if data[tostring(group_id)] then
settings = data[tostring(group_id)]['settings']
end
for m,n in pairsByKeys(settings) do
if m == 'set_name' then
name = n:gsub("", "")
i = i + 1
end end end
return '📮 | •  عدد المجموعات  🔻 *[ '..i..' ]*\n'
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function get_variables_hash(msg) 
  if gp_type(msg.chat_id_) == 'chat' or gp_type(msg.chat_id_) == 'channel' then 
    return 'chat:bot:variables' 
  end 
end 

local function get_value(msg, var_name) 
  local hash = get_variables_hash(msg) 
  if hash then 
    local value = redis:hget(hash, var_name) 
    if not value then 
      return 
    else 
      return value 
    end 
  end 
end 

local function list_chats(msg) 
  local hash = get_variables_hash(msg) 

  if hash then 
    local names = redis:hkeys(hash) 
    local text = '📮 | • قائمه الردود • ️\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n'
    for i=1, #names do 
      text = text..'📮 | • الرد • [ `'..names[i]..'` ]\n' 
    end 
       tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md') 
   else 
   return 
  end 
end 

local function save_value(msg, name, value) 
  if (not name or not value) then 
    return "Usage: !set var_name value" 
  end 
  local hash = nil 
  if msg.to.type == 'chat' or msg.to.type == 'channel'  then 
    hash = 'chat:bot:variables' 
  end 
  if hash then 
    redis:hset(hash, name, value) 
   tdcli.sendMessage(msg.chat_id_, 0, 1, '📮 | • الرد • [ `'..name..' ` ]\n📮 | • تم اضافته مع الردود •', 'md') 
  end 
end 
local function del_value(msg, name) 
  if not name then 
    return 
  end 
  local hash = nil 
  if gp_type(msg.chat_id_) == 'chat' or gp_type(msg.chat_id_) == 'channel'  then 
    hash = 'chat:bot:variables' 
  end 
  if hash then 
    redis:hdel(hash, name) 
      tdcli.sendMessage(msg.chat_id_, 0, 1, '📮 | • الرد • [ `'..name..'` ]\n📮 | • تم حذفه من الردود •', 'md') 
  end 
end 

local function delallchats(msg) 
  local hash = 'chat:bot:variables' 

  if hash then 
    local names = redis:hkeys(hash) 
    for i=1, #names do 
      redis:hdel(hash,names[i]) 
    end 
    return "📮 | • تم مسح قائمه الردود •" 
   else 
   return 
  end 
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function savePlug(txt, pname)
	name, text = pname, txt
	local file = io.open("./plugins/"..name..".lua", "w")
	file:write(text)
	file:flush()
	file:close()
end
-------------------------------------------------------------------------------------------------------------
local function mmm(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  return chat
end
----------------------------------------------------------------------------------------------------------------------------------------
local function run_bash(str)
    local cmd = io.popen(str)
    local result = cmd:read('*all')
    return result
end
--------------------------------
local api_key = nil
local base_api = "https://maps.googleapis.com/maps/api"
--------------------------------
local function get_latlong(area)
	local api      = base_api .. "/geocode/json?"
	local parameters = "address=".. (URL.escape(area) or "")
	if api_key ~= nil then
		parameters = parameters .. "&key="..api_key
	end
	local res, code = https.request(api..parameters)
	if code ~=200 then return nil  end
	local data = json:decode(res)
	if (data.status == "ZERO_RESULTS") then
		return nil
	end
	if (data.status == "OK") then
		lat  = data.results[1].geometry.location.lat
		lng  = data.results[1].geometry.location.lng
		acc  = data.results[1].geometry.location_type
		types= data.results[1].types
		return lat,lng,acc,types
	end
end
--------------------------------
local function get_staticmap(area)
	local api        = base_api .. "/staticmap?"
	local lat,lng,acc,types = get_latlong(area)
	local scale = types[1]
	if scale == "locality" then
		zoom=8
	elseif scale == "country" then 
		zoom=4
	else 
		zoom = 13 
	end
	local parameters =
		"size=600x300" ..
		"&zoom="  .. zoom ..
		"&center=" .. URL.escape(area) ..
		"&markers=color:red"..URL.escape("|"..area)
	if api_key ~= nil and api_key ~= "" then
		parameters = parameters .. "&key="..api_key
	end
	return lat, lng, api..parameters
end
------------------------------------------------------------------------------------------------------------------------------------------------------------
local function getChatId(chat_id)
  local chat = {}
  local chat_id = tostring(chat_id)
  if chat_id:match('^-100') then
    local channel_id = chat_id:gsub('-100', '')
    chat = {ID = channel_id, type = 'channel'}
  else
    local group_id = chat_id:gsub('-', '')
    chat = {ID = group_id, type = 'group'}
  end
  return chat
end
--------------------------------------------------------------------------------------------
local function modadd(msg) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
    -- superuser and admins only (because sudo are always has privilege) 
    if not is_admin(msg) then 
   if not lang then 
        return " " 
else 
     return " " 
    end 
end 
    local data = load_data(_config.moderation.data) 
  if data[tostring(msg.to.id)] then 
if not lang then 
   return '📮 | • تـم تفعيـل المجمـوعـة •'
else 
return '📮 | • تـم تفعيـل المجمـوعـة •'
  end 
end 
        -- يتم تخزين السورس في ملف data moderation.json 
      data[tostring(msg.to.id)] = { 
              owners = {}, 
      mods ={}, 
      banned ={}, 
      is_silent_users ={}, 
      filterlist ={}, 
      replay ={},
      whitelist ={}, 
      settings = { 
          set_name = msg.to.title, 
          link = '🔒', 
          tag = '🔓', 
          spam = '🔓', 
          webpage = '🔓', 
          markdown = '🔓', 
          flood = '🔕', 
          lock_bots = '🔒', 
          lock_pin = '🔓', 
          welcome = '✔', 
                  forward = '🔓', 
                  view = '🔓', 
                  audio = '🔓', 
                  video = '🔓', 
                  contact = '🔓', 
                  text = '🔓', 
                  photos = '🔓', 
                  gif = '🔓', 
                  location = '🔓', 
                  document = '🔓', 
                  sticker = '🔓', 
                  voice = '🔓', 
                   chat = '🔓', 
               keyboard = '🔓', 
        num_msg_max = '10', 
        set_char = '4000', 
        time_check = '2' 
          } 
      } 
  save_data(_config.moderation.data, data) 
      local groups = 'groups' 
      if not data[tostring(groups)] then 
        data[tostring(groups)] = {} 
        save_data(_config.moderation.data, data) 
      end 
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id 
      save_data(_config.moderation.data, data) 
    if not lang then 
  return '📮 | • تـم تفعيـل المجمـوعـة •'
else 
  local text = '📮 | • تـم تفعيـل المجمـوعـة •'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=28, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
end 

local function modrem(msg) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
    -- superuser and admins only (because sudo are always has privilege) 
      if not is_admin(msg) then 
     if not lang then 
        return " " 
    end 
   end 
    local data = load_data(_config.moderation.data) 
    local receiver = msg.to.id 
  if not data[tostring(msg.to.id)] then 
  if not lang then 
    return '📮 | • تـم تعطـيل مجمـوعـة 👇\n • [`'..msg.to.title..'`] •' 
else 
    return '📮 | • تـم تعطـيل مجمـوعـة 👇\n • [`'..msg.to.title..'`] •' 
   end 
  end 

  data[tostring(msg.to.id)] = nil 
  save_data(_config.moderation.data, data) 
     local groups = 'groups' 
      if not data[tostring(groups)] then 
        data[tostring(groups)] = nil 
        save_data(_config.moderation.data, data) 
      end data[tostring(groups)][tostring(msg.to.id)] = nil 
      save_data(_config.moderation.data, data) 
 if not lang then 
  return '📮 | • تـم تعطـيل مجمـوعـة 👇\n • [`'..msg.to.title..'`] •' 
 else 
  local text = '📮 | • تـم تعطـيل مجمـوعـة 👇\n • [`'..msg.to.title..'`] •' 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=22, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
end 

local function filter_word(msg, word) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
local data = load_data(_config.moderation.data) 
  if not data[tostring(msg.to.id)]['filterlist'] then 
    data[tostring(msg.to.id)]['filterlist'] = {} 
    save_data(_config.moderation.data, data) 
    end 
if data[tostring(msg.to.id)]['filterlist'][(word)] then 
   if not lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
            else 
         return "📮 | • الــكلمه [` "..word.." `]\n📮 | •  تـم منعـــها بنجـاح" 
    end 
end 
   data[tostring(msg.to.id)]['filterlist'][(word)] = true 
     save_data(_config.moderation.data, data) 
   if not lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
            else 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
    end 
end 

local function unfilter_word(msg, word) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 local data = load_data(_config.moderation.data) 
  if not data[tostring(msg.to.id)]['filterlist'] then 
    data[tostring(msg.to.id)]['filterlist'] = {} 
    save_data(_config.moderation.data, data) 
    end 
      if data[tostring(msg.to.id)]['filterlist'][word] then 
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil 
       save_data(_config.moderation.data, data) 
       if not lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
       elseif lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
     end 
      else 
       if not lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
       elseif lang then 
         return "📮 | • الــكلمه •` "..word.." `•\n📮 | •  تـم منعـــها بنجـاح" 
      end 
   end 
end 

local function modlist(msg) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
    local data = load_data(_config.moderation.data) 
    local i = 1 
  if not data[tostring(msg.chat_id_)] then 
  if not lang then 
    return '📮 | • الــمجمــوعــه [`'..msg.to.title..'`]\n📮 | • لـم يتـم تفعـيلهـا'
 else 
    return '📮 | • الــمجمــوعــه [`'..msg.to.title..'`]\n📮 | • لـم يتـم تفعـيلهـا'
  end 
 end 
  -- determine if table is empty 
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way 
  if not lang then 
    return "📮 | • لا يـوجـد ادمـنيـه فـي المـجموعـه •" 
else 
   return "📮 | • لا يـوجـد ادمـنيـه فـي المـجموعـه •" 
  end 
end 
if not lang then 
   message = '•🚸• قـائمـه الادمـنيـه •🚸•\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n' 
else 
   message = '•🚸• قـائمـه الادمـنيـه •🚸•\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n' 
end 
  for k,v in pairs(data[tostring(msg.to.id)]['mods']) 
do 
    message = message ..i.. '- '..v..' [' ..k.. '] \n' 
   i = i + 1 
end 
  return message 
end 

local function ownerlist(msg) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
    local data = load_data(_config.moderation.data) 
    local i = 1 
  if not data[tostring(msg.to.id)] then 
if not lang then 
    return '📮 | • الــمجمــوعــه [`'..msg.to.title..'`]\n📮 | • لـم يتـم تفعـيلهـا'
else 
return  '📮 | • الــمجمــوعــه [`'..msg.to.title..'`]\n📮 | • لـم يتـم تفعـيلهـا'
  end 
end 
  -- determine if table is empty 
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way 
 if not lang then 
    return  "📮 | • لا يـوجـد مـدراء فـي المـجموعـه •" 
else 
    return  "📮 | • لا يـوجـد مـدراء فـي المـجموعـه •" 
  end 
end 
if not lang then 
   message = '•🚸• قـائمـه المـدراء •🚸•\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n' 
else 
   message = '•🚸• قـائمـه j •🚸•\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n' 
end 
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do 
    message = message ..i.. '- '..v..' [' ..k.. '] \n' 
   i = i + 1 
end 
  return message 
end 

local function action_by_reply(arg, data) 
  local cmd = arg.cmd 
if not tonumber(data.sender_user_id_) then return false end 
    if data.sender_user_id_ then 
    if cmd == "رفع اداري" then 
local function adminprom_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if is_STADMN(tonumber(data.id_)) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md") 
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md") 
      end 
   end 
       table.insert(_config.admins, {tonumber(data.id_), user_name}) 
      save_config() 
     if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md") 
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, adminprom_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
    if cmd == "تنزيل اداري" then 
local function admindem_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
   local nameid = index_function(tonumber(data.id_)) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if not is_STADMN(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md") 
      end 
   end 
      table.remove(_config.admins, nameid) 
      save_config() 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, admindem_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
    if cmd == "رفع مطور" then 
local function visudo_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if already_sudo(tonumber(data.id_)) then 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md") 
      end 
   end 
          table.insert(_config.sudo_users, tonumber(data.id_)) 
      save_config() 
     reload_plugins(true) 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md") 
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
    if cmd == "تنزيل مطور" then 
local function desudo_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
     if not already_sudo(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md") 
      end 
   end 
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_))) 
      save_config() 
     reload_plugins(true) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, desudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
else 
    if lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(data.chat_id_, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
local hash = "gp_lang:"..data.chat_id_ 
local lang = redis:get(hash) 
  local cmd = arg.cmd 
if not tonumber(data.sender_user_id_) then return false end 
if data.sender_user_id_ then 
  if cmd == "حظر" then 
local function ban_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
   if is_STMOD(arg.chat_id, data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "  ", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
         end 
     end 
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   kick_user(data.id_, arg.chat_id) 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, ban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
   if cmd == "الغاء الحظر" then 
local function unban_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, unban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "كتم" then 
local function silent_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
   if is_STMOD(arg.chat_id, data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
    else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
       end 
     end 
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
     end 
   end 
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
  if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, silent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "الغاء الكتم" then 
local function unsilent_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, unsilent_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "حظر عام" then 
local function gban_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
  if not administration['gban_users'] then 
    administration['gban_users'] = {} 
    save_data(_config.moderation.data, administration) 
    end 
   if is_STADMN(data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
  else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
        end 
     end 
if is_gbanned(data.id_) then 
   if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
    else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
  administration['gban_users'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   kick_user(data.id_, arg.chat_id) 
     if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, gban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "الغاء العام" then 
local function ungban_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
  if not administration['gban_users'] then 
    administration['gban_users'] = {} 
    save_data(_config.moderation.data, administration) 
    end 
if not is_gbanned(data.id_) then 
   if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
  administration['gban_users'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, ungban_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "طرد" then 
   if is_STMOD(data.chat_id_, data.sender_user_id_) then 
   if not lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "  ", 0, "md") 
    elseif lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, " ", 0, "md") 
   end 
  else 
     kick_user(data.sender_user_id_, data.chat_id_) 
     end 
  end 
  if cmd == "delall" then 
   if is_STMOD(data.chat_id_, data.sender_user_id_) then 
   if not lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, " ", 0, "md") 
   elseif lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "  ", 0, "md") 
   end 
  else 
tdcli.deleteMessagesFromUser(data.chat_id_, data.sender_user_id_, dl_cb, nil) 
   if not lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "┑ • تــم مــسح رسـائله •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي •  *"..data.sender_user_id_.."*", 0, "md") 
      elseif lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "┑ • تــم مــسح رسـائله •\n┥ • العضــو • "..data.sender_user_id_.."*", 0, "md") 
       end 
    end 
  end 
else 
    if lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "  ", 0, "md") 
   else 
  return tdcli.sendMessage(data.chat_id_, "", 0, "  ", 0, "md") 
      end 
   end 
local hash = "gp_lang:"..data.chat_id_ 
local lang = redis:get(hash) 
local cmd = arg.cmd 
    local administration = load_data(_config.moderation.data) 
if not tonumber(data.sender_user_id_) then return false end 
    if data.sender_user_id_ then 
  if not administration[tostring(data.chat_id_)] then 
  if not lang then 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
else 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
     end 
  end 
if cmd == "رفع مدير" then 
local function owner_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
    if cmd == "رفع ادمن" then 
local function promote_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
     if cmd == "تنزيل مدير" then 
local function rem_owner_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
    else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
    if cmd == "تنزيل ادمن" then 
local function demote_cb(arg, data) 
    local administration = load_data(_config.moderation.data) 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
  end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
end 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = data.sender_user_id_ 
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
  if cmd == "الرتبه" then
local function visudo_cb(arg, data)
if data.username_ then
storm_user = '@'..check_markdown(data.username_)
else
storm_user = "📮 | • لا يوجد لديه معرف 😣"
end
if is_STSUD(data.id_) then
mokh = 'المطور 👮'
elseif is_STOWRS(arg.chat_id,data.id_) then
mokh = "المدير 💂"
elseif is_STMOD(arg.chat_id,data.id_) then
mokh = "الادمن 👦"
else
mokh = "العضو 👲"
end
local informeshn = "📮 | • الايدي •  ["..data.id_.."]\n📮 | • الاسم •"..check_markdown(data.first_name_).."\n📮 | • المعرف • "..storm_user..'\n📮 | • الرتبه •'..mokh
return tdcli.sendMessage(arg.chat_id, 1, 0, informeshn, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
if cmd == "ايدي" then 
local function id_cb(arg, data) 
return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md") 
end 
tdcli_function ({ 
ID = "GetUser", 
user_id_ = data.sender_user_id_ 
}, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_}) 
  end 
else 
    if lang then 
  return tdcli.sendMessage(data.chat_id_, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(data.chat_id_, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
end 


local function action_by_username(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local cmd = arg.cmd 
if not arg.username then return false end 
    if data.id_ then 
if data.type_.user_.username_ then 
user_name = '@'..check_markdown(data.type_.user_.username_) 
else 
user_name = check_markdown(data.title_) 
end 
    if cmd == "رفع اداري" then 
if is_STADMN(tonumber(data.id_)) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
      end 
   end 
       table.insert(_config.admins, {tonumber(data.id_), user_name}) 
      save_config() 
     if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
   end 
end 
    if cmd == "تنزيل اداري" then 
   local nameid = index_function(tonumber(data.id_)) 
if not is_STADMN(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
      end 
   end 
      table.remove(_config.admins, nameid) 
      save_config() 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   end 
end 
    if cmd == "رفع مطور" then 
if already_sudo(tonumber(data.id_)) then 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
      end 
   end 
          table.insert(_config.sudo_users, tonumber(data.id_)) 
      save_config() 
     reload_plugins(true) 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
   end 
end 
    if cmd == "تنزيل مطور" then 
     if not already_sudo(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
      end 
   end 
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_))) 
      save_config() 
     reload_plugins(true) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
      end 
   end 
else 
    if lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
  local cmd = arg.cmd 
    local administration = load_data(_config.moderation.data) 
if not arg.username then return false end 
    if data.id_ then 
if data.type_.user_.username_ then 
user_name = '@'..check_markdown(data.type_.user_.username_) 
else 
user_name = check_markdown(data.title_) 
end 
  if cmd == "حظر" then 
   if is_STMOD(arg.chat_id, data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
         end 
     end 
if administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   kick_user(data.id_, arg.chat_id) 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
   if cmd == "الغاء الحظر" then 
if not administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['banned'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
  if cmd == "كتم" then 
   if is_STMOD(arg.chat_id, data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
    else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
       end 
     end 
if administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
     end 
   end 
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
  if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
  if cmd == "الغاء الكتم" then 
if not administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['is_silent_users'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
  else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
  if cmd == "حظر عام" then 
  if not administration['gban_users'] then 
    administration['gban_users'] = {} 
    save_data(_config.moderation.data, administration) 
    end 
   if is_STADMN(data.id_) then 
  if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
  else 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
        end 
     end 
if is_gbanned(data.id_) then 
   if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
    else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
  administration['gban_users'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   kick_user(data.id_, arg.chat_id) 
     if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
  if cmd == "الغاء العام" then 
  if not administration['gban_users'] then 
    administration['gban_users'] = {} 
    save_data(_config.moderation.data, administration) 
    end 
if not is_gbanned(data.id_) then 
     if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
      end 
   end 
  administration['gban_users'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
    if not lang then 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   else 
     return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┥ • العضــو • "..user_name.."\n┙ • الايــدي • *"..data.id_.."*", 0, "md") 
   end 
end 
  if cmd == "طرد" then 
   if is_STMOD(arg.chat_id, data.id_) then 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
    elseif lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
   end 
  else 
     kick_user(data.id_, arg.chat_id) 
     end 
  end 
  if cmd == "delall" then 
   if is_STMOD(arg.chat_id, data.id_) then 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, " ", 0, "md") 
   elseif lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "  ", 0, "md") 
   end 
  else 
tdcli.deleteMessagesFromUser(arg.chat_id, data.id_, dl_cb, nil) 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم مــسح رسـائله •\n┥ • العضــو • "..data.id_.."*", 0, "md") 
      elseif lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • تــم مــسح رسـائله •\n┥ • العضــو • "..data.id_.."*", 0, "md") 
       end 
    end 
  end 
else 
    if lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "  ", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "  ", 0, "md") 
      end 
   end 
   local function delmsg (arg,data) 
for k,v in pairs(data.messages_) do 
tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}) 
end 
end 

local text85 = io.popen("sh ./data/cmd.sh"):read('*all') 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
local cmd = arg.cmd 
    local administration = load_data(_config.moderation.data) 
  if not administration[tostring(arg.chat_id)] then 
  if not lang then 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
else 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
     end 
  end 
if not arg.username then return false end 
   if data.id_ then 
if data.type_.user_.username_ then 
user_name = ''..check_markdown(data.type_.user_.username_) 
else 
user_name = check_markdown(data.title_) 
end 
if cmd == "رفع مدير" then 
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md") 
   end 
end 
  if cmd == "رفع ادمن" then 
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
      end 
   end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md") 
   end 
end 
   if cmd == "تنزيل مدير" then 
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
    else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   end 
end 
   if cmd == "تنزيل ادمن" then 
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
  end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • @"..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
end 
  if cmd == "الرتبه" then
local function visudo_cb(arg, data)
if data.username_ then
storm_user = '@'..check_markdown(data.username_)
else
storm_user = "📮 | • لا يوجد لديه معرف 😣"
end
if is_STSUD(data.id_) then
mokh = 'المطور 👮'
elseif is_STOWRS(arg.chat_id,data.id_) then
mokh = "المدير 💂"
elseif is_STMOD(arg.chat_id,data.id_) then
mokh = "الادمن 👦"
else
mokh = "العضو 👲"
end
local informeshn = "📮 | • الايدي •  ["..data.id_.."]\n📮 | • الاسم •"..check_markdown(data.first_name_).."\n📮 | • المعرف • "..storm_user..'\n📮 | • الرتبه •'..mokh
return tdcli.sendMessage(arg.chat_id, 1, 0, informeshn, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
   if cmd == "ايدي" then 
return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md") 
end 
if cmd == "معلومات" then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "📮 | • المعرف • [اضغط هنا](t.me/"..check_markdown(data.type_.user_.username_)..")\n\n📮 | • الايدي •  ["..data.id_.."]\n\n📮 | • الاسم •"..data.title_.."\n\n📮 | • ايدي المجموعه\n["..arg.chat_id.."]\n", 0, "md") 
end 
    if cmd == "معلومات" then 
     if not lang then 
     text = "📮 | • المعرف • "..storm_user.."\n\n📮 | • الايدي •  ["..data.id_.."]\n\n📮 | • الاسم •"..data.title_.."\n\n📮 | • ايدي المجموعه\n["..arg.chat_id.."]\n"
  else 
     text = "📮 | • المعرف • "..storm_user.."\n\n📮 | • الايدي •  ["..data.id_.."]\n\n📮 | • الاسم •"..data.title_.."\n\n📮 | • ايدي المجموعه\n["..arg.chat_id.."]\n"
         end 
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md') 
   end 
else 
    if lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
end 
    
local function action_by_id(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
    local cmd = arg.cmd 
if not tonumber(arg.user_id) then return false end 
   if data.id_ then 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
    if cmd == "رفع اداري" then 
if is_STADMN(tonumber(data.id_)) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
      end 
   end 
       table.insert(_config.admins, {tonumber(data.id_), user_name}) 
      save_config() 
     if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته اداري الــبوت", 0, "md")
   end 
end 
    if cmd == "تنزيل اداري" then 
   local nameid = index_function(tonumber(data.id_)) 
if not is_STADMN(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
      end 
   end 
      table.remove(_config.admins, nameid) 
      save_config() 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الاداره", 0, "md")
   end 
end 
    if cmd == "رفع مطور" then 
if already_sudo(tonumber(data.id_)) then 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
      end 
   end 
          table.insert(_config.sudo_users, tonumber(data.id_)) 
      save_config() 
     reload_plugins(true) 
  if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
  else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مطــور الــبوت", 0, "md")
   end 
end 
    if cmd == "تنزيل مطور" then 
     if not already_sudo(data.id_) then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
      end 
   end 
          table.remove(_config.sudo_users, getindex( _config.sudo_users, tonumber(data.id_))) 
      save_config() 
     reload_plugins(true) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تــنزيـل مــن الــمطوريــن", 0, "md")
      end 
   end 
else 
    if lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
local cmd = arg.cmd 
    local administration = load_data(_config.moderation.data) 
  if not administration[tostring(arg.chat_id)] then 
  if not lang then 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
else 
    return tdcli.sendMessage(data.chat_id_, "", 0, "📮 | • المجموعه لم يتم تفعيلها •", 0, "md") 
     end 
  end 
if not tonumber(arg.user_id) then return false end 
   if data.id_ then 
if data.first_name_ then 
if data.username_ then 
user_name = '@'..check_markdown(data.username_) 
else 
user_name = check_markdown(data.first_name_) 
end 
  if cmd == "رفع مدير" then 
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md")
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md")
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته مديـر الــمجمـوعه", 0, "md")
   end 
end 
  if cmd == "رفع ادمن" then 
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md")
else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md")
      end 
   end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md")
   else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم ترقــيته ادمــن", 0, "md")
   end 
end 
   if cmd == "تنزيل مدير" then 
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
      end 
   end 
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
    else 
return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله ادارة الــمجمـوعه", 0, "md")
   end 
end 
   if cmd == "تنزيل ادمن" then 
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then 
    if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
  end 
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil 
    save_data(_config.moderation.data, administration) 
   if not lang then 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
    else 
    return tdcli.sendMessage(arg.chat_id, "", 0, "┑ • العضــو • "..user_name.."\n┥ • الايــدي • "..data.id_.."\n┙ • تــم تـنزيـله مــن الادمنيــه", 0, "md")
   end 
end 
if cmd == "الرتبه" then
local function visudo_cb(arg, data)
if data.username_ then
storm_user = '@'..check_markdown(data.username_)
else
storm_user = "📮 | • لا يوجد لديه معرف 😣"
end
if is_STSUD(data.id_) then
mokh = 'المطور 👮'
elseif is_STOWRS(arg.chat_id,data.id_) then
mokh = "المدير 💂"
elseif is_STMOD(arg.chat_id,data.id_) then
mokh = "الادمن 👦"
else
mokh = "العضو 👲"
end
local informeshn = "📮 | • الايدي •  ["..data.id_.."]\n📮 | • الاسم •"..check_markdown(data.first_name_).."\n📮 | • المعرف • "..storm_user..'\n📮 | • الرتبه •'..mokh
return tdcli.sendMessage(arg.chat_id, 1, 0, informeshn, 0, "md")
end
tdcli_function ({
ID = "GetUser",
user_id_ = data.sender_user_id_
}, visudo_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
end
        if cmd == "whois" then 
if data.username_ then 
username = '@'..check_markdown(data.username_) 
else 
if not lang then 
username = '📮 | • لا يوجد معرف •' 
 else 
username = '📮 | • لا يوجد معرف •' 
  end 
end 
     if not lang then 
       return tdcli.sendMessage(arg.chat_id, 0, 1, '•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n📮 | • الايدي • `['..data.id_..' ]`\n\n📮 | • المعرف • '..username..'\n\n📮 | • الاسم •  '..data.first_name_, 1)
   else 
       return tdcli.sendMessage(arg.chat_id, 0, 1, '•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n📮 | • الايدي • `[ '..data.id_..' ]`\n\n📮 | • المعرف • '..username..'\n\n📮 | • الاسم • : '..data.first_name_, 1)
      end 
   end 
 else 
    if not lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
    end 
  end 
else 
    if lang then 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
   else 
  return tdcli.sendMessage(arg.chat_id, "", 0, "_🗯 • لــم يتـم العـثور علـى الشــخص_", 0, "md") 
      end 
   end 
end  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------كود تشغيل او تعطيل الردود-----------------
local function lock_replay(msg, data, target)
if not is_mod(msg) then
 return " "
end
local replay = data[tostring(target)]["settings"]["replay"] 
if replay == "no" then
return '📮 | • تم ايقاف 🔐 الردود  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
else
data[tostring(target)]["settings"]["replay"] = "no"
save_data(_config.moderation.data, data) 
return '📮 | • تم ايقاف 🔐 الردود  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
end end
local function unlock_replay(msg, data, target)
 if not is_mod(msg) then
 return " "
end 
local replay = data[tostring(target)]["settings"]["replay"]
 if replay == "yes" then
return '📮 | • تم تـفعيل🔓  الردود\n\n\n📮 | • خاصيـة • الـفتـح'
else 
data[tostring(target)]["settings"]["replay"] = "yes"
save_data(_config.moderation.data, data) 
return '📮 | • تم تـفعيل🔓  الردود\n\n\n📮 | • خاصيـة • الـفتـح'
end end
--------------كود قفل البوتات------------------- 
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
if not is_mod(msg) then 
if not lang then 
 return " " 
else 
 return " " 
end 
end 

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "🔒" then 
if not lang then 
 return "📮 | • تم قفل 🔐 البوتات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
elseif lang then 
 return "📮 | • تم قفل 🔐 البوتات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
end 
else 
 data[tostring(target)]["settings"]["lock_bots"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "📮 | • تم قفل 🔐 البوتات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
else
 return "📮 | • تم قفل 🔐 البوتات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
end 
end 
end 
-----------------------كود فتح البوتات---------------------
local function unlock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 if not is_mod(msg) then 
if not lang then 
return " " 
else 
return " " 
end 
end 

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
 if lock_bots == "🔓" then 
if not lang then 
return "📮 | • تم فتـح 🔓 دخول البوتات" 
elseif lang then 
return "📮 | • تم فتـح 🔓 دخول البوتات" 
end 
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then 
return "📮 | • تم فتـح 🔓 دخول البوتات" 
else 
return "📮 | • تم فتـح 🔓 دخول البوتات" 
end 
end 
end 
---------------كود قفل التثبيت------------------- 
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
if not is_mod(msg) then 
if not lang then 
 return " " 
else 
 return " " 
end 
end 

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "🔒" then 
if not lang then 
 return "📮 | • تم قفل `🔐` التثبيت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
elseif lang then 
 return "📮 | • تم قفل `🔐` التثبيت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
end 
else 
 data[tostring(target)]["settings"]["lock_pin"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "📮 | • تم قفل `🔐` التثبيت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
else 
 return "📮 | • تم قفل `🔐` التثبيت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
end 
end 
end 
---------------------كود فتح التثبيت-----------------------
local function unlock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 if not is_mod(msg) then 
if not lang then 
return " " 
else 
return " " 
end 
end 

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
 if lock_pin == "🔓" then 
if not lang then 
return "📮 | • تم فتـح `🔓` التثبيت " 
elseif lang then 
return "📮 | • تم فتـح `🔓` التثبيت " 
end 
else 
data[tostring(target)]["settings"]["lock_pin"] = "no" 
save_data(_config.moderation.data, data) 
if not lang then 
return "📮 | • تم فتـح `🔓` التثبيت " 
else 
return "📮 | • تم فتـح `🔓` التثبيت " 
end 
end 
end 
---------------كود قفل دخول الاعضاء ------------------- 
local function lock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
if not is_mod(msg) then 
if not lang then 
 return " " 
else 
 return " " 
end 
end 

local lock_join = data[tostring(target)]["settings"]["lock_join"] 
if lock_join == "🔒" then 
if not lang then 
 return "📮 | • تم قفل 🔐 دخول الاعضاء ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
elseif lang then 
 return "📮 | • تم قفل 🔐 دخول الاعضاء ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
end 
else 
 data[tostring(target)]["settings"]["lock_join"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "📮 | • تم قفل 🔐 دخول الاعضاء ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯 " 
else 
 return "📮 | • تم قفل 🔐 دخول الاعضاء ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الـطرد 🚯" 
end 
end 
end 
------------------------كود فتح دخول الاعضاء--------------------
local function unlock_join(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 if not is_mod(msg) then 
if not lang then 
return " " 
else 
return " " 
end 
end 
local lock_join = data[tostring(target)]["settings"]["lock_join"] 
 if lock_join == "🔓" then 
if not lang then 
return "📮 | • تم فتـح `🔓` دخول الاعضاء" 
elseif lang then 
return "📮 | • تم فتـح `🔓` دخول الاعضاء" 
end 
else 
data[tostring(target)]["settings"]["lock_join"] = "no" 
save_data(_config.moderation.data, data) 
if not lang then 
return "📮 | • تم فتـح `🔓` دخول الاعضاء" 
else 
return "📮 | • تم فتـح `🔓` دخول الاعضاء" 
end 
end 
end 
function group_settings(msg, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
if not is_mod(msg) then 
if not lang then 
    return " " 
else 
  return " " 
end 
end 
local data = load_data(_config.moderation.data) 
local target = msg.to.id 
if data[tostring(target)] then 
if data[tostring(target)]["settings"]["num_msg_max"] then 
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max']) 
   print('custom'..NUM_MSG_MAX) 
else 
NUM_MSG_MAX = 5 
end 
if data[tostring(target)]["settings"]["set_char"] then 
SETCHAR = tonumber(data[tostring(target)]['settings']['set_char']) 
   print('custom'..SETCHAR) 
else 
SETCHAR = 4000 
end 
if data[tostring(target)]["settings"]["time_check"] then 
TIME_CHECK = tonumber(data[tostring(target)]['settings']['time_check']) 
   print('custom'..TIME_CHECK) 
else 
TIME_CHECK = 2 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["link"] then 
data[tostring(target)]["settings"]["link"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["tag"] then 
data[tostring(target)]["settings"]["tag"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["mention"] then 
data[tostring(target)]["settings"]["mention"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["arabic"] then 
data[tostring(target)]["settings"]["arabic"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["edit"] then 
data[tostring(target)]["settings"]["edit"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["spam"] then 
data[tostring(target)]["settings"]["spam"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["flood"] then 
data[tostring(target)]["settings"]["flood"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["lock_bots"] then 
data[tostring(target)]["settings"]["lock_bots"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["markdown"] then 
data[tostring(target)]["settings"]["markdown"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["webpage"] then 
data[tostring(target)]["settings"]["webpage"] = "🔓" 
end 
end 

if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["welcome"] then 
data[tostring(target)]["settings"]["welcome"] = "✖" 
end 
end 

 if data[tostring(target)]["settings"] then 
 if not data[tostring(target)]["settings"]["lock_pin"] then 
 data[tostring(target)]["settings"]["lock_pin"] = "🔓" 
 end 
 end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["chat"] then 
data[tostring(target)]["settings"]["chat"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["gif"] then 
data[tostring(target)]["settings"]["gif"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["text"] then 
data[tostring(target)]["settings"]["text"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["photo"] then 
data[tostring(target)]["settings"]["photo"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["video"] then 
data[tostring(target)]["settings"]["video"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["audio"] then 
data[tostring(target)]["settings"]["audio"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["voice"] then 
data[tostring(target)]["settings"]["voice"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["sticker"] then 
data[tostring(target)]["settings"]["sticker"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["contact"] then 
data[tostring(target)]["settings"]["contact"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["forward"] then 
data[tostring(target)]["settings"]["forward"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["view"] then 
data[tostring(target)]["settings"]["view"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["location"] then 
data[tostring(target)]["settings"]["location"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["document"] then 
data[tostring(target)]["settings"]["document"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["lock_tgservice"] then 
data[tostring(target)]["settings"]["lock_tgservice"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["inline"] then 
data[tostring(target)]["settings"]["inline"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["game"] then 
data[tostring(target)]["settings"]["game"] = "🔓" 
end 
end 
if data[tostring(target)]["settings"] then 
if not data[tostring(target)]["settings"]["keyboard"] then 
data[tostring(target)]["settings"]["keyboard"] = "🔓" 
end 
end 
 if data[tostring(target)]["settings"] then 
 if not data[tostring(target)]["settings"]["lock_join"] then 
 data[tostring(target)]["settings"]["lock_join"] = "🔓" 
 end 
 end 
 local expire_date = '' 
local expi = redis:ttl('ExpireDate1:'..msg.to.id) 
if expi == -1 then 
if lang then 
   expire_date = 'غير محدود' 
else 
   expire_date = 'غير محدود' 
end 
else 
   local day = math.floor(expi / 86400) + 1 
if lang then 
   expire_date = day..' يوم' 
else 
   expire_date = day..' يوم' 
end 
end 
if not lang then 
-----------------------الاعدادات العامه---------------------
local settings = data[tostring(target)]["settings"] 
 text = "*•♦• اعدادات المجموعة •♦•*\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n*\n🔹• التعديل • *{"..settings.edit..
"}*\n🔹•  الدردشه• *{"..settings.text..
"}*\n🔹•  الروابط• *{"..settings.link..
"}*\n🔹•  المعرفات• *{"..settings.tag..
"}*\n🔹•  المنشن• *{"..settings.mention..
"}*\n🔹•  العربيه• *{"..settings.arabic..
"}*\n🔹•   الصفحات• *{"..settings.webpage..
"}*\n🔹•  الماركداون• *{"..settings.markdown..
"}*\n🔹•   التوجيه• *{"..settings.forward..
"}*\n🔹•  الملصقات• *{"..settings.sticker..
"}*\n🔹•  الفيديو• *{"..settings.video..
"}*\n🔹•  الصوتيات• *{"..settings.audio..
"}*\n🔹•  الاغاني• *{"..settings.voice..
"}*\n🔹•  الصور• *{"..settings.photo..
"}*\n🔹•  الملفات• *{"..settings.document..
"}*\n🔹•  المواقع• *{"..settings.location..
"}*\n🔹•  المتحركه• *{"..settings.gif..
"}*\n🔹•  الكل• *{"..settings.chat..
"}*\n🔹•  الجهات• *{"..settings.contact..
"}*\n🔹•  اللستات• *{"..settings.inline..
"}*\n🔹•  الكيبورد• *{"..settings.keyboard..
"}*\n🔹•  توجيه القنواة• *{"..settings.view..
"}*\n🔹• الترحيب• *{"..settings.welcome..
"}*\n🔹•  دخول الاعضاء• *{"..settings.lock_join..
"}*\n🔹•  التثبيت• *{"..settings.lock_pin..
"}*\n🔹•  الاشعارات• *{"..settings.lock_tgservice..
"}*\n🔹•  دخول البوتات• *{"..settings.lock_bots..
"}*\n🔹•  الكلايش• *{"..settings.spam.."}\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n• تابع قناتنا• @"..botusea.."\n"
 else 
local settings = data[tostring(target)]["settings"] 
 text = "*•♦• اعدادات المجموعة •♦•*\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n*\n🔹• التعديل • *{"..settings.edit..
"}*\n🔹•  الدردشه• *{"..settings.text..
"}*\n🔹•  الروابط• *{"..settings.link..
"}*\n🔹•  المعرفات• *{"..settings.tag..
"}*\n🔹•  المنشن• *{"..settings.mention..
"}*\n🔹•  العربيه• *{"..settings.arabic..
"}*\n🔹•   الصفحات• *{"..settings.webpage..
"}*\n🔹•  الماركداون• *{"..settings.markdown..
"}*\n🔹•   التوجيه• *{"..settings.forward..
"}*\n🔹•  الملصقات• *{"..settings.sticker..
"}*\n🔹•  الفيديو• *{"..settings.video..
"}*\n🔹•  الصوتيات• *{"..settings.audio..
"}*\n🔹•  الاغاني• *{"..settings.voice..
"}*\n🔹•  الصور• *{"..settings.photo..
"}*\n🔹•  الملفات• *{"..settings.document..
"}*\n🔹•  المواقع• *{"..settings.location..
"}*\n🔹•  المتحركه• *{"..settings.gif..
"}*\n🔹•  الكل• *{"..settings.chat..
"}*\n🔹•  الجهات• *{"..settings.contact..
"}*\n🔹•  اللستات• *{"..settings.inline..
"}*\n🔹•  الكيبورد• *{"..settings.keyboard..
"}*\n🔹•  توجيه القنواة• *{"..settings.view..
"}*\n🔹• الترحيب• *{"..settings.welcome..
"}*\n🔹•  دخول الاعضاء• *{"..settings.lock_join..
"}*\n🔹•  التثبيت• *{"..settings.lock_pin..
"}*\n🔹•  الاشعارات• *{"..settings.lock_tgservice..
"}*\n🔹•  دخول البوتات• *{"..settings.lock_bots..
"}*\n🔹•  الكلايش• *{"..settings.spam.."}\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n• تابع قناتنا• @"..botusea.."\n"
end
return text 
end 
---------------كود قفل الاشعارات------------------- 
local function lock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
if not is_mod(msg) then 
if not lang then 
 return " " 
else 
 return " " 
end 
end 

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
if lock_tgservice == "🔒" then 
if not lang then 
 return "📮 | • تم قفل 🔐 الاشعارات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
elseif lang then 
 return "📮 | • تم قفل 🔐 الاشعارات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
end 
else 
 data[tostring(target)]["settings"]["lock_tgservice"] = "🔒" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "📮 | • تم قفل 🔐 الاشعارات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
else 
return "📮 | • تم قفل 🔐 الاشعارات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
end 
end 
end 
------------------------كود فتح الاشعارات--------------------
local function unlock_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 if not is_mod(msg) then 
if not lang then 
return " " 
else 
return " " 
end 
end 

local lock_tgservice = data[tostring(target)]["settings"]["lock_tgservice"] 
 if lock_tgservice == "🔓" then 
if not lang then 
return "📮 | • تم فتح🔓  الاشعارات\n\n\n" 
elseif lang then 
return "📮 | • تم فتح🔓  الاشعارات\n\n\n" 
end 
else 
data[tostring(target)]["settings"]["lock_tgservice"] = "🔓" 
 save_data(_config.moderation.data, data) 
if not lang then 
return "📮 | • تم فتح🔓  الاشعارات\n\n\n" 
else 
return "📮 | • تم فتح🔓  الاشعارات\n\n\n" 
end 
end 
end 
------------------------كودات ملف البلونكز--------------------
local function plugin_enabled( name )
  for k,v in pairs(_config.enabled_plugins) do
    if name == v then
      return k
    end
  end
  -- If not found
  return false
end

-- Returns true if file exists in plugins folder
local function plugin_exists( name )
  for k,v in pairs(plugins_names()) do
    if name..'.lua' == v then
      return true
    end
  end
  return false
end

local function list_all_plugins(only_enabled, msg)
  local tmp = '\n'
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  مفعل  enabled, ❌ disabled
    local status = '✖ | •'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✔ | •'
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔ | •'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
      text = text..nsum..'.   '..status..' '..v..' \n'
    end
  end
  text = 'َ'..text..'\n\nٴ┄•🔸•┄༻📯༺┄•🔸•┄  \n'..nsum..'  •📮 | • عدد الملفات\n\n'..nact..'  •📮 | •  الملفات المفعله \n\n'..nsum-nact..'  •📮 | • الملفات المعطله '..tmp
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function list_plugins(only_enabled, msg)
  local text = ''
  local nsum = 0
  for k, v in pairs( plugins_names( )) do
    --  مفعل  enabled, ❌ disabled
    local status = '✖ | •'
    nsum = nsum+1
    nact = 0
    -- Check if is enabled
    for k2, v2 in pairs(_config.enabled_plugins) do
      if v == v2..'.lua' then 
        status = '✔ | •'
      end
      nact = nact+1
    end
    if not only_enabled or status == '✔ | •'then
      -- get the name
      v = string.match (v, "(.*)%.lua")
     -- text = text..v..'  '..status..'\n'
    end
  end
  text = "\n`📮 • تم تحديث الملفات • 📮`\n\nٴ┄•🔸•┄༻📯༺┄•🔸•┄    \n\n"..nact.."  📮 | • عدد الملفات المفعله  \n"..nsum.."📮 | • عدد الملفات   \n\nٴ┄•🔸•┄༻📯༺┄•🔸•┄    \n📮 | • تابع : @"..botusea..'\n'
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'md')
end

local function reload_plugins(checks, msg)
  plugins = {}
  load_plugins()
  return list_plugins(true, msg)
end


local function enable_plugin( plugin_name, msg )
  print('checking if '..plugin_name..' exists')
  -- Check if plugin is enabled
  if plugin_enabled(plugin_name) then
    local text = '📮 | • الملف {<code>'..plugin_name..'</code>}\n📮 | • الملف مفعل  '
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Checks if plugin exists
  if plugin_exists(plugin_name) then
    -- Add to the config table
    table.insert(_config.enabled_plugins, plugin_name)
    print(plugin_name..' added to _config table')
    save_config()
    -- Reload the plugins
    return reload_plugins(true, msg)
  else
    local text = '📮 | • الملف {<code>'..plugin_name..'</code>}\n📮 | • الملف مفعل '
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  end
end

local function disable_plugin( name, msg )
  local k = plugin_enabled(name)
  -- Check if plugin is enabled
  if not k then
    local text = '📮 | • الملف {<code>'..name..'</code>}\n📮 | • غير موجود  '
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
	return
  end
  -- Check if plugins exists
  if not plugin_exists(name) then
    local text = '📮 | • الملف {<code>'..name..'</code>}\n📮 | • غير موجود  '
	tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
  else
  -- Disable and reload
  table.remove(_config.enabled_plugins, k)
  save_config( )
  return reload_plugins(true, msg)
end  
end

local function disable_plugin_on_chat(receiver, plugin, msg)
  if not plugin_exists(plugin) then
    return "_Plugin doesn't exists_"
  end

  if not _config.disabled_plugin_on_chat then
    _config.disabled_plugin_on_chat = {}
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    _config.disabled_plugin_on_chat[receiver] = {}
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = true

  save_config()
  local text = ' '..plugin..' disabled on this chat. '
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end

local function reenable_plugin_on_chat(receiver, plugin, msg)
  if not _config.disabled_plugin_on_chat then
    return 'There aren\'t any disabled plugins'
  end

  if not _config.disabled_plugin_on_chat[receiver] then
    return 'There aren\'t any disabled plugins for this chat'
  end

  if not _config.disabled_plugin_on_chat[receiver][plugin] then
    return '_This plugin is not disabled_'
  end

  _config.disabled_plugin_on_chat[receiver][plugin] = false
  save_config()
  local text = ' '..plugin..' is enabled again. '
  tdcli.sendMessage(msg.to.id, msg.id_, 1, text, 1, 'html')
end 
---------------------------كودات الحظر-----------------
local function run(msg, matches) 
if matches[1] == "حظر عام" and is_admin(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="حظر عام"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if is_STADMN(matches[2]) then 
   if not lang then 
    return tdcli.sendMessage(msg.to.id, "", 0, " ", 0, "md") 
else 
    return tdcli.sendMessage(msg.to.id, "", 0, " ", 0, "md") 
        end 
     end 
   if is_gbanned(matches[2]) then 
   if not lang then 
  return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
    else 
  return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
  data['gban_users'][tostring(matches[2])] = "" 
    save_data(_config.moderation.data, data) 
kick_user(matches[2], msg.to.id) 
   if not lang then 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
    else 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="حظر عام"}) 
      end 
   end 
 if matches[1] == "الغاء العام" and is_admin(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="الغاء العام"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if not is_gbanned(matches[2]) then 
     if not lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
    else 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
  data['gban_users'][tostring(matches[2])] = nil 
    save_data(_config.moderation.data, data) 
   if not lang then 
return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
   else 
return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء حــظره عـام •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="الغاء العام"}) 
      end 
   end 
   if msg.to.type ~= 'pv' then 
 if matches[1] == "حظر" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="حظر"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if is_STMOD(msg.to.id, matches[2]) then 
     if not lang then 
    return tdcli.sendMessage(msg.to.id, "", 0, "  ", 0, "md") 
    else 
    return tdcli.sendMessage(msg.to.id, "", 0, "  ", 0, "md") 
        end 
     end 
   if is_banned(matches[2], msg.to.id) then 
   if not lang then 
  return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
  else 
  return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
data[tostring(chat)]['banned'][tostring(matches[2])] = "" 
    save_data(_config.moderation.data, data) 
kick_user(matches[2], msg.to.id) 
   if not lang then 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, " "..matches[2].."  ", 0, "md") 
  else 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, " "..matches[2].." ", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
     tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="حظر"}) 
      end 
   end 
 if matches[1] == "الغاء الحظر" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="الغاء الحظر"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if not is_banned(matches[2], msg.to.id) then 
   if not lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
  else 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
data[tostring(chat)]['banned'][tostring(matches[2])] = nil 
    save_data(_config.moderation.data, data) 
   if not lang then 
return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
   else 
return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء حظــره بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="الغاء الحظر"}) 
      end 
   end 
 if matches[1] == "كتم" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="كتم"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if is_STMOD(msg.to.id, matches[2]) then 
   if not lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, "", 0, "md") 
 else 
   return tdcli.sendMessage(msg.to.id, "", 0, "", 0, "md") 
        end 
     end 
   if is_silent_user(matches[2], chat) then 
   if not lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
   else 
   return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = "" 
    save_data(_config.moderation.data, data) 
    if not lang then 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
  else 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="كتم"}) 
      end 
   end 
 if matches[1] == "الغاء الكتم" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="الغاء الكتم"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if not is_silent_user(matches[2], chat) then 
     if not lang then 
     return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].."", 0, "md") 
   else 
     return tdcli.sendMessage(msg.to.id, "", 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].." ]*", 0, "md") 
        end 
     end 
data[tostring(chat)]['is_silent_users'][tostring(matches[2])] = nil 
    save_data(_config.moderation.data, data) 
   if not lang then 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].."*", 0, "md") 
  else 
 return tdcli.sendMessage(msg.to.id, msg.id, 0, "┑ • تــم الغــاء كتــمه بـنجـاح •\n┙ • العضــو • "..matches[2].."*", 0, "md") 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="الغاء الكتم"}) 
      end 
   end 
      if matches[1]:lower() == 'م' and is_owner(msg) then 
         if matches[2] == 'ة' then 
            if next(data[tostring(chat)]['banned']) == nil then 
     if not lang then 
               return "📮 | • لا يوجـد اعضـاء مـحظوريـن  •" 
   else 
               return "📮 | • لا يوجـد اعضـاء مـحظوريـن  •" 
              end 
            end 
            for k,v in pairs(data[tostring(chat)]['banned']) do 
               data[tostring(chat)]['banned'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
     if not lang then 
            return "📮 | • تـم مسـح قائمـه المحظـوريـن •" 
    else 
            return "📮 | • تـم مسـح قائمـه المحظـوريـن •" 
           end 
         end 
         if matches[2] == 'ة' then 
            if next(data[tostring(chat)]['is_silent_users']) == nil then 
        if not lang then 
               return "📮 | • لا يوجـد اعضـاء مـكتوميـن  •" 
   else 
               return "📮 | • لا يوجـد اعضـاء مـكتوميـن  •" 
             end 
            end 
            for k,v in pairs(data[tostring(chat)]['is_silent_users']) do 
               data[tostring(chat)]['is_silent_users'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
                end 
       if not lang then 
            return "📮 | • تـم مسـح قائمـه المكتوميـن •" 
   else 
            return "📮 | • تـم مسـح قائمـه المكتوميـن •" 
               end 
             end 
        end 
     end 
      if matches[1]:lower() == 'و' and is_sudo(msg) then 
         if matches[2] == 'قائمه ة' then 
            if next(data['gban_users']) == nil then 
    if not lang then 
               return "📮 | • لا يوجـد اعضـاء مـحظوريـن عـام  •" 
   else 
               return "📮 | • لا يوجـد اعضـاء مـحظوريـن عـام  •" 
             end 
            end 
            for k,v in pairs(data['gban_users']) do 
               data['gban_users'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
      if not lang then 
            return "📮 | • تـم مسـح قائمـه المحظـوريـن عـام •" 
   else 
            return "📮 | • تـم مسـح قائمـه المحظـوريـن عـام •" 
          end 
         end 
     end 
if matches[1] == " " and is_admin(msg) then 
  return gbanned_list(msg) 
 end 
   if msg.to.type ~= 'pv' then 
if matches[1] == " " and is_mod(msg) then 
  return silent_users_list(chat) 
 end 
if matches[1] == " " and is_mod(msg) then 
  return banned_list(chat) 
     end 
  end 
  ---------------------كود المعلومات-----------------------
   if matches[1]:lower() == 'معلوماتي' then 
function get_id(arg, data) 
local username 
if data.first_name_ then 
if data.username_ then 
username = '@'..data.username_ 
else 
username = 'No Username!' 
end 
local telNum 
if data.phone_number_ then 
telNum = '+'..data.phone_number_ 
else 
telNum = '----' 
end 
local lastName 
if data.last_name_ then 
lastName = data.last_name_ 
else 
lastName = '----' 
end 
local rank 
if is_sudo(msg) then 
rank = 'مطور البوت 💠' 
elseif is_owner(msg) then 
rank = 'مدير الكروب 👮' 
elseif is_admin(msg) then 
rank = 'ادمن الكروب 💂' 
elseif is_mod(msg) then 
rank = 'اداري الكروب 📌' 
else 
rank = 'عضو في الكروب 👲' 
end 
local text = '📛 • اهلا بك في معلوماتك • 📛\n\nٴ┄•🔸•┄༻📯༺┄•🔸•┄    \n\n📮 | •   الاسم الاول : '..data.first_name_..'\n\n📮 | •   الاسم الثاني : '..lastName..'\n\n📮 | •   المعرف: '..username..'\n\n📮 | •   الايدي : [<code> '..data.id_..'</code> ]\n\n📮 | •   ايدي الكروب : [<code> '..arg.chat_id.." </code>]\n\n📮 | •  رسائلك [<code>"..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).."</code>]\n\n📮 | •   موقعك : "..rank..'\n\nٴ┄•🔸•┄༻📯༺┄•🔸•┄    \n\n 📌•  مـطـور الـسـورس : @'..sudouser..'\n📌• قناتنا : @'..botusea..'\n'
            tdcli.sendMessage(arg.chat_id, msg.id_, 1, text, 1, 'html') 
end 
end 
tdcli_function({ ID = 'GetUser', user_id_ = msg.sender_user_id_, }, get_id, {chat_id=msg.chat_id_, user_id=msg.sendr_user_id_}) 
end 
   if matches[1] == " " then
 local function dl_photo(arg,data) tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'طه')
end
  tdcli_function ({ID = 
"GetUserProfilePhotos",user_id_ = 
msg.sender_user_id_,offset_ = 
tonumber(matches[2]) - 1,limit_ = 100000}, dl_photo, nil) 
end 
--------------------------كود التجربه------------------
local taha = { 
   "ڜـﮩ๋͜ﮧـ͜ާغًألـﮩﮨہٰٰہٰ عًيوُטּـي ﻤ̉̉ـﭑإ́ يـهـﻤ̉̉ـنـي ﮨ́́ﮨ́ﮨـي", 
  "`وداعتك شغال بس لتلح 🌝❤️`", 
  "اي تاج راسي مشتغل ما اوكف 🌚🖤🚶‍♂", 
  } 
if matches[1] == 'شغال' and is_sudo(msg) then  
return taha[math.random(#taha)] 
end 
--------------------كود وضع معلومات المطور من التلي------------------------
if matches [1] =='ضع كليشه المطور' and msg.from.id == tonumber(SUDO) then 
if not is_sudo(msg) then 
return '📮 | • للمــدراء فقــط🚸' 
end 
local STORM = matches[2] 
redis:set('bot:STORM',STORM) 
return ' \n📮 | • تــم وضــع كليشه المطور' 
end 
if  matches[1] == 'مطور' or matches[1] == 'المطور' then 
    local hash = ('bot:STORM') 
    local STORM = redis:get(hash) 
    if not STORM then 
    return '📌• معلومات المطور •\n\n┄•🔹•┄༻🔴༺┄•🔹•┄\n\n💠• المطور • @'..sudouser..'\n💠• قناتنا • @'..botusea..'\n'
    else 
     tdcli.sendMessage(msg.chat_id_, 0, 1, STORM, 1, 'md') 
    end 
    end 
if matches[1]=="احذف كليشه المطور" then 
if not is_sudo(msg) then 
return '📮 | • للمــدراء فقــط🚸' 
end 
    local hash = ('bot:STORM') 
    redis:del(hash) 
return ' \n📮 | • تــم حذف كليشه المطور' 
end  
--------------------------كود جلب صوره مع تشغيل وايقاف جلب الصور------------------
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
local data = load_data(_config.moderation.data) 
local chat = msg.to.id 
local user = msg.from.id 
if msg.to.type ~= 'pv' then 
if matches[1] == "جلب صوره" then
 local function dl_photo(arg,data) tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'📮 | • هاي صورتك رقم {'..matches[2]..'}\n')
end
local lock_get = data[tostring(msg.to.id)]["settings"]["lock_get"] 
if lock_get == "yas" then
tdcli_function ({ID = 
"GetUserProfilePhotos",user_id_ = 
msg.sender_user_id_,offset_ = 
tonumber(matches[2]) - 1,limit_ = 100000}, dl_photo, nil) 
end 
end
----------------------كود تثبيت الرسائل----------------------
if ((matches[1] == "تثبيت" and not Clang) or (matches[1] == "تثبيت" and Clang)) and is_mod(msg) and msg.reply_id then 
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then 
if is_owner(msg) then 
    data[tostring(chat)]['pin'] = msg.reply_id 
     save_data(_config.moderation.data, data) 
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1) 
if not lang then 
return "\n📮 | •  تـــم تثبيـــت الرسـالـــه" 
elseif lang then 
local text = "\n📮 | •  تـــم تثبيـــت الرسـالـــه" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=25, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
elseif not is_owner(msg) then 
   return 
 end 
 elseif lock_pin == 'no' then 
    data[tostring(chat)]['pin'] = msg.reply_id 
     save_data(_config.moderation.data, data) 
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1) 
if not lang then 
return "\n📮 | •  تـــم تثبيـــت الرسـالـــه" 
elseif lang then 
local text = "\n📮 | •  تـــم تثبيـــت الرسـالـــه" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=25, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
end 
end
------------------------كود الايدي بعد قفل ايقاف الايدي--------------------
if matches[1] == "ايدي" then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
if data.photos_[0] then
local rank
if is_sudo(msg) then
rank = 'المطور  👨‍✈️' 
elseif is_owner(msg) then
rank = 'مدير الكروب 👨‍🏭' 
elseif is_sudo(msg) then
rank = 'الاداري 👦' 
elseif is_mod(msg) then
rank = 'ادمن الكروب 👮' 
else
rank = 'عضو بس 👲' 
end
if msg.from.username then
userxn = "@"..(msg.from.username or "---")
else
userxn = "لا يتوفر"
end
local msgs = tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)

tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'\n┑ • ايديك  •'..msg.sender_user_id_..'\n\n┥ • معرفك • @'..(msg.from.username or '----')..'\n\n┥ • رسائلك • '..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0)..'\n\n┙ • موقعك • '..rank..'\n',msg.id_,msg.id_) 
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, "_انت لا تملك صوره في حسابك 😢💭...!_\n\n> _ايدي المجموعه 🎭 :_ `"..msg.to.id.."`\n_ايديك 📍:_ `"..msg.from.id.."`", 1, 'md')
end
end
local lock_id = data[tostring(msg.to.id)]["settings"]["lock_id"] 
if lock_id == "yas" then
tdcli_function ({
ID = "GetUserProfilePhotos",
user_id_ = msg.from.id,
offset_ = 0,
limit_ = 1
}, getpro, nil)
end
end
if msg.reply_id and not matches[2] and is_mod(msg) then
tdcli_function ({
ID = "GetMessage",
chat_id_ = msg.to.id,
message_id_ = msg.reply_id
}, action_by_reply, {chat_id=msg.to.id,cmd="id"})
end
if matches[2] and is_mod(msg) then
tdcli_function ({
ID = "SearchPublicChat",
username_ = matches[2]
}, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
end
end
------------------------كود الغاء تثبيت الرسائل--------------------
if ((matches[1] == 'الغاء التثبيت' and not Clang) or (matches[1] == "الغاء التثبيت" and Clang)) and is_mod(msg) then 
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then 
if is_owner(msg) then 
tdcli.unpinChannelMessage(msg.to.id) 
if not lang then 
return " \n📮 | •  تـــم الغـــاء تثبيـــت الرسـالـــه" 
elseif lang then 
local text = " \n📮 | •  تـــم الغـــاء تثبيـــت الرسـالـــه" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=26, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
elseif not is_owner(msg) then 
   return 
 end 
 elseif lock_pin == 'no' then 
tdcli.unpinChannelMessage(msg.to.id) 
if not lang then 
return " \n📮 | •  تـــم الغـــاء تثبيـــت الرسـالـــه" 
elseif lang then 
local text = " \n📮 | •  تـــم الغـــاء تثبيـــت الرسـالـــه" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=26, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
end 
end 
end
-----------------------كود تفعيل المجموعه---------------------
if matches[1] == "تفعيل" then 
return modadd(msg) 
end 
----------------------كود تعطيل المجموعه----------------------
if matches[1] == "تعطيل" then 
return modrem(msg) 
end 
-----------------------------كودات رفع وتنزيل المدراء---------------
if matches[1] == "رفع مدير" and is_admin(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع مدير"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع مدير"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع مدير"}) 
      end 
   end 
if matches[1] == "تنزيل مدير" and is_admin(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل مدير"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل مدير"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل مدير"}) 
      end 
   end 
   -----------------------------كودات رفع وتنزيل الادمنيه---------------
if matches[1] == "رفع ادمن" and is_owner(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع ادمن"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع ادمن"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع ادمن"}) 
      end 
   end 
if matches[1] == "تنزيل ادمن" and is_owner(msg) then 
if not matches[2] and msg.reply_id then 
 tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل ادمن"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل ادمن"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل ادمن"}) 
      end 
   end 
if matches[1] == "طرد" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="طرد"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if is_STMOD(msg.to.id, matches[2]) then 
   if not lang then 
     tdcli.sendMessage(msg.to.id, "", 0, "  ", 0, "md") 
   elseif lang then 
     tdcli.sendMessage(msg.to.id, "", 0, " ", 0, "md") 
         end 
     else 
kick_user(matches[2], msg.to.id) 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="طرد"}) 
         end 
      end 
 if matches[1] == "delall" and is_mod(msg) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="delall"}) 
end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
   if is_STMOD(msg.to.id, matches[2]) then 
   if not lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, " ", 0, "md") 
     elseif lang then 
   return tdcli.sendMessage(msg.to.id, "", 0, "  ", 0, "md") 
   end 
     else 
tdcli.deleteMessagesFromUser(msg.to.id, matches[2], dl_cb, nil) 
    if not lang then 
  return tdcli.sendMessage(msg.to.id, "", 0, "   "..matches[2].." ", 0, "md") 
   elseif lang then 
  return tdcli.sendMessage(msg.to.id, "", 0, " "..matches[2].."  ", 0, "md") 
         end 
      end 
   end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="delall"}) 
         end 
      end 
      -----------------------------كودات رفع وتنزيل المطورين---------------
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
 if tonumber(msg.from.id) == SUDO then 
if matches[1] == "رفع مطور" and msg.from.id == tonumber(SUDO) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع مطور"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع مطور"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع مطور"}) 
      end 
   end 
if matches[1] == "تنزيل مطور" and msg.from.id == tonumber(SUDO) then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل مطور"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل مطور"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل مطور"}) 
      end 
   end 
   -------------------------
   if matches[1] == "الرتبه" then 
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="الرتبه"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="الرتبه"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="الرتبه"}) 
      end 
   end 
end 
-----------------------------كودات رفع وتنزيل الاداريين---------------
if matches[1] == "رفع اداري" and is_sudo(msg) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "   " 
end
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_id 
    }, action_by_reply, {chat_id=msg.to.id,cmd="رفع اداري"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="رفع اداري"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
   tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="رفع اداري"}) 
      end 
   end 
if matches[1] == "تنزيل اداري" and is_sudo(msg) then 
if tonumber(msg.from.id) ~= tonumber(SUDO) then
return "   " 
end
if not matches[2] and msg.reply_id then 
    tdcli_function ({ 
      ID = "GetMessage", 
      chat_id_ = msg.to.id, 
      message_id_ = msg.reply_to_message_id_ 
    }, action_by_reply, {chat_id=msg.to.id,cmd="تنزيل اداري"}) 
  end 
  if matches[2] and string.match(matches[2], '^%d+$') then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="تنزيل اداري"}) 
    end 
  if matches[2] and not string.match(matches[2], '^%d+$') then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="تنزيل اداري"}) 
      end 
   end 
   --------------------------كودات قفل وفتح------------------
   if ((matches[1] == "قفل" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then 
local target = msg.to.id 
if ((matches[2] == "البوتات" and not Clang) or (matches[2] == "البوتات" and Clang)) then 
return lock_bots(msg, data, target) 
end 
if ((matches[2] == "التثبيت" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then 
return lock_pin(msg, data, target) 
end 
if ((matches[2] == "الدخول" and not Clang) or (matches[2] == " الدخول" and Clang)) then 
return lock_join(msg, data, target) 
end 
if ((matches[2] == "الاشعارات" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then 
return lock_tgservice(msg ,data, target) 
end 
end 

if ((matches[1] == "فتح" and not Clang) or (matches[1] == "فتح" and Clang)) and is_mod(msg) then 
local target = msg.to.id 
if ((matches[2] == "البوتات" and not Clang) or (matches[2] == "البوتات" and Clang)) then 
return unlock_bots(msg, data, target) 
end 
if ((matches[2] == "التثبيت" and not Clang) or (matches[2] == " التثبيت" and Clang)) and is_owner(msg) then 
return unlock_pin(msg, data, target) 
end 
if ((matches[2] == "الدخول" and not Clang) or (matches[2] == "الدخول" and Clang)) then 
return unlock_join(msg, data, target) 
end 
if ((matches[2] == "الاشعارات" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then 
return unlock_tgservice(msg ,data, target) 
end 
end 
   --------------------------------------------قفل الروابط------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local link = data[tostring(msg.to.id)]["settings"]["link"] 
if (matches[2] == "الروابط بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الروابط" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الروابط بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الروابط بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐`  الروابط ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if link == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الروابط مفتوحه" 
    else 
    return "📮 | •  الروابط مفتوحه" 
   end 
end 
  local offender = 'link_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["link"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الروابط" 
    else 
    return "📮 | • تم فتح   الروابط" 
       end 
   end 
end 

---------------------قفل المعرفات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local tags = data[tostring(msg.to.id)]["settings"]["tag"] 
if (matches[2] == "المعرفات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "المعرفات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif matches[2] == "المعرفات بالطرد" and is_mod(msg) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif matches[2] == "المعرفات بالكتم" and is_mod(msg) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐`  المعرفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if tags == "مفتوحه" then 
   if not lang then 
    return "📮 | •  المعرفات مفتوحه" 
    else 
    return "📮 | •  المعرفات مفتوحه" 
   end 
end 
  local offender = 'tag_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["tag"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   المعرفات" 
    else 
    return "📮 | • تم فتح   المعرفات" 
       end 
   end 
end 

---------------------قفل الدردشه------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local text = data[tostring(msg.to.id)]["settings"]["text"] 
if (matches[2] == "الدردشه بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔒`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الدردشه" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الدردشه بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الدردشه بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐`  الدردشه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if text == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الدردشه مفتوحه" 
    else 
    return "📮 | •  الدردشه مفتوحه" 
   end 
end 
  local offender = 'text_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["text"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم فتح   الدردشه" 
    else 
    return "📮‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم فتح   الدردشه" 
       end 
   end 
end 

---------------------قفل الكل------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local chats = data[tostring(msg.to.id)]["settings"]["chat"] 
if (matches[2] == "الكل بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الكل" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الكل بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الكل بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `??`  الكل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if chats == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الكل مفتوحه" 
    else 
    return "📮 | •  الكل مفتوحه" 
   end 
end 
  local offender = 'chat_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["chat"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الكل" 
    else 
    return "📮 | • تم فتح   الكل" 
       end 
   end 
end 

---------------------قفل العربيه------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local arabic = data[tostring(msg.to.id)]["settings"]["arabic"] 
if (matches[2] == "العربيه بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "العربيه" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "العربيه بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "العربيه بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` العربيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if arabic == "مفتوحه" then 
   if not lang then 
    return "📮 | •  العربيه مفتوحه" 
    else 
    return "📮‍🗨￤ العربيه مفتوحه" 
   end 
end 
  local offender = 'arabic_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["arabic"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   العربيه" 
    else 
    return "📮 | • تم فتح   العربيه" 
       end 
   end 
end 

---------------------قفل التعديل------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local edit = data[tostring(msg.to.id)]["settings"]["edit"] 
if (matches[2] == "التعديل بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "التعديل" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "التعديل بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "التعديل بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` التعديل ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if edit == "مفتوحه" then 
   if not lang then 
    return "📮 | •  التعديل مفتوحه" 
    else 
    return "📮 | •  التعديل مفتوحه" 
   end 
end 
  local offender = 'edit_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["edit"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   التعديل" 
    else 
    return "📮 | • تم فتح   التعديل" 
       end 
   end 
end 

---------------------قفل الماركداون------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local markdown = data[tostring(msg.to.id)]["settings"]["markdown"] 
if (matches[2] == "الماركداون بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الماركداون" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الماركداون بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الماركداون بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الماركداون ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if markdown == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الماركداون مفتوحه" 
    else 
    return "📮 | •  الماركداون مفتوحه" 
   end 
end 
  local offender = 'markdown_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["markdown"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الماركداون" 
    else 
    return "📮 | • تم فتح   الماركداون" 
       end 
   end 
end 

---------------------قفل المنشن------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local mention = data[tostring(msg.to.id)]["settings"]["mention"] 
if (matches[2] == "المنشن بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "المنشن" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "المنشن بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "المنشن بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` المنشن ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if mention == "مفتوحه" then 
   if not lang then 
    return "📮 | •  المنشن مفتوحه" 
    else 
    return "📮 | •  المنشن مفتوحه" 
   end 
end 
  local offender = 'mention_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["mention"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   المنشن" 
    else 
    return "📮 | • تم فتح   المنشن" 
       end 
   end 
end 

---------------------قفل التكرار------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local flood = data[tostring(msg.to.id)]["settings"]["flood"] 
if (matches[2] == "التكرار بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["flood"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` تكرار ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` تكرار ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "التكرار بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["flood"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` تكرار ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` تكرار ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if flood == "disable" then 
   if not lang then 
    return "📮 | •  تكرار مفتوحه" 
    else 
    return "📮 | •  تكرار مفتوحه" 
   end 
end 
data[tostring(msg.to.id)]["settings"]["flood"] = "disable" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "👁‍??￤تم فتح   تكرار" 
    else 
    return "??‍🗨￤تم فتح   تكرار" 
       end 
   end 
end 

---------------------قفل الكلايش------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local spam = data[tostring(msg.to.id)]["settings"]["spam"] 
if (matches[2] == "الكلايش بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الكلايش" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
     return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الكلايش بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الكلايش بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
     return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الكلايش ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if spam == "disable" then 
   if not lang then 
    return "📮 | •  الكلايش مفتوحه" 
    else 
    return "📮 | •  الكلايش مفتوحه" 
   end 
end 
  local offender = 'spam_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["spam"] = "disable" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الكلايش" 
    else 
    return "📮 | • تم فتح   الكلايش" 
       end 
   end 
end 

---------------------قفل الصفحات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local webpage = data[tostring(msg.to.id)]["settings"]["webpage"] 
if (matches[2] == "الصفحات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الصفحات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الصفحات بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الصفحات بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الصفحات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if webpage == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الصفحات مفتوحه" 
    else 
    return "📮 | •  الصفحات مفتوحه" 
   end 
end 
  local offender = 'webpage_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["webpage"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الصفحات" 
    else 
    return "📮 | • تم فتح   الصفحات" 
       end 
   end 
end 

---------------------قفل التوجيه------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local forward = data[tostring(msg.to.id)]["settings"]["forward"] 
if (matches[2] == "التوجيه بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "التوجيه" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔒` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "التوجيه بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` التوجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "التوجيه بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` قفل اعادة توجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔒` قفل اعادة توجيه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if forward == "مفتوحه" then 
   if not lang then 
    return "📮 | •  التوجيه مفتوحه" 
    else 
    return "📮 | •  التوجيه مفتوحه" 
   end 
end 
  local offender = 'forward_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["forward"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   التوجيه" 
    else 
    return "📮 | • تم فتح   التوجيه" 
       end 
   end 
end 

--------------------قفل توجيه القنواة------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local view = data[tostring(msg.to.id)]["settings"]["view"] 
if (matches[2] == "توجيه القنواة بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل 🔒 قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • التحذير ☡" 
    else 
    return "📮 | • تم قفل 🔒 قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • التحذير ☡" 
   end 
elseif (matches[2] == "توجيه القنواة" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • المسح 🗑" 
    else 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • المسح 🗑" 
   end 
elseif (matches[2] == "توجيه القنواة بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطرد 🚷" 
    else 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطرد 🚷" 
   end 
elseif (matches[2] == "توجيه القنواة بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔒` قفل توجيه القنواة ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if view == "مفتوحه" then 
   if not lang then 
    return "📮 | •  توجيه القنواةمفتوحه" 
    else 
    return "📮 | •  توجيه القنواةمفتوحه" 
   end 
end 
  local offender = 'view_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["view"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   توجيه القنواة" 
    else 
    return "📮 | • تم فتح   توجيه القنواة" 
       end 
   end 
end 

---------------------قفل الصفحات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local sticker = data[tostring(msg.to.id)]["settings"]["sticker"] 
if (matches[2] == "الملصقات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الملصقات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الملصقات بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الملصقات بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل `🔐` الملصقات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if sticker == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الملصقات مفتوحه" 
    else 
    return "📮 | •  الملصقات مفتوحه" 
   end 
end 
  local offender = 'sticker_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["sticker"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الملصقات" 
    else 
    return "📮 | • تم فتح   الملصقات" 
       end 
   end 
end 

---------------------قفل الصور------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local photo = data[tostring(msg.to.id)]["settings"]["photo"] 
if (matches[2] == "الصور بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الصور" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الصور بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الصور بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الصور ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if photo == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الصور مفتوحه" 
    else 
    return "📮 | •  الصور مفتوحه" 
   end 
end 
  local offender = 'photo_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["photo"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الصور" 
    else 
    return "📮 | • تم فتح   الصور" 
       end 
   end 
end 

---------------------قفل الفيديو------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local video = data[tostring(msg.to.id)]["settings"]["video"] 
if (matches[2] == "الفيديو بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الفيديو" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الفيديو بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚷" 
   end 
elseif (matches[2] == "الفيديو بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الفيديو ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if video == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الفيديو مفتوحه" 
    else 
    return "👁‍??￤ الفيديو مفتوحه" 
   end 
end 
  local offender = 'video_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["video"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الفيديو" 
    else 
    return "📮 | • تم فتح   الفيديو" 
       end 
   end 
end 

---------------------قفل المتحركه------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local gif = data[tostring(msg.to.id)]["settings"]["gif"] 
if (matches[2] == "المتحركه بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "المتحركه" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "المتحركه بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "المتحركه بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` المتحركه ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if gif == "مفتوحه" then 
   if not lang then 
    return "📮 | •  المتحركه مفتوحه" 
    else 
    return "📮 | •  المتحركه مفتوحه" 
   end 
end 
  local offender = 'gif_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["gif"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   المتحركه" 
    else 
    return "📮 | • تم فتح   المتحركه" 
       end 
   end 
end 

---------------------قفل الكيبورد------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local keyboard = data[tostring(msg.to.id)]["settings"]["keyboard"] 
if (matches[2] == "الكيبورد بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الكيبورد" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الكيبورد بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الكيبورد بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الكيبورد ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if keyboard == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الكيبورد مفتوحه" 
    else 
    return "📮 | •  الكيبورد مفتوحه" 
   end 
end 
  local offender = 'keyboard_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم فتح   الكيبورد" 
    else 
    return "📮 | • تم فتح   الكيبورد" 
       end 
   end 
end 

---------------------قفل الملفات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local document = data[tostring(msg.to.id)]["settings"]["document"] 
if (matches[2] == "الملفات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الملفات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الملفات بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `??` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الملفات بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الملفات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if document == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الملفات مفتوحه" 
    else 
    return "📮 | •  الملفات مفتوحه" 
   end 
end 
  local offender = 'document_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["document"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الملفات" 
    else 
    return "??‍🗨￤تم فتح   الملفات" 
       end 
   end 
end 

---------------------قفل المواقع------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local location = data[tostring(msg.to.id)]["settings"]["location"] 
if (matches[2] == "المواقع بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "المواقع" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "المواقع بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "المواقع بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` المواقع ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if location == "مفتوحه" then 
   if not lang then 
    return "??‍🗨￤ المواقع مفتوحه" 
    else 
    return "📮 | •  المواقع مفتوحه" 
   end 
end 
  local offender = 'location_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["location"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "??‍🗨￤تم فتح   المواقع" 
    else 
    return "📮 | • تم فتح   المواقع" 
       end 
   end 
end 

---------------------قفل الجهات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local contact = data[tostring(msg.to.id)]["settings"]["contact"] 
if (matches[2] == "الجهات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الجهات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الجهات بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الجهات بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الجهات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if contact == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الجهات مفتوحه" 
    else 
    return "📮 | •  الجهات مفتوحه" 
   end 
end 
  local offender = 'contact_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["contact"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الجهات" 
    else 
    return "📮 | • تم فتح   الجهات" 
       end 
   end 
end 

---------------------قفل الصوت------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local audio = data[tostring(msg.to.id)]["settings"]["audio"] 
if (matches[2] == "الصوت بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الصوت" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الصوت بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الصوت بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الصوت ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if audio == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الصوت مفتوحه" 
    else 
    return "📮 | •  الصوت مفتوحه" 
   end 
end 
  local offender = 'audio_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["audio"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الصوت" 
    else 
    return "📮 | • تم فتح   الصوت" 
       end 
   end 
end 

---------------------قفل الالعاب------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local game = data[tostring(msg.to.id)]["settings"]["game"] 
if (matches[2] == "الالعاب بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الالعاب" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الالعاب بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الالعاب بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الالعاب ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if game == "مفتوحه" then 
   if not lang then 
    return "📮 | •  قفل الالعاب مفتوحه" 
    else 
    return "📮 | •  قفل الالعاب مفتوحه" 
   end 
end 
  local offender = 'game_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["game"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   قفل الالعاب" 
    else 
    return "📮 | • تم فتح   قفل الالعاب" 
       end 
   end 
end 

---------------------قفل اللستات------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local inline = data[tostring(msg.to.id)]["settings"]["inline"] 
if (matches[2] == "اللستات بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "اللستات" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "اللستات بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "اللستات بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` اللستات ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if inline == "مفتوحه" then 
   if not lang then 
    return "📮 | •  اللستات مفتوحه" 
    else 
    return "📮 | •  اللستات مفتوحه" 
   end 
end 
  local offender = 'inline_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["inline"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   اللستات" 
    else 
    return "📮 | • تم فتح   اللستات" 
       end 
   end 
end 

---------------------قفل الاغاني------------------ 
if matches[1] == "قفل" and is_mod(msg) then 
local voice = data[tostring(msg.to.id)]["settings"]["voice"] 
if (matches[2] == "الاغاني بالتحذير" and not Clang) or (matches[2] == "بالتحذير" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
    else 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة : التحذيـر ☡" 
   end 
elseif (matches[2] == "الاغاني" and not Clang) or (matches[2] == "بالحذف" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
    else 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑" 
   end 
elseif (matches[2] == "الاغاني بالطرد" and not Clang) or (matches[2] == "بالطرد" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
    else 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الطـرد 🚯" 
   end 
elseif (matches[2] == "الاغاني بالكتم" and not Clang) or (matches[2] == "بالكتم" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
    else 
    return "📮 | • تم قفل `🔐` الاغاني ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الكتـم 🔇" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "تعطيل" and Clang) then 
  if voice == "مفتوحه" then 
   if not lang then 
    return "📮 | •  الاغاني مفتوحه" 
    else 
    return "📮 | •  الاغاني مفتوحه" 
   end 
end 
  local offender = 'voice_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["voice"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتح   الاغاني" 
    else 
    return "📮 | • تم فتح   الاغاني" 
       end 
   end 
end 
 ---------------------كودات الفتح------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local link = data[tostring(msg.to.id)]["settings"]["link"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الروابط" 
    else 
    return " \n📮 | • تم قفل  الروابط" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الروابط " 
    else 
    return " \n📮 | • تم قفل  الروابط " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الروابط" 
    else 
    return " \n📮 | • تم قفل  الروابط" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["link"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الروابط" 
    else 
    return " \n📮 | • تم قفل  الروابط" 
   end 
elseif (matches[2] == "الروابط" and not Clang) or (matches[2] == "الروابط" and Clang) then 
  if link == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الروابط\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الروابط\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'link_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["link"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الروابط\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الروابط\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Tag Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local tags = data[tostring(msg.to.id)]["settings"]["tag"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n??‍🗨￤تم قفل  المعرفات" 
    else 
    return " \n📮 | • تم قفل  المعرفات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  المعرفات " 
    else 
    return " \n??‍🗨￤تم قفل  المعرفات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل  المعرفات" 
    else 
    return " \n📮 | • تم قفل  المعرفات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["tag"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  المعرفات" 
    else 
    return " \n📮 | • تم قفل  المعرفات" 
   end 
elseif (matches[2] == "المعرفات" and not Clang) or (matches[2] == "المعرفات" and Clang) then 
  if tags == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المعرفات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المعرفات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'tag_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["tag"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المعرفات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المعرفات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Text Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local text = data[tostring(msg.to.id)]["settings"]["text"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الدردشه" 
    else 
    return " \n📮 | • تم قفل  الدردشه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الدردشه " 
    else 
    return " \n📮 | • تم قفل  الدردشه " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الدردشه" 
    else 
    return " \n📮 | • تم قفل  الدردشه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["text"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الدردشه" 
    else 
    return " \n📮 | • تم قفل  الدردشه" 
   end 
elseif (matches[2] == "الدردشه" and not Clang) or (matches[2] == "الدردشه" and Clang) then 
  if text == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓` الدردشه \n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓` الدردشه \n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'text_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["text"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return  "📮 | • تم فتـح `🔓` الدردشه \n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓` الدردشه \n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Chat Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local chats = data[tostring(msg.to.id)]["settings"]["chat"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الكل" 
    else 
    return " \n📮 | • تم قفل  الكل" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الكل " 
    else 
    return " \n📮 | • تم قفل  الكل " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الكل" 
    else 
    return " \n📮 | • تم قفل  الكل" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["chat"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل  الكل" 
    else 
    return " \n📮 | • تم قفل  الكل" 
   end 
elseif (matches[2] == "الكل" and not Clang) or (matches[2] == "الكل" and Clang) then 
  if chats == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكل\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكل\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'chat_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["chat"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكل\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكل\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Arabic Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local arabic = data[tostring(msg.to.id)]["settings"]["arabic"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل العربيه" 
    else 
    return " \n📮 | • تم قفل العربيه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل العربيه " 
    else 
    return " \n📮 | • تم قفل العربيه " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل العربيه" 
    else 
    return " \n📮 | • تم قفل العربيه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["arabic"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل العربيه" 
    else 
    return " \n📮 | • تم قفل العربيه" 
   end 
elseif (matches[2] == "العربيه" and not Clang) or (matches[2] == "العربيه" and Clang) then 
  if arabic == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    العربيه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    العربيه\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'arabic_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["arabic"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    العربيه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    العربيه\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Edit Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local edit = data[tostring(msg.to.id)]["settings"]["edit"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التعديل" 
    else 
    return " \n📮 | • تم قفل التعديل" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n👁‍??￤تم قفل التعديل " 
    else 
    return " \n📮 | • تم قفل التعديل " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التعديل" 
    else 
    return " \n📮 | • تم قفل التعديل" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["edit"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التعديل" 
    else 
    return " \n📮 | • تم قفل التعديل" 
   end 
elseif (matches[2] == "التعديل" and not Clang) or (matches[2] == "التعديل" and Clang) then 
  if edit == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    التعديل\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    التعديل\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'edit_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["edit"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    التعديل\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    التعديل\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------MarkDown Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local markdown = data[tostring(msg.to.id)]["settings"]["markdown"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الماركداون" 
    else 
    return " \n📮 | • تم قفل الماركداون" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الماركداون " 
    else 
    return " \n📮 | • تم قفل الماركداون " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الماركداون" 
    else 
    return " \n📮 | • تم قفل الماركداون" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["markdown"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الماركداون" 
    else 
    return " \n📮 | • تم قفل الماركداون" 
   end 
elseif (matches[2] == "الماركداون" and not Clang) or (matches[2] == "الماركداون" and Clang) then 
  if markdown == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الماركداون\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الماركداون\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'markdown_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["markdown"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الماركداون\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الماركداون\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Mention Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local mention = data[tostring(msg.to.id)]["settings"]["mention"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المنشن" 
    else 
    return " \n📮 | • تم قفل المنشن" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المنشن " 
    else 
    return " \n📮 | • تم قفل المنشن " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n👁‍??￤تم قفل المنشن" 
    else 
    return " \n📮 | • تم قفل المنشن" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["mention"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المنشن" 
    else 
    return "👁‍??￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل المنشن" 
   end 
elseif (matches[2] == "المنشن" and not Clang) or (matches[2] == "المنشن" and Clang) then 
  if mention == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المنشن\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المنشن\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'mention_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["mention"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المنشن\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المنشن\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Flood Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local flood = data[tostring(msg.to.id)]["settings"]["flood"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["flood"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل تكرار" 
    else 
    return " \n📮 | • تم قفل تكرار" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["flood"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل تكرار" 
    else 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n👁‍??￤تم قفل تكرار" 
   end 
elseif (matches[2] == "التكرار" and not Clang) or (matches[2] == "التكرار" and Clang) then 
  if flood == "disable" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    تكرار\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    تكرار\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
data[tostring(msg.to.id)]["settings"]["flood"] = "disable" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    تكرار\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    تكرار\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Spam Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local spam = data[tostring(msg.to.id)]["settings"]["spam"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الكلايش" 
    else 
    return " \n📮 | • تم قفل الكلايش" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
     return " \n📮 | • تم قفل الكلايش " 
    else 
    return " \n📮 | • تم قفل الكلايش " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الكلايش" 
    else 
    return " \n📮 | • تم قفل الكلايش" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["spam"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
     return " \n📮 | • تم قفل الكلايش" 
    else 
    return " \n📮 | • تم قفل الكلايش" 
   end 
elseif (matches[2] == "الكلايش" and not Clang) or (matches[2] == "الكلايش" and Clang) then 
  if spam == "disable" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكلايش\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكلايش\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'spam_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["spam"] = "disable" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكلايش\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكلايش\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Webpage Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local webpage = data[tostring(msg.to.id)]["settings"]["webpage"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصفحات" 
    else 
    return " \n📮 | • تم قفل الصفحات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصفحات " 
    else 
    return " \n📮 | • تم قفل الصفحات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصفحات" 
    else 
    return " \n📮 | • تم قفل الصفحات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["webpage"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصفحات" 
    else 
    return " \n📮 | • تم قفل الصفحات" 
   end 
elseif (matches[2] == "الصفحات" and not Clang) or (matches[2] == "الصفحات" and Clang) then 
  if webpage == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصفحات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصفحات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'webpage_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["webpage"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصفحات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصفحات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Forward Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local forward = data[tostring(msg.to.id)]["settings"]["forward"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التوجيه" 
    else 
    return " \n📮 | • تم قفل التوجيه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التوجيه " 
    else 
    return " \n📮 | • تم قفل التوجيه " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل التوجيه" 
    else 
    return " \n📮 | • تم قفل التوجيه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["forward"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل قفل اعادة توجيه" 
    else 
    return " \n📮 | • تم قفل قفل اعادة توجيه" 
   end 
elseif (matches[2] == "التوجيه" and not Clang) or (matches[2] == "التوجيه" and Clang) then 
  if forward == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    التوجيه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    التوجيه\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'forward_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["forward"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    التوجيه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    التوجيه\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------View Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local view = data[tostring(msg.to.id)]["settings"]["view"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل توجيه القنواة\n📮 | •  خاصيه التحذير ⚠" 
    else 
    return " \n📮 | • تم قفل توجيه القنواة\n📮 | •  خاصيه التحذير ⚠" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل توجيه القنواة" 
    else 
    return " \n📮 | • تم قفل توجيه القنواة" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n??‍🗨￤تم قفل توجيه القنواة\n👁‍??￤ خاصيه الطرد 🚸" 
    else 
    return " \n??‍🗨￤تم قفل توجيه القنواة\n??‍??￤ خاصيه الطرد 🚸" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["view"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل توجيه القنواة\n📮 | •  خاصيه الكتم 🔕" 
    else 
    return " \n📮 | • تم قفل توجيه القنواة\n📮 | •  خاصيه الكتم 🔕" 
   end 
elseif (matches[2] == "توجيه القنواة" and not Clang) or (matches[2] == "توجيه القنواة" and Clang) then 
  if view == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    توجيه القنواة\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    توجيه القنواة\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'view_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["view"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    توجيه القنواة\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    توجيه القنواة\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Sticker Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local sticker = data[tostring(msg.to.id)]["settings"]["sticker"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملصقات" 
    else 
    return " \n📮 | • تم قفل الملصقات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملصقات " 
    else 
    return " \n?? | • تم قفل الملصقات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملصقات" 
    else 
    return " \n📮 | • تم قفل الملصقات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["sticker"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل الملصقات" 
    else 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل الملصقات" 
   end 
elseif (matches[2] == "الملصقات" and not Clang) or (matches[2] == "الملصقات" and Clang) then 
  if sticker == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الملصقات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الملصقات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'sticker_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["sticker"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الملصقات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الملصقات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Photo Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local photo = data[tostring(msg.to.id)]["settings"]["photo"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n👁‍??￤تم قفل الصور" 
    else 
    return " \n📮 | • تم قفل الصور" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصور " 
    else 
    return " \n📮 | • تم قفل الصور " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصور" 
    else 
    return " \n📮 | • تم قفل الصور" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["photo"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصور" 
    else 
    return " \n📮 | • تم قفل الصور" 
   end 
elseif (matches[2] == "الصور" and not Clang) or (matches[2] == "الصور" and Clang) then 
  if photo == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصور\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصور\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'photo_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["photo"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصور\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصور\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Video Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local video = data[tostring(msg.to.id)]["settings"]["video"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الفيديو" 
    else 
    return " \n📮 | • تم قفل الفيديو" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الفيديو " 
    else 
    return " \n📮 | • تم قفل الفيديو " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الفيديو" 
    else 
    return " \n📮 | • تم قفل الفيديو" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["video"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n👁‍??￤تم قفل الفيديو" 
    else 
    return " \n📮 | • تم قفل الفيديو" 
   end 
elseif (matches[2] == "الفيديو" and not Clang) or (matches[2] == "الفيديو" and Clang) then 
  if video == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الفيديو\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الفيديو\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'video_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["video"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الفيديو\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الفيديو\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Gif Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local gif = data[tostring(msg.to.id)]["settings"]["gif"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المتحركه" 
    else 
    return " \n📮 | • تم قفل المتحركه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المتحركه " 
    else 
    return " \n📮 | • تم قفل المتحركه " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المتحركه" 
    else 
    return " \n📮 | • تم قفل المتحركه" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["gif"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المتحركه" 
    else 
    return " \n📮 | • تم قفل المتحركه" 
   end 
elseif (matches[2] == "المتحركه" and not Clang) or (matches[2] == "المتحركه" and Clang) then 
  if gif == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المتحركه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المتحركه\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'gif_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["gif"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المتحركه\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المتحركه\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Keyboard Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local keyboard = data[tostring(msg.to.id)]["settings"]["keyboard"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الكيبورد" 
    else 
    return " \n📮 | • تم قفل الكيبورد" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الكيبورد " 
    else 
    return " \n📮 | • تم قفل الكيبورد " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الكيبورد" 
    else 
    return " \n📮 | • تم قفل الكيبورد" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "??‍🗨￤مرحــبا عزيــزي المستخــدم \n📮 | • تم قفل الكيبورد" 
    else 
    return " \n📮 | • تم قفل الكيبورد" 
   end 
elseif (matches[2] == "الكيبورد" and not Clang) or (matches[2] == "الكيبورد" and Clang) then 
  if keyboard == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكيبورد\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكيبورد\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'keyboard_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["keyboard"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الكيبورد\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الكيبورد\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Document Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local document = data[tostring(msg.to.id)]["settings"]["document"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملفات" 
    else 
    return " \n📮 | • تم قفل الملفات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملفات " 
    else 
    return " \n📮 | • تم قفل الملفات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملفات" 
    else 
    return " \n📮 | • تم قفل الملفات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["document"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الملفات" 
    else 
    return " \n📮 | • تم قفل الملفات" 
   end 
elseif (matches[2] == "الملفات" and not Clang) or (matches[2] == "الملفات" and Clang) then 
  if document == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الملفات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الملفات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'document_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["document"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الملفات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الملفات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Location Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local location = data[tostring(msg.to.id)]["settings"]["location"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المواقع" 
    else 
    return " \n📮 | • تم قفل المواقع" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المواقع " 
    else 
    return " \n📮 | • تم قفل المواقع " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n??‍🗨￤تم قفل المواقع" 
    else 
    return " \n📮 | • تم قفل المواقع" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["location"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل المواقع" 
    else 
    return " \n👁‍??￤تم قفل المواقع" 
   end 
elseif (matches[2] == "المواقع" and not Clang) or (matches[2] == "المواقع" and Clang) then 
  if location == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المواقع\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المواقع\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'location_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["location"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    المواقع\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    المواقع\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Contact Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local contact = data[tostring(msg.to.id)]["settings"]["contact"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الجهات" 
    else 
    return " \n📮 | • تم قفل الجهات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الجهات " 
    else 
    return " \n📮 | • تم قفل الجهات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الجهات" 
    else 
    return " \n?? | • تم قفل الجهات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["contact"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الجهات" 
    else 
    return " \n📮 | • تم قفل الجهات" 
   end 
elseif (matches[2] == "الجهات" and not Clang) or (matches[2] == "الجهات" and Clang) then 
  if contact == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الجهات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الجهات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'contact_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["contact"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الجهات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الجهات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Audio Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local audio = data[tostring(msg.to.id)]["settings"]["audio"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصوت" 
    else 
    return " \n📮 | • تم قفل الصوت" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصوت " 
    else 
    return " \n📮 | • تم قفل الصوت " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصوت" 
    else 
    return " \n📮 | • تم قفل الصوت" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["audio"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الصوت" 
    else 
    return " \n📮 | • تم قفل الصوت" 
   end 
elseif (matches[2] == "الصوت" and not Clang) or (matches[2] == "الصوت" and Clang) then 
  if audio == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصوت\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصوت\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'audio_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["audio"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الصوت\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الصوت\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Game Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local game = data[tostring(msg.to.id)]["settings"]["game"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الالعاب" 
    else 
    return " \n📮 | • تم قفل الالعاب" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الالعاب " 
    else 
    return " \n📮 | • تم قفل الالعاب " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n👁‍??￤تم قفل الالعاب" 
    else 
    return " \n??‍??￤تم قفل الالعاب" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["game"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الالعاب" 
    else 
    return " \n📮 | • تم قفل الالعاب" 
   end 
elseif (matches[2] == "الالعاب" and not Clang) or (matches[2] == "الالعاب" and Clang) then 
  if game == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    قفل الالعاب\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    قفل الالعاب\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'game_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["game"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    قفل الالعاب\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    قفل الالعاب\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Inline Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local inline = data[tostring(msg.to.id)]["settings"]["inline"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n??‍🗨￤تم اللستات" 
    else 
    return " \n📮 | • تم اللستات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل اللستات " 
    else 
    return " \n📮 | • تم قفل اللستات " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل اللستات" 
    else 
    return " \n📮 | • تم قفل اللستات" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["inline"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل اللستات" 
    else 
    return " \n📮 | • تم قفل اللستات" 
   end 
elseif (matches[2] == "اللستات" and not Clang) or (matches[2] == "اللستات" and Clang) then 
  if inline == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    اللستات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    اللستات\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'inline_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["inline"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    اللستات\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    اللستات\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end 

---------------------Voice Settings------------------ 
if matches[1] == "فتح" and is_mod(msg) then 
local voice = data[tostring(msg.to.id)]["settings"]["voice"] 
if (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالتحذير" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الاغاني" 
    else 
    return " \n📮 | • تم قفل الاغاني" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالحذف" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الاغاني " 
    else 
    return " \n📮 | • تم قفل الاغاني " 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالطرد" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n??‍🗨￤تم قفل الاغاني" 
    else 
    return " \n👁‍??￤تم قفل الاغاني" 
   end 
elseif (matches[2] == "" and not Clang) or (matches[2] == "" and Clang) then 
data[tostring(msg.to.id)]["settings"]["voice"] = "بالكتم" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return " \n📮 | • تم قفل الاغاني" 
    else 
    return " \n📮 | • تم قفل الاغاني" 
   end 
elseif (matches[2] == "الاغاني" and not Clang) or (matches[2] == "الاغاني" and Clang) then 
  if voice == "مفتوحه" then 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الاغاني\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الاغاني\n\n\n📮 | • خاصيـة • الـفتـح" 
   end 
end 
  local offender = 'voice_offender:'..msg.to.id 
   redis:del(offender) 
data[tostring(msg.to.id)]["settings"]["voice"] = "مفتوحه" 
 save_data(_config.moderation.data, data) 
   if not lang then 
    return "📮 | • تم فتـح `🔓`    الاغاني\n\n\n📮 | • خاصيـة • الـفتـح" 
    else 
    return "📮 | • تم فتـح `🔓`    الاغاني\n\n\n📮 | • خاصيـة • الـفتـح" 
       end 
   end 
end

  ---------------------- 
   if matches[1] == "المجموعات" and is_admin(msg) then 
return storm_chat(msg)
    end 

if matches[1] == 'تحويل سوبر' and is_admin(msg) then 
local text = matches[2] 
tdcli.createNewGroupChat({[0] = msg.from.id}, text) 
  if not lang then 
return ''
  else 
return ''
   end 
end 

if matches[1] == 'ترقيه المجموعه' and is_admin(msg) then 
local text = matches[2] 
tdcli.createNewChannelChat({[0] = msg.sender_user_id_}, text) 
   if not lang then 
return ''
  else 
return ''
   end 
end 

if matches[1] == 'سوبر' and is_admin(msg) then 
local id = msg.to.id 
tdcli.migrateGroupChatToChannelChat(id) 
  if not lang then 
return ''
  else 
return ''
   end 
end 

if matches[1] == 'دخول' and is_admin(msg) then 
tdcli.importChatInviteLink(matches[2]) 
   if not lang then 
return ''
  else 
return ''
  end 
end 

if matches[1] == 'ضع اسم البوت' and is_sudo(msg) then 
tdcli.changeName(matches[2]) 
   if not lang then 
return '📮 | •  تم تغيير اسم البوت :_ \n`{ '..matches[2]..' }`'
  else 
return '📮 | •  تم تغيير اسم البوت :_ \n`{ '..matches[2]..' }`'
   end 
end 

if matches[1] == 'ضع معرف البوت' and is_sudo(msg) then 
tdcli.changeUsername(matches[2]) 
   if not lang then 
return '📮 | • تم تغيير معرف البوت\n{ @'..matches[2]..' }'
  else 
return '📮 | • تم تغيير معرف البوت\n{ @'..matches[2]..' }'
   end 
end 

if matches[1] == 'حذف معرف البوت' and is_sudo(msg) then 
tdcli.changeUsername('') 
   if not lang then 
return '📮 | • تم حذف معرف البوت'
  else
return '📮 | • تم حذف معرف البوت'
end
end 

if matches[1] == 'ت' and is_sudo(msg) then 
if matches[2] == 'فعيل الماركدون' then 
redis:set('markread','on') 
   if not lang then
return '📮 | • تم تفعيل الماركدون'
else
return '📮 | • تم تفعيل الماركدون'
   end 
end 
if matches[2] == 'عطيل الماركدون' then 
redis:set('markread','off') 
    if not lang then
return '📮 | • تم تعطيل الماركدون'
   else
return '📮 | • تم تعطيل الماركدون'
      end 
   end 
end 

if matches[1] == 'اذاعه' and msg.from.id == tonumber(SUDO) then		
local data = load_data(_config.moderation.data)		
local bc = matches[2]			
for k,v in pairs(data) do				
tdcli.sendMessage(k, 0, 0, bc, 0)			
end	
end

if matches[1] == "المطورين" and msg.from.id == tonumber(SUDO) then
return sudolist(msg) 
    end 

      if matches[1] == "تعطيل" and matches[2] and is_admin(msg) then 
    local data = load_data(_config.moderation.data) 
         data[tostring(matches[2])] = nil 
         save_data(_config.moderation.data, data) 
         local groups = 'groups' 
         if not data[tostring(groups)] then 
            data[tostring(groups)] = nil 
            save_data(_config.moderation.data, data) 
         end 
         data[tostring(groups)][tostring(matches[2])] = nil 
         save_data(_config.moderation.data, data) 
      tdcli.sendMessage(matches[2], 0, 1, "Group has been removed by admin command", 1, 'html') 
    return '📮 | • تم تعطيل المجموعه *'..matches[2]..'* بنجاح' 
      end 
if matches[1] == "الاداريين" and is_admin(msg) then 
return adminlist(msg) 
    end 
     if matches[1] == "غادر" and is_sudo(msg) then 
  tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil) 
   end 
     if matches[1] == "ت" and msg.from.id == tonumber(SUDO) then 
local hash = 'auto_leave_bot' 
--Enable Auto Leave 
     if matches[2] == 'فعيل المغادره' then 
    redis:del(hash) 
   return '📮 | • *المغادره تلقائيا تم تفعيلها*'
--Disable Auto Leave 
     elseif matches[2] == 'عطيل المغادره' then 
    redis:set(hash, true) 
   return '📮 | • *المغادره تلقائيا تم تعطيلها*'
--Auto Leave Status 
      elseif matches[2] == 'حاله المغادره' then 
      if not redis:get(hash) then 
   return '📮 | • *الخروج تلقائي تم تفعيله 📡*'
       else
   return '📮 | • *الخروج تلقائي تم تعطيله ❌*'
         end
      end 
   end 
   -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------خاصيه التسغيل والايقاف ---------------
if matches[1] == "تشغيل" and is_mod(msg) then
local target = msg.to.id
local target = msg.to.id
if matches[2] == "الردود" then
lock_reply = data[tostring(chat)]['settings']['lock_reply']
if lock_reply == "yas" then
return '📮 | • تم تشغيل🔓  الردود\n\n\n📮 | • خاصيـة • الـفتـح'
else
data[tostring(chat)]['settings']['lock_reply'] = "yas"
save_data(_config.moderation.data, data)
return '📮 | • تم تشغيل🔓  الردود\n\n\n📮 | • خاصيـة • الـفتـح'
end
end
if matches[2] == "الايدي" then
lock_id = data[tostring(chat)]['settings']['lock_id']
if lock_id == "yas" then
return '📮 | • تم تشغيل🔓  الايدي\n\n\n📮 | • خاصيـة • الـفتـح'
else
data[tostring(chat)]['settings']['lock_id'] = "yas"
save_data(_config.moderation.data, data)
return '📮 | • تم تشغيل🔓  الايدي\n\n\n📮 | • خاصيـة • الـفتـح'
end
end
if matches[2] == "جلب الصوره" then
lock_get = data[tostring(chat)]['settings']['lock_get']
if lock_get == "yas" then
return '📮 | • تم تشغيل `🔐` جلب الصوره  \n\n\n📮 | • خاصيـة • الـفتـح ' 
else
data[tostring(chat)]['settings']['lock_get'] = "yas"
save_data(_config.moderation.data, data)
return '📮 | • تم تشغيل `🔐` جلب الصوره  \n\n\n📮 | • خاصيـة • الـفتـح '
end
end
if matches[2] == "الخدمات" and msg.from.id == tonumber(SUDO) then
lock_taha = data[tostring(chat)]['settings']['lock_taha']
if lock_taha == "yas" then
return '📮 | • تم تشغيل🔓  الخدمات\n\n\n📮 | • خاصيـة • الـفتـح'
else
data[tostring(chat)]['settings']['lock_taha'] = "yas"
save_data(_config.moderation.data, data)
return '📮 | • تم تشغيل🔓  الخدمات\n\n\n📮 | • خاصيـة • الـفتـح'
end
end
end
if matches[1] == "ايقاف" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "الردود" then
lock_reply = data[tostring(chat)]['settings']['lock_reply']
if lock_reply == "no" then
return '📮 | • تم ايقاف 🔐 الردود  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
else
data[tostring(chat)]['settings']['lock_reply'] = "no"
save_data(_config.moderation.data, data)
return '📮 | • تم ايقاف 🔐 الردود  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
end
end
if matches[2] == "الايدي" then
lock_id = data[tostring(chat)]['settings']['lock_id']
if lock_id == "no" then
return '📮 | • تم ايقاف 🔐 الايدي  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
else
data[tostring(chat)]['settings']['lock_id'] = "no"
save_data(_config.moderation.data, data)
return '📮 | • تم ايقاف 🔐 الايدي  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
end
end
if matches[2] == "جلب الصوره" then
lock_get = data[tostring(chat)]['settings']['lock_get']
if lock_get == "no" then
return '📮 | • تم ايقاف 🔐 جلب الصوره  \n\n\n📮 | • خاصيـة • الحـذف 🗑'
else
data[tostring(chat)]['settings']['lock_get'] = "no"
save_data(_config.moderation.data, data)
return '📮 | • تم ايقاف 🔐 جلب الصوره  \n\n\n📮 | • خاصيـة • الحـذف 🗑'
end
end
if matches[2] == "الخدمات" and msg.from.id == tonumber(SUDO) then
lock_taha = data[tostring(chat)]['settings']['lock_taha']
if lock_taha == "no" then
return '📮 | • تم ايقاف 🔐 الخدمات  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
else
data[tostring(chat)]['settings']['lock_taha'] = "no"
save_data(_config.moderation.data, data)
return '📮 | • تم ايقاف 🔐 الخدمات  ❮ ☑️ ❯ \n\n\n📮 | • خاصيـة • الحـذف 🗑'
end
end
end
-----------------------
-- Show the available plugins 
  if is_sudo(msg) then
  if (matches[1]:lower() == 'الملفات' or matches[1] == 'الملفات') and msg.from.id == tonumber(SUDO) then --after changed to moderator mode, set only sudo
    return list_all_plugins(false, msg)
  end
end
  -- Re-enable a plugin for this chat
   if matches[1]:lower() == 'ت' or matches[1] == 'ت' and msg.from.id == tonumber(SUDO) then
  if matches[2] == 'فعيل ملف' and matches[4] == 'chat' or matches[4] == 'مجموعة' then
      if is_mod(msg) then
    local receiver = msg.chat_id_
    local plugin = matches[3]
    print("enable "..plugin..' on this chat')
    return reenable_plugin_on_chat(receiver, plugin, msg)
  end
    end

  -- Enable a plugin
  if matches[2] == 'فعيل ملف' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    local plugin_name = matches[3]
    print("enable: "..matches[3])
    return enable_plugin(plugin_name, msg)
  end
  -- Disable a plugin on a chat
  if matches[2] == 'عطيل ملف' and matches[4] == 'chat' or matches[4] == 'مجموعة' then
      if is_mod(msg) then
    local plugin = matches[3]
    local receiver = msg.chat_id_
    print("disable "..plugin..' on this chat')
    return disable_plugin_on_chat(receiver, plugin, msg)
  end
    end
  -- Disable a plugin
  if matches[2] == 'عطيل ملف' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    if matches[3] == 'plugins' then
		return 'This plugin can\'t be disabled'
    end
    print("disable: "..matches[3])
    return disable_plugin(matches[3], msg)
  end

  -- Reload all the plugins!
  if matches[2] == '*' and is_sudo(msg) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end
  end
  if (matches[1]:lower() == 'تحديث' or matches[1] == 'تحديث') and msg.from.id == tonumber(SUDO) then --after changed to moderator mode, set only sudo
    return reload_plugins(true, msg)
  end 
-------------------- الترحيب ----------------------- 
   if (matches[1]:lower() == "ت" or matches[1] == 'ت') and is_mod(msg) then 
   if not lang then 
      if matches[2] == "فعيل الترحيب" then 
         welcome = data[tostring(chat)]['settings']['welcome'] 
         if welcome == "✔" then 
            return " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تفعيلهَُـــا" 
         else 
      data[tostring(chat)]['settings']['welcome'] = "✔" 
       save_data(_config.moderation.data, data) 
            return " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تفعيلهَُـــا" 
         end 
      end 
      if matches[2] == "عطيل الترحيب" then 
         welcome = data[tostring(chat)]['settings']['welcome'] 
         if welcome == "✖" then 
            return " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تعطيلهَُـــا" 
         else 
      data[tostring(chat)]['settings']['welcome'] = "✖" 
       save_data(_config.moderation.data, data) 
            return " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تعطيلهَُـــا" 
         end 
      end 
      else 
            if matches[2] == "فعيل الترحيب" then 
         welcome = data[tostring(chat)]['settings']['welcome'] 
         if welcome == "✔" then 
            local text = " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تفعيلهَُـــا" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=20, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
         else 
      data[tostring(chat)]['settings']['welcome'] = "✔" 
       save_data(_config.moderation.data, data) 
            local text = " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تفعيلهَُـــا" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=24, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
         end 
      end 
      if matches[2] == "عطيل الترحيب" then 
         welcome = data[tostring(chat)]['settings']['welcome'] 
         if welcome == "✖" then 
            local text = " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تعطيلهَُـــا" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=24, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
         else 
      data[tostring(chat)]['settings']['welcome'] = "✖" 
       save_data(_config.moderation.data, data) 
            local text = " \n📮 | •  رسالَُـــه التَُـــرحيَُـــب تَُـــم تعطيلهَُـــا" 
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=30, user_id_=msg.sender_user_id_}}}}, dl_cb, nil) 
         end 
      end 
      end 
   end 
   if (matches[1]:lower() == "ضع ترحيب" or matches[1] == 'ضع ترحيب') and matches[2] and is_mod(msg) then 
      data[tostring(chat)]['setwelcome'] = matches[2] 
       save_data(_config.moderation.data, data) 
       if not lang then 
      return " \n📮 | •  تــــم وضـــع الترحــــيب \n📮 | •  الــــكلمه »:  { "..matches[2].." }\nٴ┄•⚔•┄༻💠༺┄•⚔•┄\n\n📮 | •  تستطيع ايضا وضع 📌\n📮 | • اسم  المجموعه • *gpname*\n📮 | • اضهار  القوانين • *rules*\n📮 | • معرف الشخص • *username*\n📮 | • عرض  الوقت • *time*\n📮 | • عرض التاريخ • *date*\n📮 | • اسم الشخص • *name*\n\nٴ┄•⚔•┄༻💠༺┄•⚔•┄" 
       else 
      return " \n📮 | •  تــــم وضـــع الترحــــيب \n📮 | •  الــــكلمه »:  { "..matches[2].." }\nٴ┄•⚔•┄༻💠༺┄•⚔•┄\n\n📮 | •  تستطيع ايضا وضع 📌\n📮 | • اسم  المجموعه • *gpname*\n📮 | • اضهار  القوانين • *rules*\n📮 | • معرف الشخص • *username*\n📮 | • عرض  الوقت • *time*\n📮 | • عرض التاريخ • *date*\n📮 | • اسم الشخص • *name*\n\nٴ┄•⚔•┄༻💠༺┄•⚔•┄" 
       end 
     end 
   end 
   if matches[1] == "الترحيب"  and is_mod(msg) then
		if data[tostring(msg.to.id)]['setwelcome']  then
	    return data[tostring(msg.to.id)]['setwelcome']  
	    else
		return "📮 | • اهلا بك يا "..(check_markdown(msg.from.first_name or "----"))..'\n📮 | • نورتنا ضيف جهاتك في كروب {` '..msg.to.title..'`}\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n•♦• تابع @'..botusea
	end
end

   ------------------------- 
    if (matches[1]:lower() == "معلومات المجموعه" or matches[1] == 'معلومات المجموعه') and is_mod(msg) and msg.to.type == "channel" then 
local function group_info(arg, data) 
if not lang then 
ginfo = "•⚜• معلومات المجموعه •⚜•\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n📮 | • عـدد الادمنـيه •  *["..data.administrator_count_.."]*\n\n📮 | • عـدد الاعضـاء • *["..data.member_count_.."]*\n\n📮 | • عـدد المطـرودين • *["..data.kicked_count_.."]*\n\n📮 | • الايـدي • *["..data.channel_.id_.."]*\n\n📮 | • الاسم • *["..msg.to.title.."]*\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n•تابع قناتنا• @"..botusea.."\n• المطور • @"..sudouser
elseif lang then 
ginfo = "•⚜• معلومات المجموعه •⚜•\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n\n📮 | • عـدد الادمنـيه •  *["..data.administrator_count_.."]*\n\n📮 | • عـدد الاعضـاء • *["..data.member_count_.."]*\n\n📮 | • عـدد المطـرودين • *["..data.kicked_count_.."]*\n\n📮 | • الايـدي • *["..data.channel_.id_.."]*\n\n📮 | • الاسم • *["..msg.to.title.."]*\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n•تابع قناتنا• @"..botusea.."\n• المطور • @"..sudouser
end 
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md') 
end 
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id}) 
end 
if (matches[1]:lower() == 'تغيير الرابط' or matches[1] == 'تغير الرابط') and is_mod(msg) and not matches[2] then 
   local function callback_link (arg, data) 
    local administration = load_data(_config.moderation.data) 
            if not data.invite_link_ then 
               administration[tostring(msg.to.id)]['settings']['linkgp'] = nil 
               save_data(_config.moderation.data, administration) 
       if not lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • البـوت مجـرد ادمن فـي المـجموعـه قـم بارسـال *•[ ضـع رابـط ]•* ", 1, 'md') 
       elseif lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • البـوت مجـرد ادمن فـي المـجموعـه قـم بارسـال *•[ ضـع رابـط ]•* ", 1, 'md') 
    end 
            else 
               administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_ 
               save_data(_config.moderation.data, administration) 
        if not lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • تـم صـنع رابـط جديـد •", 1, 'md') 
        elseif lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • تـم صـنع رابـط جديـد •", 1, 'md') 
            end 
            end 
         end 
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil) 
      end 
      if (matches[1]:lower() == 'رابط جديد' or matches[1] == 'رابط جديد') and is_mod(msg) and (matches[2] == 'pv' or matches[2] == 'خاص') then 
   local function callback_link (arg, data) 
      local result = data.invite_link_ 
      local administration = load_data(_config.moderation.data) 
            if not result then 
               administration[tostring(msg.to.id)]['settings']['linkgp'] = nil 
               save_data(_config.moderation.data, administration) 
       if not lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • البـوت مجـرد ادمن فـي المـجموعـه قـم بارسـال *•[ ضـع رابـط ]•* ", 1, 'md') 
       elseif lang then 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • البـوت مجـرد ادمن فـي المـجموعـه قـم بارسـال *•[ ضـع رابـط ]•* ", 1, 'md') 
    end 
            else 
               administration[tostring(msg.to.id)]['settings']['linkgp'] = result 
               save_data(_config.moderation.data, administration) 
        if not lang then 
      tdcli.sendMessage(user, msg.id, 1, "📮 | • رابـط المجموعـه • \n"..msg.to.id.."`\n"..result, 1, 'md') 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • تـم ارسـال الرابـط الـى الخـاص • ", 1, 'md') 
        elseif lang then 
      tdcli.sendMessage(user, msg.id, 1, "📮 | • رابـط المجموعـه • \n"..msg.to.id.."`\n"..result, 1, 'md') 
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • تـم ارسـال الرابـط الـى الخـاص • ", 1, 'md') 
            end 
            end 
         end 
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil) 
      end 
      if (matches[1]:lower() == 'ضع رابط' or matches[1] == 'ضع رابط') and is_owner(msg) then 
      if not matches[2] then 
      data[tostring(chat)]['settings']['linkgp'] = 'waiting' 
         save_data(_config.moderation.data, data) 
         if not lang then 
         return '📮 | • قـــم بارســـال الرابـــط الـــجديـــد •' 
    else 
         return '📮 | • قـــم بارســـال الرابـــط الـــجديـــد •' 
       end 
      end 
       data[tostring(chat)]['settings']['linkgp'] = matches[2] 
          save_data(_config.moderation.data, data) 
      if not lang then 
         return "📮 | • تـم حفــظ الرابــط الجــديــد • `<✔>`" 
    else 
         return "📮 | • تـم حفــظ الرابــط الجــديــد • `<✔>`" 
       end 
      end 
      if msg.text then 
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$") 
         if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then 
            data[tostring(chat)]['settings']['linkgp'] = msg.text 
            save_data(_config.moderation.data, data) 
            if not lang then 
            return "📮 | • تـم حفــظ الرابــط الجــديــد • `<✔>`" 
           else 
           return "📮 | • تـم حفــظ الرابــط الجــديــد • `<✔>`" 
          end 
       end 
      end 
    if (matches[1]:lower() == 'الرابط' or matches[1] == 'الرابط') and is_mod(msg) and not matches[2] then 
      local linkgp = data[tostring(chat)]['settings']['linkgp'] 
      if not linkgp then 
      if not lang then 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
     else 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
      end 
      end 
     if not lang then 
       text =   "📮 | • رابــط المجــموعـة • ⚙\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n\n"..linkgp 
     else 
      text =   "📮 | • رابــط المجــموعـة • ⚙\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n\n"..linkgp 
         end 
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html') 
     end 
     if ((matches[1] == "الرابط" and not Clang) or (matches[1] == "الرابط" and Clang)) and is_mod(msg) then 
      local linkgp = data[tostring(chat)]['settings']['linkgp'] 
      if not linkgp then 
      if not lang then 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
     else 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
      end 
      end 
    if not lang then 
    texth = "اضغط هنا للحصول على الرابط 🚸" 
        elseif lang then 
    texth = "اضغط هنا للحصول على الرابط 🚸" 
    end 
local function inline_link_cb(TM, BD) 
      if BD.results_ and BD.results_[0] then 
tdcli.sendInlineQueryResultMessage(msg.to.id, 0, 0, 1, BD.inline_query_id_, BD.results_[0].id_, dl_cb, nil) 
    else 
     if not lang then 
       text =   "📮 | • رابــط المجــموعـة • ⚙\n•┈•💠•۪۫•৩﴾ • ?? • ﴿৩•۪۫•💠•┈•\n\n"..linkgp 
     else 
      text =   "📮 | • رابــط المجــموعـة • ⚙\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n\n"..linkgp 
         end 
  return tdcli.sendMessage(msg.to.id, msg.id, 0, text, 0, "md") 
   end 
end 
tdcli.getInlineQueryResults(107705060, msg.to.id, 0, 0, "["..texth.." "..msg.to.title.."]("..linkgp..")", 0, inline_link_cb, nil) 
end 
    if (matches[1]:lower() == 'الرابط' or matches[1] == 'الرابط') and (matches[2] == 'pv' or matches[2] == 'خاص') then 
   if is_mod(msg) then 
      local linkgp = data[tostring(chat)]['settings']['linkgp'] 
      if not linkgp then 
      if not lang then 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
     else 
        return "📮 | • لـم يتــم وضــع الرابــط ارســل *•[ ضـع رابـط ]•*" 
      end 
      end 
     if not lang then 
    tdcli.sendMessage(chat, msg.id, 1, "<b>link Was Send In Your Private Message</b>", 1, 'html') 
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html') 
     else 
    tdcli.sendMessage(chat, msg.id, 1, "<b>تم ارسال الرابط في الخاص</b>", 1, 'html') 
      tdcli.sendMessage(user, "", 1, "<b>رابط المجموعة "..msg.to.title.." :</b>\n"..linkgp, 1, 'html') 
         end 
     end 
    end 
  if (matches[1]:lower() == "ضع قوانين" or matches[1] == 'ضع قوانين') and matches[2] and is_mod(msg) then 
    data[tostring(chat)]['rules'] = matches[2] 
     save_data(_config.moderation.data, data) 
     if not lang then 
    return "📮 | • تــم حفـــظ الـــقوانيــن • 🗯" 
   else 
  return "📮 | • تــم حفـــظ الـــقوانيــن • 🗯" 
   end 
  end 
  if matches[1]:lower() == "القوانين" or matches[1] == 'القوانين' then 
 if not data[tostring(chat)]['rules'] then 
   if not lang then 
     rules = "       ⚜• قوانين المجموعه •⚜\n\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n\n📮 | • عدم عمل توجيهات داخل المجموعه •\n📮 | • عدم نشر الكلايش الاباحيه •\n📮 | • عدم تكرار في المجموعه •\n📮 | • عدم التكلم في السياسه •\n📮 | • عدم نشر الروابط •\n📮 | • احترم تحترم •\n\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n" 
    elseif lang then 
       rules = "       ⚜• قوانين المجموعه •⚜\n\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n\n📮 | • عدم عمل توجيهات داخل المجموعه •\n📮 | • عدم نشر الكلايش الاباحيه •\n📮 | • عدم تكرار في المجموعه •\n📮 | • عدم التكلم في السياسه •\n📮 | • عدم نشر الروابط •\n📮 | • احترم تحترم •\n\n•┈•💠•۪۫•৩﴾ • 💢 • ﴿৩•۪۫•💠•┈•\n" 
 end 
        else 
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules'] 
      end 
    return rules 
  end 
if ((matches[1] == "معلومات" and not Clang) or (matches[1] == "معلومات" and Clang)) and matches[2] and is_mod(msg) then 
    tdcli_function ({ 
      ID = "SearchPublicChat", 
      username_ = matches[2] 
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="معلومات"}) 
  end 
if ((matches[1] == "معلوماته" and not Clang) or (matches[1] == "معلوماته" and Clang)) and matches[2] and is_mod(msg) then 
tdcli_function ({ 
    ID = "GetUser", 
    user_id_ = matches[2], 
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"}) 
  end 
  

      if ((matches[1]:lower() == 'عدد الاحرف' and not Clang) or (matches[1] == "عدد الاحرف" and Clang)) then 
         if not is_mod(msg) then 
            return 
         end 
         local chars_max = matches[2] 
         data[tostring(msg.to.id)]['settings']['set_char'] = chars_max 
         save_data(_config.moderation.data, data) 
    if not lang then 
     return "`تم ضع عدد رسائل الحروف هو :` *[ "..matches[2].." ]* `حرف`" 
   else 
     return "`تم ضع عدد رسائل الحروف هو :` *[ "..matches[2].." ]* `حرف`" 
      end 
  end 
  if ((matches[1]:lower() == 'ضع تكرار' and not Clang) or (matches[1] == "ضع تكرار" and Clang)) and is_mod(msg) then 
         if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 50 then 
            return "📮 | •  يـــمكنك وضـــع عــدد التــكرار مــن *•[1 الى 50]•* فقــط • " 
      end 
         local flood_max = matches[2] 
         data[tostring(chat)]['settings']['num_msg_max'] = flood_max 
         save_data(_config.moderation.data, data) 
         if not lang then 
    return '📮 | • تم وضع عدد تكرار رسائل •\n📮 | • التكرار ل *[ '..tonumber(matches[2]).. ' ]* رساله •' 
    else 
    return '📮 | • تم وضع عدد تكرار رسائل •\n📮 | • التكرار ل *[ '..tonumber(matches[2]).. ' ]* رساله •' 
    end 
       end 
  if ((matches[1]:lower() == 'ضع وقت التكرار' and not Clang) or (matches[1] == "ضع وقت تكرار" and Clang)) and is_mod(msg) then 
         if tonumber(matches[2]) < 2 or tonumber(matches[2]) > 10 then 
            return " \n📮 | •  يـــمكنك وضـــع عــدد التــكرار مــن `{  1 / 50  }` فقَُـــط " 
      end 
         local time_max = matches[2] 
         data[tostring(chat)]['settings']['time_check'] = time_max 
         save_data(_config.moderation.data, data) 
         if not lang then 
    return "`تم ضع زمن تكرار الرسائل هو  :` *[ "..matches[2].." ]* `ثواني`" 
    else 
    return "`تم ضع زمن تكرار الرسائل هو  :` *[ "..matches[2].." ]* `ثواني`" 
    end 
       end 
            if ((matches[1]:lower() == 'تنظيف' and not Clang) or (matches[1] == "تنظيف" and Clang)) and is_owner(msg) then 
         if ((matches[2] == 'المحذوف' and not Clang) or (matches[2] == "المحذوف" and Clang)) and msg.to.type == "channel" then 
  function check_deleted(TM, BD) 
    for k, v in pairs(BD.members_) do 
local function clean_cb(TM, BD)
if not BD.first_name_ then
kick_user(BD.id_, msg.to.id) 
end
end
tdcli.getUser(v.user_id_, clean_cb, nil)
 end 
    tdcli.sendMessage(msg.to.id, msg.id, 1, "📮 | • تــــــم طرد الحـــسابـات المحذوفه •", 1, 'md') 
  end 
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.to.id).ID,offset_ = 0,limit_ = 1000000}, check_deleted, nil)
  end 
  end
  --------------------------------------------------------------------------------------------------------------------------------------------
      if ((matches[1]:lower() == 'مسح' and not Clang) or (matches[1] == "مسح" and Clang)) and is_owner(msg) then 
         if ((matches[2] == 'الادمنيه' and not Clang) or (matches[2] == "الادمنيه" and Clang)) then 
            if next(data[tostring(chat)]['mods']) == nil then 
            if not lang then 
               return "📮 | • لا يـــوجــد ادمنيـــه لــيتم تــنزيلهـم •" 
             else 
                return "📮 | • لا يـــوجــد ادمنيـــه لــيتم تــنزيلهـم •" 
            end 
            end 
            for k,v in pairs(data[tostring(chat)]['mods']) do 
               data[tostring(chat)]['mods'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
            if not lang then 
            return "📮 | • تـــم تنزيـــل جميـــع الادمنيـــه • " 
          else 
            return "📮 | • تـــم تنزيـــل جميـــع الادمنيـــه • " 
         end 
         end 
         if matches[2] == 'البوتات' or matches[2] == 'البوتات' then
  function delbots(arg, data) 
local deleted = 0 
for k, v in pairs(data.members_) do 
if v.user_id_ ~= our_id then 

kick_user(v.user_id_, msg.to.id) 
deleted = deleted + 1 
end 
end 
if deleted == 0 then 
tdcli.sendMessage(msg.to.id, msg.id, 1, '', 1, 'md') 
else 
tdcli.sendMessage(msg.to.id, msg.id, 1, '', 1, 'html') 
end 
end 
tdcli.getChannelMembers(msg.to.id, 0, 'Bots', 200, delbots, nil) 
  end
    if matches[2] == 'المطرودين' or matches[2] == 'المطرودين' then
    local function cleanbl(ext, res)
      if tonumber(res.total_count_) == 0 then
	  if not lang then
        return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '📮 | • قائمـة المحظـوريـن تــم تنضيفهــا •', 1, 'md')
		else
		return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '📮 | • قائمـة المحظـوريـن تــم تنضيفهــا •', 1, 'md')
		end
      end
      local x = 0
      for x,y in pairs(res.members_) do
        x = x + 1
        tdcli.changeChatMemberStatus(ext.chat_id, y.user_id_, 'Left', dl_cb, nil)
      end
	  if not lang then
      return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '📮 | • تـم ازالـة الحظـر عـن المطروديـن •', 1, 'md')
	  else
	  return tdcli.sendMessage(ext.chat_id, ext.msg_id, 0, '📮 | • تـم ازالـة الحظـر عـن المطروديـن •', 1, 'md')
	  end
    end
	
    return tdcli.getChannelMembers(msg.to.id, 0, 'Kicked', 200, cleanbl, {chat_id = msg.to.id, msg_id = msg.id})
  end
         if ((matches[2] == 'قائمه المنع' and not Clang) or (matches[2] == "قائمه المنع" and Clang)) then 
            if next(data[tostring(chat)]['filterlist']) == nil then 
     if not lang then 
               return "📮 | • لا يـــوجــد كلـمات ممنـوعـه •" 
         else 
               return "📮 | • لا يـــوجــد كلـمات ممنـوعـه •" 
             end 
            end 
            for k,v in pairs(data[tostring(chat)]['filterlist']) do 
               data[tostring(chat)]['filterlist'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
       if not lang then 
            return "📮 | • تـم مـسح قائمـه المنـع •" 
           else 
            return "📮 | • تـم مـسح قائمـه المنـع •" 
           end 
         end 
         if ((matches[2] == 'القوانين' and not Clang) or (matches[2] == "القوانين" and Clang)) then 
            if not data[tostring(chat)]['rules'] then 
            if not lang then 
               return "📮 | • لا يـــوجــد قوانـيــن لــيتم مسحهـا •" 
             else 
               return "📮 | • لا يـــوجــد قوانـيــن لــيتم مسحهـا •" 
             end 
            end 
               data[tostring(chat)]['rules'] = nil 
               save_data(_config.moderation.data, data) 
             if not lang then 
            return "📮 | • تـم مـسح القوانـيــن •" 
          else 
            return "📮 | • تـم مـسح القوانـيــن •" 
         end 
       end 
         if ((matches[2] == 'الترحيب' and not Clang) or (matches[2] == "ترحيب" and Clang)) then 
            if not data[tostring(chat)]['setwelcome'] then 
            if not lang then 
               return "📮 | • لا يـــوجــد ترحـيــب لــيتم مسحــه •" 
             else 
               return "📮 | • لا يـــوجــد ترحـيــب لــيتم مسحــه •" 
             end 
            end 
               data[tostring(chat)]['setwelcome'] = nil 
               save_data(_config.moderation.data, data) 
             if not lang then 
            return "📮 | • تـم مـسح الترحـيــب •" 
          else 
            return "📮 | • تـم مـسح الترحـيــب •" 
         end 
       end 
         if ((matches[2] == 'الوصف' and not Clang) or (matches[2] == "الوصف" and Clang)) then 
        if msg.to.type == "chat" then 
            if not data[tostring(chat)]['about'] then 
            if not lang then 
               return "📮 | • لا يـــوجــد وصــف لــيتم مسحـه •" 
            else 
              return "📮 | • لا يـــوجــد وصــف لــيتم مسحـه •" 
          end 
            end 
               data[tostring(chat)]['about'] = nil 
               save_data(_config.moderation.data, data) 
        elseif msg.to.type == "channel" then 
   tdcli.changeChannelAbout(chat, "", dl_cb, nil) 
             end 
             if not lang then 
            return "📮 | • تـم مـسح الوصـف •" 
           else 
              return "📮 | • تـم مـسح الوصـف •" 
             end 
            end 
        end
      if ((matches[1]:lower() == 'مسح' and not Clang) or (matches[1] == "مسح" and Clang)) and is_admin(msg) then 
         if ((matches[2] == 'المدراء' and not Clang) or (matches[2] == "المدراء" and Clang)) then 
            if next(data[tostring(chat)]['owners']) == nil then 
             if not lang then 
               return "📮 | • لا يـــوجــد مــدراء لــيتم تــنزيلهـم •" 
            else 
                return "📮 | • لا يـــوجــد مــدراء لــيتم تــنزيلهـم •" 
            end 
            end 
            for k,v in pairs(data[tostring(chat)]['owners']) do 
               data[tostring(chat)]['owners'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
            if not lang then 
            return "📮 | • تـم تنزيــل جميــع الــمدراء •" 
           else 
            return "📮 | • تـم تنزيــل جميــع الــمدراء •" 
          end 
         end 
     end 
if ((matches[1] == "ضع اسم" and not Clang) or (matches[1] == "ضع اسم" and Clang)) and matches[2] and is_mod(msg) then 
local gp_name = matches[2] 
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil) 
end 
  if ((matches[1] == "ضع وصف" and not Clang) or (matches[1] == "ضع وصف" and Clang)) and matches[2] and is_mod(msg) then 
     if msg.to.type == "channel" then 
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil) 
    elseif msg.to.type == "chat" then 
    data[tostring(chat)]['about'] = matches[2] 
     save_data(_config.moderation.data, data) 
     end 
     if not lang then 
    return "📮 | • تـــم وضــع وصــف فـي المــجمـوعـــه •" 
    else 
     return "📮 | • تـــم وضــع وصــف فـي المــجمـوعـــه •" 
      end 
  end 
  if ((matches[1] == "الوصف" and not Clang) or (matches[1] == "الوصف" and Clang)) and msg.to.type == "chat" then 
 if not data[tostring(chat)]['about'] then 
     if not lang then 
     about = "📮 | • لا يـــوجــد وصــف فـي المــجمـوعـــه •" 
      elseif lang then 
      about = "📮 | • لا يـــوجــد وصــف فـي المــجمـوعـــه •" 
       end 
        else 
     about = "*Group Description :*\n"..data[tostring(chat)]['about'] 
      end 
    return about 
  end 
if ((matches[1] == 'منع' and not Clang) or (matches[1] == "منع" and Clang)) and is_mod(msg) then 
    return filter_word(msg, matches[2]) 
  end 
  if ((matches[1] == 'الغاء منع' and not Clang) or (matches[1] == "الغاء منع" and Clang)) and is_mod(msg) then 
    return unfilter_word(msg, matches[2]) 
  end 
  if ((matches[1] == 'قائمه المنع' and not Clang) or (matches[1] == "قائمه المنع" and Clang)) and is_mod(msg) then 
    return filter_list(msg) 
  end 
if ((matches[1] == "الاعدادات" and not Clang) or (matches[1] == "الاعدادات" and Clang)) then 
return group_settings(msg, target) 
end 
if ((matches[1] == "اعدادات قفل" and not Clang) or (matches[1] == "اعدادات قفل" and Clang)) then 
return mutes(msg, target) 
end 
if ((matches[1] == "الادمنيه" and not Clang) or (matches[1] == "الادمنيه" and Clang)) then 
return modlist(msg) 
end 
if ((matches[1] == "المدراء" and not Clang) or (matches[1] == "المدراء" and Clang)) and is_owner(msg) then 
return ownerlist(msg) 
end 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (matches[1]:lower() == "ضع لغه" and not Clang) and is_owner(msg) then 
local hash = "gp_lang:" 
if matches[2] == "عربي" then 
redis:set(hash, true) 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر لغــة الــمجموعــه' 
  elseif matches[2] == "انكلش" then 
 redis:del(hash) 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر لغــة الــمجموعــه' 
end 
end 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (matches[1] == 'ضع لغه' and Clang) and is_owner(msg) then 
local hash = "gp_lang:" 
if matches[2] == "عربي" then 
redis:set(hash, true) 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر لغــة الــمجموعــه' 
  elseif matches[2] == "عربي" then 
 redis:del(hash) 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر لغــة الــمجموعــه' 
end 
end 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (matches[1]:lower() == "الاوامر" and not Clang) and is_owner(msg) then 
local hash = "cmd_lang:" 
if matches[2] == "عربي" then 
redis:set(hash, true) 
   if lang then 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر الى اوامر عربي ' 
else 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر الى اوامر عربي ' 
end 
end 
end 
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if (matches[1]:lower() == "عربي" and Clang) and is_owner(msg) then 
local hash = "cmd_lang:" 
redis:del(hash) 
   if lang then 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n📮 | • تــم تــغييــر الى اوامر انكلش ' 
else 
return ' \n📮 | • الــمجمــوعــه\n📮 | • { '..msg.to.title..'}\n?? | • تــم تــغييــر الى اوامر انكلش ' 
end 
end 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
   if is_sudo(msg) then 
    local name = matches[3] 
  local value = matches[4] 
  if matches[2] == 'الردود' and msg.from.id == tonumber(SUDO) then 
    local output = delallchats(msg) 
    return output 
  end 
  if matches[2] == 'اضف للكل' and msg.from.id == tonumber(SUDO) then 
  local text = save_value(msg, name, value) 
   tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md') 
    elseif matches[2] == 'حذف للكل' and msg.from.id == tonumber(SUDO) then 
    local text = del_value(msg,name) 
   tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md') 
    end 
 end 
  if matches[1] == 'الردود' and msg.from.id == tonumber(SUDO) then 
    local output = list_chats(msg) 
    return output 
  else 
local text = get_value(msg, matches[1]) 
   tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md') 
  end

  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  local key = 'chat:gp'..msg.to.id
  if matches[1] == 'رد اضف للمجموعه' and is_mod(msg) then
    redis:hset(key,matches[2],matches[3])
    return "📮 | • الــكلمــه {`"..matches[2].."`}\n📮 | • الــرد {`"..matches[3].."`}\n📮 | • تــم اضافتــها الــى قائمــه الردود"
  end
  
  if matches[1] == 'رد حذف للمجموعه' and is_mod(msg) then
    redis:hdel(key,matches[2])
    return "📮 | • الــكلمــه {`"..matches[2].."`}\n📮 | • تــم ازالتها من قائمــه الردود"
  end
  
  if redis:hget(key,matches[1]) then
    return redis:hget(key,matches[1])
  end
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
local chat_id = tostring(msg.chat_id_)
local reply_id = msg.reply_to_message_id_
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
if not redis:sismember("su",msg.chat_id_) then
redis:sadd("su",msg.chat_id_)
end
elseif id:match('-(%d+)') then
if not redis:sismember("gp",msg.chat_id_) then
redis:sadd("gp",msg.chat_id_)
end
elseif id:match('') then
if not redis:sismember("user",msg.chat_id_) then
redis:sadd("user",msg.chat_id_)
end
end
end
if (matches[1]:lower() == "توجيه" or matches[1] == "توجيه") and msg.reply_to_message_id_ ~= 0 and msg.from.id == tonumber(SUDO) then
if (matches[2] == "للمجموعات" or matches[2] == "للمجموعات") then
local gp = redis:smembers('su')
local gps = redis:scard('su')
for i=1, #gp do
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '📮 | • تم التوجيه الى [*'..gps..'*] مجموعات • 🗯', 1, 'md')
end
if (matches[2] == "للخاص" or matches[2] == "للخاص") then
local gp = redis:smembers('user')
local gps = redis:scard('user')
for i=1, #gp do
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '📮 | • تم التوجيه الى [*'..gps..' *] مشتركين 🔊', 1, 'md')
end
if (matches[2] == "للكل" or matches[2] == "للكل") then
local gp = redis:smembers('user')
local gps = redis:scard('user')
for i=1, #gp do
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
local gp = redis:smembers('su')
local gps = redis:scard('su')
for i=1, #gp do
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
local gp = redis:smembers('gp')
local gps = redis:scard('gp')
for i=1, #gp do
tdcli.forwardMessages(gp[i], chat_id,{[0] = reply_id}, 0)
end
tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '📮 | • تم توجيه الى المجموعات والمشتركين 📡', 1, 'md')
end
end
local lock_reply = data[tostring(msg.to.id)]["settings"]["lock_reply"] 
if lock_reply == "yas" then
if matches[1] == "شلونك" or matches[1]== "شلونج" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  اۢنٰـۛتهہ شعليك بيهة',
'  مــﮫـمـ❥ـوﯢمـ۾☹ ',
'تٌمآم حٍـيَآتٌيَ ۆآنْتٌ 😊 ',
'ۆآلُلُہ مۆ ڒٍيَنْ😢 ',
'   بْخـيَر ۆصٍحٍـہةّ ۆعآفَيَہ😌',
'  آلُلُةّ ڒٍيَنْ لُۆ مگبْلُ😢😌 ',
'  مۆ گنْآلُہةّ لُحٍـمدِ لُلُہةّ ',
'  آةّۆۆۆۆ شُگدِ تٌلُحٍ آنْتٌ😕 ',
'  بْلُ عبْآس آبْۆ آلُفَآضٍلُ آنْيَ لُحٍـمدِلُلُہةّ 😐😤 ',
'تمام وانت/ي شلونك/ج🎈',
'تمام وانت/ي شلونك/ج🎈'
}
            return answers[math.random(#answers)] 
      end 
      end 
     if matches[1] == "بوت" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  آنْجٍبْ لُگ آلُبْآرحٍـةّ تٌغَلُطً علُيَةّ 😭😒 ',
'  ۆعمةّ آنْشُآلُلُہةّ شُبْيَگ يَلُآ گۆلُ 😒😠 ',
'   بْعدِ رۆحٍـيَ آمرنْيَ آنْتٌ 😍😘',
' نْجٍبْ لُگ عنْدِيَ آسم ۆصٍيَحٍـنْيَ بْيَة 😟😤ّ',
'  غَيَر يَگعدِ رآحٍـةّ آلُڒٍآحٍـفَ 😝😂 ',
'  ۆلُگ شُبْيَگ خـبْصٍتٌنْيَ بْس صٍيَحٍ مۆ دِآ آنْسقَ ۆيَةّ بْنْتٌ 😒😤 ',
' تٌرآ مشُتٌغَلُ مآ ۆآگفَ 😉',
'  آيَ آيَ آجٍتٌيَ آلُمصٍآلُحٍ يَلُآ آحٍـجٍيَ شُعنْدِگ😣😓 ',
'   غَيَر يَبْطًلُ ۆبْعدِ مآ يَلُحٍ ۆيَخـلُيَنْيَ آرتٌآحٍ 😒😰',
'  لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨ ',
'   شبي معاجبك 😒🍃',
' تاج راسي كول حبيبي 😻🙊😚  ',
'  ها حياتي 😻اامرني كلبي 😇🙊 ',
'ها احجي شتريد 😏 صيحلي باسمي بعد لدكول بوت😹😢🚶   ',
'   نجب لك صارت قديمه صيحلي باسمي 😒👬💛',
' حياتي انت كول بعد روحي 😽🙊  ',
' فضها كول شرايد تعبتوني😢😞  ',
'   تفصل يروحتي 😍😻'

}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "هلو" or matches[1]== "هلا" or matches[1]== "هاي" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
' هـُ‘ـُلُٱ بُـ‘ـُيُـ‘ـُكُ شُـ‘ـُوٌنُـ‘ـكُ ??😇  ',
'   هّـلَأّوٌتٌ عٌلَ نِبًيِّ صّـمًوٌنِ حًأّر وٌلَبًلَبًيِّ 😻😹',
'   يِّهّـلَأّ وٌأّلَلَهّ نِوٌرتٌـنِأّ حًمًبًقُلَبًيِّ 😸',
'  کْوٌلَ سِـلَأّمً عٌلَيِّکْمً لَتٌـصّـيِّر مًأّيِّعٌ 😒😩 ',
'   هّـلَأّ حًيِّأّتٌـيِّ مًنِوٌر أّنِتٌ بًسِـ بًدٍوٌنِ ﺰحًفُـ رجّـأّئأّأّ 😂😂',
'لَأّ هّـلَهّ وٌلَأّ مًرحًبًأّ 😒 ',
'  أّهّـوٌوٌوٌ أّجّـهّ أّلَﺰأّحًفُ 😤  ',
'   کْلَ أّلَهّـلَأّ بًيِّکْ وٌبًجهّـأّتٌـکْ خِـصّـمً أّلَحًجّـيِّ ضًـيِّفُ جّـهّـأّتٌـکْ 😉😂',
'   يِّعٌمًيِّ هّـلَأّ بًيِّکْ مًنِيِّنِ مًأّ جّـيِّتٌ 😒😣',
'هلوات عيونـي نورت😌🌷',
'هلُۆآتٌ حٍـيَـ{ლ}ـآتٌيَ┆✨😽💞',
'هـايـات يـروحـي┋🌸😻'
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "سلام عليكم" or matches[1]== "سلام" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  وٌعٌلَيِّکْمً أّلَسِـلَأّمً وٌرحًمًةّ أّلَلَهّ وٌبًرکْأّتٌـهّ 😘😬',
'   وٌعٌلَيِّکْمً سِـلَأّمً شُـوٌنِکْ حًيِّأّتٌـيِّ شُـخِـّـبًأّرکْ 😋😇',
'کْلَ أّلَهّـلَأّ بًيِّکْ حًمًبًيِّ 😕😆 ',
'   أّيِّ عٌوٌدٍ ثًـکْيِّلَ يِّسِـلَمً يِّلَأّ عٌيِّنِيِّ کْمًلَ أّلَسِـلَأّمً مًأّلَتٌـکْ وٌبًلَشُ أّﺰحًفُ 😉😂😂',
'   يِّهّـلَأّ وٌأّلَلَهّ أّشُـلَوٌنِکْمً شُـخِــبًأّرکْمً أّبوٌکْ شُـوٌنِهّ ',
'وعليـكم السلام ورحمـة الله وبركاتهُ😍',
'وعليكم السلام والرحمه🏌🏿‍♀️',
'ﯛ୭ﯠ۶ـہٰٰٰٖٖٖلہٰٰٰٖٖٖيکگہٰٰٰٖٖٖمہٰٰٰٖٖٖہ ٵٴلہٰٰٰٖٖٖسہلہٰٰٰٖٖٖاٴمہٰٰٰٖٖٖہ ┆ 😸➰✌️🏿'
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "منور" or matches[1]== "منورين" or matches[1]== "منوره" then 
      if msg.to.type == 'channel' then 
            local answers = {
'   أّکْيِّدٍ مًنِوٌر بًوٌجّـوٌدٍيِّ أّنِيِّ ☺',
' أّيِّ عٌمًيِّ کْلَهّـأّ وٌأّسِـطِأّتٌ مًوٌ صّـوٌجّـکْمً وٌأّلَلَهّـيِّ 😣😢  ',
' لَأّ مًوٌ مًنِوٌر وٌأّذِأّ تٌـعٌأّنِدٍ أّدٍفُـرکْ 😒😂 ',
'   أّفُـتٌـهّـمًنِأّ عٌمًيِّ مًنِوٌ أّنِتٌـ وٌهّـوٌ 😛😂',
'   هّـأّ لَأّﺰمً خِـيِّلَتٌ عٌلَيِّةّ 😂😂',
' أّيِّ وٌأّلَلَةّ فُـعٌلَأّ مًنِوٌر هّـلَ صّـأّکْ 😂😓'
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "مح" or matches[1]== "محح" or matches[1]== "محح" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
' ﺎخٰٰ̲خྀـٓربٰ ﯛ୭ات̲كھٰربْ ♥',
' ﻋِﻋٰافيٰۛـۢھٰهۃ ؛💜ֆ   ',
'ﺄموﯟعنَ ،😞💓.   ',
'  أّوٌفُـ أّلَلَلَهّ 😍 شُـهّـلَ بًوٌسِـهّ  ',
'  دٍيِّيِّيِّ لَکْ ﺰأّحًفُـ لَضًـلَ تٌـبًوٌسِ 😒😌 ',
'  أّهّـوٌووٌوٌ لَيِّشُـوٌفُـهّ يِّکْوٌلَ هّـوٌ مًهّـنِدٍ وٌيِّبًوٌسِ بًلَ عٌأّلَمً 😩😂  ',
'   دٍنِجّـبً لَکْ ﺰأّحًفُ 😝😂'
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "ضايج" or matches[1]== "ضوجه" or matches[1]== "ضايجه" or matches[1]== "حيل ضوجه" then  
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'   كٰ̲ۛكۛلٰشۢ ،🍿ֆۦ ',
'  ضايج لئن كلبه مكسور 🙀😿 ',
'  حـٍبيبي ءّ🙍‍♂️💜 اركـ🕺🏻ـصلج🌚 ',
'   أّيِّ وٌأّلَلةّ ضًـوٌجّـهّـ وٌنِسِـوٌأّنِ مًأّکْوٌ وٌشُـغُلَ مًأّکْوٌ 😣😢',
'  أّيِّ أّلَيِّوٌمً کْآبًهّ حًيِّلَ 😞 ',
'  حًيِِّـأّتٌـيِّ تٌـعٌ نِلَعٌبً لَعٌبًةّ لَبًوٌسِـأّتٌ بًوٌسِـنِيِّ وٌأّبًوٌسِـکْ 😂😢 ',
'  هّـهّـهّـهّـهّـهّـهّ دٍنِجّـبً وٌيِّنِ أّکْوٌ ضًـوٌجّـهّ 😝😂 ',
' أّلَلَلَلَلَهّـمً لَأّ شُـمًأّتٌـهّ 😂😂'
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "صباحو" or matches[1]== "صباح الخير" then 
     if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  صباحو النور اشرقت وانورت🌝🎈 ',
'صۢبٰاζ النور 😍😘   ',
'  صۢبٰاζـۢوٰﯟ ،☀️ عسل 😋😎 ',
'  صباحو النور يا نور 😻😹 ' 
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "زاحف" or matches[1]== "زواحف" then 
         if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  اهوو هم زحف 😢😂 ',
'  على خالتك¤_¤ 😒 ',
' شكو تزحف ولك 😝 خلوني بس اني ازحف 🙊😹  ',
'  أّسِـمًيِّ 😌',
'  أّنِتٌ شُـعٌلَيِّکْ بًأّسِـمًيِّ 😕  '

}
            return answers[math.random(#answers)] 
         end 
     end 
     if matches[1] == "احبك" or matches[1]== "احبج" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  اشتم ريحـة🙄 زحف يمعودين😺🎈 ',
'  مي تو واني اموت بيك/ج♥️🌝 ',
'  بعد روحي واني احبكم هم بس لتزحفلي رجاا 😸😸💋 ',
'  ولك ما تبطل زحفك 😡😹 صارت قديمه ترا 😂🙊 ',
'   أّوٌفُ أّلَلَهّـهّـهّـ أّنِيِّ أّمًوٌتٌـنِ بًيِّکْ وٌلَعٌبًأّسِ 😢😍'

}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "هه" or matches[1]== "ههه" or matches[1]== "هههه" or matches[1]== "ههههه" or matches[1]== "هههههه" or matches[1]== "ههههههه" or matches[1]== "ههههههههه" or matches[1]== "هههههههههههه" or matches[1]== "هههههههههههههههههه" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'  دووم 🙄 ',
'دووم الضحُــكه  يرويحتي💋🍃   ',
' انت شبيك تخبلت 😒😨😹😹  ',
' دووم الضحكـه 😽  ',
'   كافي تضخك 😒 انت مو زغير 😎😻😹',
'انت شبيك تخبلت 😒😨😹😹   ',
'  وٌأّلَلَهّ مًأّکْوٌ فُـأّيِّدٍهّ وٌيِّأّکْ '
}
            return answers[math.random(#answers)] 
      end 
     end 
     if matches[1] == "انجب" or matches[1]== "انجبي" then 
      if msg.to.type == 'channel' or 'chat' then 
            local answers = {
'دٍنِجّـبً أّنِتٌ لَأّ أّتٌـنِحًکْ تٌـرأّ 😒😂 ',
'  أّنِجّـبً عٌلَيِّکْ أّکْيِّدٍ  😋😂',
'   أّلَنِسِـأّء أّوٌلَأّ حًيِّأّتٌـتٌـيِّ 😉😂',
'   جّـبًأّبًهّ لَجّـبًکْ أّيِّ وٌأّلَلَةّ 😛😢',
'  مًأّشُـيِّ رأّحً أّنِجّـبً بًسِ مًوٌ لَخِـأّطِرکْ وٌأّلَلَةّ 😓😢 ',
'  غُيِّر يِّکْعٌدٍ رأّحًهّ ﺰأّحًفُـ 😅😂ِ ',
'وٌلَيِّ عٌنِيِّ تٌـرأّ مًتٌـعٌأّرکْ وٌيِّهّـ أّلَحًبً وٌرحًيِّ طِأّفُـرهّـ 😢😢😣 '
}
            return answers[math.random(#answers)] 
      end 
     end 
    if msg.text =="🌚" then
return  "• فـﮧديت صخـﮧامك🙊👄" 
end
if msg.text == "🌚🌚" then
return  "• فـﮧديت صخـﮧامك🙊👄" 
end
if msg.text == "🌚🌚🌚" then 
return  "• فـﮧديت صخـﮧامك🙊👄" 
end
if msg.text == "🌚🌚🌚🌚" then
return  "• فـﮧديت صخـﮧامك🙊👄" 
end
if msg.text =="🚶🏻" then 
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ ??💙 ۶ الماشي✨🚶🏻" 
end
if msg.text =="🚶🏻🚶🏻" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶ الماشي✨🚶🏻" 
end
if msg.text =="🚶🏻🚶🏻🚶🏻🚶🏻" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶ الماشي✨🚶🏻" 
end
if msg.text =="🚶🏻🚶🏻🚶🏻" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶ الماشي✨🚶🏻" 
end
if msg.text =="🙈" then
return  "» ﺷــ๋͜ـﮭڸ خــ๋͜ـجل ﮪ 💗😻̯͡" 
end
if msg.text =="🙈🙈" then
return  "» ﺷــ๋͜ـﮭڸ خــ๋͜ـجل ﮪ 💗😻̯͡" 
end
if msg.text =="🙈🙈🙈" then
return  "» ﺷــ๋͜ـﮭڸ خــ๋͜ـجل ﮪ 💗😻̯͡" 
end
if msg.text =="🙈🙈🙈🙈" then
return  "» ﺷــ๋͜ـﮭڸ خــ๋͜ـجل ﮪ 💗😻̯͡" 
end
if msg.text =="🙊🙊🙊🙊" then
return  "فديت الخجل يبن القرده 😹😹😢" 
end
if msg.text =="🙊🙊🙊" then
return  "فديت الخجل يبن القرده 😹😹😢"  
end
if msg.text =="🙊🙊" then
return  "فديت الخجل يبن القرده 😹😹😢" 
end
if msg.text =="🙊" then
return  "فديت الخجل يبن القرده 😹😹😢" 
end
if msg.text =="😍😍😍😍" then
return  "صعد الحب🙄 الله يستر😹💔 من الزحف 😂😹" 
end
if msg.text =="😍😍😍" then
return  "صعد الحب🙄 الله يستر😹💔 من الزحف 😂😹" 
end
if msg.text =="😍😍" then
return  "صعد الحب🙄 الله يستر😹💔 من الزحف 😂😹" 
end
if msg.text =="😍" then
return  "صعد الحب🙄 الله يستر😹💔 من الزحف 😂😹" 
end
if msg.text =="😂😂😂😂" then
return  "دوم الضحـكه😽🎈 " 
end
if msg.text =="😂😂😂" then
return  "دوم الضحـكه😽🎈 " 
end
if msg.text =="😂😂" then
return  "دوم الضحـكه😽🎈 " 
end
if msg.text =="😂" then
return  "دوم الضحـكه😽🎈 " 
end
if msg.text =="😉😉😉😉" then
return  "باع الغمزه 🙀 تموت 🙈🍃" 
end
if msg.text =="😉😉😉" then
return  "باع الغمزه 🙀 تموت 🙈🍃" 
end
if msg.text =="😉😉" then
return  "باع الغمزه 🙀 تموت 🙈🍃" 
end
if msg.text =="😉" then
return  "باع الغمزه 🙀 تموت 🙈🍃" 
end
if msg.text =="😳😳😳😳" then
return  "شبيك 🙀 مصدوم شنو 🙄 جديده عليك حتى تنصدم ♥️🍃" 
end
if msg.text =="😳😳😳" then
return  "شبيك 🙀 مصدوم شنو 🙄 جديده عليك حتى تنصدم ♥️🍃" 
end
if msg.text =="😳😳" then
return  "شبيك 🙀 مصدوم شنو 🙄 جديده عليك حتى تنصدم ♥️??" 
end
if msg.text =="??" then
return  "شبيك 🙀 مصدوم شنو 🙄 جديده عليك حتى تنصدم ♥️🍃" 
end
if msg.text =="😠😠😠😠" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😠😠😠" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😠😠" then
return  "حمه الصيني طفوه 😍😹??" 
end
if msg.text =="😠" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😡😡😡😡" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😡😡😡" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😡😡" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😡" then
return  "حمه الصيني طفوه 😍😹😹" 
end
if msg.text =="😭😭😭😭" then
return  "لا تبجي يروحي محد يسوه تبجيله ☺😘"
end 
if msg.text =="😭😭😭" then
return  "لا تبجي يروحي محد يسوه تبجيله ☺😘" 
end
if msg.text =="😭😭" then
return  "لا تبجي يروحي محد يسوه تبجيله ☺??" 
end
if msg.text =="😭" then
return  "لا تبجي يروحي محد يسوه تبجيله ☺😘" 
end
if msg.text =="😌😌😌😌" then
return  "فديت 🙊😻 الرقه مالتك 😉😇🙊" 
end
if msg.text =="😌😌😌" then
return  "فديت 🙊😻 الرقه مالتك 😉😇🙊" 
end
if msg.text =="😌😌" then
return  "فديت 🙊😻 الرقه مالتك 😉😇🙊" 
end
if msg.text =="😌" then
return  "فديت 🙊😻 الرقه مالتك 😉😇🙊" 
end
if msg.text =="💃💃💃??" then
return  "شددها ابو سميره 😂 خوش تهز 😹😹" 
end
if msg.text =="💃💃??" then
return  "شددها ابو سميره 😂 خوش تهز 😹😹" 
end
if msg.text =="💃??" then
return  "شددها ابو سميره 😂 خوش تهز 😹😹" 
end
if msg.text =="💃" then
return  "شددها ابو سميره 😂 خوش تهز 😹😹" 
end
if msg.text =="👀" then
return  "هاي وين دا تباوع ولك😹😹🙊" 
end
if msg.text =="👀👀" then
return  "هاي وين دا تباوع ولك😹😹🙊" 
end
if msg.text =="😱😱😱😱" then
return  "عزا العزاك هاي شفت ولك 😂😂😍" 
end
if msg.text =="😱😱😱" then
return  "عزا العزاك هاي شفت ولك 😂😂😍" 
end
if msg.text =="😱😱" then
return  "عزا العزاك هاي شفت ولك 😂😂😍" 
end
if msg.text =="😱" then
return  "عزا العزاك هاي شفت ولك 😂😂😍" 
end
if msg.text =="😊😊😊😊" then
return  "فديت الخجل كله 😎😍" 
end
if msg.text =="😊😊😊" then
return  "فديت الخجل كله 😎😍" 
end
if msg.text =="😊😊" then
return  "فديت الخجل كله 😎😍" 
end
if msg.text =="😊" then
return  "فديت الخجل كله 😎😍" 
end
if msg.text =="😘😘😘😘" then
return  "• ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘" 
end
if msg.text =="😘😘😘" then
return  "• ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘" 
end
if msg.text =="😘??" then
return  "• ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘" 
end
if msg.text =="😘" then
return  "• ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽??̯⁾ֆ‘" 
end
if msg.text =="☺☺☺☺" then
return  "ابتسامه مال واحد شايل اهموم الدنيا كوله بگلبه 💔😿"
end
if msg.text =="☺☺☺" then
return  "ابتسامه مال واحد شايل اهموم الدنيا كوله بگلبه 💔😿"
end
if msg.text =="☺☺" then
return  "ابتسامه مال واحد شايل اهموم الدنيا كوله بگلبه 💔??"
end
if msg.text =="☺" then
return  "ابتسامه مال واحد شايل اهموم الدنيا كوله بگلبه 💔😿"
end
if msg.text =="😞😞😞😞" then
return  "منو مضوجك🙀 دليني عليه😾💪🏼" 
end
if msg.text =="😞😞😞" then
return  "منو مضوجك🙀 دليني عليه😾💪🏼" 
end
if msg.text =="😞😞" then
return  "منو مضوجك🙀 دليني عليه😾💪🏼" 
end
if msg.text =="😞" then
return  "منو مضوجك🙀 دليني عليه😾💪🏼" 
end
if msg.text =="😻😻😻😻" then
return  "باع الحب صاعد عده فول 😹😻" 
end
if msg.text =="😻😻😻" then
return  "باع الحب صاعد عده فول 😹😻" 
end
if msg.text =="😻😻" then
return  "باع الحب صاعد عده فول 😹😻" 
end
if msg.text =="😻" then
return  "باع الحب صاعد عده فول 😹😻" 
end
if msg.text =="😇" then
return  "مسويلك مصيبه ودا تبتسم 😻😹😹😹" 
end
if msg.text =="😇😇" then
return  "مسويلك مصيبه ودا تبتسم 😻😹😹😹" 
end
if msg.text =="🚶" then
return  "منور يبعد الكلب 🌺😻😇" 
end
if msg.text =="🚶🚶" then
return  "منور يبعد الكلب 🌺??😇" 
end
if msg.text =="🚶🚶🚶" then
return  "منور يبعد الكلب 🌺😻😇" 
end
if msg.text =="🚶🚶🚶??" then
return  "منور يبعد الكلب 🌺😻😇" 
end
if msg.text =="😢😢😢😢" then
return  "عيـ😻ـونك/ج✨ حرام ينزل😴 دمعهن🙊" 
end
if msg.text =="😢😢😢" then
return  "عيـ😻ـونك/ج✨ حرام ينزل😴 دمعهن🙊" 
end
if msg.text =="😢😢" then
return  "عيـ😻ـونك/ج✨ حرام ينزل😴 دمعهن🙊" 
end
if msg.text =="😢" then
return  "عيـ😻ـونك/ج✨ حرام ينزل?? دمعهن??" 
end
if msg.text =="😹😹😹😹" then
return  "دوم الضحكه يالغالي 😻" 
end
if msg.text =="😹😹😹" then
return  "دوم الضحكه يالغالي ??"
end
if msg.text =="😹😹" then
return  "دوم الضحكه يالغالي 😻"
end
if msg.text =="😹" then
return  "دوم الضحكه يالغالي 😻"
end
if msg.text =="😿😿😿😿" then
return  "منو وياك يرويحتي 😓😻" 
end
if msg.text =="😿😿😿" then
return  "منو وياك يرويحتي 😓😻" 
end
if msg.text =="😿😿" then
return  "منو وياك يرويحتي ??😻" 
end
if msg.text =="😿" then
return  "منو وياك يرويحتي 😓??" 
end
if msg.text =="😏😏😏😏" then
return  "عود شوفوني اني شخصـية 😣وهو وجـهه وجه الطلي ??😹😹" 
end
if msg.text =="😏??😏" then
return  "عود شوفوني اني شخصـية 😣وهو وجـهه وجه الطلي 🙊😹😹" 
end
if msg.text =="😏😏" then
return  "عود شوفوني اني شخصـية 😣وهو وجـهه وجه الطلي 🙊😹😹" 
end
if msg.text =="😏" then
return  "عود شوفوني اني شخصـية 😣وهو وجـهه وجه الطلي 🙊😹😹" 
end
if msg.text =="😒😒😒😒" then
return  "شبي🙃 ‎‏💛🙈  ggɺᓗɺÎ  ضايج💔" 
end
if msg.text =="😒😒😒" then
return  "شبي🙃 ‎‏💛??  ggɺᓗɺÎ  ضايج💔" 
end
if msg.text =="😒😒" then
return  "شبي🙃 ‎‏💛🙈  ggɺᓗɺÎ  ضايج💔" 
end
if msg.text =="😒" then
return  "شبي🙃 ‎‏💛🙈  ggɺᓗɺÎ  ضايج💔" 
end
if msg.text =="😝😝😝😝" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😝😝😝" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😝😝" then
return  "لو جوعان ??لو مريض نفسي😹💔" 
end
if msg.text =="😝" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😕😕😕" then
return  "شكو عاوج حلكك😒😻😹😹" 
end
if msg.text =="😕😕" then
return  "شكو عاوج حلكك😒😻😹😹" 
end
if msg.text =="😕" then
return  "شكو عاوج حلكك😒😻😹😹" 
end
if msg.text =="🚶‍♀️🚶‍♀️🚶‍♀️🚶‍♀️" then
return  "- الجمال البـيـج فـاتح للـغغزل چم بـاب💅🏻💛" 
end
if msg.text =="🚶‍♀️🚶‍♀️🚶‍♀️" then
return  "- الجمال البـيـج فـاتح للـغغزل چم بـاب💅🏻💛" 
end
if msg.text =="🚶‍♀️🚶‍♀️" then
return  "- الجمال البـيـج فـاتح للـغغزل چم بـاب💅🏻💛" 
end
if msg.text =="🚶‍♀️" then
return  "- الجمال البـيـج فـاتح للـغغزل چم بـاب💅🏻💛" 
end
if msg.text =="🚶🏻🚶🏻🚶🏻🚶🏻" then
return  "- الجمال البـيـك فـاتح للـغغزل چم بـاب💛" 
end
if msg.text =="🚶🏻🚶🏻🚶🏻" then
return  "- الجمال البـيـك فـاتح للـغغزل چم بـاب💛" 
end
if msg.text =="🚶🏻🚶🏻" then
return  "- الجمال البـيـك فـاتح للـغغزل چم بـاب💛" 
end
if msg.text =="🚶🏻" then
return  "- الجمال البـيـك فـاتح للـغغزل چم بـاب💛"
end 
if msg.text =="😔😔😔😔" then
return  "ليش زعلان يعمري 😔 تعال احجيلي اهمومك💔🍃"
end 
if msg.text =="😔😔😔" then
return  "ليش زعلان يعمري 😔 تعال احجيلي اهمومك💔🍃" 
end
if msg.text =="😔😔" then
return  "ليش زعلان يعمري 😔 تعال احجيلي اهمومك💔🍃" 
end
if msg.text =="😔" then
return  "ليش زعلان يعمري 😔 تعال احجيلي اهمومك💔🍃" 
end
if msg.text =="😑😑😑😑" then
return  "منو مضوجك☹️ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="😑😑😑" then
return  "منو مضوجك☹️ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="😑😑" then
return  "منو مضوجك☹️ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="😑" then
return  "منو مضوجك☹️ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="😐??😐😐" then
return  "شبيك ضايج يروحي 😓😭" 
end
if msg.text =="😐😐😐" then
return  "شبيك ضايج يروحي 😓😭"
end
if msg.text =="😐😐" then
return  "شبيك ضايج يروحي 😓😭"
end
if msg.text =="😐" then
return  "شبيك ضايج يروحي 😓😭"
end
if msg.text =="😋😋😋😋" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😋😋😋" then
return  "لو جوعان 🤔لو مريض نفسي??💔" 
end
if msg.text =="😋😋" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😋" then
return  "لو جوعان 🤔لو مريض نفسي😹💔" 
end
if msg.text =="😎😎😎😎" then
return  "مسوي عمليه لعيونك 😔 لو انت خبل🙌😿"
end
if msg.text =="😎😎😎" then
return  "مسوي عمليه لعيونك 😔 لو انت خبل🙌😿"
end
if msg.text =="😎😎" then
return  "مسوي عمليه لعيونك 😔 لو انت خبل🙌😿"
end
if msg.text =="😎" then
return  "مسوي عمليه لعيونك 😔 لو انت خبل🙌😿"
end
if msg.text =="😴😴😴😴" then
return  "رأح, دكـّــوم تـّــمس๋͜‏ـلّـ๋͜‏ـت ولي نأم 😹☹️😻  " 
end
if msg.text =="😴??😴" then
return  "رأح, دكـّــوم تـّــمس๋͜‏ـلّـ๋͜‏ـت ولي نأم 😹☹️😻  " 
end
if msg.text =="😴😴" then
return  "رأح, دكـّــوم تـّــمس๋͜‏ـلّـ๋͜‏ـت ولي نأم 😹☹️😻  " 
end
if msg.text =="😴" then
return  "رأح, دكـّــوم تـّــمس๋͜‏ـلّـ๋͜‏ـت ولي نأم 😹☹️😻  " 
end
if msg.text =="😽😽😽😽" then
return  " ﭑإ́وُف فديـٍَــت ﭑإ́لـپـــٰٰـوُﮨﮨﮨــهٰ⇣̉ـ  😻🙈🙊" 
end
if msg.text =="😽😽😽" then
return  " ﭑإ́وُف فديـٍَــت ﭑإ́لـپـــٰٰـوُﮨﮨﮨــهٰ⇣̉ـ  😻🙈🙊" 
end
if msg.text =="😽😽" then
return  " ﭑإ́وُف فديـٍَــت ﭑإ́لـپـــٰٰـوُﮨﮨﮨــهٰ⇣̉ـ  😻🙈🙊" 
end
if msg.text =="😽" then
return  " ﭑإ́وُف فديـٍَــت ﭑإ́لـپـــٰٰـوُﮨﮨﮨــهٰ⇣̉ـ  😻🙈🙊" 
end
if msg.text =="😾😾" then
return  "خاب ديلك😐😹" 
end
if msg.text =="😾" then
return  "خاب ديلك😐😹" 
end
if msg.text =="💔" then
return  "ﭑإ́وُف ﭑإ́لـلــهٰ⇣̉ يـٍَﮩﮨﮨﮨـﭑإ́عـِِِِد قلـپـــٰٰـك 😢😞💋 " 
end
if msg.text =="💔💔" then
return  "ﭑإ́وُف ﭑإ́لـلــهٰ⇣̉ يـٍَﮩﮨﮨﮨـﭑإ́عـِِِِد قلـپـــٰٰـك 😢😞💋 " 
end
if msg.text =="💔💔💔" then
return  "ﭑإ́وُف ﭑإ́لـلــهٰ⇣̉ يـٍَﮩﮨﮨﮨـﭑإ́عـِِِِد قلـپـــٰٰـك 😢😞💋 " 
end
if msg.text =="💔💔💔💔" then
return  "ﭑإ́وُف ﭑإ́لـلــهٰ⇣̉ يـٍَﮩﮨﮨﮨـﭑإ́عـِِِِد قلـپـــٰٰـك 😢😞💋 " 
end
if msg.text =="💛" then
return  "قلبوشتي😻💋" 
end
if msg.text =="💙" then
return  "عافيتي😻💋" 
end
if msg.text =="💜" then
return  "يروحي😻💋انت" 
end
if msg.text =="❤" then
return  "يعمري??💋 انت " 
end
if msg.text =="💚" then
return  "منور ابو كلب الاخضر😐😹" 
end
if msg.text =="💋💋💋💋" then
return  "اوووف شنو هذا الحلك😻" 
end
if msg.text =="💋💋💋" then
return  "اوووف شنو هذا الحلك??" 
end
if msg.text =="💋💋" then
return  "اوووف شنو هذا الحلك😻" 
end
if msg.text =="💋" then
return  "اوووف شنو هذا الحلك😻" 
end
if msg.text =="🙋" then
return  "هلا حبعمري??❤️" 
end
if msg.text =="🙋🙋" then
return  "هلا حبعمري🙂❤️" 
end
if msg.text =="🙋🙋🙋" then
return  "هلا حبعمري🙂❤️" 
end
if msg.text =="🐕" then
return  "ها عمو شبيك🌝💔" 
end
if msg.text =="🐆" then
return  "ولا يكعد راحه ابو صابر🌝😹" 
end
if msg.text =="🐈" then
return  "بشت بشت😐😹" 
end
if msg.text =="🌹🌹" then
return  "هلا حياتي عطرها🙂💋" 
end
if msg.text =="🌹" then
return  "هلا حياتي عطرها🙂💋" 
end
if msg.text =="🌝🌝🌝🌝" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶" 
end
if msg.text =="🌝🌝🌝" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶" 
end
if msg.text =="🌝🌝" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶" 
end
if msg.text =="🌝" then
return  "شـﮫـۛالـٰٰ̲ضـِۛـوٰ୭ٰۛٳٲ 🌝💙 ۶" 
end
if msg.text =="🐍" then
return  "ماكو غيرك زاحف🙊🗯" 
end
if msg.text =="🐍??" then
return  "ماكو غيرك زاحف🙊🗯" 
end
if msg.text =="🐍🐍🐍" then
return  "ماكو غيرك زاحف??🗯" 
end
if msg.text =="🐍🐍🐍🐍" then
return  "ماكو غيرك زاحف🙊🗯" 
end
if msg.text =="🐅" then
return  "منور النجر🌝😹" 
end
if msg.text =="🐅🐅" then
return  "منور النجر????" 
end
if msg.text =="🐅🐅🐅" then
return  " منورالنجر??💋 " 
end
if msg.text =="🌺" then
return  "عطرها حبي🌝💋" 
end
if msg.text =="🍁" then
return  "عطرها حبي🌝💋" 
end
if msg.text =="💐" then
return  "عطرها حبي🌝💋"
end
if msg.text =="🙄🙄🙄🙄" then
return  "شلگيت فوگ وتباوع🤔لو انت احول🙄💔" 
end
if msg.text =="🙄🙄🙄" then
return  "شلگيت فوگ وتباوع🤔لو انت احول🙄💔" 
end
if msg.text =="🙄🙄" then
return  "شلگيت فوگ وتباوع🤔لو انت احول🙄💔" 
end
if msg.text =="🙄" then
return  "شلگيت فوگ وتباوع🤔لو انت احول🙄💔" 
end
if msg.text =="طه" then
return  "ﭑإ́لـــﻤ̉̉ـطوُر ﻤ̉̉ـﭑإ́لـــﺗـ͜͡ہــٍّـــِّي إ́لـــعـُُـﮨ́́ﮨ́ﮨق فديـٍّــتـِّـّٰٰ̐ـ͜͜͡ާـه \n@TAHAJ20" 
end
if msg.text =="خليجي" then
return  "ﭑإ́لـــﻤ̉̉ـطوُر ﻤ̉̉ـﭑإ́لـــﺗـ͜͡ہــٍّـــِّي إ́لـــعـُُـﮨ́́ﮨ́ﮨق فديـٍّــتـِّـّٰٰ̐ـ͜͜͡ާـه \n@TAHAJ20"
end
if msg.text =="خليجي صاك" then
return  "ﭑإ́لـــﻤ̉̉ـطوُر ﻤ̉̉ـﭑإ́لـــﺗـ͜͡ہــٍّـــِّي إ́لـــعـُُـﮨ́́ﮨ́ﮨق فديـٍّــتـِّـّٰٰ̐ـ͜͜͡ާـه \n@TAHAJ20"
end
if msg.text =="@TAHAJ20" then
return  "ﭑإ́لـــﻤ̉̉ـطوُر ﻤ̉̉ـﭑإ́لـــﺗـ͜͡ہــٍّـــِّي إ́لـــعـُُـﮨ́́ﮨ́ﮨق فديـٍّــتـِّـّٰٰ̐ـ͜͜͡ާـه \n@TAHAJ20"
end
if msg.text =="اريد قناة" then
return  "تفضل حياتي @TEAMSTORM" 
end
if msg.text =="قناة" then
return  "تفضل حياتي @TEAMSTORM" 
end
if msg.text =="اريد قناه" then
return  "تفضل حياتي @TEAMSTORM" 
end
if msg.text =="قناه" then
return  "تفضل حياتي @TEAMSTORM" 
end
if msg.text =="نرتبط" then
return  "ولك ما تبطل زحفك 😡😹 صارت قديمه ترا 😂🙊" 
end
if msg.text =="نكبل" then
return  "ولك ما تبطل زحفك 😡😹 صارت قديمه ترا 😂🙊" 
end
if msg.text =="عرفينا" then
return  "ولك ما تبطل زحفك ??😹 صارت قديمه ترا 😂🙊" 
end
if msg.text =="نتعرف" then
return  "ولك ما تبطل زحفك ??😹 صارت قديمه ترا 😂🙊" 
end
if msg.text =="نت منين" then
return  "شكو تزحف ولك 😹😹 خلوني بس اني ازحف 🙊😹😿" 
end
if msg.text =="خلي نتعرف" then
return  "شكو تزحف ولك 😹?? خلوني بس اني ازحف 🙊😹😿" 
end
if msg.text =="شسمك" then
return  "شكو تزحف ولك 😹😹 خلوني بس اني ازحف 🙊😹😿" 
end
if msg.text =="عرفنا" then
return  "شكو تزحف ولك 😹😹 خلوني بس اني ازحف 🙊😹😿" 
end
if msg.text =="هاذا شنو" then
return  "لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨" 
end
if msg.text =="يمكن بوت" then
return  "لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨" 
end
if msg.text =="اي بوت" then
return  "لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨" 
end
if msg.text =="هاذا بوت" then
return  "لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨" 
end
if msg.text =="وين البوت" then
return  "لۧاٲ   مو بوت😒 اقرا🙃 اسمي✨" 
end
if msg.text =="المطور" then
return  "مايريد ينيجكم كوة هيه عوفوه 😾🖕🏻" 
end
if msg.text =="مطور" then
return  "مايريد ينيجكم كوة هيه عوفوه 😾🖕🏻"
end
if msg.text =="تعال نلعب" then
return  "تعالو لعبو بمالي 😸😸" 
end
if msg.text =="تعاي نلعب" then
return  "تعالو لعبو بمالي ??😸" 
end
if msg.text =="نلعب" then
return  "تعالو لعبو بمالي 😸??" 
end
if msg.text =="تلعبون" then
return  "تعالو لعبو بمالي 😸😸" 
end
if msg.text =="🤔🤔🤔🤔" then
return  "ولا يكعد راحه اينشتاين الصغير 😂😂" 
end
if msg.text =="🤔🤔🤔" then
return  "ولا يكعد راحه اينشتاين الصغير 😂😂" 
end
if msg.text =="🤔🤔" then
return  "ولا يكعد راحه اينشتاين الصغير 😂😂" 
end
if msg.text =="🤔" then
return  "ولا يكعد راحه اينشتاين الصغير 😂😂" 
end
if msg.text =="🖕🖕🖕🖕" then
return  "بحي هاذا لوفه وحطه فتيزك 😹😹😻" 
end
if msg.text =="🖕🖕🖕" then
return  "بحي هاذا لوفه وحطه فتيزك 😹😹😻" 
end
if msg.text =="🖕🖕" then
return  "بحي هاذا لوفه وحطه فتيزك 😹😹😻" 
end
if msg.text =="🖕" then
return  "بحي هاذا لوفه وحطه فتيزك 😹😹😻" 
end
if msg.text =="💋💋💋💋" then
return  "فديتك حلكك بحي ☹😹" 
end
if msg.text =="💋💋💋" then
return  "فديتك حلكك بحي ☹??" 
end
if msg.text =="💋💋" then
return  "فديتك حلكك بحي ☹😹" 
end
if msg.text =="💋" then
return  "فديتك حلكك بحي ☹😹" 
end
if msg.text =="تصبح عله خير" then
return  "روح نام ??😉 حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="راح انام" then
return  "روح نام 😍?? حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="نعسان" then
return  "روح نام 😍?? حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="ت ع خ" then
return  "روح نام 😍😉 حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="تصبحون عله خير" then
return  "روح نام 😍😉 حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="تصبحي عله خير" then
return  "روح نام 😍😉 حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="تصبحين عله خير" then
return  "روح نام 😍😉 حياتي 😌 تصبح عله خير 💋" 
end
if msg.text =="صباحووو" then
return  "صباحو النور يا نور 😻😹" 
end
if msg.text =="صباحو" then
return  "صباحو النور يا نور 😻😹" 
end
if msg.text =="صباحوو" then
return  "صباحو النور يا نور 😻😹" 
end
if msg.text =="صباح الخير" then
return  "صباحو النور يا نور 😻😹" 
end
if msg.text =="دوووم" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="دووووم" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="دوم" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="ددوم" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="دومك" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="دومج" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="ادوم" then
return  "لله يديم انفاسك/ج 😇😚" 
end
if msg.text =="شونج" then
return  "تمام وانت/ي شلونك/ج 😻🙊" 
end
if msg.text =="شلونج" then
return  "تمام وانت/ي شلونك/ج 😻🙊" 
end
if msg.text =="شخبارج" then
return  "تمام وانت/ي شلونك/ج 😻🙊" 
end
if msg.text =="شلونجن" then
return  "تمام وانت/ي شلونك/ج 😻🙊" 
end
if msg.text =="ضايجه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ🕺🏻ـصلج🌚" 
end
if msg.text =="ضايجهه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ🕺🏻ـصلج🌚" 
end
if msg.text =="حيل ضايجه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ??🏻ـصلج🌚" 
end
if msg.text =="ضووجهه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ🕺🏻ـصلج🌚" 
end
if msg.text =="ضوججه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ💃🏻ـصلك🌝" 
end
if msg.text =="ضوجهه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ💃🏻ـصلك🌝" 
end
if msg.text =="ضوجه" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ💃🏻ـصلك🌝" 
end
if msg.text =="ضايجين" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ💃🏻ـصلك🌝" 
end
if msg.text =="ضايج" then
return  "حـٍبيبي ءّ🙍‍♂️💜 اركـ💃🏻ـصلك🌝" 
end
if msg.text =="اروح" then
return  "مٰٝـٍْ✋ۡـٍٰآ ترٰوۢۛඋ ،💛  احد لازمك🤦🏻‍♂️" 
end
if msg.text =="اروحح" then
return  "مٰٝـٍْ✋ۡـٍٰآ ترٰوۢۛඋ ،💛  احد لازمك🤦🏻‍♂️" 
end
if msg.text =="راح اروح" then
return  "مٰٝـٍْ✋ۡـٍٰآ ترٰوۢۛඋ ،💛  احد لازمك🤦🏻‍♂️" 
end
if msg.text =="رايح" then
return  "مٰٝـٍْ✋ۡـٍٰآ ترٰوۢۛඋ ،💛  احد لازمك🤦🏻‍♂️" 
end
if msg.text =="اجيييي" then
return  "ﮪﮪﮧעّ ⁞⁞ُ͡‏   💗 بيك🚶🏻 حمبي 👻" 
end
if msg.text =="اجي" then
return  "ﮪﮪﮧעّ ⁞⁞ُ͡‏   💗 بيك🚶🏻 حمبي 👻" 
end
if msg.text =="اجييي" then
return  "ﮪﮪﮧעّ ⁞⁞ُ͡‏   💗 بيك🚶🏻 حمبي 👻" 
end
if msg.text =="ممكنن" then
return  "أإآيٰٰ    تـٴِﮧ﴿🚶🏻﴾ۣـعالۂ͡†♩❥"
end
if msg.text =="ممكن" then
return  "أإآيٰٰ    تـٴِﮧ﴿🚶🏻﴾ۣـعالۂ͡†♩❥"
end
if msg.text =="ببكن" then
return  "أإآيٰٰ    تـٴِﮧ﴿🚶🏻﴾ۣـعالۂ͡†♩❥"
end
if msg.text =="مممكن" then
return  "أإآيٰٰ    تـٴِﮧ﴿🚶🏻﴾ۣـعالۂ͡†♩❥"
end
if msg.text =="ديييي" then
return  "يمشوك🐕 بيها🙊😹 حمبي" 
end
if msg.text =="دييي" then
return  "يمشوك🐕 بيها🙊😹 حمبي" 
end
if msg.text =="ديي" then
return  "يمشوك🐕 بيها??😹 حمبي" 
end
if msg.text =="دي" then
return  "يمشوك🐕 بيها🙊😹 حمبي" 
end
if msg.text =="وليييي" then
return  "۽ﺈنجٰٓجٰٓہ͡‌ـبۂ 🌝 ٰٓ₎ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="ولييي" then
return  "۽ﺈنجٰٓجٰٓہ͡‌ـبۂ 🌝 ٰٓ₎ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="وليي" then
return  "۽ﺈنجٰٓجٰٓہ͡‌ـبۂ 🌝 ٰٓ₎ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="ولي" then
return  "۽ﺈنجٰٓجٰٓہ͡‌ـبۂ 🌝 ٰٓ₎ פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="احبكك" then
return  "بعد روحي واني احبكم هم بس لتزحفلي رجاا ??😸💋" 
end
if msg.text =="ااحبك" then
return  "بعد روحي واني احبكم هم بس لتزحفلي رجاا 😸😸💋" 
end
if msg.text =="احبككك" then
return  "بعد روحي واني احبكم هم بس لتزحفلي رجاا 😸😸💋" 
end
if msg.text =="احبكم" then
return  "بعد روحي واني احبكم هم بس لتزحفلي رجاا 😸😸💋" 
end
if msg.text =="اييييي" then
return  "يب قابل اغشكم 🙈🎈" 
end
if msg.text =="اييي" then
return  "يب قابل اغشكم 🙈🎈" 
end
if msg.text =="ايي" then
return  "يب قابل اغشكم 🙈🎈" 
end
if msg.text =="اي" then
return  "يب قابل اغشكم 🙈🎈" 
end
if msg.text =="تعالو" then
return  " ما اروح المطورين مالتي ميقبلون😐🎈 " 
end
if msg.text =="تعالوو" then
return  "لا ما اروح المطورين مالتي ميقبلون😐??" 
end
if msg.text =="تعالووو" then
return  "لا ما اروح المطورين مالتي ميقبلون??🎈" 
end
if msg.text =="تعالوووو" then
return  "لا ما اروح المطورين مالتي ميقبلون😐🎈" 
end
if msg.text =="شبيك" then
return  "مبينه شي سلامتك/ ج🎈😌" 
end
if msg.text =="شبيكم" then
return  "مبينه شي سلامتك/ ج🎈😌"  
end
if msg.text =="شبيكك" then
return  "مبينه شي سلامتك/ ج🎈😌" 
end
if msg.text =="شبيكمم" then
return "مبينه شي سلامتك/ ج🎈😌" 
end
if msg.text =="جب" then
return  "جب بخشـ👃🏻ـمك פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="انجب" then
return  "جب بخشـ👃🏻ـمك פـٍـٍبيبي ءّ🙍‍♂️??" 
end
if msg.text =="نجب" then
return  "جب بخشـ👃??ـمك פـٍـٍبيبي ءّ🙍‍♂️💜" 
end
if msg.text =="اانجب" then
return  "جب بخشـ👃🏻ـمك פـٍـٍبيبي ءّ??‍♂️💜" 
end
if msg.text =="وين" then
return  "• بٌِٰـﮧﮧأرِٰض اَٰلْٰلْٰهَٰہۧ اَٰلْٰـہوٍّاَٰسٌٍعٍِّـﮧهَٰہۧ😽💜ֆ" 
end
if msg.text =="وينن" then
return  "• بٌِٰـﮧﮧأرِٰض اَٰلْٰلْٰهَٰہۧ اَٰلْٰـہوٍّاَٰسٌٍعٍِّـﮧهَٰہۧ😽💜ֆ" 
end
if msg.text =="وين تريد" then
return  "• بٌِٰـﮧﮧأرِٰض اَٰلْٰلْٰهَٰہۧ اَٰلْٰـہوٍّاَٰسٌٍعٍِّـﮧهَٰہۧ😽💜ֆ" 
end
if msg.text =="ووين" then
return  "• بٌِٰـﮧﮧأرِٰض اَٰلْٰلْٰهَٰہۧ اَٰلْٰـہوٍّاَٰسٌٍعٍِّـﮧهَٰہۧ😽💜ֆ" 
end
if msg.text =="باي" then
return  "لله وياكـ💙✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘"
end
if msg.text =="بااي" then
return  "لله وياكـ💙✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘"
end
if msg.text =="باااي" then
return  "لله وياكـ💙✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘"
end
if msg.text =="باااااي" then
return  "لله وياكـ??✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘"
end
if msg.text =="بايي" then
return  "لله وياكـ??✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽🍯̯⁾ֆ‘"
end
if msg.text =="باييي" then
return  "لله وياكـ💙✨ يا • ﻋٰۧﻋٰ̯ۧـسۂﻝَُّ↵⁽??̯⁾ֆ‘"
end
if msg.text =="شلونكم" then
return  "آلـْ ح ـمـِْدِّ اللّـٰھ وانٓــتــٰـہ/ي ࿐❥ 🌎🌸" 
end
if msg.text =="شلونك" then
return  "آلـْ ح ـمـِْدِّ اللّـٰھ وانٓــتــٰـہ/ي ࿐❥ 🌎🌸" 
end
if msg.text =="شونك" then
return  "آلـْ ح ـمـِْدِّ اللّـٰھ وانٓــتــٰـہ/ي ࿐❥ 🌎🌸" 
end
if msg.text =="شونكم" then
return  "آلـْ ح ـمـِْدِّ اللّـٰھ وانٓــتــٰـہ/ي ࿐❥ 🌎🌸" 
end
if msg.text =="☹️☹️☹️☹️" then
return "شبيك متعصب حبي 😱😿 منو وياك 😿😹😹"
end
if msg.text =="☹️☹️☹️" then
return "شبيك متعصب حبي 😱😿 منو وياك ??😹😹"
end
if msg.text =="☹️☹️" then
return "شبيك متعصب حبي 😱😿 منو وياك 😿??😹"
end
if msg.text =="☹️" then
return "شبيك متعصب حبي 😱😿 منو وياك 😿😹😹"
end
if msg.text =="🙂🙂🙂🙂" then
return "اوف شهل الابتسامه احله من الكمر 😎😻😻😹"
end
if msg.text =="😕😕😕😕" then
return "شكو عاوج حلكك😒😻😹😹"
end
if msg.text =="🙄🤞🏿" then
return "شبيك صافن على ايدك 😹??😹"
end
if msg.text =="🙁💔" then
return "ضايج لئن كلبه مكسور ??😿"
end
if msg.text =="🙂✌️" then
return "مبتسم على وجهي 😌😹😹😹😹"
end
if msg.text =="هه" then
return "ضحكتك 🚶 مال فروخ 😿 بطلها 😹😹😹"
end
if msg.text =="ههه" then
return "دوم حياتي مو يوم 🌹😻"
end
if msg.text =="هههه" then
return "دومها يل قالي 😻??😹"
end
if msg.text =="ههههه" then
return "دوم الضحكه بعد كلبي انت 😍🙊"
end
if msg.text =="هههههه" then
return "كافي تضخك 😒 انت مو زغير 😎😻😹"
end
if msg.text =="ههههههه" then
return "كافي تضخك 😒 انت مو زغير 😎😻😹"
end
if msg.text =="هههههههه" then
return "كافي تضخك 😒 انت مو زغير 😎😻😹"
end
if msg.text =="ههههههههه" then
return "انت شبيك تخبلت 😒😨😹😹"
end
if msg.text =="هههههههههه" then
return "انت شبيك تخبلت 😒😨😹😹"
end
if msg.text =="😹😹😹😹😹😹😹" then
return "انت شبيك تخبلت 😒😨😹😹"
end
if msg.text =="😹😹😹😹😹😹😹😹😹😹" then
return "انت شبيك تخبلت 😒😨😹😹"
end
if msg.text =="بربك" then 
return "ي وعلي ابو الحسن 😐💔" 
end
if msg.text =="كلكم" then 
return "ليش تجمع بحي اني بوت 😞💔" 
end
if msg.text =="والرب" then 
return "استغفر الله جنان كم مره كتلك لتحلف جذب😑🎈" 
end
if msg.text =="حقك" then 
return "ي حقك حمبي اني وياك ضدهم😐🎈" 
end
if msg.text =="اكلك" then 
return  "كول حبي بس لا تبول علينا 😸💛" 
end
if msg.text =="اكول" then 
return  "كول وفتح حلكك خل ابول 😸😸🙊" 
end
if msg.text =="احبج" then 
return  "ولكم زاحف دفره قبل لا يتكاثر بل كروب 😸😸😸💛" 
end
if msg.text =="خاص" then 
return  "اسف مرتبط ويه بنت عمك 😸😸💙" 
end
if msg.text =="تعال خاص" then 
return  "ها ها تريدون تلعبون بدلي 😸😸💑" 
end
if msg.text =="تعالي خاص" then 
return  "ها ها 😸 عود هم كول ما ازحف وهاي كمشتك😸💛" 
end
if msg.text =="تعال" then 
return  "ولي لك ليريدني هو يجيني 😸🌞" 
end
if msg.text =="صوفي" then
return  "فديته هاذا اخوي ابو الوكفات فديت ابنمي😍😍"
end 
if msg.text =="شغال" then
return  "❞ ءيہـ͜ާي ۶ـٰٰٰོۂٰٰٰٰٰزيہزيۂٰٰٰٰٰـﮯ بـہٰٖآﻗقــ͡ي ﯙأتۂـ͜مــٰཻدد 🤓💕" 
end
if msg.text =="فرخ" then
return  "• ؤخـٰٰ͒ہر آﻧﮧـ͜ާۂٰٰٰٰٰي ڵہٰٰٖٖكي᪼᪳ـۂتہٰٖـﮫﮧٰٰٖٖ 😋۶ֆ كبلك" 
end
if msg.text =="نصعد" then
return "مكالمهةة لو زرور ??🤘🏿"
end
if msg.text =="وف" then
return "مو كتلج اريحج لتخافين 🌝💦"
end
if msg.text =="اوي" then
return "هاي تفله بعد ميعور حمبي 🌚💦"
end
if msg.text =="كحبه" then
return "يب ادري بيها حته ناجها سويجد 😹"
end
if msg.text =="يوجع" then
return "حته ترتاحين يا عيني 😺"
end
if msg.text =="ولو منا" then
return "ماولي اذا ما انيجكم ??🤘🏻"
end
if msg.text =="الله" then
return "شبي خوما ضوجك خوما كللهم مايكل ناج هذا 🙀🙌🏻"
end
if msg.text =="نيجه" then
return "تعال بعد عمك افتر وما تحس وي التفال 🐸💚"
end
if msg.text =="كول انجب" then
return "خايب ولي لاتفل بطيزك ينطيني اوامر الفرخ 🤘🏿🤡🤘🏿"
end
if msg.text =="انكليزي" then
return "فاج يو ماين 😎"
end
if msg.text =="مرحبا" then 
return  " مہٰ۪۫ږآحہٰ۪۫بہٰ۪۫ هلا بيك 💑💋" 
end
if msg.text =="هاي" then 
return  "يههلا بيك حياتي 💛🌿" 
end
if msg.text =="شلونكم" then 
return  " تہۣۧمہۣۧﭑمہۣۧ بحي وانت شخبار 💛🌿" 
end
if msg.text =="هلاوووووو" then 
return  "يههلا بيك نورتنا 💛" 
end
if msg.text =="خرب" then 
return  "خرب وجهك حمتر لتكفر 🌞🌿 " 
end
if msg.text =="سلام" then 
return  "يهلا حمبي نورت 💛😻" 
end
if msg.text =="انت انجب" then 
return  "اي حمبي 😸 تعال فتح حلكك 😸💙" 
end
if msg.text =="وين ولك" then 
return  "يم خالتك الشكره بن  الصاكه" 
end
if msg.text =="اكرهك" then 
return  "شعور متبادل حبي" 
end
if msg.text =="تكرهني" then 
return  "شي اكيد احبك حياتي 😸💛" 
end
if msg.text =="اعشقك" then 
return  "فيدوه اني هم عشقك😊😹🙊" 
end
if msg.text =="شباب" then 
return  "كباب وتكه وسمج 😸😸??" 
end
if msg.text =="ماريا" then 
return  "ولك هاي الصاكه العشق هاي حبيبت المطور هاي 😸🙊😻😻️" 
end
if msg.text =="😂😂😂😂😂😂" then 
return  "يضحك الفطير 😹😹" 
end
if msg.text =="😇" then 
return  "استريح بحي رايد شي 😹😹😻" 
end
if msg.text =="😖" then 
return  "دي وجهك معقد 😹😹" 
end
if msg.text =="😄" then 
return  "حيل فتح حلكك نوب 😹😹😘" 
end
if msg.text =="😌😌😌😌??" then 
return  "فديت الغرور كله بحي" 
end
if msg.text =="😭😭😭😭😭" then 
return  "منو ويك حياتي بس كلي اله اهينه كدامك 😹😹" 
end
if msg.text =="😫" then 
return  "ها بحي منو مضوجك ??😻" 
end
if msg.text =="☻" then 
return  "عساس ثكيل العينتين تاليتك تزحفبل خاص 😹😹" 
end
if msg.text =="😠" then 
return  "طفه طفه 💦💦 تره حمه حيل" 
end
if msg.text =="😳😳😳😳😳" then 
return  "ها شفت/ي ابوك/ج مصلخ ونصدمت 😹😹" 
end
if msg.text =="😹" then 
return  "اضحك شكو عله كلبك ☹😹" 
end
if msg.text =="🙊🙊🙊🙊🙊" then 
return  "ها قردي شبيك مستحي 😂😂" 
end
if msg.text =="🙈🙈🙈🙈🙈" then 
return  "صار/ت قرد يعني خجلان ?😹😹😹" 
end
if matches[1]=="بوت" and is_sudo(msg) then 
return  "تاج راسي كول حبيبي 😻🙊😚" 
end
if msg.text =="بوت" and is_admin(msg) then 
return "ها حياتي المدير 😻اامرني كلبي 😇🙊" 
end
if msg.text =="بوت" and is_owner(msg) then 
return "ها حياتي المدير 😻اامرني كلبي 😇🙊" 
end
if msg.text =="بوت" and is_mod(msg) then 
return "ها احجي شتريد 😏 صيحلي باسمي بعد لدكول بوت😹😢🚶" 
end
if msg.text =="بوت" then 
return  "نجب لك صارت قديمه صيحلي باسمي 😒👬💛" 
end 
if matches[1]=="ستورم" and is_sudo(msg) then 
return  "عيونه لستورم يبعد كلبي 😻🙊😹" 
end
if msg.text =="ستورم" and is_admin(msg) then 
return "حياتي انت كول بعد روحي 😽🙊" 
end
if msg.text =="ستورم" and is_owner(msg) then 
return "تفضل تاج راسي 😻🙊" 
end
if msg.text =="ستورم" and is_mod(msg) then 
return "تفصل يروحتي 😍😻" 
end
if msg.text =="ستورم" then 
return "فضها كول شرايد تعبتوني😢😞" 
------------------------------ 
end 
if msg.text ==" " and is_sudo(msg) then 
return  "انت الكلب الي ماعيش من دونه ??🙊" 
end
if msg.text ==" " and is_admin(msg) then 
return "انت اداري يرويحتي 😽🙈" 
end
if msg.text ==" " and is_owner(msg) then 
return "انت تاج راسي المدير 😍😘" 
end
if msg.text ==" " and is_mod(msg) then 
return "انت صديقي الادمن 💔💋" 
end
if msg.text ==" " then 
return  "هو انت مجرد عضو 😒😅" 
end 
if matches[1]=="شنو اني" and is_sudo(msg) then 
return  "انت حياتي المطور 💋😽" 
end
if msg.text =="شنو اني" and is_admin(msg) then 
return "انت الاداري يكلبي 😍🙈" 
end
if msg.text =="شنو اني" and is_owner(msg) then 
return "انت المدير النفس كله 😻☺" 
end
if msg.text =="شنو اني" and is_mod(msg) then 
return "يا صديقي انت الادمن 💛🌚" 
end
if msg.text =="شنو اني" then 
return "انت عضو لا تحل ولا تربط 😹😻" 
end 
end 
----------------------------------------------------------------------------------------------------------------------------------------
local bot_id = botid
if matches[1] == 'طرد الكل' and msg.from.id == tonumber(SUDO) or matches[1] == 'طرد الكل' and msg.from.id == tonumber(SUDO) or matches[1] == 'طرد الكل' and msg.from.id == tonumber(SUDO) then 
  function m(arg, data) 
    for k, v in pairs(data.members_) do
    if tonumber(v.user_id_) ~= tonumber(bot_id) then
     kick_user(v.user_id_, msg.to.id) 
end
end
    tdcli.sendMessage(msg.to.id, msg.id, 1, '📮 | • تم طرد الكل بنجاح 😇', 1, 'md') 
end  
  tdcli_function ({ID = "GetChannelMembers",channel_id_ = mmm(msg.to.id).ID,offset_ = 0,limit_ = 1000}, m, nil)
  end 
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((matches[1]:lower() == "ملصق") or (matches[1] == "ملصق")) and is_mod(msg) then 
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.webp') 
     tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil) 
end
end
--------------------------------------------------------------------------------------------------------------------------------
if ((matches[1]:lower() == "متحركه") or (matches[1] == "متحركه")) and is_mod(msg) then
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
        local modes = {'memories-anim-logo','alien-glow-anim-logo','flash-anim-logo','flaming-logo','whirl-anim-logo','highlight-anim-logo','burn-in-anim-logo','shake-anim-logo','inner-fire-anim-logo','jump-anim-logo'}
        local text = URL.escape(matches[2]) 
        local url2 = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
        local title , res = http.request(url2)
        local jdat = json:decode(title)
        local gif = jdat.src
        local file = download_to_file(gif,'byroo.gif')
        tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, file, '', dl_cb, nil)
 end
 end
--------------------------------------------------------------------------------------------------------------------------------
if ((matches[1]:lower() == "صوره") or (matches[1] == "صوره" )) and is_mod(msg) then 
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
local logo = {'comics-logo','water-logo','3d-logo','blackbird-logo','runner-logo','graffiti-burn-logo','electric','standing3d-logo','style-logo','steel-logo','fluffy-logo','surfboard-logo','orlando-logo','fire-logo','clan-logo','chrominium-logo','harry-potter-logo','amped-logo','inferno-logo','uprise-logo','winner-logo','star-wars-logo','silver-logo','Design-Dance'} 
local text = URL.escape(matches[2])
local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..logo[math.random(#logo)]..'&text='..text..'&symbol_tagname=popular&fontsize=100&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=100&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=400&scaleHeight=200&&_=1469943010141' 
local title , res = http.request(url) 
local jdat = json:decode(title) 
local sticker = jdat.src 
local file = download_to_file(sticker,'byroo.jpg') 
    tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, file, "", dl_cb, nil)
end
end
--------------------------------------------------------------------------------------------------------------------------------
if ((matches[1]:lower() == "زخرفه") or (matches[1] == "زخرفه")) and is_mod then
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
	if #matches < 2 then
		return "📮 | • اكتب زخرفه عربي من ثمه فراغ ثم اكتب الاسم المراد زخرفته"
	end
	if string.len(matches[2]) > 20 then
		 tdcli.sendMessage(msg.chat_id_, 0, 1, "📮 | • لا اسنطيع زخرفه اكثر من 20 حرف", 1, 'html')
	end
	local font_base = "ض,ص,ق,ف,غ,ع,ه,خ,ح,ج,ش,س,ی,ب,ل,ا,ن,ت,م,چ,ظ,ط,ز,ر,د,پ,و,ک,گ,ث,ژ,ذ,آ,ئ,.,_"

	local font_hash = "ض,ص,ق,ف,غ,ع,ه,خ,ح,ج,ش,س,ی,ب,ل,ا,ن,ت,م,چ,ظ,ط,ز,ر,د,پ,و,ک,گ,ث,ژ,ذ,آ,ئ,.,_"
	local fonts = {
		
"ضـٍہًہ,صًـٍـًہ,ـᓆـ,ف͒ہٰٰ,غہٰٰ,؏ۤـہٰٰ,ھہ,ـפֿـ,ـפـ,ج,ش,ـωـ,ی,بہٰٰ ,لྀ̲ہٰٰ,آ,نہٰٰ ,ྀ̲تہٰٰ ,םـۂ,چ,ظٍـً,طہـۛ,ز,ر,ـב,پ,ـפּـ,ڪٰྀہٰٰٖـ,گـ,ثِْْہٰٰہٰٰہٰٰـ,ژ,ذَِِِْ,آ,ئ,.,_",
"ضۜۜہٰٰ,صۛہُُِِٰٰۛہٰٰۛہٰٰ,قྀ̲ہٍٍٰٰٰٰٰྀ̲ہٰٰٰྀ̲ہٰٰٰ,ف͒ہِِٰٰٰٰ͒ہٰٰ͒ہٰٰ,غہِِِِٰٰٰٰہٰٰہٰٰ,؏ۤـہ,ٰ̲ھہ,خٰ̐ہّّٰٰٰ̐ہٰ̐ہ,حہٌٌٰٰٰٰہٰٰہٰٰ,جًًِِّّْْْۧۧۧ,شِٰہََُُِٰٰٰہِٰٰٰہٰٰ,سٌٌٍٍٰٰٰٰٰٰٓٓٓ,ی,بّہٌٌِِّٰٰہّہ,لْْٰٰ,آ,نَِٰہٍٍَِٰٰٰہَِٰہ,تَہََّّٰٰٰہََٰہَٰ,مٰ̲ہٍٍٰٰٰ̲ہٰ̲ہ,چ,ظۗہََِِْْٰٰۗہٰٰۗہٰٰ,طۨہََُُِِٰٰۨہٰٰۨہٰٰ,زًًَََََ,رِِٰٰ,دِِٰٰ,پ,وٍٍِِِّّ,ڪٰྀہٰٰٖ,گ,ثہِِْْْْٰٰہٰٰہٰٰ,ژ,ذََِِِْْ,ئ,آ,.,_",
"ضــ,صــ,قــ,فــ,غــ,عــ,ـهــ,خــ,حــ,جــ,شــ, سـ,یــ,بــ,لــ,ﺂ,نــ,تــ,مــ,چــ,ظــ,طــ,ـز,ـر,ـد,پــ,ـو,کــ,گــ,ـثــ,ـژ,ـذ,ﺂ,ئ,.,_",		
"ضۜہٰٰ,صۛہٰٰ,قྀ̲ہٰٰٰ,ف͒ہٰٰ,غہٰٰ,؏ۤـہ,ٰ̲ھہ,خٰ̐ہ,حہٰٰ,جْۧ,شِٰہٰٰ,سٰٰٓ,ی,بّہ,ل,آ,نَِٰہ,تَہَٰ,مٰ̲ہ,چ,ظۗہٰٰ,طۨہٰٰ,زَ,ر,د,پ,وِ,ک,گ,ثہٰٰ,ژ,ذِ,ئ,آ,.,_",
"ﺿ'ــ́,ﺻ'ــ́ـ,ق,ف,ﻍ,عـٌٍٍ,ﮪ͜͡ہــ,خ'ــ,‏ﺣ'ـــ,ﺟ'ـــ,ﺷ'ــ́ﮨ,ﺳ'ــ́,ی,ب'ــ́,لــ₰ــ,ﺂ,ن'ـ,ﺗ'ـ͜͡ہــ́,ﻤ̉̉ـ,چ,ظ,ط,ز,ر,د,پ,ؤ,ﮓ,گ,ﺚ,ژ,ذ,ئ,ﺂ  ,.,_",
"ﻀـ,ﺻـ,ق,ف,ﻋ̉̉̀,عـِِِِ,ـﮧـہٰ⇣̉ـ,خــ₰ـ,‏حــٰٰـॡۣۛـ,ﺠــ,ـﮨ́́ﮨ́ﮨ,ﮨﮨﮨـ,ی,پـــٰٰـॡۣۛ,لـ,ﭑإ́,نـ,ﺗــﮩًٍ✺ٍَﮩ,ﻤ̉̉ـ,چ,ظ,ط,ز,ر,د,پ,وُ,ﮓـ🔞ـ,گ,ﺛـ,ژ,ذ,ئ,ﭑإ́  ,.,_",
"ضًً,صـ๑ــَ,ق,ف,غً,عــ₰ــًً,هہـ,خِہ,ـحّ,جـ🔞ـٌ,ڜ,سـ❗️ـُُُُُ,ی,بـ℘ـِ,لـ,أ,نــہٰ⇣ـ,ِِتً,مہـ†ـً,چ,ظـ⁽🌝₎ـَ,ط,ز,ر,د,پ,وُ,ﮏ,گ,ثـ͜͡ہــِ,ژ,ذ,ئ,أ  ,.,_",
"ضًـٍـًہًـٍـًہ,صًـٍـًہ,ق,ف,غً,عً,هہـ,خِہ,ב,,جـﮩ๋͜ﮧـ͜ާْ,ڜـﮩ๋͜ﮧـ͜ާ,ڛﮧೋـّ̐ــً,ی,بہ,لـﮩﮨہٰٰہٰ,أ,טּ,تہٍـﮧ௸ِـِۣـّ̐ہٰ,مہ,چ,ظٍـًہ,ط,ز,ر,د,پ,وُ,ڪـ,گ,ثہـﮧﮧ♚ــٰ̲ہٰٰ,ژ,ذ,ئ,أ  ,.,_",
"ض,ص,ق,ف,غـ͜ﮩ͞₍🙈₎ﮩـ,عـ͜ﮩ͞₍❤️₎ﮩـ,هـہۛஓہـۛ,خـہۛஓہـۛ,ﺣـہۛஓہـۛ,جـہۛஓہـۛ,شۖـہۛஓہـۛ,سۜـہۛஓہـۛ,ی,بـ͜ﮩ͞₍💗₎ﮩـ,ل,اآ,نـہۛஓہـۛ,تـ͜ﮩ͞₍🍃₎ﮩـ,مـہۛஓہـۛ,چ,ظـ͜ﮩ͞₍🙈₎ﮩـ,طـہۛஓہـۛ,ز,ر,د,پ,ؤ,كـ͜ﮩ͞₍😈₎ﮩـ,گ,ثۨـہۛஓہـۛ,ژ,ذ,ئ,اآ  ,.,_",
"ضـ͜ﮩ͞₍😍₎ﮩـ,صـ͜ﮩ͞₍🙈₎ﮩـ,ق,فـ͜ﮩ͞₍🍃₎ﮩـ,ﻍـہۛஓہـۛ,؏ـہۛஓہـۛ,هـّـ✮ﮩ๋͜‏ـ,خ,ح,ج,شـ͜ﮩ͞₍🙂₎ﮩـ,سـ͜ﮩ͞₍👋₎ﮩـ,ی,ﯧـہۛஓہـۛ,لـہۛஓہـۛ,اآ,نـ͜ﮩ͞₍🖐₎ﮩـ,ت,مـ͜ﮩ͞₍🌚₎ﮩـ,چ,ظـہۛஓہـۛ,طـّـ✮ﮩ๋͜‏ـ,ز,ر,د,پ,وُ,كـہۛஓہـۛ,گ,ث,ژ,ذ,ئ,اآ  ,.,_",
"ضّـ✮ﮩ๋͜‏ـۣۛ﴿🌚﴾ـ,صـ✮ﮩ๋͜‏ـۣۛ﴿🌺﴾ـ,قـّـ✮ﮩ,فـّـ✮ﮩ๋͜‏ـۣۛ﴿😍﴾ـ,غـّـ✮ﮩ๋͜‏ـۣۛ﴿😌﴾ـ,عـّـ✮ﮩ๋͜‏ـ,ه,خـّـ✮ﮩ๋͜‏ـۣۛ﴿❓﴾ـ,حـّـ✮ﮩ๋͜‏ـ,,جـّـ✮ﮩ๋͜‏ـ,شـّـ✮ﮩ๋͜‏ـ,سـّـ✮ﮩ๋͜‏ـ,ی,بہ,ل,أ,ن,تـّـ✮ﮩ๋͜‏ـ,م,چ,ظـّـ✮ﮩ๋͜‏ـ,ط,ز,ر,د,پ,و,كـّـ✮ﮩ๋͜‏ـ,گ,ثہ,ژ,ذ,ئ,أ  ,.,_",
"ﻀــٍٍٍٍٍ,ﺻـ๋͜ﮧٰ۪ـہ,ق,ف,ﻋ̉̉̀ــۛৣـۛۛہ,عــٌٍٍ,ۂ͜ާـہ,خـৣৣـ,‏حـٍّ﴿❦﴾ـ,ﺠــ,ش,س,ی,پـًًًً,لــٰٰـॡۣۛـ,ﭑ́,ن,ﺗـﮩ๋͜ﮧـ͜ާ,ﻤ̉̉ـ,چ,ظـۛৣـ,ط,ز,ر,د,پ,وُ,ﮓـﮧ௸ْْــّ̐ہٰٰ,گ,ﺛـﮩﮨہٰٰہٰ,ژ,ذ,ئ,ﭑ́  ,.,_",
"ض,ص,ق,ف,غ,ع,هـ͜ﮩ͞₍🙇₎ﮩـ,خ,ح,ج,ش,س,ی,ب,لـّـ✮ﮩ๋͜‏ـ,آ,نہٰٰ ,ྀ̲تہٰٰ ,مـّـ✮ﮩ๋͜‏ـ,چ,طـ͜ﮩ͞₍😒₎ﮩـྀ̲ہٰٰ,طـ͜ﮩ͞₍😒₎ﮩـ,ڒ,ـﺭْ,دۛ,پ,ﯢ,ڪ,گ,ثྀ̲ہٰٰ,ژ,ﺫ,ئ,آ  ,.,_",
"ض,صۛہٰٰ,قྀ̲ہٰٰ,ف͒ہٰٰ,غہٰٰ,؏ۤـہٰٰ,ھہ,خٰ̐ہ,حہٰٰ,جْہ,شِٰہٰٰ,سٰٓہ,ی,بہٰٰ ,لྀ̲ہٰٰ,آ,نہٰٰ ,ྀ̲تہٰٰ ,םـۂ,چ,طہٰٰ ྀ̲ہٰٰྀ̲ہٰٰ,طہٰٰ ,ڒ,ـﺭْ,دۛ,پ,ﯢ,ڪ,گ,ثྀ̲ہٰٰ,ژ,ﺫ,ئ,آ  ,.,_",
"ض,صـﮩ๋͜‏ـ,قـﮩ๋͜‏ـ,فـﮩ๋͜‏ـ,غـﮩ๋͜‏ـ,؏ـﮩ๋͜‏ـ,هـﮩ๋͜‏ـ,خـﮩ๋͜‏ـ,حـﮩ๋͜‏ـ,جـﮩ๋͜‏ـ,شـﮩ๋͜‏ـ,سـﮩ๋͜‏ـ,ی,بـﮩ๋͜‏ـ,لّۣۗ,آِ,نْۛ,تٌۙ,ﻡِۙـ,چ,ظـﮩ๋͜‏ـۖۜ,طٌۗ,ﺯۖ,ږۙ,ڊْ,پ,ﯠۚ,ڪٌۘ,گ,ثٌّۜ,ژ,ﺫۗ,ئ,آِ  ,.,_",
"ض,صــ᷈͟ـ✦ـ,قــ᷈͟ـ✦ـ,فــ᷈͟ـ✦ـ,غــ᷈͟ـ✦ـ,عــ᷈͟ـ✦ـ,هــ᷈͟ـ✦ـ,خــ᷈͟ـ✦ـ,حــ᷈͟ـ✦ـ,جــ᷈͟ـ✦ـ,شــ᷈͟ـ✦ـ,ســ᷈͟ـ✦ـ,ی,بــ᷈͟ـ✦ـ,لــ᷈͟ـ✦ـ,ٲآٲ,نــ᷈͟ـ✦ـ,تــ᷈͟ـ✦ـ,مــ᷈͟ـ✦ـ,چ,ظــ᷈͟ـ✦ـــ᷈͟ـ✦ـ,طــ᷈͟ـ✦ـ,ز,ر,د,پ,ﯠ,كــ᷈͟ـ✦ـ,گ,ثــ᷈͟ـ✦ـ,ژ,ذ,ئ,ٲآٲ  ,.,_",
"ض,صـﮩ⃑ﮩ,قـﮩ⃑ﮩ,فـﮩ⃑ﮩ,غـﮩ⃑ﮩ,عـﮩ⃑ﮩ,هـﮩ⃑ﮩ,خـﮩ⃑ﮩ,حـﮩ⃑ﮩ,جـﮩ⃑ﮩ,شـﮩ⃑ﮩ,سـﮩ⃑ﮩ,ی,بـﮩ⃑ﮩ,لـﮩ⃑ﮩ,آ,نـﮩ⃑ﮩ,تـﮩ⃑ﮩ,مـﮩ⃑ﮩ,چ,ظـﮩ⃑ﮩـﮩ⃑ﮩ,طـﮩ⃑ﮩ,ڒ,ر,ډ,پ,ﯛ,كـﮩ⃑ﮩ,گ,ثـﮩ⃑ﮩ,ژ,ﮈ,ئ,آ  ,.,_",
"ضًـٍـًہ,صًـٍஹـ,ـقـ,ف,غً,عًـ௬ـ,هہ,خِہ,בـ,جْـஸ்ரீـ,ڜـக்ஷ்ـ,ڛً,ی,بہ,ل,آ,ہن,تہ,م,چ,ظٍـًௌـ,طٍـًہ,ز,ڑ,دٍ,پ,وُ,ـڪـ,گ,ثـৡـ,ژ,ذٍ,ئ,آ  ,.,_",
"ضہۣۗ,صہۣۗ,قَہۣۗـெـ,فُہۣۗ,غّہۣۗ,عَہۣۗ,هہۣۗ,خٌہۣۗ,حًہۣۗ,جَہۣۗ,شّہۣۗ,سہۣۗـக்ஷـ,ی,بّہۣۗـளுـ,لًً,أ,نٌہۣۗـஹـ,تُہۣۗ,مہۣۗ,چ,ظٌہۣۗ,طٌہۣۗـணـ,زُ,رُ,دُ,پ,وِ,كہۣۗ,گ,ثًہۣۗ,ژ,ذٌ,ئ,أ  ,.,_",
"ض,صہۭۖﹻﹻہۣۣـ,قہۭۖﹻﹻہۣۣـ,فہۭۖﹻﹻہۣۣـ,غہۭۖﹻﹻہۣۣـ,غہۭۖﹻﹻہۣۣـ,هہۭۖﹻﹻہۣۣـ,خہۭۖﹻﹻہۣۣـ,حہۭۖﹻﹻہۣۣـ,جہۭۖﹻﹻہۣۣـ,شہۭۖﹻﹻہۣۣـ,سہۭۖﹻﹻہۣۣـ,ی,بہۭۖﹻﹻہۣۣـ,لہۭۖﹻﹻہۣۣـ,آ,نہۭۖﹻﹻہۣۣـ,تہۭۖﹻﹻہۣۣـ,مہۭۖﹻﹻہۣۣـ,چ,ظہۭۖﹻﹻہۣۣـہۭۖﹻﹻہۣۣـ,طہۭۖﹻﹻہۣۣـ,ز,ر,د,پ,ﯠ,كہۭۖﹻﹻہۣۣـ,گ,ثہۭۖﹻﹻہۣۣـ,ژ,ذ,ئ,آ  ,.,_",
"ض,صـﮩ  ͜↯ﮩـ,قـﮩ  ͜↯ﮩـ,فـﮩ  ͜↯ﮩـ,غـﮩ  ͜↯ﮩـ,عـﮩ  ͜↯ﮩـ,هـﮩ  ͜↯ﮩـ,خـﮩ  ͜↯ﮩـ,حـﮩ  ͜↯ﮩـ,جـﮩ  ͜↯ﮩـ,شـﮩ  ͜↯ﮩـ,سـﮩ  ͜↯ﮩـ,ی,بـﮩ  ͜↯ﮩـ,لـﮩ  ͜↯ﮩـ,ٲ,نـﮩ  ͜↯ﮩـ,تـﮩ  ͜↯ﮩـ,مـﮩ  ͜↯ﮩـ,چ,ظـﮩ  ͜↯ﮩــﮩ  ͜↯ﮩـ,طـﮩ  ͜↯ﮩـ,ز,ر,د,پ,و,ګ,گ,ثـﮩ  ͜↯ﮩـ,ژ,ذ,ئ,ٲ  ,.,_",
"ض,صـہٰٰــۛ๘ـۛۛہ,قـہٰٰــۛ๘ـۛۛہ,فـہٰٰــۛ๘ـۛۛہ,غـہٰٰــۛ๘ـۛۛہ,عـہٰٰــۛ๘ـۛۛہ,هـہٰٰــۛ๘ـۛۛہ,خـہٰٰــۛ๘ـۛۛہ,حـہٰٰــۛ๘ـۛۛہ,جـہٰٰــۛ๘ـۛۛہ,شـہٰٰــۛ๘ـۛۛہ,سـہٰٰــۛ๘ـۛۛہ,ی,بـہٰٰــۛ๘ـۛۛہ,لـہٰٰــۛ๘ـۛۛہ,أ,نـہٰٰــۛ๘ـۛۛہ,تـہٰٰــۛ๘ـۛۛہ,مـہٰٰــۛ๘ـۛۛہ,چ,ظـہٰٰــۛ๘ـۛۛہـہٰٰــۛ๘ـۛۛہ,طـہٰٰــۛ๘ـۛۛہ,ز,ر,د,پ,و,ک,گ,ثـہٰٰــۛ๘ـۛۛہ,ژ,ذ,ئ,أ  ,.,_",
"ض,صـٰ۫ﹻේـ,قـٰ۫ﹻේـ,فـٰ۫ﹻේـ,غـٰ۫ﹻේـ,عـٰ۫ﹻේـ,هـٰ۫ﹻේـ,خـٰ۫ﹻේـ,حـٰ۫ﹻේـ,جـٰ۫ﹻේـ,شـٰ۫ﹻේـ,سـٰ۫ﹻේـ,ی,بـٰ۫ﹻේـ,لـٰ۫ﹻේـ,ٱℓ,نَـٰ۫ﹻේـ,تْـٰ۫ﹻේـ,مٌـٰ۫ﹻේـ,چ,ظٌـٰ۫ﹻේــٰ۫ﹻේـ,طِـٰ۫ﹻේـ,زُ,رَ,دِ,پ,وَ,كِـٰ۫ﹻේـ,گ,ثُـٰ۫ﹻේـ,ژ,ذَ,ئ,ٱℓ  ,.,_",
"ض,صہٰﮧـ͡ۦ͢,قہٰﮧـ͡ۦ͢,فہٰﮧـ͡ۦ͢,غہٰﮧـ͡ۦ͢,عہٰﮧـ͡ۦ͢,هہٰﮧـ͡ۦ͢,خہٰﮧـ͡ۦ͢,حہٰﮧـ͡ۦ͢,جہٰﮧـ͡ۦ͢,شہٰﮧـ͡ۦ͢,سہٰﮧـ͡ۦ͢,ی,بہٰﮧـ͡ۦ͢,لہٰﮧـ͡ۦ͢,ا,نہٰﮧـ͡ۦ͢,تہٰﮧـ͡ۦ͢,مہٰﮧـ͡ۦ͢,چ,ظہٰﮧـ͡ۦ͢ہٰﮧـ͡ۦ͢,طہٰﮧـ͡ۦ͢,ز,ر,د,پ,و,كہٰﮧـ͡ۦ͢,گ,ثہٰﮧـ͡ۦ͢,ژ,ذ,ئ,ا  ,.,_",
	}
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local result = {}
	i=0
	for k=1,#fonts do
		i=i+1
		local tar_font = fonts[i]:split(",")
		local text = matches[2]
		local text = text:gsub("ض",tar_font[1])
		local text = text:gsub("ص",tar_font[2])
		local text = text:gsub("ق",tar_font[3])
		local text = text:gsub("ف",tar_font[4])
		local text = text:gsub("غ",tar_font[5])
		local text = text:gsub("ع",tar_font[6])
		local text = text:gsub("ه",tar_font[7])
		local text = text:gsub("خ",tar_font[8])
		local text = text:gsub("ح",tar_font[9])
		local text = text:gsub("ج",tar_font[10])
		local text = text:gsub("ش",tar_font[11])
		local text = text:gsub("س",tar_font[12])
		local text = text:gsub("ی",tar_font[13])
		local text = text:gsub("ب",tar_font[14])
		local text = text:gsub("ل",tar_font[15])
		local text = text:gsub("ا",tar_font[16])
		local text = text:gsub("ن",tar_font[17])
		local text = text:gsub("ت",tar_font[18])
		local text = text:gsub("م",tar_font[19])
		local text = text:gsub("چ",tar_font[20])
		local text = text:gsub("ظ",tar_font[21])
		local text = text:gsub("ط",tar_font[22])
		local text = text:gsub("ز",tar_font[23])
		local text = text:gsub("ر",tar_font[24])
		local text = text:gsub("د",tar_font[25])
		local text = text:gsub("پ",tar_font[26])
		local text = text:gsub("و",tar_font[27])
		local text = text:gsub("ک",tar_font[28])
		local text = text:gsub("گ",tar_font[29])
		local text = text:gsub("ث",tar_font[30])
		local text = text:gsub("ژ",tar_font[31])
		local text = text:gsub("ذ",tar_font[32])
		local text = text:gsub("ئ",tar_font[33])
		local text = text:gsub("آ",tar_font[34])

		table.insert(result, text)
	end
	local result_text = "📮 | • الكلمه [<code>"..matches[2].."</code>]\n📮 | • عدد الكلمات المزخرفه ["..tostring(#fonts).."]\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n"
	a=0
	for v=1,#result do
		a=a+1
		result_text = result_text..a.." • <code>"..result[a].."</code>\n----------------------------------\n"
	end
	tdcli.sendMessage(msg.chat_id_, 0, 1, result_text, 1, 'html')
end
end
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if ((matches[1]:lower() == "زخرف") or (matches[1] == "زخرف")) and is_mod then
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
if #matches < 2 then
return "📮 | • اكتب زخرفه من ثمه فراغ ثم اكتب الاسم المراد زخرفته"
end
if string.len(matches[2]) > 20 then
tdcli.sendMessage(msg.chat_id_, 0, 1, "📮 | • لا اسنطيع زخرفه اكثر من 20 حرف", 1, 'html')
end
local font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
local font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
local fonts = {
		
"ă,ƅ,č,ɗ,ĕ,f,ğ,ɦ,ĭ,ĵ,ƙ,l,ɱ,ň,ŏ,ρ,ỡ,ř,š,t,ŭ,v,ŵ,ҳ,ў,ž,ă,ƅ,č,ɗ,ĕ,f,ğ,ɦ,ĭ,ĵ,ƙ,l,ɱ,ň,ŏ,ρ,ỡ,ř,š,t,ŭ,v,ŵ,ҳ,ў,ž,0,9,8,7,6,5,4,3,2,1  ,.,_",

"â,ß,Ç,ď,ę,ḟ,ĝ,ĥ,ĭ,Ĵ,ķ,ł,Ḿ,ñ,ǿ,ƿ,q,ŗ,ŝ,ť,ú,v,Ŵ,x,ŷ,Ž,â,ß,Ç,ď,ę,ḟ,ĝ,ĥ,ĭ,Ĵ,ķ,ł,Ḿ,ñ,ǿ,ƿ,q,ŗ,ŝ,ť,ú,v,Ŵ,x,ŷ,Ž,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ɐ,p,ɔ,q,ǝ,ɟ,ƃ,ɥ,ı,ſ,ʞ,ן,ɯ,u,o,p,q,ɹ,s,ʇ,u,ʌ,ʍ,x,ʎ,z,ɐ,p,ɔ,q,ǝ,ɟ,ƃ,ɥ,ı,ſ,ʞ,ן,ɯ,u,o,p,q,ɹ,s,ʇ,u,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Ꭿ,Ᏸ,Ꮸ,Ꭰ,Ꭼ,Ꮀ,Ꮆ,Ꮋ,Ꭵ,Ꭻ,Ꮶ,Ꮮ,Ꮇ,Ꮑ,Ꮻ,Ꮲ,Ꮕ,Ꭱ,Ꮪ,Ꮏ,Ꮜ,Ꮙ,Ꮤ,Ꮉ,Ꮍ,Ꮓ,Ꭿ,Ᏸ,Ꮸ,Ꭰ,Ꭼ,Ꮀ,Ꮆ,Ꮋ,Ꭵ,Ꭻ,Ꮶ,Ꮮ,Ꮇ,Ꮑ,Ꮻ,Ꮲ,Ꮕ,Ꭱ,Ꮪ,Ꮏ,Ꮜ,Ꮙ,Ꮤ,Ꮉ,Ꮍ,Ꮓ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"â,ß,Ç,ď,ę,ḟ,ĝ,ĥ,ĭ,Ĵ,ķ,ł,Ḿ,ñ,ǿ,ƿ,q,ŗ,ŝ,ť,ú,v,Ŵ,x,ŷ,Ž,â,ß,Ç,ď,ę,ḟ,ĝ,ĥ,ĭ,Ĵ,ķ,ł,Ḿ,ñ,ǿ,ƿ,q,ŗ,ŝ,ť,ú,v,Ŵ,x,ŷ,Ž,0,9,8,7,6,5,4,3,2,1  ,.,_",

"🇦 ,🇧 ,🇨 ,🇩 ,🇪 ,🇫 ,🇬 ,🇭 ,🇮 ,🇯 ,🇰 ,🇱 ,🇲 ,🇳 ,🇴 ,🇵 ,🇶 ,🇷 ,🇸 ,🇹 ,🇺 ,🇻 ,🇼 ,🇽 ,🇾 ,🇿 ,🇦 ,🇧 ,🇨 ,🇩 ,🇪 ,🇫 ,🇬 ,🇭 ,🇮 ,🇯 ,🇰 ,🇱 ,🇲 ,🇳 ,🇴 ,🇵 ,🇶 ,🇷 ,🇸 ,🇹 ,🇺 ,🇻 ,🇼 ,🇽 ,🇾 ,🇿 ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ᾄ,в,ƈ,ძ,ε,բ,ģ,ђ,į,j,k,ℓ,₥,ŋ,Ǿ,ṕ,գ,ʀ,ʂ,t,մ,v,ա,ჯ,Ƴ,ʐ,ᾄ,в,ƈ,ძ,ε,բ,ģ,ђ,į,j,k,ℓ,₥,ŋ,Ǿ,ṕ,գ,ʀ,ʂ,t,մ,v,ա,ჯ,Ƴ,ʐ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Æ,ß,ç,ԃ,ɐ,ƒ,ɠ,Ħ,į,ʝ,ƙ,Ŀ,ო,Ռ,Ø,Ƿ,Գ,Ґ,$,†,ย,,ຟ,χ,ψ,ȥ,Æ,ß,ç,ԃ,ɐ,ƒ,ɠ,Ħ,į,ʝ,ƙ,Ŀ,ო,Ռ,Ø,Ƿ,Գ,Ґ,$,†,ย,,ຟ,χ,ψ,ȥ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ﾑ,乃,Ͼ,Ð,ē,ϝ,Ǥ,ん,Ґ,ʝ,ƙ,ﾉ,ᄊ,刀,©,ｱ,Գ,尺,ㄎ,乇,Ц,ﾚ,ա,ﾒ,ﾘ,乙,ﾑ,乃,Ͼ,Ð,ē,ϝ,Ǥ,ん,Ґ,ʝ,ƙ,ﾉ,ᄊ,刀,©,ｱ,Գ,尺,ㄎ,乇,Ц,ﾚ,ա,ﾒ,ﾘ,乙,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ą,в,ƈ,ԃ,ε,ƒ,ɠ,ԋ,ï,ʝ,ƙ,ƚ,♏,ɦ,Ծ,ք,ϱ,г,Տ,乇,Ū,√,щ,Ж,Ɣ,ȥ,ą,в,ƈ,ԃ,ε,ƒ,ɠ,ԋ,ï,ʝ,ƙ,ƚ,♏,ɦ,Ծ,ք,ϱ,г,Տ,乇,Ū,√,щ,Ж,Ɣ,ȥ,0,9,8,7,6,5,4,3,2,1   ,.,_",

"Ǻ,฿,₡,Đ,Є,ƒ,Ģ,Ħ,Ĩ,j,k,ℓ,₥,ŋ,Ǿ,ṕ,գ,Г,Ŝ,Ṫ,ษ,Ṽ,ฟ,Ẍ,ץ,Ẕ,Ǻ,฿,₡,Đ,Є,ƒ,Ģ,Ħ,Ĩ,j,k,ℓ,₥,ŋ,Ǿ,ṕ,գ,Г,Ŝ,Ṫ,ษ,Ṽ,ฟ,Ẍ,ץ,Ẕ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ᾄ,в,ƈ,ḋ,ἔ,ғ,ʛ,ђ,ἷ,j,k,ł,м,ղ,ὄ,ր,գ,ʀ,ʂ,Ṱ,մ,Ɣ,ա,ჯ,Ƴ,ʐ,ᾄ,в,ƈ,ḋ,ἔ,ғ,ʛ,ђ,ἷ,j,k,ł,м,ղ,ὄ,ր,գ,ʀ,ʂ,Ṱ,մ,Ɣ,ա,ჯ,Ƴ,ʐ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Ǟ,в,ƈ,D,ę,բ,g,৸,i,j,k,ł,ɱ,ᾗ,ὄ,ῥ,գ,ʀ,ʂ,t,մ,v,w,ჯ,Ƴ,~z,Ǟ,в,ƈ,D,ę,բ,g,৸,i,j,k,ł,ɱ,ᾗ,ὄ,ῥ,գ,ʀ,ʂ,t,մ,v,w,ჯ,Ƴ,~z,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Δ,β,๕,đ,ệ,₣,Ĝ,ђ,Ỉ,j,k,Ł,Ṁ,ŋ,Ǿ,ṕ,գ,Г,Ŝ,Ṫ,ษ,Ṽ,ฟ,Ẍ,ץ,Ẕ,Δ,β,๕,đ,ệ,₣,Ĝ,ђ,Ỉ,j,k,Ł,Ṁ,ŋ,Ǿ,ṕ,գ,Г,Ŝ,Ṫ,ษ,Ṽ,ฟ,Ẍ,ץ,Ẕ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Ǻ,฿,₡,Đ,Є,ƒ,Ģ,Ħ,Ĩ,j,k,ℓ,₥,₦,Ǿ,ρ,գ,Ŗ,Ş,Ŧ,Ǜ,ϋ,￦,Ж,Ψ,Ź,Ǻ,฿,₡,Đ,Є,ƒ,Ģ,Ħ,Ĩ,j,k,ℓ,₥,₦,Ǿ,ρ,գ,Ŗ,Ş,Ŧ,Ǜ,ϋ,￦,Ж,Ψ,Ź,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Ǻ,β,Ĉ,Đ,ξَ,ƒ,ģ,ђ,į,j,k,ℓ,Ṃ,п,ὄ,ק,Ƣ,,Ṧ,Ṱ,µ,ν,ฟ,א,Ύ,żŻ,Ǻ,β,Ĉ,Đ,ξَ,ƒ,ģ,ђ,į,j,k,ℓ,Ṃ,п,ὄ,ק,Ƣ,,Ṧ,Ṱ,µ,ν,ฟ,א,Ύ,żŻ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"მ,Ɓჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,j,k,l,ო,ղ,ὄ,ր,գ,գ,ʂ,Ṱ,մ,Ɣ,ա,ჯ,Ƴ,ʐ,მ,Ɓჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,j,k,l,ო,ղ,ὄ,ր,գ,գ,ʂ,Ṱ,մ,Ɣ,ա,ჯ,Ƴ,ʐ,0,9,8,7,6,5,4,3,2,1  ,.,_",

"ᾄ,в,ƈ,ḋ,ἔ,ғ,ʛ,ђ,ἷ,j,k,ł,м,ᾗ,ὄ,ῥ,գ,ʀ,ʂ,t,մ,v,w,ჯ,Ƴ,~z,ᾄ,в,ƈ,ḋ,ἔ,ғ,ʛ,ђ,ἷ,j,k,ł,м,ᾗ,ὄ,ῥ,գ,ʀ,ʂ,t,մ,v,w,ჯ,Ƴ,~z,0,9,8,7,6,5,4,3,2,1  ,.,_",

"Ǟ,в,ƈ,D,ę,բ,g,৸,i,j,k,ł,ɱ,n,Φ,ῥ,գ,Я,ʂ,Ʈ,Ц,Ɣ,Щ,ж,Ƴ,ż,Ǟ,в,ƈ,D,ę,բ,g,৸,i,j,k,ł,ɱ,n,Φ,ῥ,գ,Я,ʂ,Ʈ,Ц,Ɣ,Щ,ж,Ƴ,ż,0,9,8,7,6,5,4,3,2,1  ,.,_",


"ᗩ,ᙖ,ᑕ,ᗪ,ᕮ,ℱ,ᘐ,ᕼ,Ꭵ,ᒎ,Ḱ,ᒪ,ᙢ,ᘉ,〇,ᖘ,Ⴓ,ᖇ,ᔕ,ͳ,ᘮ,ᐯ,ᗯ,‏χ,ϒ,Ꙃ,ᗩ,ᙖ,ᑕ,ᗪ,ᕮ,ℱ,ᘐ,ᕼ,Ꭵ,ᒎ,Ḱ,ᒪ,ᙢ,ᘉ,〇,ᖘ,Ⴓ,ᖇ,ᔕ,ͳ,ᘮ,ᐯ,ᗯ,‏χ,ϒ,Ꙃ,0,9,8,7,6,5,4,3,2,1,.,_",

"α,в,c,∂,ε,ғ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,s,т,υ,v,ω,x,ү,z,α,в,c,∂,ε,ғ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,s,т,υ,v,ω,x,ү,z,0,9,8,7,6,5,4,3,2,1,.,_",

"ᵃ,ᵇ,ᶜ,ᵈ,ᵉ,ᶠ,ᵍ,ʰ,ᶤ,ʲ,ᵏ,ˡ,ᵐ,ᶰ,ᵒ,ᵖ,ᵠ,ʳ,ˢ,ᵗ,ᵘ,ᵛ,ʷ,ˣ,ʸ,ᶻ,ᵃ,ᵇ,ᶜ,ᵈ,ᵉ,ᶠ,ᵍ,ʰ,ᶤ,ʲ,ᵏ,ˡ,ᵐ,ᶰ,ᵒ,ᵖ,ᵠ,ʳ,ˢ,ᵗ,ᵘ,ᵛ,ʷ,ˣ,ʸ,ᶻ,0,9,8,7,6,5,4,3,2,1,.,_",

"à,Ђ,ć,ď,ë,Բ,ĝ,ḩ,į,Ј,қ,Ŀ,m,ŋ,ð,ρ,Θ,я,ś,ť,μ,ⱱ,ẁ,א,y,ź,à,Ђ,ć,ď,ë,Բ,ĝ,ḩ,į,Ј,қ,Ŀ,m,ŋ,ð,ρ,Θ,я,ś,ť,μ,ⱱ,ẁ,א,y,ź,0,9,8,7,6,5,4,3,2,1,.,_",

"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,ⴅ,И,Ø,P,Ҩ,R,Ṩ,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,ⴅ,И,Ø,P,Ҩ,R,Ṩ,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",

"Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",

"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,ⴅ,И,Ø,P,Ҩ,R,Ṩ,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,ⴅ,И,Ø,P,Ҩ,R,Ṩ,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",

"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Ꝙ,尺,丂,ｲ,Џ,Ṽ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Ꝙ,尺,丂,ｲ,Џ,Ṽ,Щ,ﾒ,ﾘ,乙,0,9,8,7,6,5,4,3,2,1,.,_",

"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,Ј,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,ⱴ,ฬ,ᶍ,ỿ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,Ј,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,ⱴ,ฬ,ᶍ,ỿ,z,0,9,8,7,6,5,4,3,2,1,.,_",

"ค,ც,८,ძ,૯,Բ,₲,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,Ỿ,ઽ,ค,ც,८,ძ,૯,Բ,₲,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,Ỿ,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",

"Λ,ß,Ƈ,δ,Ɛ,Բ,₲,Ḩ,ị,Ĵ,Ҡ,Ⱡ,ⴅ,ⴂ,Ỗ,Ꝓ,Ꝙ,Ɽ,Ṥ,Ͳ,Ʊ,Ѵ,Ѡ,Ӿ,Ỿ,Ꙃ,Λ,ß,Ƈ,δ,Ɛ,Բ,₲,Ḩ,ị,Ĵ,Ҡ,Ⱡ,ⴅ,ⴂ,Ỗ,Ꝓ,Ꝙ,Ɽ,Ṥ,Ͳ,Ʊ,Ѵ,Ѡ,Ӿ,Ỿ,Ꙃ,0,9,8,7,6,5,4,3,2,1,.,_",

"ᴀ,ʙ,ᴄ,ᴅ,ᴇ,ғ,ɢ,ʜ,ɪ,ᴊ,ᴋ,ʟ,ᴍ,ɴ,ᴏ,ᴘ,ǫ,ʀ,ѕ,ᴛ,ᴜ,ᴠ,ᴡ,х,ʏ,ᴢ,ᴀ,ʙ,ᴄ,ᴅ,ᴇ,ғ,ɢ,ʜ,ɪ,ᴊ,ᴋ,ʟ,ᴍ,ɴ,ᴏ,ᴘ,ǫ,ʀ,ѕ,ᴛ,ᴜ,ᴠ,ᴡ,х,ʏ,ᴢ,0,9,8,7,6,5,4,3,2,1,.,_",

"Ａ,Ｂ,С,Ｄ,Ｅ,Բ,Ｇ,Ｈ,Ｉ,Ｊ,Ｋ,Ｌ,Ⅿ,Ｎ,Ｏ,Ｐ,Ｑ,Ｒ,Ｓ,Ｔ,Ｕ,Ｖ,Ｗ,Ｘ,Ｙ,Ｚ,Ａ,Ｂ,С,Ｄ,Ｅ,Բ,Ｇ,Ｈ,Ｉ,Ｊ,Ｋ,Ｌ,Ⅿ,Ｎ,Ｏ,Ｐ,Ｑ,Ｒ,Ｓ,Ｔ,Ｕ,Ｖ,Ｗ,Ｘ,Ｙ,Ｚ,0,9,8,7,6,5,4,3,2,1,.,_",

"Λ,Б,Ͼ,Ð,Ξ,Ŧ,₲,Ḧ,ł,J,К,Ł,Ɱ,Л,Ф,Ꝓ,Ǫ,Я,Ŝ,₮,Ǚ,Ṽ,Ш,Ж,Ẏ,Ꙃ,Λ,Б,Ͼ,Ð,Ξ,Ŧ,₲,Ḧ,ł,J,К,Ł,Ɱ,Л,Ф,Ꝓ,Ǫ,Я,Ŝ,₮,Ǚ,Ṽ,Ш,Ж,Ẏ,Ꙃ,0,9,8,7,6,5,4,3,2,1,.,_",

}

local result = {}
i=0
for k=1,#fonts do
i=i+1
local tar_font = fonts[i]:split(",")
local text = matches[2]
local text = text:gsub("A",tar_font[1])
local text = text:gsub("B",tar_font[2])
local text = text:gsub("C",tar_font[3])
local text = text:gsub("D",tar_font[4])
local text = text:gsub("E",tar_font[5])
local text = text:gsub("F",tar_font[6])
local text = text:gsub("G",tar_font[7])
local text = text:gsub("H",tar_font[8])
local text = text:gsub("I",tar_font[9])
local text = text:gsub("J",tar_font[10])
local text = text:gsub("K",tar_font[11])
local text = text:gsub("L",tar_font[12])
local text = text:gsub("M",tar_font[13])
local text = text:gsub("N",tar_font[14])
local text = text:gsub("O",tar_font[15])
local text = text:gsub("P",tar_font[16])
local text = text:gsub("Q",tar_font[17])
local text = text:gsub("R",tar_font[18])
local text = text:gsub("S",tar_font[19])
local text = text:gsub("T",tar_font[20])
local text = text:gsub("U",tar_font[21])
local text = text:gsub("V",tar_font[22])
local text = text:gsub("W",tar_font[23])
local text = text:gsub("X",tar_font[24])
local text = text:gsub("Y",tar_font[25])
local text = text:gsub("Z",tar_font[26])
local text = text:gsub("a",tar_font[27])
local text = text:gsub("b",tar_font[28])
local text = text:gsub("c",tar_font[29])
local text = text:gsub("d",tar_font[30])
local text = text:gsub("e",tar_font[31])
local text = text:gsub("f",tar_font[32])
local text = text:gsub("g",tar_font[33])
local text = text:gsub("h",tar_font[34])
local text = text:gsub("i",tar_font[35])
local text = text:gsub("j",tar_font[36])
local text = text:gsub("k",tar_font[37])
local text = text:gsub("l",tar_font[38])
local text = text:gsub("m",tar_font[39])
local text = text:gsub("n",tar_font[40])
local text = text:gsub("o",tar_font[41])
local text = text:gsub("p",tar_font[42])
local text = text:gsub("q",tar_font[43])
local text = text:gsub("r",tar_font[44])
local text = text:gsub("s",tar_font[45])
local text = text:gsub("t",tar_font[46])
local text = text:gsub("u",tar_font[47])
local text = text:gsub("v",tar_font[48])
local text = text:gsub("w",tar_font[49])
local text = text:gsub("x",tar_font[50])
local text = text:gsub("y",tar_font[51])
local text = text:gsub("z",tar_font[52])
local text = text:gsub("0",tar_font[53])
local text = text:gsub("9",tar_font[54])
local text = text:gsub("8",tar_font[55])
local text = text:gsub("7",tar_font[56])
local text = text:gsub("6",tar_font[57])
local text = text:gsub("5",tar_font[58])
local text = text:gsub("4",tar_font[59])
local text = text:gsub("3",tar_font[60])
local text = text:gsub("2",tar_font[61])
local text = text:gsub("1",tar_font[62])
		
table.insert(result, text)
end
local result_text = "📮 | • الكلمه [`"..matches[2].."`]\n📮 | • عدد الكلمات المزخرفه [ `"..tostring(#fonts).."\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n"
a=0
for v=1,#result do
a=a+1
result_text = result_text..a.." • <code>"..result[a].."</code>\n----------------------------------\n"
end
tdcli.sendMessage(msg.chat_id_, 0, 1, result_text, 1, 'html')
end
end
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
if matches[1] == "الحساب" then
            local text = ' 📮 | • اضغط هنا للدخول الى الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.to.id, reply_to_message_id_=msg.id, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=29, user_id_=matches[2]}}}}, dl_cb, nil)
end
if matches[1] == "ايديي" and is_sudo(msg) then 
return "\n `"..arg.chat_id.."`"
elseif matches[1]=="ايديي" and is_admin(msg) then 
return "\n `"..arg.chat_id.."`"
elseif matches[1]=="ايديي" and is_owner(msg) then 
return "\n `"..arg.chat_id.."`"
elseif matches[1]=="ايديي" and is_mod(msg) then 
return "\n `"..arg.chat_id.."`"
elseif matches[1]=="معرفي" then 
return  "\n👁‍🗨┊معرفك :> @"..(msg.from.username or "لايوجد").. "\n"
elseif matches[1]=="gid" then 
return  "`"..msg.to.id.. "`"
elseif matches[1]=="رسايلي" then 
return " رسائلك [*"..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).."*]"
elseif matches[1]=="  " then 
local lock_id = data[tostring(msg.to.id)]["settings"]["lock_id"] 
if lock_id == "no" then
return  "\n\n♦️￤» ايديك •  "..user.." }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد")..'\n'
elseif matches[1]=="اسمي" then 
return  "\n♦️┊اسمك :> "..(check_markdown(msg.from.first_name or "----")).."\n "
elseif matches[1]=="رسائلي" then 
return " رسائلك [*"..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).."*]"
------------------------------
end
end
if matches[1]==" " and is_sudo(msg) then 
return "•🚸• موقعك في المجموعه •🚸• \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈• \n \n\n♦️￤»  رسائلك • { "..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).. " }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد").. "\n\n♦️￤» اسمك  •  "..(check_markdown(msg.from.first_name or "----")).."\n\n♦️￤» ايديك •  "..user.."\n\n♦️￤»  موقعك • المطور \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n\n•💠• تابعنا @ "..botusea
elseif matches[1]==" " and is_admin(msg) then 
return "•🚸• موقعك في المجموعه •🚸• \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈• \n \n\n♦️￤»  رسائلك • { "..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).. " }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد").. "\n\n♦️￤» اسمك  •  "..(check_markdown(msg.from.first_name or "----")).."\n\n♦️￤» ايديك •  "..user.."\n\n♦️￤»  موقعك • المدير \n\n•┈•??•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n\n•💠• تابعنا @ "..botusea
elseif matches[1]==" " and is_owner(msg) then 
return "•🚸• موقعك في المجموعه •🚸• \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈• \n \n\n♦️￤»  رسائلك • { "..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).. " }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد").. "\n\n♦️￤» اسمك  •  "..(check_markdown(msg.from.first_name or "----")).."\n\n♦️￤» ايديك •  "..user.."\n\n♦️￤»  موقعك • الاداري \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n\n•💠• تابعنا @ "..botusea
elseif matches[1]==" " and is_mod(msg) then 
return "•🚸• موقعك في المجموعه •🚸• \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈• \n \n\n♦️￤»  رسائلك • { "..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).. " }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد").. "\n\n♦️￤» اسمك  •  "..(check_markdown(msg.from.first_name or "----")).."\n\n♦️￤» ايديك •  "..user.."\n\n♦️￤»  موقعك • الادمن \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n\n•💠• تابعنا @ "..botusea
elseif matches[1]==" " then 
return "•🚸• موقعك في المجموعه •🚸• \n\n•~~•??•~~•♦️•~~•🗯•~~• \n \n\n♦️￤»  رسائلك • { "..tonumber(redis:get('msgs:'..msg.from.id..':'..msg.to.id) or 0).. " }\n\n♦️￤»  معرفك •   @"..(msg.from.username or "لايوجد").. "\n\n♦️￤» اسمك  •  "..(check_markdown(msg.from.first_name or "----")).."\n\n♦️￤» ايديك •  "..user.."\n\n♦️￤»  موقعك • عضو \n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n\n•💠• تابعنا @ "..botusea
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
redis:incr("allmsg")
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match('-100(%d+)') then
if not redis:sismember("su",msg.chat_id_) then
redis:sadd("su",msg.chat_id_)
end
elseif id:match('-(%d+)') then
if not redis:sismember("gp",msg.chat_id_) then
redis:sadd("gp",msg.chat_id_)
end
elseif id:match('') then
if not redis:sismember("user",msg.chat_id_) then
redis:sadd("user",msg.chat_id_)
end
end
end
if matches[1] == 'اعدادات البوت' or matches[1] == 'اعدادات البوت' and msg.from.id == tonumber(SUDO) then
local allmsg = redis:get("allmsg")
local gps = redis:scard("su")
local gp = redis:scard("gp")
local user = redis:scard("user")
--------------------------------------------------------------------------------------------------------------------------------
       tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '`⚜• معلومات البوت •⚜`\n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈• \n\n📮 | • عدد رسائل المجموعه '..allmsg..'\n\n📮 | • عدد المجموعات الخارقه '..gps..'\n\n📮 | • عدد المجموعات العاديه '..gp..'\n\n📮 | • عدد الاعضاء في الخاص '..user..'\n\n•┈•💠•۪۫•৩﴾ • 🚸️ • ﴿৩•۪۫•💠•┈•\n📮 | • تابع @'..botusea..'\n', 1, 'md')
end
if matches[1] == 'ريست' or matches[1] == 'ریست' and is_sudo(msg) then
redis:del("allmsg")
redis:del("su")
redis:del("gp")
redis:del("user")
tdcli.sendMessage(msg.chat_id_, msg.id_,1,' 📮 | • تم تحديث البوت 🚸 ',1,'md')
end
----------------------------------------------------------------------------------------------------
if matches[1]:lower() == 'تعديل' or matches[1] == 'تعديل' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local Text = matches[2]
tdcli.editMessageText(msg.to.id, msg.reply_to_message_id_, nil, Text, 1, 'md')
end

if matches[1]:lower() == 'تعديل' or matches[1] == 'تعديل' and msg.reply_to_message_id_ ~= 0 and is_sudo(msg) then
local tExt = matches[2]
tdcli.editMessageCaption(msg.to.id, msg.reply_to_message_id_, nil, tExt)
end
----------------------------------------------------------------------------------------------------
if matches[1]:lower() == 'تحويل صوره' or matches[1]:lower() == "تحويل صوره" and msg.reply_id then
local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
function tophoto(arg, data)
function tophoto_cb(arg,data)
if data.content_.sticker_ then
local file = data.content_.sticker_.sticker_.path_
local secp = tostring(tcpath)..'/data/sticker/'
local ffile = string.gsub(file, '-', '')
local fsecp = string.gsub(secp, '-', '')
local name = string.gsub(ffile, fsecp, '')
local sname = string.gsub(name, 'webp', 'jpg')
local pfile = 'data/photos/'..sname
local pasvand = 'webp'
local apath = tostring(tcpath)..'/data/sticker'
if file_exi(tostring(name), tostring(apath), tostring(pasvand)) then
os.rename(file, pfile)
tdcli.sendPhoto(msg.to.id, 0, 0, 1, nil, pfile, '📮 | • تابع جديدنا • @'..botusea..'\n', dl_cb, nil)
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '📮 | • قم بارسال الملصق مره اخرى •', 1, 'md')
end
else
tdcli.sendMessage(msg.to.id, msg.id_, 1, '📮 | • هاذا ليس ملصق', 1, 'md')
end
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, tophoto_cb, nil)
end
tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_id }, tophoto, nil)
end
end
if matches[1] == "حذف" and is_mod(msg)  then
if not matches[2] and msg.reply_id then
del_msg(msg.to.id, msg.reply_id)
del_msg(msg.to.id, msg.id)
end
end
--------------------------------
	if matches[1]:lower() == 'تحويل ملصق' or matches[1]:lower() == "تحويل ملصق" and msg.reply_id then
	local lock_taha = data[tostring(msg.to.id)]["settings"]["lock_taha"] 
if lock_taha == "yas" then
		function tosticker(arg, data)
			function tosticker_cb(arg,data)
				if data.content_.ID == 'MessagePhoto' then
					file = data.content_.photo_.id_
					local pathf = tcpath..'/data/photo/'..file..'_(1).jpg'
					local pfile = 'data/photos/'..file..'.webp'
					if file_exi(file..'_(1).jpg', tcpath..'/data/photo', 'jpg') then
						os.rename(pathf, pfile)
						tdcli.sendDocument(msg.chat_id_, 0, 0, 1, nil, pfile, '📮 | • تابع جديدنا • @'..botusea..'\n', dl_cb, nil)
					else
						tdcli.sendMessage(msg.to.id, msg.id_, 1, '📮 | • قم بارسال الصوره مره اخرى •', 1, 'md')
					end
				else
					tdcli.sendMessage(msg.to.id, msg.id_, 1, '📮 | • هاذه ليست صوره •', 1, 'md')
				end
			end
			tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = data.id_ }, tosticker_cb, nil)
		end
		tdcli_function ({ ID = 'GetMessage', chat_id_ = msg.chat_id_, message_id_ = msg.reply_id }, tosticker, nil)
    end
    end
local gp_type = "typing:"..msg.chat_id_
if matches[1] == "ت"  and msg.from.id == tonumber(SUDO) then
--تفعيله
if matches[2] == "فعيل القرائه" then 
redis:set(type, true) 
return "📮 | • تم تفعيل🔓  القرائه\n\n\n"
--تعطيله
elseif matches[2] == "عطيل القرائه" then 
redis:del(type) 
return "📮 | • تم تعطيل 🔐 القرائه  ❮ ☑️ ❯ \n\n\n"
end 
end 
if redis:get(type) then
tdcli.sendChatAction(msg.chat_id_, "Typing")
end
if matches[1]:lower() == 'كول' or matches[1] == 'كول' then
local pext = matches[2]
tdcli.sendMessage(msg.to.id, 0,1, pext,1,'md')
end
if matches[1] == "رابط الحذف"  then
    local text = [[

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

📮 | • رابط الحذف • ♨️

📮 | • احذف ونتبه لمستقبلك • 🌀

📌• https://telegram.org/deactivate

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if matches[1] == "الاوامر" and is_mod(msg) then
    local text = [[
📍 اهــلا بك عــزيزي في اوامر السورس  

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

☇ •- م1  « لعـرض قائمــه الـحمـايـه

☇ •- م2 « لعرض قائمه الحظر 🗑

☇ •- م3  « لعــرض اوامـر المجموعـه 🔧

☇ •- م4  « لعــرض اوامـر الحمايه بمميزات 🔧

☇ •- م5 « لعرض اوامر الخدمات 📥

☇ •- م6  « لعــرض اوامـر المطور 👨🏻‍🚀

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if matches[1] == "م1" and is_mod(msg) then
    local text = [[
🔹- اهلا بك في اوامر الحمايه 🔧

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

🎭 • قفل : /
                 => + الامر 
🎭 • فتح : \

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
   
☇ • الروابط  📮
☇ • التوجيه. ♻
☇ • التاك   🏷    
☇ • التعديل. 📎 
☇ • البوتات. 👾 
☇ • الكلايش  📝
☇ • العربيه   📜
☇ • الفشار. 🔞   
☇ • الاضافه.  🖇
☇ • الصفحات  💻
☇ • الاغاني 🎤   
☇ • التثبيت🔖   
☇ • الماركداون 🃏
☇ • الاشعارات 🚩
☇ • المتحركه 🎭
☇ • الملصقات ♣
☇ • الجهات 📞
☇ • الملفات 📇
☇ • التاك 🆔
☇ • الصور 📷
☇ • المواقع 🚏
☇ • الفيديو 📺
☇ • الصوت 📢
☇ • الدردشه📝
☇ • التكرار  بالكتم  🔕  
☇ • التكرار  بالطرد 🚷 

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
   
]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if matches[1] == "م2" and is_mod(msg) then
    local text = [[
اهلا بك في اوامــر الحــظر والطـرد 

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

☇ • حظر  « لحظر العضو ❕
☇ • الغاء حظر «  للغاء الحظر❕
☇ • طرد  « « لطرد العضو ❕
☇ • حظر عام « للحظر عام ❕
☇ • الغاء العام «  لغاء حظر عام ❕
☇ • منع + كلمه  « لمنع الكلمات ❕
☇ • الغاء منع + كلمه «  الغاء منع ❕
☇ • كتم « « لكتم العضو ❕
☇ • الغاء الكتم « « للغاء الكتم ❕

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
    
]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 if matches[1] == "م3" and is_mod(msg) then
    local text = [[
• اوامر المجموعـه👩🏻‍🔧👨🏻‍🔧 •

ٴ┄•🔸•┄༻📯༺┄•🔸•┄     

☇ • تثبيت  >  بالرد 📌
☇ • الغاء تثبيت > بالرد 📌 🗑
☇ •  تفعيل الترحيب ❕
☇ • تعطيل الترحيب ❕
☇ • تشغيل الردود 🔔
☇ • ايقاف الردود 🔕
☇ • تشغيل الايدي 📌
☇ • ايقاف الايدي 📌
☇ • تشغيل جلب الصوره 📥
☇ • ايقاف جلب الصوره 🔑

ٴ┄•🔸•┄༻📯༺┄•🔸•┄        

☇ • ضع رابط  ◄ ثم ارسل الرابط  🔗
☇ • ضع رابط + الرابط 🔗
☇ • ضع قوانين  +  النص 📋    
☇ • ضع وصف  + النص 🏷
☇ • ضع ترحيب +  النص 🎊
☇ • ضع اسم. +  النص  📝     

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    

 📮┇ مسح  ◄  الاوامر ادناه ↓
☇ •  المحظورين  
☇ •  المكتومين 
☇ •  قائمه العام
☇ •  قائمه المنع 
☇ •  الادمنيه 
☇ •  المدراء
☇ •  الوصف  
☇ •  القوانين   
☇ •  الترحيب
☇ •  البوتات
☇ •  المطرودين
 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄        
☇ • تنظيف المحذوف • لطرد المحذوفين
☇ • قائمه المنع •  لعرض كلمه الممنوعه
☇ • الادمنيه • لـعرض ادمنيه البوت 
☇ • المدراء. • لـعرض مدراء المجموعه 
☇ • الوصف  • لـعرض وصـف الكروب
☇ • القوانين • لـعرض قوانين الكروب 
☇ • جلب صوره + [ رقم الصوره ]
☇ • رد اضف للمجموعه [ الكلمه + الرد ]
☇ • رد حذف للمجموعه [ الكلمه ]

ٴ┄•🔸•┄༻📯༺┄•🔸•┄       
      
]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if matches[1] == "م4" and is_mod(msg) then
    local text = [[
📌 • اهلا بك عزيزي في اوامر الحمايه 🔧

ٴ┄•🔸•┄༻📯༺┄•🔸•┄

📮 | • قفل + الامر + [ بالكتم • بالتحذير • بالطرد ] •
 
📮 | • فتح + الامر

ٴ🔸┄༻مميزات جديده༺┄🔸

📮 | • الروابط •
☇• قفل  الروابط [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الروابط 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • المعرفات @ •
☇• قفل المعرفات  [ بالكتم • بالتحذير • بالطرد ]
☇• فتح المعرفات  
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • توجيه القنواة •
☇• قفل توجيه القنواة [ بالكتم • بالتحذير • بالطرد ]
☇• فتح توجيه القنواة 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الصفحات •
☇• قفل الصفحات [ بالكتم • بالتحذير • بالطرد ] 
☇• الصفحات 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الكلايش •
☇• قفل الكلايش [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الكلايش 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • التكرار •
☇• قفل التكرار [ بالكتم • بالطرد ]
☇• فتح التكرار 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الماركداون •
☇• قفل الماركداون [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الماركداون 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • التعديل •
☇• قفل التعديل [ بالكتم • بالتحذير • بالطرد ]
☇• فتح التعديل  
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • المتحركه •
☇• قفل المتحركه  [ بالكتم • بالتحذير • بالطرد ]
☇• فتح المتحركه 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
 📮 | • الصور •
☇• قفل الصور [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الصور 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 
📮 | • الملفات •
☇• قفل الملفات [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الملفات 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 
📮 | • الملصقات •
☇• قفل الملصقات [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الملصقات 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الفديو •
☇• قفل الفديو [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الفديو 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الدردشه •
☇• قفل الدردشه [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الدردشه 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • التوجيه •
☇• قفل التوجيه [ بالكتم • بالتحذير • بالطرد ]
☇• فتح التوجيه 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • المواقع •
☇• قفل المواقع [ بالكتم • بالتحذير • بالطرد ]
☇• فتح المواقع  
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الصوت •
☇• قفل الصوت [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الصوت 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الاغاني •
☇• قفل الاغاني [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الاغاني 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
 📮 | • اللستات •
☇• قفل اللستات [ بالكتم • بالتحذير • بالطرد ]
☇• فتح اللستات  
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الجهات •
☇• قفل الجهات [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الجهات  
ٴ┄•🔸•┄༻📯༺┄•🔸•┄
📮 | • الكل} : 
☇• قفل الكل  [ بالكتم • بالتحذير • بالطرد ]
☇• فتح الكل 
ٴ┄•🔸•┄༻📯༺┄•🔸•┄

]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if matches[1] == "م5" and is_mod(msg) then
    local text = [[
⛦ • اهلا بك في الاوامر الخدميه 🔧

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
   
☇ • تحويل صوره [ بالرد على الملصق ]
☇ • تحويل ملصق [ بالرد على الصوره ]
☇ • صوره + [ النص ]
☇ • ملصق + [ النص ]
☇ • متحركه + [ النص ]
☇ • زخرفه + [ النص ] لزخرفه الاسم بالعربي
☇ • زخرف + [ النص ] لزخرفه الاسم بالانكلش

ٴ┄•🔸•┄༻📯༺┄•🔸•┄    
]]
    return text
  end
  ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if matches[1] == "م6" and is_sudo(msg) then
    local text = [[
  اوامـر خاصه بل  الـمـطـورين 👨🏻‍🚀

ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 

☇•   تفعيل > لتفعيل البوت ✔
☇•  تعطيل > لتعطيل البوت ✖
☇•  رفع مدير. • > { رد • معرف }
☇• تنزيل مدير • > { رد • معرف }
☇• رفع ادمن  • > { رد • معرف }
☇• تنزيل ادمن • > { رد • معرف }

ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 

•⚜• للمطور الاساسي فقط 🔻

☇• رفع مطور • > { رد • معرف } 
☇• تنزيل مطور • > { رد • معرف }
☇• ضع كليشه المطور • + النص 
☇• حذف كليشه المطور •
☇•  اذاعه • + الكلام ☑️
☇•  رساله • + ايدي المجموعه ✅ا
☇•  غادر  • > لخروج البوت 🙋🏻‍♂
☇• اعدادات البوت 
☇• تشغيل الخدمات • > لتشغيل خدمات البوت

 ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 

☇• رد اضف للكل •  [ الكلمه + الرد ]
☇• رد حذف للكل • [ الكلمه ]
☇• مسح الكل • > لمسح الردود
☇• الردود • > لعرض الردود
☇• تفعيل المغادره • > لمغادرة البوت
☇• تعطيل المغادره • > لعدم مغادرة البوت
☇• المجموعات • > لرؤيه المجموعات 
☇• توجيه للكل • > بالرد عله الرساله
☇• توجيه للخاص • > بالرد عله الرساله
☇• توجيه للمجموعات • > بالرد عله الرساله
☇• تفعيل ملف • + اسم الملف
☇• تعطيل ملف • + اسم الملف
☇• تحديث • > لتحديث ملفات السورس
☇ • تفعيل القرائه • > لجعل البوت اسرع واقوه

ٴ┄•🔸•┄༻📯༺┄•🔸•┄ 

]]
    return text
  end
  
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function pre_process(msg) 
 local chat = msg.to.id 
   local user = msg.from.id 
 local data = load_data(_config.moderation.data) 
local function welcome_cb(arg, data) 
local hash = "gp_lang:"..arg.chat_id 
local lang = redis:get(hash) 
      administration = load_data(_config.moderation.data) 
    if administration[arg.chat_id]['setwelcome'] then 
     welcome = administration[arg.chat_id]['setwelcome'] 
      else 
     if not lang then 
     welcome = '📮 | • اهلا بك يا name}\n}📮 | • نورتنا ضيف جهاتك في كروب {gpname}\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n•♦• تابع @'..botusea
    elseif lang then 
     welcome = '📮 | • اهلا بك يا name}\n}📮 | • نورتنا ضيف جهاتك في كروب {gpname}\n\n•┈•⚜•۪۫•৩﴾ • ♦️ • ﴿৩•۪۫•⚜•┈•\n•♦• تابع @'..botusea
        end 
     end 
 if administration[tostring(arg.chat_id)]['rules'] then 
rules = administration[arg.chat_id]['rules'] 
else 
   if not lang then 
     return "• القوانين الافتراضية •\n\nٴ┄•⚔•┄༻💠༺┄•⚔•┄\n📮 | • عدم التكرار \n📮 | • عدم نشر الروابط \n📮 | • عدم عمل توجيهات \n📮 | • عدم نشر كلايش اباحيه \n📮 | • عدم التكلم في السياسه \n📮 | • احترم تحترم \n \nٴ┄•⚔•┄༻💠༺┄•⚔•┄"
       else 
       rules = "• القوانين الافتراضية •\n\nٴ┄•⚔•┄༻💠༺┄•⚔•┄\n📮 | • عدم التكرار \n📮 | • عدم نشر الروابط \n📮 | • عدم عمل توجيهات \n📮 | • عدم نشر كلايش اباحيه \n📮 | • عدم التكلم في السياسه \n📮 | • احترم تحترم \n \nٴ┄•⚔•┄༻💠༺┄•⚔•┄"
       end 
end 
if data.username_ then 
user_name = "@"..check_markdown(data.username_) 
else 
user_name = "" 
end 
      local welcome = welcome:gsub("{rules}", rules) 
      local welcome = welcome:gsub("{name}", check_markdown(data.first_name_..' '..(data.last_name_ or ''))) 
      local welcome = welcome:gsub("{username}", user_name) 
      local welcome = welcome:gsub("{gpname}", arg.gp_name) 
      tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md") 
   end 
   if data[tostring(chat)] and data[tostring(chat)]['settings'] then 
   if msg.adduser then 
      welcome = data[tostring(msg.to.id)]['settings']['welcome'] 
      if welcome == "✔" then 
         tdcli.getUser(msg.adduser, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title}) 
      else 
         return false 
      end 
   end 
   if msg.joinuser then 
      welcome = data[tostring(msg.to.id)]['settings']['welcome'] 
      if welcome == "✔" then 
         tdcli.getUser(msg.sender_user_id_, welcome_cb, {chat_id=chat,msg_id=msg.id_,gp_name=msg.to.title}) 
      else 
         return false 
        end 
      end 
   end 
 ---------------
 local function anti_flood(msg)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
local flood = data[tostring(chat)]['settings']['flood']
   if msg.from.username then
      user_name = "@"..check_markdown(msg.from.username)
         else
      user_name = check_markdown(msg.from.first_name)
     end
   if flood == "kick" then
if redis:get('sender:'..user..':flood') then
return
else
   del_msg(chat, msg.id)
    kick_user(user, chat)
   if not lang then
  tdcli.sendMessage(chat, msg.id, 0, "`📮 | •  العضو` "..user_name.."\n📮 | •  الالايدي *[ "..user.." ]*\n`📮 | •  تم طرده بسبب تكرار الرسائل`", 0, "md")
   elseif lang then
  tdcli.sendMessage(chat, msg.id, 0, "`📮 | •  العضو` "..user_name.."\n📮 | •  الالايدي *[ "..user.." ]*\n`📮 | •  تم طرده بسبب تكرار الرسائل`", 0, "md")
    end
redis:setex('sender:'..user..':flood', 30, true)
      end
   end
   if flood == "silent" then
if redis:get('sender:'..user..':flood') then
return
else
   del_msg(chat, msg.id)
    silent_user(user_name, user, chat)
   if not lang then
  tdcli.sendMessage(chat, msg.id, 0, "`📮 | •  العضو` "..user_name.."\n📮 | •  الالايدي *[ "..user.." ]*\n`📮 | •  تم كتمك بسبب تكرار الرسائل`", 0, "md")
   elseif lang then
  tdcli.sendMessage(chat, msg.id, 0, "`📮 | •  العضو` "..user_name.."\n📮 | •  الالايدي *[ "..user.." ]*\n`📮 | •  تم كتمك بسبب تكرار الرسائل`", 0, "md")
    end
redis:setex('sender:'..user..':flood', 30, true)
      end
   end
end
  
local function pre_process(msg)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
local is_channel = msg.to.type == "channel"
local is_chat = msg.to.type == "chat"
local auto_leave = 'auto_leave_bot'
local hash = "gp_lang:"..chat
local lang = redis:get(hash)
if not redis:get('autodeltime1') then
	redis:setex('autodeltime1', 14400, true)
     run_bash("rm -rf ~/.telegram-cli/data/sticker/*")
     run_bash("rm -rf ~/.telegram-cli/data/photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/animation/*")
     run_bash("rm -rf ~/.telegram-cli/data/video/*")
     run_bash("rm -rf ~/.telegram-cli/data/audio/*")
     run_bash("rm -rf ~/.telegram-cli/data/voice/*")
     run_bash("rm -rf ~/.telegram-cli/data/temp/*")
     run_bash("rm -rf ~/.telegram-cli/data/thumb/*")
     run_bash("rm -rf ~/.telegram-cli/data/document/*")
     run_bash("rm -rf ~/.telegram-cli/data/profile_photo/*")
     run_bash("rm -rf ~/.telegram-cli/data/encrypted/*")
	 run_bash("rm -rf ./data/photos/*")
end
   if is_channel or is_chat then
        local TIME_CHECK = 2
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['time_check'] then
            TIME_CHECK = tonumber(data[tostring(chat)]['settings']['time_check'])
          end
        end
    if msg.text then
  if msg.text:match("(.*)") then
    if not data[tostring(msg.to.id)] and not redis:get(auto_leave) and not is_admin(msg) then
  --tdcli.sendMessage(msg.to.id, "", 0, "_This Is Not One Of My_ *Groups*", 0, "md")
  --tdcli.changeChatMemberStatus(chat, our_id, 'Left', dl_cb, nil)
      end
   end
end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
		settings = data[tostring(chat)]['settings']
	else
		return
	end
	if settings.link then
		links = settings.link
	else
		links = '🔓'
	end
	if settings.tag then
		tags = settings.tag
	else
		tags = '🔓'
	end
	if settings.lock_pin then
		lock_pin = settings.lock_pin
	else
		lock_pin = '🔓'
	end
	if settings.arabic then
		arabic = settings.arabic
	else
		arabic = '🔓'
	end
	if settings.mention then
		mentions = settings.mention
	else
		mentions = '🔓'
	end
		if settings.edit then
		edit = settings.edit
	else
		edit = '🔓'
	end
		if settings.spam then
		spam = settings.spam
	else
		spam = '🔓'
	end
	if settings.flood then
		flood = settings.flood
	else
		flood = '🔓'
	end
	if settings.markdown then
		markdowns = settings.markdown
	else
		markdowns = '🔓'
	end
	if settings.webpage then
		webpages = settings.webpage
	else
		webpages = '🔓'
	end
	if settings.chat then
		chats = settings.chat
	else
		chats = '🔓'
	end
	if settings.gif then
		gifs = settings.gif
	else
		gifs = '🔓'
	end
   if settings.photo then
		photos = settings.photo
	else
		photos = '🔓'
	end
	if settings.sticker then
		stickers = settings.sticker
	else
		stickers = '🔓'
	end
	if settings.contact then
		contacts = settings.contact
	else
		contacts = '🔓'
	end
	if settings.inline then
		inlines = settings.inline
	else
		inlines = '🔓'
	end
	if settings.game then
		games = settings.game
	else
		games = '🔓'
	end
	if settings.text then
		Ltext = settings.text
	else
		Ltext = '🔓'
	end
	if settings.keyboard then
		keyboards = settings.keyboard
	else
		keyboards = '🔓'
	end
	if settings.forward then
		forwards = settings.forward
	else
		forwards = '🔓'
	end
	if settings.view then
		view = settings.view
	else
		view = '🔓'
	end
	if settings.location then
		locations = settings.location
	else
		locations = '🔓'
	end
   if settings.document then
		documents = settings.document
	else
		documents = '🔓'
	end
	if settings.voice then
		voices = settings.voice
	else
		voices = '🔓'
	end
	if settings.audio then
		audios = settings.audio
	else
		audios = '🔓'
	end
	if settings.video then
		videos = settings.video
	else
		videos = '🔓'
	end
	if settings.lock_tgservice then
		lock_tgservice = settings.lock_tgservice
	else
		lock_tgservice = '🔓'
	end
	if settings.lock_join then
		lock_join = settings.lock_join
	else
		lock_join = '🔓'
	end
   if msg.from.username then
      username = "@"..check_markdown(msg.from.username)
         else
      username = check_markdown(msg.from.first_name)
     end
   if msg.from.username then
      user_name = "@"..msg.from.username
         else
      user_name = msg.from.first_name
     end
  if msg.adduser or msg.joinuser or msg.deluser then
  if lock_tgservice == "yes" then
del_msg(chat, tonumber(msg.id))
  end
end
 if not is_mod(msg) and not is_whitelist(msg.from.id, msg.to.id) and msg.from.id ~= our_id then
	if msg.adduser or msg.joinuser then
		if lock_join == "yes" then
			function join_kick(arg, data)
				kick_user(data.id_, msg.to.id)
			end
			if msg.adduser then
				tdcli.getUser(msg.adduser, join_kick, nil)
			elseif msg.joinuser then
				tdcli.getUser(msg.joinuser, join_kick, nil)
			end
		end
	end
end
   if msg.pinned and is_channel then
  if lock_pin == "yes" then
     if is_owner(msg) then
      return
     end
     if tonumber(msg.from.id) == our_id then
      return
     end
    local pin_msg = data[tostring(chat)]['pin']
      if pin_msg then
  tdcli.pinChannelMessage(msg.to.id, pin_msg, 1)
       elseif not pin_msg then
   tdcli.unpinChannelMessage(msg.to.id)
          end
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>الالايدي :</b> '..msg.from.id..'\n<b>المعرف :</b> '..('@'..msg.from.username or '<i>لا يوجد معرف</i>')..'\n<i>تثبيت الرسائل مقفل من المدراء 🔐</i>', 0, "html")
     elseif not lang then
    tdcli.sendMessage(msg.to.id, msg.id, 0, '<b>الالايدي :</b> '..msg.from.id..'\n<b>المعرف :</b> '..('@'..msg.from.username or '<i>لا يوجد معرف</i>')..'\n<i>تثبيت الرسائل مقفل من المدراء 🔐</i>', 0, "html")
          end
      end
  end
      if not is_mod(msg) and msg.from.id ~= our_id and not is_whitelist(msg.from.id, msg.to.id) then
if msg.edited then
if edit == "بالتحذير" then
  local offender = 'edit_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل هنا', 0, "html")
        end
   end
elseif edit == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif edit == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع التعديل تم طردك', 0, "html")
          end
elseif edit == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع التعديل هنا تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع التعديل هنا تم كتمك', 0, "html")
       end
   end
end
if msg.forward_info_ then
if forwards == "بالتحذير" then
  local offender = 'forward_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة التوجيه هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة التوجيه هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة التوجيه هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة التوجيه هنا', 0, "html")
        end
   end
elseif forwards == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif forwards == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة توجيه تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '?? | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة توجيه تم طردك', 0, "html")
          end
elseif forwards == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '?? | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة توجيه هنا تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اعادة توجيه هنا تم كتمك', 0, "html")
       end
   end
end
if tonumber(msg.views_) ~= 0 then
if view == "بالتحذير" then
  local offender = 'view_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة هنا', 0, "html")
        end
   end
elseif view == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif view == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة تم طردك', 0, "html")
          end
elseif view == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع اوسال توجيه القنواة تم كتمك', 0, "html")
       end
   end
end
if msg.photo_ then
if photos == "بالتحذير" then
  local offender = 'photo_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور هنا', 0, "html")
        end
   end
elseif photos == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif photos == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور تم طردك', 0, "html")
          end
elseif photos == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصور تم كتمك', 0, "html")
       end
   end
end
    if msg.video_ then
if videos == "بالتحذير" then
  local offender = 'video_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو هنا', 0, "html")
        end
   end
elseif videos == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif videos == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو تم طردك', 0, "html")
          end
elseif videos == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الفيديو تم كتمك', 0, "html")
       end
   end
end
    if msg.document_ then
if documents == "بالتحذير" then
  local offender = 'document_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات هنا', 0, "html")
        end
   end
elseif documents == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif documents == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات تم طردك', 0, "html")
          end
elseif documents == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملفات تم كتمك', 0, "html")
       end
   end
end
    if msg.sticker_ then
if stickers == "بالتحذير" then
  local offender = 'sticker_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات هنا', 0, "html")
        end
   end
elseif stickers == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif stickers == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات تم طردك', 0, "html")
          end
elseif stickers == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الملصقات تم كتمك', 0, "html")
       end
   end
end
    if msg.animation_ then
if gifs == "بالتحذير" then
  local offender = 'gif_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور المتحركة هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور المتحركة هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور المتحركة هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور المتحركة هنا', 0, "html")
        end
   end
elseif gifs == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif gifs == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صورمتحركة تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صورمتحركة تم طردك', 0, "html")
          end
elseif gifs == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور متحركة تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال صور متحركة تم كتمك', 0, "html")
       end
   end
end
    if msg.contact_ then
if contacts == "بالتحذير" then
  local offender = 'contact_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال هنا', 0, "html")
        end
   end
elseif contacts == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif contacts == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال تم طردك', 0, "html")
          end
elseif contacts == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال جهات اتصال تم كتمك', 0, "html")
       end
   end
end
    if msg.location_ then
if locations == "بالتحذير" then
  local offender = 'location_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع هنا', 0, "html")
        end
   end
elseif locations == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif locations == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع تم طردك', 0, "html")
          end
elseif locations == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المواقع تم كتمك', 0, "html")
       end
   end
end
    if msg.voice_ then
if voices == "بالتحذير" then
  local offender = 'voice_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
        end
   end
elseif voices == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif voices == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<i>📮 | • العضو : </i> '..user_name..' \n<i>📮 | • الايدي :</i> <b>'..user..'</b>\n📮 | • ممنوع ارسال التسجيلات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<i>📮 | • العضو : </i> '..user_name..' \n<i>📮 | • الايدي :</i> <b>'..user..'</b>\n📮 | • ممنوع ارسال التسجيلات تم طردك', 0, "html")
          end
elseif voices == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال التسجيلات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال التسجيلات تم كتمك', 0, "html")
       end
   end
end
   if msg.content_ then
  if msg.reply_markup_ and  msg.reply_markup_.ID == "ReplyMarkupInlineKeyboard" then
if keyboards == "بالتحذير" then
  local offender = 'keyboard_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد هنا', 0, "html")
        end
   end
elseif keyboards == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif keyboards == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد تم طردك', 0, "html")
          end
elseif keyboards == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال كيبورد تم كتمك', 0, "html")
         end
      end
   end
end
    if tonumber(msg.via_bot_user_id_) ~= 0 then
if inlines == "بالتحذير" then
  local offender = 'inline_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات هنا', 0, "html")
        end
   end
elseif inlines == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif inlines == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات تم طردك', 0, "html")
          end
elseif inlines == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال اللستات تم كتمك', 0, "html")
       end
   end
end
    if msg.game_ then
if games == "بالتحذير" then
  local offender = 'game_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الالعاب هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الالعاب هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الالعاب هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الالعاب هنا', 0, "html")
        end
   end
elseif games == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif games == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الالعاب تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '?? | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الالعاب تم طردك', 0, "html")
          end
elseif games == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الالعاب تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الالعاب تم كتمك', 0, "html")
       end
   end
end
    if msg.audio_ then
if audios == "بالتحذير" then
  local offender = 'audio_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات هنا', 0, "html")
        end
   end
elseif audios == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif audios == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات تم طردك', 0, "html")
          end
elseif audios == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الصوتيات تم كتمك', 0, "html")
       end
   end
end
if msg.media.caption then
local link_caption = msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Gg][Tt][Aa][Mm].[Dd][Oo][Gg]/") or msg.media.caption:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]/") or msg.media.caption:match("[Tt][Ll][Gg][Rr][mM][.][Mm][Ee]/")
if link_caption then
if links == "بالتحذير" then
  local offender = 'link_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
        end
   end
elseif links == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif links == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم طردك', 0, "html")
          end
elseif links == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم كتمك', 0, "html")
       end
   end
end
local tag_caption = msg.media.caption:match("@")("#")("/")("!")
if tag_caption then
if tags == "بالتحذير" then
  local offender = 'tag_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
        end
   end
elseif tags == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif tags == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم طردك', 0, "html")
          end
elseif tags == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم كتمك', 0, "html")
       end
   end
end
if is_filter(msg, msg.media.caption) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
local arabic_caption = msg.media.caption:match("[\216-\219][\128-\191]")
if arabic_caption then
if arabic == "بالتحذير" then
  local offender = 'arabic_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
        end
   end
elseif arabic == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif arabic == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم طردك', 0, "html")
          end
elseif arabic == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم كتمك', 0, "html")
         end
      end
   end
end
if msg.text then
			local _nl, ctrl_chars = string.gsub(msg.text, '%c', '')
        local max_chars = 4000
        if data[tostring(msg.to.id)] then
          if data[tostring(msg.to.id)]['settings']['set_char'] then
            max_chars = tonumber(data[tostring(msg.to.id)]['settings']['set_char'])
          end
        end
			 local _nl, real_digits = string.gsub(msg.text, '%d', '')
			local max_real_digits = tonumber(max_chars) * 50
			local max_len = tonumber(max_chars) * 51
			if string.len(msg.text) > max_len or ctrl_chars > max_chars or real_digits > max_real_digits then
if spam == "بالتحذير" then
  local offender = 'spam_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الكلايش مقفول هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الكلايش مقفول هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الكلايش مقفول هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الكلايش مقفول هنا', 0, "html")
        end
   end
elseif spam == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif spam == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الكلايش مقفول تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '<i>Spam message not allowed here</i>\n<i>User</i> '..user_name..' '..user..' <i>has been kicked because of spam message</i>', 0, "html")
          end
elseif spam == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع ارسال الكلايش مقفول تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع ارسال الكلايش مقفول تم كتمك', 0, "html")
          end
       end
   end
local link_msg = msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/")
if link_msg then
if links == "بالتحذير" then
  local offender = 'link_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
     elseif not lang then
          tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط هنا', 0, "html")
        end
   end
elseif links == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif links == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم طردك', 0, "html")
          end
elseif links == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الروابط تم كتمك', 0, "html")
       end
   end
end
local tag_msg = msg.text:match("@")
if tag_msg then
if tags == "بالتحذير" then
  local offender = 'tag_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات هنا', 0, "html")
        end
   end
elseif tags == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif tags == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم طردك', 0, "html")
          end
elseif tags == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المعرفات تم كتمك', 0, "html")
       end
   end
end
if is_filter(msg, msg.text) then
 if is_channel then
 del_msg(chat, tonumber(msg.id))
  elseif is_chat then
kick_user(user, chat)
      end
    end
local arabic_msg = msg.text:match("[\216-\219][\128-\191]")
if arabic_msg then
if arabic == "بالتحذير" then
  local offender = 'arabic_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
     elseif not lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال حروف عربية هنا', 0, "html")
        end
   end
elseif arabic == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif arabic == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم طردك', 0, "html")
          end
elseif arabic == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال العربية تم كتمك', 0, "html")
       end
   end
end
if msg.text:match("(.*)") then
if Ltext == "بالتحذير" then
  local offender = 'text_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله هنا', 0, "html")
        end
   end
elseif Ltext == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif Ltext == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله تم طردك', 0, "html")
     elseif not lang then
tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله تم طردك', 0, "html")
          end
elseif Ltext == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال الدردشه مقفله تم كتمك', 0, "html")
          end
       end
   end
end
if chats == "بالتحذير" then
  local offender = 'chat_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة', 0, "html")
        end
   end
elseif chats == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif chats == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة تم طردك', 0, "html")
          end
elseif chats == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع الارسال المجموعه  مقفلة تم كتمك', 0, "html")
       end
   end
if msg.content_.entities_ and msg.content_.entities_[0] then
    if msg.content_.entities_[0].ID == "MessageEntityMentionName" then
if mentions == "بالتحذير" then
  local offender = 'mention_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن هنا', 0, "html")
        end
   end
elseif mentions == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif mentions == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال المنشن تم طردك', 0, "html")
          end
elseif mentions == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع ارسال المنشن تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | •️ ممنوع ارسال المنشن تم كتمك', 0, "html")
       end
   end
end
  if msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then
if webpages == "بالتحذير" then
  local offender = 'webpage_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع هنا', 0, "html")
        end
   end
elseif webpages == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif webpages == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع تم طردك', 0, "html")
          end
elseif webpages == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال روابط المواقع تم كتمك', 0, "html")
       end
   end
end
  if msg.content_.entities_[0].ID == "MessageEntityBold" or msg.content_.entities_[0].ID == "MessageEntityCode" or msg.content_.entities_[0].ID == "MessageEntityPre" or msg.content_.entities_[0].ID == "MessageEntityItalic" then
if markdowns == "بالتحذير" then
  local offender = 'markdown_offender:'..msg.to.id
  local is_offender = redis:sismember(offender, msg.from.id)
  if is_offender then
 del_msg(chat, tonumber(msg.id))
redis:srem(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون هنا', 0, "html")
          end
  elseif not is_offender then
 del_msg(chat, tonumber(msg.id))
redis:sadd(offender, user)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون هنا', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '?? | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون هنا', 0, "html")
        end
   end
elseif markdowns == "بالحذف" then
 del_msg(chat, tonumber(msg.id))
elseif markdowns == "بالطرد" then
del_msg(chat, tonumber(msg.id))
 kick_user(user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون تم طردك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون تم طردك', 0, "html")
          end
elseif markdowns == "بالكتم" then
del_msg(chat, tonumber(msg.id))
 silent_user(username, user, chat)
    if lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون تم كتمك', 0, "html")
     elseif not lang then
     tdcli.sendMessage(msg.to.id, msg.id, 0, '📮 | • العضو : '..user_name..' \n📮 | • الايدي : '..user..'\n📮 | • ممنوع ارسال الماركداون تم كتمك', 0, "html")
          end
       end
    end
 end
if msg.to.type ~= 'pv' and not is_mod(msg) and not msg.adduser and msg.from.id ~= our_id and not is_whitelist(msg.from.id, msg.to.id) then
  if msg.from.id then
    local hash = 'user:'..user..':msgs'
    local msgs = tonumber(redis:get(hash) or 0)
        local NUM_MSG_MAX = 5
        if data[tostring(chat)] then
          if data[tostring(chat)]['settings']['num_msg_max'] then
            NUM_MSG_MAX = tonumber(data[tostring(chat)]['settings']['num_msg_max'])
          end
        end
    if msgs > NUM_MSG_MAX then
     anti_flood(msg)
    end
    redis:setex(hash, TIME_CHECK, msgs+1)
               end
           end
      end
   end
  
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local hash = "gp_lang:"..msg.to.id 
local lang = redis:get(hash) 
local data = load_data(_config.moderation.data) 
chat = msg.to.id 
user = msg.from.id 
   if msg.to.type ~= 'pv' then 

if ((matches[1] == "قفل" and not Clang) or (matches[1] == "قفل" and Clang)) and is_mod(msg) then 
local target = msg.to.id 
if ((matches[2] == "البوتات" and not Clang) or (matches[2] == "البوتات" and Clang)) then 
return lock_bots(msg, data, target) 
end 
if ((matches[2] == "التثبيت" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then 
return lock_pin(msg, data, target) 
end 
if ((matches[2] == "الدخول" and not Clang) or (matches[2] == "الاعضاء" and Clang)) then 
return lock_join(msg, data, target) 
end 
if ((matches[2] == "الاشعارات" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then 
return lock_tgservice(msg ,data, target) 
end 
end 

if ((matches[1] == "فتح" and not Clang) or (matches[1] == "فتح" and Clang)) and is_mod(msg) then 
local target = msg.to.id 
if ((matches[2] == "البوتات" and not Clang) or (matches[2] == "البوتات" and Clang)) then 
return unlock_bots(msg, data, target) 
end 
if ((matches[2] == "التثبيت" and not Clang) or (matches[2] == "التثبيت" and Clang)) and is_owner(msg) then 
return unlock_pin(msg, data, target) 
end 
if ((matches[2] == "الدخول" and not Clang) or (matches[2] == "الاعضاء" and Clang)) then 
return unlock_join(msg, data, target) 
end 
if ((matches[2] == "الاشعارات" and not Clang) or (matches[2] == "الاشعارات" and Clang)) then 
return unlock_tgservice(msg ,data, target)  
end 
end
end
end
end
end
return { 
description = "Plugin to manage other plugins. Enable, disable or reload.", 
  usage = { 
      moderator = { 
          "!plug disable [plugin] chat : disable plugin only this chat.", 
          "!plug enable [plugin] chat : enable plugin only this chat.", 
          }, 
      sudo = { 
          "!plist : list all plugins.", 
          "!pl + [plugin] : enable plugin.", 
          "!pl - [plugin] : disable plugin.", 
          "!pl * : reloads all plugins." }, 
          }, 
patterns ={ 
	"^(رد حذف للمجموعه)(.*)$",
	"^(رد) (حذف للكل) (.*)$", 
	"^(حذف) (.*)$",
	"^(تفعيل)$", 
"^(تعطيل)$", 
"^(تحديث)$",
"^(توجيه) (.*)$",
"^(تثبيت)$", 
'^(تشغيل) (.*)$',
'^(تنظيف) (.*)$', 
"^(ترجمه) ([^%s]+) (.*)$",
"^(تعديل) (.*)$",
"^(تعديل) (.*)$",
"^(تحويل صوره)$",
"^(تحويل ملصق)$",
"^(تنزيل مطور)$", 
"^(تنزيل مطور) (.*)$", 
"^(تنزيل مدير)$", 
"^(تنزيل مدير) (.*)$", 
"^(تنزيل ادمن)$", 
"^(تنزيل ادمن) (.*)$", 
"^(ت)(فعيل ملف) ([%w_%.%-]+)$", 
"^(ت)(عطيل ملف) ([%w_%.%-]+)$", 
"^(ت)(فعيل ملف) ([%w_%.%-]+) (chat)", 
"^(ت)(عطيل ملف) ([%w_%.%-]+) (chat)", 
"^(ت) (.*)$", 
"^(ضع لغه) (.*)$", 
"^(رفع مطور)$", 
"^(المطورين)$", 
"^(رفع مطور) (.*)$", 
"^(غادر)$", 
"^(ت) (.*)$", 
"^(المجموعات)$", 
"^(حاله المغادره)$", 
"^(دخول) (.*)$", 
"^(ضع اسم البوت) (.*)$", 
"^(ت)(.*)$", 
"^(راسل) (%d+) (.*)$", 
"^(ايدي)$", 
"^(ايدي) (.*)$", 
"^(الغاء التثبيت)$", 
"^(معلومات المجموعه)$", 
"^(test)$", 
"^(رفع مدير)$", 
"^(رفع مدير) (.*)$", 
"^(رفع ادمن)$", 
"^(رفع ادمن) (.*)$", 
"^(قفل) (.*)$", 
"^(فتح) (.*)$", 
"^(الاعدادات)$", 
"^(قفل) (.*)$", 
"^(فتح) (.*)$", 
"^(الرابط)$", 
"^(ضع رابط)$", 
'^(ضع رابط) ([https?://w]*.?telegram.me/joinchat/%S+)$', 
'^(ضع رابط) ([https?://w]*.?t.me/joinchat/%S+)$', 
"^(رابط جديد)$", 
"^(القوانين)$", 
"^(ضع قوانين) (.*)$", 
"^(الوصف)$", 
"^(ضع وصف) (.*)$", 
"^(ضع اسم) (.*)$", 
"^(مسح) (.*)$", 
"^(ضع تكرار) (%d+)$", 
"^(ضع وقت التكرار) (%d+)$", 
"^(res) (.*)$", 
"^(whois) (%d+)$", 
"^(ضع لغه) (.*)$", 
"^(منع) (.*)$", 
"^(الغاء منع) (.*)$", 
"^(قائمه المنع)$", 
"^([https?://w]*.?t.me/joinchat/%S+)$", 
"^([https?://w]*.?telegram.me/joinchat/%S+)$", 
"^(ضع ترحيب) (.*)", 
"^(الترحيب) (.*)$", 
"^(موقعي)$",
"^(ملصق) (.*)$",
"^(متحركه) (.*)$",
"^(زخرفه) (.*)$",
"^(زخرف عربي) (.*)$",
"^(صوره) (.*)$",
'^(معلوماتي)$',
'^(مكاني)$',
"^(حذف رسائلي)$",
"^(الردود)$", 
"^(رد) (اضف للكل) ([^%s]+) (.+)$", 
"^(مسح) (الردود)$", 
"^(رد اضف للمجموعه) (.*) (.*)$",
'^(lock selph)$',
'^(unlock selph)$',
'^(قفل السيلفي)$',
'^(فتح السيلفي)$',
"^(gid)$",
"^(ايدي)$",
"^(اسمي)$",
"^(معرفي)$",
"^(رسايلي)$",
"^(رسائلي)$",
"^(الحساب) (.*)$",
"^(جلب صوره) (.*)$",
"^(موقعي)$",
"^(stephbot)$",
"^(reset)$",
"^(اعدادات البوت)$",
"^(سورس)$",
"^(ضع كليشه المطور) (.*)$", 
"^(المطور)$",
"^ضع كليشه المطور$",
"^المطور$", 
"^احذف كليشه المطور$",
'^(ايقاف) (.*)$',
"^([Ff]wd) (.*)$",
'^(مسح) (.*)$', 
"^(رسائلي)$",
"^(رسايلي)$",
"^(الترحيب)$",
"^([Cc]leanmember)$",
"^(طرد الكل)$",
"^[Pp][Ll][Uu][Gg][Ii][Nn] (.+) (.*)$",
"^([Ii][Nn][Ff][Oo])$", 
"^(جلب صوره) (%d+)$", 
"^(شغال)", 
"^(تيست)", 
"^(صوره) (.*)$",
"^(ملصق) (.*)$",
"^(ترجمه) ([^%s]+) (.*)$",
"^(زخرفه) (.*)$",
"^(زخرف) (.*)$",
"^(صوره) (.+)$",                       
"^(ملصق) (.+)$",
"^(متحركه) (.*)$",
"^(كول) (.*)$",	
"^(اذاعه) (.*)$",
'^(معلومات) (.*)$', 
'^(معلوماته) (%d+)$',
"^(الرتبه) (.*)$", 
"^(الرتبه)$", 
"^(رابط الحذف)$", 
"^(الاوامر)$", 
"^(م1)$", 
"^(م2)$", 
"^(م3)$", 
"^(م4)$", 
"^(م5)$", 
"^(م6)$", 
"^(القرائه) (.*)$",
'^[Cc][Pp][Uu]$', 
"^([Pp]list)$",
"^([Pp]l) (+) ([%w_%.%-]+)$",
"^([Pp]l) (-) ([%w_%.%-]+)$",
"^([Pp]l) (+) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (-) ([%w_%.%-]+) (chat)$",
"^([Pp]l) (*)$",
"^([Rr]eload)$",
	"^(الملفات)$",
"^(.*)$",
   
}, 
run=run, 
pre_process = pre_process 
} 

