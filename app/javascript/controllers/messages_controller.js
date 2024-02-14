// app/javascript/controllers/messages_controller.js
import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:submit-end", (event) => {
      const form = event.detail.form;
      form.reset();

      const turboFrames = document.querySelectorAll("turbo-frame[name='notifications']");
      turboFrames.forEach((frame) => {
        frame.dispatchEvent(new Event("turbo:load"));
      });
    });
  }
}
