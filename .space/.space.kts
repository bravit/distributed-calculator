job("Build Fleet indexes") {
    warmup(ide = Ide.Fleet) {
        devfile = ".space/devfile.yaml"
        scriptLocation = ""
    }
}