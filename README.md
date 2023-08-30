# Avito

### Общее описание приложения:
Приложение для iOS, состоит из двух экранов:

- Список товаров, данный экран будет стартовым.
- Детальная карточка товара, будет открываться по нажатию на элемент в списке товаров.

### Реализована следующая логика:
У каждого экрана может быть три состояния: 
- Отображение ошибки
![Simulator Screenshot - iPhone 14 Pro - 2023-08-30 at 10 58 36](https://github.com/unnamed082/avito/assets/49235559/936f56ce-4915-43a6-91fe-59653547d16e)
- Состояние загрузки
![Simulator Screenshot - iPhone 14 Pro - 2023-08-30 at 10 57 36](https://github.com/unnamed082/avito/assets/49235559/f72dae60-fc8c-43e8-b3e9-8714650e732d)
- Отображение контента из JSON файла
![Simulator Screenshot - iPhone 14 Pro - 2023-08-30 at 10 50 45](https://github.com/unnamed082/avito/assets/49235559/45e15ee2-d918-4697-8850-618770efe61e)
![Simulator Screenshot - iPhone 14 Pro - 2023-08-30 at 11 00 25](https://github.com/unnamed082/avito/assets/49235559/9e212537-550a-4ba3-ac72-2f75e4f1cd6b)


Внешний вид приложения релизовывался с дизайном из приложение Авито.
Для каждого экрана сделала загрузка данных в формате JSON из интернета:
- https://www.avito.st/s/interns-ios/main-page.json
    - URL для запроса на главном экране.
- https://www.avito.st/s/interns-ios/details/{itemId}.json
    - URL для запроса на детальной странице. ID берется из данных для главного экрана. 
    - Пример ссылки: https://www.avito.st/s/interns-ios/details/1.json


### Доп функционал
1. На экраны добавлены refreshControl-ы для повторной попытки получить данные при возникновении ошибок
2. На экране с детальной информацией добавлена возможность выполнить вызов по номеру или направить письмо на указанный email (необходимо кликнуть на элементы(
![IMG_2557](https://github.com/unnamed082/avito/assets/49235559/d393207c-b5e0-4c24-9d4a-0b4e91618e70)
