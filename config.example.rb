require 'omnigollum'
require 'omniauth-ldap'

# ----- config -----
wiki_options = {
  :port => 3000,
  :allow_uploads => true,
  :per_page_uploads => true,
  :follow_renames => false,
  :display_metadata => false,
  :css => true,
  :h1_title => true,
  :emoji => true,
}
Precious::App.set(:wiki_options, wiki_options)

# If present, undefine the :FORMAT_NAMES constant to avoid the 
# "already initialized constant FORMAT_NAMES" warning
#Gollum::Page.send :remove_const, :FORMAT_NAMES if defined? Gollum::Page::FORMAT_NAMES
# Redefine the :FORMAT_NAMES constant to limit the available
# formats on the editor to only markdown
#Gollum::Page::FORMAT_NAMES = { :markdown  => "Markdown" }

# ----- auth -----
auth_options = {
  # OmniAuth::Builder block is passed as a proc
  :providers => Proc.new do
    provider :ldap,
        :title => 'Identification',
        :host => 'ldap.com',
        :port => 389,
        :uid  => 'cn',
        :method   => :plain,
        :base => 'dc=example'
  end,                                                                                                                                  
  :authorized_users => nil,                                                                                                             
  :dummy_auth => false,                                                                                                                 
  # If you want to make pages private:                                                                                                  
  # :protected_routes => ['/*'],                                                                                                  
                                                                                                                                        
  # Specify committer name as just the user name                                                                                        
  :author_format => Proc.new { |user| user.name },                                                                                      
  # Specify committer e-mail as just the user e-mail                                                                                    
  :author_email => Proc.new { |user| user.email }                                                                                       
}                                                                                                                                       
                                                                                                                                        
# Precious::App.enable :session                                                                                                         
Precious::App.set(:omnigollum, auth_options)                                                                                            
Precious::App.register Omnigollum::Sinatra                                                                                              

# ----- misc config -----
GitHub::Markup::Markdown::MARKDOWN_GEMS['kramdown'] = proc { |content|
  Kramdown::Document.new(content, 
    :input => "GFM", 
    :auto_ids => false, 
    :math_engine => nil, 
    :smart_quotes => ["'", "'", '"', '"'].map{|char| char.codepoints.first}).to_html
} # This shows the defaults options for kramdown (on gollum 5.x), change the options hash to get the desired results.
