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
  
  def save_meta_markdown
    h={
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
    File.open(story_path, 'w'){|f| f.write content} 
    process_drb   
  end
  
  def process_drb
    puts __method__
  end
  
  def save_pdf
    puts __method__
  end
  
  def save_layout_yml
    
  end
end
