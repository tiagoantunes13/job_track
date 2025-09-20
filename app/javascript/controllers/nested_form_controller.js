// app/javascript/controllers/nested_form_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["template", "links"];

  connect() {
    this.wrapperClass = this.data.get("wrapperClass") || "nested-fields";
  }

  add(e) {
    e.preventDefault();

    const content = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    );
    this.linksTarget.insertAdjacentHTML("beforebegin", content);
  }

  remove(e) {
    e.preventDefault();

    const wrapper = e.target.closest(`.${this.wrapperClass}`);

    // New records are simply removed from the DOM
    if (wrapper.dataset.newRecord === "true") {
      wrapper.remove();
    } else {
      // Existing records are hidden and marked for deletion
      wrapper.querySelector("input[name*='_destroy']").value = "1";
      wrapper.style.display = "none";
    }
  }
}
