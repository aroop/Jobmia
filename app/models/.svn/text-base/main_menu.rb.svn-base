class MainMenu
  
  attr_accessor :children, :name, :options, :visible
  
  def initialize(name, options = {}, &block)
    @children = []
    @name = name
    @options = options
    @visible = true
    yield(self) if block_given?
  end
  
  def add_child(item, &block)
    yield(item) if block_given?
    @children << item
  end
  
  def has_children?
    @children.length > 0        
  end    
    
  def is_selected?(options = {})
    return true if @options[:controller] == options[:controller] && @options[:action] == options[:action] 
    for child in @children
      return true if child.is_selected?(options)
    end    
    false
  end
  
  def is_controller_selected?(options = {})
    return true if @options[:controller] == options[:controller]
    for child in @children
      return true if child.is_controller_selected?(options)
    end
    false  	
  end

end