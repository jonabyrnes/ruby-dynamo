scheduler = Rufus::Scheduler.new
scheduler.every("10s") do
  @articles = Article.all
  @articles.each do |article|
    puts "#{article.title} | #{article.text}"
  end
end