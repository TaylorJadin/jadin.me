#!/bin/bash

# Requires jq (get from package manager) and jwt-cli (get from npm)

# Configuration
API_URL="https://jadin-me.us.reclaim.cloud/ghost/api/v3/admin/posts/"
UPLOAD_URL="https://jadin-me.us.reclaim.cloud/ghost/api/v3/admin/images/upload/"
ADMIN_API_KEY="$1"
MARKDOWN_FILE_PATH="$2"

# Function to create a JWT for Ghost API authentication
create_jwt() {
  local id secret iat header payload
  id=$(echo $ADMIN_API_KEY | cut -d ':' -f 1)
  secret=$(echo $ADMIN_API_KEY | cut -d ':' -f 2)
  iat=$(date +%s)
  header="{\"alg\":\"HS256\",\"typ\":\"JWT\",\"kid\":\"$id\"}"
  payload="{\"iat\":$iat,\"exp\":$(($iat + 300)),\"aud\":\"/v3/admin/\"}"
  echo $(echo -n "$header.$payload" | jwt -s $secret)
}

# Function to upload an image to Ghost
upload_image() {
  local image_path=$1
  local response
  response=$(curl -s -X POST -H "Authorization: Ghost $TOKEN" -F "file=@$image_path" $UPLOAD_URL)
  echo $response | jq -r '.images[0].url'
}

# Function to process images in the Markdown content
process_images() {
  local content=$1
  local image_paths=($(grep -oP '!\[.*?\]\(\K.*?(?=\))' <<< "$content"))
  local image_map=()
  for image_path in "${image_paths[@]}"; do
    if [[ -f $image_path ]]; then
      image_url=$(upload_image $image_path)
      if [[ $image_url != null ]]; then
        image_map+=("$image_path=$image_url")
      fi
    fi
  done
  for mapping in "${image_map[@]}"; do
    local_path=$(echo $mapping | cut -d '=' -f 1)
    url=$(echo $mapping | cut -d '=' -f 2)
    content=$(sed "s|$local_path|$url|g" <<< "$content")
  done
  echo "$content"
}

# Read the content of the Markdown file
MARKDOWN_CONTENT=$(cat "$MARKDOWN_FILE_PATH")

# Create the JWT token
TOKEN=$(create_jwt)

# Process and upload images
PROCESSED_CONTENT=$(process_images "$MARKDOWN_CONTENT")

# Prepare the post data
POST_DATA=$(jq -n --arg title "Your Post Title" --arg markdown "$PROCESSED_CONTENT" '{posts: [{title: $title, markdown: $markdown, status: "published"}]}')

# Make the request to publish the post
RESPONSE=$(curl -s -X POST -H "Authorization: Ghost $TOKEN" -H "Content-Type: application/json" -d "$POST_DATA" $API_URL)

# Check the response
if [[ $(echo $RESPONSE | jq -r '.posts[0].id') ]]; then
  echo "Post published successfully!"
else
  echo "Failed to publish post: $RESPONSE"
fi