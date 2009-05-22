atom_feed do |feed|
  feed.title(@category.title)
  if !@comments.nil? and @comments.first
    feed.updated((@comments.first.created_at))
  else
    # feed.updated
  end
  feed.url("")
      for comment in @comments
        card =Card.find(comment.commentable_id)
        feed.entry(comment,{:url=> card_path(card)}) do |entry|
          # entry.url(card_url)
          #find card
          
        entry.title("Re: "+card.title)
        content = simple_format(comment.comment)
        entry.content(content,:type=>'html')
        entry.author do |author|
        author.name(comment.user.login)
      end
    end
  end
end