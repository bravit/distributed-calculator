job("Warm up the Dev Environment") {
    warmup(ide = Ide.Fleet) {
        devfile = ".space/devfile.yaml"
        scriptLocation = "./dev-env-warmup.sh"
    }
}