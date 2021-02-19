# json.array! @items, :id, :name, :detail
json.array! @items do |item|
  json.id item.id
  json.name  item.name
  json.detail item.detail
  json.image item.images[0]&.src&.url
end