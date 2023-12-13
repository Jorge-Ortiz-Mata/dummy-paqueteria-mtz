import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
  }

  toggleModal() {
    document.getElementById('responsive_navbar').classList.toggle('hidden');
  }
}
