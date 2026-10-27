import { Controller } from "@hotwired/stimulus"

const EMAIL_PATTERN = /^[^\s@]+@[^\s@]+\.[^\s@]+$/

export default class extends Controller {
  static targets = ["email", "personalDataConsent", "button", "inputShell"]

  connect() {
    this.submitting = false
    this.validate()
  }

  validate() {
    const email = this.emailTarget.value.trim()
    const emailIsValid = EMAIL_PATTERN.test(email)
    const consentIsValid = this.personalDataConsentTarget.checked
    const formIsValid = emailIsValid && consentIsValid

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