async function createProcessor() {
  const rehypeHighlight = await import("rehype-highlight");
  const rehypeKatex = await import("rehype-katex");
  const remarkGfm = await import("remark-gfm");
  const remarkMath = await import("remark-math");
  const remarkParse = await import("remark-parse");
  const remarkRehype = await import("remark-rehype");
  const { unified } = await import("unified");
  const rehypeRaw = await import("rehype-raw");
  const rehypeStringify = await import("rehype-stringify");

  // for dynamic imports we have to call .default
  return unified()
    .use(remarkParse.default)
    .use(remarkMath.default)
    .use(remarkGfm.default)
    .use(remarkRehype.default, { allowDangerousHtml: true })
    .use(rehypeRaw.default)
    .use(rehypeKatex.default)
    .use(rehypeHighlight.default)
    .use(rehypeStringify.default);
}

function eleventyRemark() {
  return {
    render: async (str, data) => {
      const p = await createProcessor();
      const res = await p.data({ eleventy: data }).process(str);
      return res.value;
    },
  };
}

module.exports = function (eleventyConfig) {
  eleventyConfig.addPassthroughCopy("assets");
  eleventyConfig.addPassthroughCopy("styles");

  eleventyConfig.addLayoutAlias("page", "layouts/page.njk");

  eleventyConfig.setLibrary("md", eleventyRemark());

  return {
    templateFormats: ["md", "njk"],
    markdownTemplateEngine: false,
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk",
    dir: {
      input: "src",
      includes: "_includes",
      output: "_site",
      data: "_data",
    },
  };
};
