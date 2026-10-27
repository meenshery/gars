import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "image", "placeholder", "message"]

  connect() {
    this.originalSource = this.imageTarget.getAttribute("src") || ""
    this.previewUrl = null
  }

  preview() {
    const file = this.inputTarget.files[0]

    this.releasePreview()

    if (!file) {
      this.restoreImage()
      this.messageTarget.textContent = ""
      return
    }

    const allowedTypes = ["image/jpeg", "image/png", "image/webp"]

    if (!allowedTypes.includes(file.type)) {
      this.rejectFile("JPG, PNG или WEBP")
      return
    }

    if (file.size > 10 * 1024 * 1024) {
      this.rejectFile("Не больше 10 МБ")
      return
    }

    this.previewUrl = URL.createObjectURL(file)
    this.imageTarget.src = this.previewUrl
    this.imageTarget.hidden = false
    this.placeholderTarget.hidden = true
    this.messageTarget.classList.remove("A_Text--error")
    this.messageTarget.textContent = "Обложка выбрана"
  }

  rejectFile(message) {
    this.inputTarget.value = ""
    this.restoreImage()
    this.messageTarget.classList.add("A_Text--error")
    this.messageTarget.textContent = message
  }

  restoreImage() {
    if (this.originalSource) {
      this.imageTarget.src = this.originalSource
    } else {
      this.imageTarget.removeAttribute("src")
    }

    this.imageTarget.hidden = !this.originalSource
    this.placeholderTarget.hidden = Boolean(this.originalSource)
  }

  releasePreview() {
    if (this.previewUrl) {
      URL.revokeObjectURL(this.previewUrl)
      this.previewUrl = null
    }
  }

  reset() {
    this.releasePreview()
    this.inputTarget.value = ""
    this.restoreImage()
    this.messageTarget.textContent = ""
    this.messageTarget.classList.remove("A_Text--error")
  }

  disconnect() {
    this.releasePreview()
  }
}