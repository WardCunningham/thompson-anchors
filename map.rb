# construct a map based on anchors in export.json
# ruby map.rb

require 'json'

@export = JSON.parse File.read('export.json', :encoding => 'utf-8')
@dot = []

def note string
  STDERR.puts string
end

def slug title
  title.gsub(/\s/, '-').gsub(/[^A-Za-z0-9-]/, '').downcase()
end

def link
  @export.each do |slug, json|
    json['links'] = here = {}
    json['story'].each do |item|
      next unless ['paragraph','markdown'].include? item['type']
      item['text'].scan(/\[\[(.+?)\]\]/).each do |title, *rest|
        slug = slug(title)
        next unless page = @export[slug]
        here[slug] = page['title']
      end
    end
  end
end

def quote string
  "\"#{string.gsub(/ /,'\n')}\""
end

def url title
  slug = slug title
  url = "https://thompson.wiki.innovateoregon.org/view/#{slug title}"
  "\"#{url}\""
end


def plot page
  return if page.nil?
  @dot << "#{from = quote page['title']} [fillcolor=gold URL=#{url page['title']}]"
  page['links'].each do |slug, title|
    to = quote @export[slug]['title']
    @dot << "#{to} [URL=#{url title}]"
    @dot << "#{from} -> #{to}"
  end
end

link

note "#{@export.size} pages"
note "#{@export.select{|k,v|not v['links'].empty?}.size} with links"

seeds =['Learning Cycles','Pattern Languages','Agile Mindset',
  'Dialectical Synthesis','Agile Learning','Evangelist','Higher Purpose',
  'Eureka Moments','Scrum','Learning Journal','Flow State',
  'Prime Pattern','Make-a-thon','Innovators','Innovate Oregon','Essence of Agile',
  'Wholehearted Commitment','Curiosity','Core Values','Collective Flow',
  'Cartesian Mindset','Audacious Aspiration','Agile Partnership Program']

seeds.each do |seed|
  plot @export[slug(seed)]
end

File.open('map.dot','w') do |file|
  file.puts "digraph { node [shape=box style=filled fillcolor=palegreen] rankdir=LR #{@dot.join "\n"}}"
end

`dot -Tsvg map.dot > map.svg`
