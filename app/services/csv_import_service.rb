require 'csv'

class CsvImportService
  def initialize(file)
    @file = file
  end

  def call
    CSV.foreach(@file.path, headers: true) do |row|
      post = Post.new(title: row['Title'], description: row['Description'])
      post.save!
    end
  end
end
