atom_feed do |feed|
  feed.title(@category.title)
  feed.updated((@cards.last.created_at))
  
      for card in @cards
        feed.entry(card) do |entry|
        entry.title(card.title)
        content = image_tag card.cover.url(:A6)
        if card.back.file?
          content += image_tag card.back.url(:A6)
        end
        content+=simple_format(card.desc)
        entry.content(content,:type=>'html')
        entry.author do |author|
        author.name(card.user.login)
      end
    end
  end
end