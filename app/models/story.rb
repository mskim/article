class Story < ActiveRecord::Base
  attr_accessible :author, :body, :published_on, :subtitle, :title
  
  def path
    "#{Rails.root}/public/stories"
  end
  
  def pdf_path
    "#{Rails.root}/public/stories/#{id}.pdf"
  end
  
  def image_path
    "#{Rails.root}/public/stories/#{id}.jpg"
  end
  
  def story_path
    "#{Rails.root}/public/stories/#{id}.md"
  end
  
  def setup
    system("mkdir -p #{path}") unless File.exists?(path)
  end
  
  def tempalte_path
    "#{Rails.root}/public/template/1.pdf"
  end
  
  def output_path
    "#{Rails.root}/public/stories/#{id}.pdf"
  end
  
  def save_meta_markdown
    File.open(story_path, 'w'){|f| f.write meta_markdown} 
  end
  
  def meta_markdown
    h={
      :template     => tempalte_path,
      :output_path  => output_path,
      :type         => "article",
      :title        => title,
      :author       => author,
      :subtitle     => subtitle,
      :published_on => published_on
    }
    content = h.to_yaml
    content += "---\n"
    content += "\n\n\n"
    content +=body
    content
  end
  
  def process_drb
    puts __method__
    @layout_server = @layout_server || DRbObject.new_with_uri("druby://127.0.0.1:12345")
    puts @layout_server.process_magazine_article(meta_markdown)    
  end

end
