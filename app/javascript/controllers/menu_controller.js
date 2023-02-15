import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ["items"]
  conect() {
    alert("Hello, Stimulus!")
  }
  toggle() {
    this.element.classList.toggle("translate-x-full")
  }
}
