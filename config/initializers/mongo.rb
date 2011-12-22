MongoMapper.config = { 
  Rails.env => { 
    'uri' => ENV['MONGOHQ_URL'] || "mongodb://localhost/annotations_#{Rails.env}"
  } 
}

MongoMapper.connect(Rails.env)

