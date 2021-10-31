module.exports = function (eleventyConfig) {
  eleventyConfig.addWatchTarget("./styles/")
  eleventyConfig.addPassthroughCopy("img")
  eleventyConfig.addPassthroughCopy({ public: "/" })

  return {
    templateFormats: ["html", "css"],
  }
}
