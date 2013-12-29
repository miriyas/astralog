admin = User.create(nickname: "MIRiyA", email: "miriya.lee@gmail.com", password: 1111, password_confirmation: 1111, role: "admin")
user = User.create(nickname: "user", email: "user@gmail.com", password: 1111, password_confirmation: 1111)

subject1 = Subject.create(style: "blog", name: "IT & UX")
subject2 = Subject.create(style: "blog", name: "개발 이야기")

t1c1 = Category.create(subject_id: subject1.id, role: "category", name: "모바일 HW 이야기", view_type: "list", position: 1)
t1c2 = Category.create(subject_id: subject1.id, role: "category", name: "카메라 이야기", view_type: "summary", position: 2)
t1c3 = Category.create(subject_id: subject1.id, role: "category", name: "삼성", view_type: "show", position: 2)

category1 = Category.create(subject_id: subject1.id, role: "category", name: "루비 온 레일즈", view_type: "list", position: 1)
category1 = Category.create(subject_id: subject1.id, role: "category", name: "루비 온 레일즈", view_type: "list", position: 1)
category1 = Category.create(subject_id: subject1.id, role: "category", name: "루비 온 레일즈", view_type: "list", position: 1)


# 
# post1 = Post.create(category_id: 1, user_id: admin.id, title: "테스트용 글 1", body: "글 내용 ㅇㄹㅇㄴㄹㅇㄴㄹㅁㄴ")
