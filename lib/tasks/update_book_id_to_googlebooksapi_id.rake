namespace :update_book_id_to_googlebooksapi_id do
  desc 'likesテーブルのbook_idカラムをGoogle Books APIのIDに変更する'
  task update: :environment do
    # 冪等性は考えていないため、注意！

    Like.transaction do
      Like.all.each do |like|
        googlebooksapi_id = like.book.googlebooksapi_id
        like.update!(book_id: googlebooksapi_id)
        puts "#{googlebooksapi_id} has changed!"
      end
    end

    Question.transaction do
      Question.all.each do |question|
        googlebooksapi_id = question.book.googlebooksapi_id
        question.update!(book_id: googlebooksapi_id)
        puts "#{googlebooksapi_id} has changed!"
      end
    end
  end
end
