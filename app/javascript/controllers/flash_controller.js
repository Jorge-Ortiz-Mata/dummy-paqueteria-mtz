import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  removeNotice() {
    document.getElementById('notice').remove();
  }
}
