# YaMDb   ![example workflow](https://github.com/Hash466/yamdb_final/actions/workflows/yamdb_workflow.yml/badge.svg)
  
**Проект YaMDb собирает отзывы (Review) пользователей на произведения (Titles).   
Произведения делятся на категории: «Книги», «Фильмы», «Музыка».   
Список категорий (Category) может быть расширен администратором.**

### Стек используемых технологий:

- Python 3;
- Django 3;
- Django REST framework 3;
- PostgreSQL 12;
- NGINX;
- Gunicorn 20;



### Запуск проекта:  
  
Для запуска проекта на хосте необходимо установить Docker ([ссылка на документацию](https://www.docker.com/products/docker-desktop))

Стянуть проект с репозитория командой:
```bash
git clone https://github.com/Hash466/infra_sp2.git
```

#### В корневой директории проекта необходимо в файле ".env" указать свой пароль для доступа к БД:
- DB_ENGINE=используемая_база_данных
- DB_NAME=имя_базы_данных
- POSTGRES_USER=имя_пользователя_базы_данных
- POSTGRES_PASSWORD=пароль_пользователя_базы_данных
- DB_HOST=имя_контейнера_с_базой_данных
- DB_PORT=порт_базы_данных
- SECRET_KEY=секретный_ключ
- DEBUG_STATUS=режим_разработки
- ALLOWED_HOSTS=перечень_IP_для_доступа

Затем выполнить команду:
```bash
docker-compose up -d --build
```

После запуска проекта необходимо применить миграции, создать суперпользователя и собрать статику

### Применение миграций, создание суперпользователя и сбор статики:

При запущенном приложении выполнить:
```bash
docker-compose exec web python manage.py migrate --noinput
docker-compose exec web python manage.py createsuperuser
docker-compose exec web python manage.py collectstatic --no-input
```

### Алгоритм регистрации пользователей:  
  
- Пользователь отправляет POST-запрос на добавление нового пользователя с параметрами email и username на эндпоинт /api/v1/auth/signup/.  
- YaMDB отправляет письмо с кодом подтверждения (confirmation_code) на адрес email.  
- Пользователь отправляет POST-запрос с параметрами username и confirmation_code на эндпоинт /api/v1/auth/token/, в ответе на запрос ему приходит token (JWT-токен).  
- При желании пользователь отправляет PATCH-запрос на эндпоинт /api/v1/users/me/ и заполняет поля в своём профайле (описание полей — в документации).  


### Пользовательские роли:  
  
- **Аноним** — может просматривать описания произведений, читать отзывы и комментарии.  
- **Аутентифицированный пользователь (user)** — может, как и Аноним, читать всё, дополнительно он может публиковать отзывы и ставить оценку произведениям (фильмам/книгам/песенкам), может комментировать чужие отзывы; может редактировать и удалять свои отзывы и комментарии. Эта роль присваивается по умолчанию каждому новому пользователю.  
- **Модератор (moderator)** — те же права, что и у Аутентифицированного пользователя плюс право удалять любые отзывы и комментарии.  
- **Администратор (admin)** — полные права на управление всем контентом проекта. Может создавать и удалять произведения, категории и жанры. Может назначать роли пользователям.  
- **Суперюзер Django** — обладет правами администратора (admin)


### Для работы с приложением доступна документация по следующей http://127.0.0.1/redoc/ после запуска приложения



### Автор проекта:
- Виталий Казаков;




#### [Развёрнутое приложение (демо)](http://practicum.tech/redoc/)