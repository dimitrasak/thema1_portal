// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
//import "controllers"

//= require jquery3 
//= require popper 
//= require bootstrap 

// app/javascript/packs/application.js
// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
// import "controllers"

import consumer from "./consumer"

document.addEventListener('DOMContentLoaded', () => {
  // Your jQuery and Bootstrap-related code can go here, or consider converting them to ES6 imports as well.
  // Example:
  // import $ from 'jquery';
  // window.jQuery = $;
  // import 'bootstrap';

  consumer.subscriptions.create("portal", {
    connected() {
      // Called when the subscription is ready for use on the server
    },

    disconnected() {
      // Called when the subscription has been terminated by the server
    },

    received(data) {
      if (data.event === 'login') {
        // Handle login event
      } else if (data.event === 'signup') {
        // Handle signup event
      }
    }
  });
});

