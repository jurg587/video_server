# Video Server Challenge
This app is a concept for managing video server rooms and users.

All data is stored in a SQLite database embedded in the application. It is assumed that a user cannot leave a room if they are the host.

## Installation
Before running the application install bundle dependencies using:

    $ bundle install

Setup the database environment using:

    $ rails db:setup

## Usage
To start the server execute:

    $ rails server

This will start a server on http://localhost:3000/

To run the tests execute:

    $ rspec

## API calls
Run the following command to see all available routes:

    $ rails routes

A REST client like postman can be used to connect to the server.

The 'Authorization' header needs to be set for any API call which requires authentication. An Authentication token can be obtained by registering or when a user signs in. The token expires after 24 hours.

## API Documentation

## Rooms [/v1/rooms]


### Get room [GET /v1/rooms/{guid}]

+ Parameters
    + guid: `93835628-3731-4cee-bb26-9cdc665a0089` (string, required)

+ Request gets a room given its guid
**GET**&nbsp;&nbsp;`/v1/rooms/93835628-3731-4cee-bb26-9cdc665a0089`

    + Headers

            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "room": {
                "name": "Ms. Ali Abbott",
                "guid": "93835628-3731-4cee-bb26-9cdc665a0089",
                "capacity_limit": 5,
                "host_user": {
                  "id": 21,
                  "username": "Ollie Wilderman DDS",
                  "mobile_token": "73bce1e9-f325-4150-978c-9fd693b41cab",
                  "created_at": "2020-06-19T06:50:03.436Z",
                  "updated_at": "2020-06-19T06:50:03.436Z"
                },
                "participants": [
                  {
                    "id": 21,
                    "username": "Ollie Wilderman DDS",
                    "mobile_token": "73bce1e9-f325-4150-978c-9fd693b41cab",
                    "created_at": "2020-06-19T06:50:03.436Z",
                    "updated_at": "2020-06-19T06:50:03.436Z"
                  }
                ],
                "created_at": "2020-06-19T06:50:03.426Z",
                "updated_at": "2020-06-19T06:50:03.426Z"
              }
            }

### Create a room [POST /v1/rooms]


+ Request creates a new room for the current user
**POST**&nbsp;&nbsp;`/v1/rooms`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
              "room": {
                "name": "Mrs. Claude Schmidt",
                "guid": "bf500682-2bb4-41ac-930b-010fa64f5f97",
                "capacity_limit": 20
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "room": {
                "name": "Mrs. Claude Schmidt",
                "guid": "a4f54875-9ebf-4d7b-90ea-a65cb297d909",
                "capacity_limit": 20,
                "host_user": {
                  "id": 21,
                  "username": "Sherryl Brakus",
                  "mobile_token": "4f6f684e-4fa3-42ab-bbbc-a426a5e987ed",
                  "created_at": "2020-06-19T06:50:03.457Z",
                  "updated_at": "2020-06-19T06:50:03.457Z"
                },
                "participants": [
                  {
                    "id": 21,
                    "username": "Sherryl Brakus",
                    "mobile_token": "4f6f684e-4fa3-42ab-bbbc-a426a5e987ed",
                    "created_at": "2020-06-19T06:50:03.457Z",
                    "updated_at": "2020-06-19T06:50:03.457Z"
                  }
                ],
                "created_at": "2020-06-19T06:50:03.464Z",
                "updated_at": "2020-06-19T06:50:03.464Z"
              }
            }

### Change the room host [PUT /v1/rooms/change_host]


+ Request changes the host of the room successfully if the current user is the host
**PUT**&nbsp;&nbsp;`/v1/rooms/change_host`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
              "room": {
                "host_user_id": 22
              },
              "guid": "5f2157a7-2ad5-4e09-8c5d-6a7822337949"
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "room": {
                "name": "Shannon Wolf",
                "guid": "5f2157a7-2ad5-4e09-8c5d-6a7822337949",
                "capacity_limit": 5,
                "host_user": {
                  "id": 22,
                  "username": "Kaleigh Keebler",
                  "mobile_token": "4ddc775d-3cb7-441e-8a4f-ae5c95d55f6a",
                  "created_at": "2020-06-19T06:50:03.474Z",
                  "updated_at": "2020-06-19T06:50:03.474Z"
                },
                "participants": [
                  {
                    "id": 21,
                    "username": "Anthony Sipes IV",
                    "mobile_token": "e81cfab8-678f-448a-acc9-0a89b4d9c361",
                    "created_at": "2020-06-19T06:50:03.471Z",
                    "updated_at": "2020-06-19T06:50:03.471Z"
                  },
                  {
                    "id": 22,
                    "username": "Kaleigh Keebler",
                    "mobile_token": "4ddc775d-3cb7-441e-8a4f-ae5c95d55f6a",
                    "created_at": "2020-06-19T06:50:03.474Z",
                    "updated_at": "2020-06-19T06:50:03.474Z"
                  }
                ],
                "created_at": "2020-06-19T06:50:03.469Z",
                "updated_at": "2020-06-19T06:50:03.469Z"
              }
            }

### Join a room [POST /v1/rooms/join]


+ Request joins a room successfully
**POST**&nbsp;&nbsp;`/v1/rooms/join`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
              "guid": "7733e976-a50e-4bf6-85f3-953170287938"
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "room": {
                "name": "Billy Crooks",
                "guid": "7733e976-a50e-4bf6-85f3-953170287938",
                "capacity_limit": 5,
                "host_user": {
                  "id": 22,
                  "username": "Orlando Streich",
                  "mobile_token": "f2b31a5a-5088-40db-9baf-931f7c944ff0",
                  "created_at": "2020-06-19T06:50:03.490Z",
                  "updated_at": "2020-06-19T06:50:03.490Z"
                },
                "participants": [
                  {
                    "id": 22,
                    "username": "Orlando Streich",
                    "mobile_token": "f2b31a5a-5088-40db-9baf-931f7c944ff0",
                    "created_at": "2020-06-19T06:50:03.490Z",
                    "updated_at": "2020-06-19T06:50:03.490Z"
                  },
                  {
                    "id": 21,
                    "username": "Ms. Setsuko VonRueden",
                    "mobile_token": "a211d7eb-6088-40a7-8392-fbb631be9508",
                    "created_at": "2020-06-19T06:50:03.487Z",
                    "updated_at": "2020-06-19T06:50:03.487Z"
                  }
                ],
                "created_at": "2020-06-19T06:50:03.488Z",
                "updated_at": "2020-06-19T06:50:03.488Z"
              }
            }

### Leave a room [DELETE /v1/rooms/leave]


+ Request leaves a room successfully
**DELETE**&nbsp;&nbsp;`/v1/rooms/leave`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
              "guid": "2edd0d6d-2391-4e73-b573-e257b3cf4121"
            }

+ Response 204

    + Body

            {}

### Search rooms given a username [GET /v1/rooms/search]


+ Request gets the user rooms given a certain username
**GET**&nbsp;&nbsp;`/v1/rooms/search?username=Miss Grisel Frami`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "rooms": [
                {
                  "name": "Harris Becker",
                  "guid": "0d010137-0e40-4662-9b32-018b1a8819fb",
                  "capacity_limit": 5,
                  "host_user": {
                    "id": 21,
                    "username": "Miss Grisel Frami",
                    "mobile_token": "3719ab57-bf7f-4217-aef4-d398bf155a7d",
                    "created_at": "2020-06-19T06:50:03.511Z",
                    "updated_at": "2020-06-19T06:50:03.511Z"
                  },
                  "participants": [
                    {
                      "id": 21,
                      "username": "Miss Grisel Frami",
                      "mobile_token": "3719ab57-bf7f-4217-aef4-d398bf155a7d",
                      "created_at": "2020-06-19T06:50:03.511Z",
                      "updated_at": "2020-06-19T06:50:03.511Z"
                    }
                  ],
                  "created_at": "2020-06-19T06:50:03.509Z",
                  "updated_at": "2020-06-19T06:50:03.509Z"
                },
                {
                  "name": "Thomas Ondricka V",
                  "guid": "d3056b9e-8338-4e5c-a0b3-fcb1bf6df0e0",
                  "capacity_limit": 5,
                  "host_user": {
                    "id": 21,
                    "username": "Miss Grisel Frami",
                    "mobile_token": "3719ab57-bf7f-4217-aef4-d398bf155a7d",
                    "created_at": "2020-06-19T06:50:03.511Z",
                    "updated_at": "2020-06-19T06:50:03.511Z"
                  },
                  "participants": [
                    {
                      "id": 21,
                      "username": "Miss Grisel Frami",
                      "mobile_token": "3719ab57-bf7f-4217-aef4-d398bf155a7d",
                      "created_at": "2020-06-19T06:50:03.511Z",
                      "updated_at": "2020-06-19T06:50:03.511Z"
                    }
                  ],
                  "created_at": "2020-06-19T06:50:03.514Z",
                  "updated_at": "2020-06-19T06:50:03.514Z"
                }
              ]
            }


## Users [/v1/users]


### Sign in a user [POST /v1/users/sign_in]


+ Request signs in successfully
**POST**&nbsp;&nbsp;`/v1/users/sign_in`

    + Headers

            Content-Type: application/json

    + Body

            {
              "username": "Dustin Kertzmann",
              "password": "password@123"
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "user": {
                "id": 21,
                "username": "Dustin Kertzmann",
                "mobile_token": "2bd670d0-09ce-45fb-b038-126f46d681d5",
                "created_at": "2020-06-19T06:50:03.530Z",
                "updated_at": "2020-06-19T06:50:03.530Z",
                "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M"
              }
            }

### Register a user [POST /v1/users/register]


+ Request registers successfully
**POST**&nbsp;&nbsp;`/v1/users/register`

    + Headers

            Content-Type: application/json

    + Body

            {
              "user": {
                "username": "Donette Wiegand",
                "password": "password@123",
                "password_confirmation": "password@123",
                "mobile_token": "4ded21e8-6560-413c-ac8e-923fddedce92"
              }
            }

+ Response 201

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "user": {
                "id": 21,
                "username": "Donette Wiegand",
                "mobile_token": "4ded21e8-6560-413c-ac8e-923fddedce92",
                "created_at": "2020-06-19T06:50:03.537Z",
                "updated_at": "2020-06-19T06:50:03.537Z",
                "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M"
              }
            }

### Get users [GET /v1/users]


+ Request gets all users
**GET**&nbsp;&nbsp;`/v1/users`

    + Headers

            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "users": [
                {
                  "id": 19,
                  "username": "Keva Hessel",
                  "mobile_token": "3dacb950-6bac-4e53-a9ee-cb62ae87acfc",
                  "created_at": "2020-06-18T20:46:57.390Z",
                  "updated_at": "2020-06-18T20:46:57.390Z"
                },
                {
                  "id": 20,
                  "username": "Ian Corwin",
                  "mobile_token": "035dea25-be06-4454-b2d7-dafb611e8b07",
                  "created_at": "2020-06-18T21:01:56.580Z",
                  "updated_at": "2020-06-18T21:01:56.580Z"
                },
                {
                  "id": 21,
                  "username": "Dee Littel",
                  "mobile_token": "41fc9d02-c28e-409d-ae2b-fefdb0d73523",
                  "created_at": "2020-06-19T06:50:03.540Z",
                  "updated_at": "2020-06-19T06:50:03.540Z"
                },
                {
                  "id": 22,
                  "username": "Keven Corwin",
                  "mobile_token": "b01330ac-aa6e-4214-91cc-f715b52db18a",
                  "created_at": "2020-06-19T06:50:03.542Z",
                  "updated_at": "2020-06-19T06:50:03.542Z"
                }
              ]
            }

+ Request gets a user with a certain username
**GET**&nbsp;&nbsp;`/v1/users?username=Ricky Kohler`

    + Headers

            Content-Type: application/json

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "users": [
                {
                  "id": 22,
                  "username": "Ricky Kohler",
                  "mobile_token": "b31df52b-15ac-4049-b48f-82bca4754df8",
                  "created_at": "2020-06-19T06:50:03.551Z",
                  "updated_at": "2020-06-19T06:50:03.551Z"
                }
              ]
            }

### Update a user [PUT /v1/users]


+ Request updates the user successfully
**PUT**&nbsp;&nbsp;`/v1/users`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
              "user": {
                "mobile_token": "123",
                "password": "123",
                "password_confirmation": "123"
              }
            }

+ Response 200

    + Headers

            Content-Type: application/json; charset=utf-8

    + Body

            {
              "user": {
                "id": 21,
                "username": "Amiee Hoppe",
                "mobile_token": "123",
                "created_at": "2020-06-19T06:50:03.557Z",
                "updated_at": "2020-06-19T06:50:03.563Z"
              }
            }

### Destroy a user [DELETE /v1/users]


+ Request deletes the user successfully
**DELETE**&nbsp;&nbsp;`/v1/users`

    + Headers

            Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyMSwiZXhwIjoxNTkyNjM1ODAzfQ._1Hh0qW5cjtfoja1zkLSq9VRC7B84M3zCV6yPLpHq8M
            Content-Type: application/json

    + Body

            {
            }

+ Response 204

    + Body

            {}


