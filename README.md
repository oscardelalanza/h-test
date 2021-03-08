# Homie Test

> This is the `Homie` engineering test for the backend position. The goal of the test is to create an API to retrieve the
> information of the different properties published for rental purposes. As mentioned in the test description, `Homie`
> works with different partners, like `Metros Cubicos`, `Inmuebles24`, `Segundamano`.

![screenshot](docs/screenshots/portrait.jpg)

## Built With

- `Ruby v2.7.2`
- `Rails v6.1.3`
- `PostgreSQL`, `devise-jwt`, `dotenv-rails`, `rubocop`, `jbuilder`

## Live Demo

[https://sheltered-anchorage-28656.herokuapp.com](https://sheltered-anchorage-28656.herokuapp.com/)

## Getting Started

### Homie instructions

##### Instructions

- Design and make an API that validates a token to retrieve properties with the `published status`. 
- Allow `create`, `read`, `update` and `delete` for each property.

##### Considerations

- Each partner may require different information on the properties listed.
- The owner availability could be any day from `Monday` to `Sunday`, from `8 am` to `8 pm`.

##### Main data to retrieve

- `Name`
- `Description`
- `Rental Price`
- `Owner Name`
- `Owner Phone`
- `Owner Availability`
- `Status`
    * `published`
    * `available`
    * `deleted`

### Development Plan

The `API` will be separated into two different modules to meet the project requirements. The first module will be the
`Owners`, where the `Create`, `Read`, `Update`, and Delete features will be included. The second module will be the
`Partners`, where the token validation feature will be implemented for all the external incoming requests.

#### Owners

This module is intended to `Create`, `Read`, `Update` and `Delete` properties. To secure access to the right property
owner, a basic authentication system is suggested.

- Features
  * `Authentication`, in order to warranty access to the right owner to the properties information, a basic authentication
    system is suggested. This feature will be used to recollect the owner information.
  * `Create`, this feature will be available for registered owners and will be used to create new property records.
  * `Update`, this feature will be available for registered owners and will be used to update existing property records.
  * `Read`, this feature will be mainly available for registered owners and will be used to retrieve existing property records.
    A variant of this feature will be available for the `partners` (check partners description for more information).
  * `Delete`, this feature will be available for registered owners and will be used to implement a `soft-delete` feature
    by changing the property status to `deleted`.
    
- Data Models
  * `Owner`, this model will hold the owners data (name, phone, availability) and it will be related to the Property model
    through a `1:n` relationship.
  * `Property`, this model will hold the properties data (name, description, rental price, status) and it will belong to
    the owner model.
    

#### Partners

This module is intended to warranty access to the `published` properties to the different partners through a validation
token.

- Features
  * `Partner Registration`, this feature will be used to register different applications as `partners` of the API and
    issue a unique token for each one of them.
  * `Property fetch`, this will be a variant of the `Read` feature, to warranty access to the information only to the
    registered partners by validating the token issued after the partner registration.

- Data models
  * `Partners`, this model will hold the partner information, and will be used to generate an access token to the API
    records.
    
    
### Database Model

![erd](docs/erd.png)

**To get a local copy up and running follow these simple example steps.**

### Prerequisites

If you want to get a local copy of this project, make sure you have installed the following in your local environment.
- `Git`
- `Ruby v2.7.2` or greater
- `Rails v6.1.3`
- `PostgreSQL`

### Setup

Clone the project by running any of the following commands:
- SSH: `git clone git@github.com:oscardelalanza/h-test.git`
- HTTPS: `git clone https://github.com/oscardelalanza/h-test.git`
- GitHub CLI: `gh repo clone oscardelalanza/h-test`
- ZIP: [Download](https://github.com/oscardelalanza/h-test/archive/feature/planning.zip)

Set the `ENV` variables by doing the following:
- Rename the file `.env_example` to `.env`.
- Change the predefined values of the keys (optional).

### Install

- Run the command `bundle install` to install the required gems.
- Run the command `rails db:create` to create the database.
- Run the command `rails db:migrate` to execute the required database migrations.
- Run the command `rails db:seed` to seed the database.

### Usage

##### Owners 

- Create your account
  * Send a `POST` request to the path `/owners` with the required parameters. See the `json` example:
  
    ```json
      {
        "owner": {
          "name": "I'm The Owner",
          "available_day": "Tuesday",
          "hour_start": "07:00",
          "hour_end": "20:00",
          "phone": "1234567890",
          "password": "mypassword"
        }
      }
    ```
  
- Create a session
  * Get authenticated to the server by sending a `POST` request to the path `/owners/sign_in` with the required
    parameters. See the `json` example:
    
    ```json
      {
        "owner": {
          "phone": "1234567890",
          "password": "mypassword"
        }
      }
    ```
  
  * After sending the request, the server will respond with an `Authorization Header`, send it as a `Bearer` token with 
    all your future requests to be recognized as an `Owner`. You can also get the Authorization token after creating
    your account.
    
    ```bulk
      Authorization:Bearer eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiJiOTNiZTZhNS01MjZlLTRlN2YtYjExZi1hYzIyNjYzMmEyYTAiLCJzdWIiOiIzIiwic2NwIjoib3duZXIiLCJhdWQiOm51bGwsImlhdCI6MTYxNTIxOTc2MCwiZXhwIjoxNjE1MjIzMzYwfQ.ZYQuI8Ie-eBCW2aG2-jPuTPjVHmE4hshat-UHoKrryM
    ```

##### Properties

In order to perform any of the following actions, you have to send an `Authorization Header` as a `Bearer token` with
each request.

- Index
  * Send a `GET` request to the path `/properties` to get a list of all your properties registered.
    See the example response.
  
    ```json
      {
        "data": [
          {
            "property": {
              "id": 2,
              "name": "Property Jane Doe",
              "description": "description random",
              "status": "published",
              "rental_price": "150.53"
            }
          },
          {
            "property": {
              "id": 3,
              "name": "Property Jane Doe",
              "description": "description random",
              "status": "available",
              "rental_price": "150.53"
            }
          },
          {
            "property": {
              "id": 4,
              "name": "Property Jane Doe",
              "description": "description random",
              "status": "deleted",
              "rental_price": "150.53"
            }
          }
        ]
      }
    ```
  
- Show
  * Send a `GET` request to the path `/properties/:id` replacing the `:id` for the `id` of the property you want
    to see in full detail. See the example response: `/properties/3`.
    
    ```json
      {
        "data": {
          "property": {
            "id": 3,
            "name": "Property Jane Doe",
            "description": "description random",
            "status": "deleted",
            "rental_price": "150.53"
          }
        }
      }
    ```
    
- Create
  * Send a `POST` request to the path `/properties` to register a new property. See the example to know the required
    `json` parameters.
    
    ```json
      {
        "property": {
          "name": "my property",
          "description": "apartment with 2 beds and one garage",
          "status": "published",
          "rental_price": 254.00
        }
      }
    ```
    
- Update
  * Send a `PUT`  request to the path `/properties/:id` replacing the `:id` key for the `id` of the property you want
    to update. In the body of the request send and object with the attributes to update. See the example.
    
    ```json
      {
        "property": {
          "name": "my property updated"
        }
      }
    ```
  
- Delete
  * Send a `DELETE` request to the path `/properties/:id` replacing the `:id` for the `id` of the property you want to
    delete. `/property/10`.

##### Partners

Register as a partner to get access to the `published` properties by doing the following.
- Send a `POST` request to the path `/partners` and send a `json` object with the name of your app. See the example.
  
  ```json
    {
      "partner": {
        "name": "my app"
      }
    }
  ```

- The server will respond with a unique `auth_token`, this will be used to identify your app in your future requests.
  See the example response.
  ```json
    {
      "data": {
        "partner": {
          "name": "my app",
          "auth_token": "dDWLa4qhzz2kRknScmX1RStT"
        }
      }
    }
  ```
  
- Use your `auth_token` to retrieve the `publisehd` properties by sending a `GET` request to the path
  `/published_properties/:token` replacing the `:token` key by your `auth_token`. See the example request:
  `/published_properties/dDWLa4qhzz2kRknScmX1RStT`
  
  ```json
    {
      "data": [
        {
          "property": {
            "name": "Property Jane Doe",
            "description": "description random",
            "status": "published",
            "rental_price": "150.53",
            "owner": {
              "name": "Jane Doe",
              "phone": "4445556666",
              "available?": true
            }
          }
        },
        {
          "property": {
            "name": "Property John Doe",
            "description": "description random",
            "status": "published",
            "rental_price": "150.53",
            "owner": {
              "name": "John Doe",
              "phone": "3335556666",
              "available?": false
            }
          }
        },
        {
          "property": {
            "name": "Property Jeanna Doe",
            "description": "description random",
            "status": "published",
            "rental_price": "150.53",
            "owner": {
              "name": "Jeanna Doe",
              "phone": "4448886666",
              "available?": false
            }
          }
        },
        {
          "property": {
            "name": "my property updated",
            "description": "apartment with 2 beds and one garage",
            "status": "published",
            "rental_price": "254.0",
            "owner": {
              "name": "Jane Doe",
              "phone": "4445556666",
              "available?": true
            }
          }
        }
      ]
    }
  ```

### Run tests

- Start the test suite by running the command `rails test`

### Deployment

- Start the development server by running the command `rails server`

## Authors

👤 **Oscar De La Lanza**

- Github: [@oscardelalanza](https://github.com/oscardelalanza)
- Twitter: [@oscardelalanza](https://twitter.com/oscardelalanza)
- Linkedin: [Oscar De La Lanza](https://www.linkedin.com/in/oscardelalanza/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](https://github.com/oscardelalanza/h-test/issues).

## Show your support

Give a ⭐️ if you like this project!

## 📝 License

This project is [MIT](lic.url) licensed.