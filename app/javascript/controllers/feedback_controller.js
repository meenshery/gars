import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body", "button", "inputShell"]

  connect() {
    this.submitting = false
    this.validate()
  }

  validate() {
    const body = this.bodyTarget.value.trim()
    const formIsValid = body.length > 0 && body.length <= 2000

    this.buttonTarget.disabled = this.submitting || !formIsValid
    this.inputShellTarget.classList.toggle("is-valid", formIsValid)
  }

  submitStart() {
    this.submitting = true
    this.validate()
  }

  submitEnd() {
    this.submitting = false
    this.validate()
  }
}