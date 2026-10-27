import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["layer"]

  connect() {
    this.x = 0
    this.y = 0
    this.targetX = 0
    this.targetY = 0
    this.frame = null

    this.onMove = this.onMove.bind(this)
    this.onLeave = this.onLeave.bind(this)
    this.animate = this.animate.bind(this)

    this.reducedMotion = window.matchMedia("(prefers-reduced-motion: reduce)").matches

    if (this.reducedMotion) return

    this.element.addEventListener("pointermove", this.onMove)
    this.element.addEventListener("pointerleave", this.onLeave)
  }

  onMove(event) {
    if (event.pointerType === "touch") return

    const rect = this.element.getBoundingClientRect()
    const mouseX = (event.clientX - rect.left) / rect.width
    const mouseY = (event.clientY - rect.top) / rect.height

    this.targetX = -(mouseX - 0.5) * 100
    this.targetY = -(mouseY - 0.5) * 75

    this.startAnimation()
  }

  onLeave() {
    this.targetX = 0
    this.targetY = 0

    this.startAnimation()
  }

  startAnimation() {
    if (this.frame === null) {
      this.frame = requestAnimationFrame(this.animate)
    }
  }

  animate() {
    this.frame = null

    const smoothness = 0.06

    this.x += (this.targetX - this.x) * smoothness
    this.y += (this.targetY - this.y) * smoothness

    const layer = this.layerTarget

    layer.style.setProperty("--gradient-x", `${this.x}px`)
    layer.style.setProperty("--gradient-y", `${this.y}px`)
    layer.style.setProperty("--glow-x", `${-this.x * 0.6}px`)
    layer.style.setProperty("--glow-y", `${-this.y * 0.4}px`)
    layer.style.setProperty("--curve-x", `${this.x * 0.4}px`)
    layer.style.setProperty("--curve-y", `${-this.y * 0.5}px`)
    layer.style.setProperty("--gradient-rotate", `${this.x * 0.006}deg`)

    if (Math.abs(this.targetX - this.x) > 0.1 || Math.abs(this.targetY - this.y) > 0.1) {
      this.startAnimation()
    }
  }

  disconnect() {
    this.element.removeEventListener("pointermove", this.onMove)
    this.element.removeEventListener("pointerleave", this.onLeave)

    if (this.frame !== null) {
      cancelAnimationFrame(this.frame)
      this.frame = null
    }
  }
}