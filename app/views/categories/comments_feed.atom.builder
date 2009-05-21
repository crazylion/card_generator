atom_feed do |feed|
  feed.title(@category.title)
  feed.updated((@comments.first.created_at))
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