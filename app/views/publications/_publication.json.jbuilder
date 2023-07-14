json.extract! publication, :id, :title, :description, :user_id, :created_at, :updated_at
json.url publication_url(publication, format: :json)
