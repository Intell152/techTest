
# Minsait TechTest

Technical test project for Minsait: a mobile application developed in Flutter as part of the selection process.


## Authors

- [@Jesús Angel Sosa Hernández](https://github.com/Intell152)


## API Reference

#### Get now_playing movies

```http
  GET 3/movie/now_playing
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |

#### Get top_rated movies

```http
  GET 3/movie/top_rated
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key        |


#### Get upcoming movies

```http
  GET 3/movie/upcoming
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key` | `string` | **Required**. Your API key        |

#### add(num1, num2)


#### Get id movie details

```http
  GET 3/movie/${id}/credits
```

| Parameter | Type     | Description                        |
| :-------- | :------- | :--------------------------------  |
| `id`      | `string` | **Required**. Id of movie to fetch |


## Documentation

The architecture used is Clean Architecture since the components are organized in layers that represent different levels of abstraction and responsibilities.

Proyect Structure:
/src
|-- blocs
    |-- map
    |-- movies
    |-- profile
|-- l10n
|-- models
    |-- actor
    |-- movie
    |-- user
|-- pages
    |-- main_page.dart
    |-- movie_details_page.dart
    |-- pages.dart
|-- routes
|-- services
    |-- actor_service.dart
    |-- movie_service.dart
    |-- user_service.dart
    |-- service_locator.dar
    |-- isar.dar
    |-- services.dar
|-- theme
|-- views
    |-- map_view.dart
    |-- movies_view.dart
    |-- profile_view.dart
    |-- qr_scanner_view.dart
    |-- views.dart
|-- widgets
    |-- card_carouser.dart
    |-- custom_field_button.dart
    |-- custom_text_field.dart
    |-- movie_card_swiper.dart
    |-- movie_slider.dart
    |-- review_item.dart
    |-- widgets.dart
|-- main


For the need for data persistence, I opted for Isar since it is an easy-to-manipulate NoSQL DB designed to work in Flutter.

[isar DB](https://pub.dev/packages/isar)

Each view was considered as an independent bloc, so a Bloc or Cubit was created to manage the state in each of the views.

[Flutter_bloc ](https://pub.dev/packages/flutter_bloc)




## Use Explanation

Initial view with Bottom Navigation Bar, here we can see the now playing movies, the top rated and Upcoming movies, we can Tap to see the details of the selected movie.

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/MoviesView.png)

This is a page, on this we can see the main details of the selected movie.

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/MovieDetailsPage.png)

The Map view shows 3 locations by default (Anthropology Museum, Soumaya and Fine Arts), but has the option to read a QR with format 19.2740801, -99.7020265456915 and mark the new location on the map.

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/MapView.png)

QR Lector view.

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/QRscanner.png)

In the Profile view we can edit the information and add reviews, it has its Sliver Barr and accepts as many Reviews as you want.

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/ProfileView.png)

Add Review view

![Movies View](https://raw.githubusercontent.com/Intell152/techTest/8dd85bed879eab8dc852e6f4389968571f28e5eb/AddReview.png)