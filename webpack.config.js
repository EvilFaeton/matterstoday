var webpack = require("webpack");
var path = require("path");
var imgRoot = path.join(__dirname, "./assets/images");

module.exports = {
  context: path.join(__dirname, "./"),
  entry: {
    public_page: [
      "./assets/matters.coffee",
    ]
  },
  output: {
    path: path.join(__dirname, "./public/chunks"),
    publicPath: "/chunks/",
    filename: "[name].bundle.js",
    chunkFilename: "[hash]/js/[id].js",
    hotUpdateMainFilename: "[hash]/update.json",
    hotUpdateChunkFilename: "[hash]/js/[id].update.js"
  },
  resolve: {
    extensions: [
      "",
      ".webpack.js",
      ".web.js",
      ".js",
      ".coffee",
      ".cjsx",
      ".jsx",
      ".sass"
    ],
    modulesDirectories: [
      "web_modules",
      "node_modules",
      "bower_components",
      "vendor/assets/javascripts/components",
      "app/assets/javascripts/components"
    ]
  },
  recordsPath: path.join(__dirname, "records.json"),
  module: {
    loaders: [
      { test: /\.json$/,   loader: "json" },
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.cjsx$/,   loader: "coffee!cjsx" },
      { test: /\.jsx$/,    loader: "jsx-loader?harmony" },
      {
        test: /\.less$/,
        loader: "style!css!autoprefixer?ie 8,ff 17!less"
      },
      {
        test: /\.css$/,
        loader: "style!css?root=" + imgRoot + "!autoprefixer?ie 8,ff 17"
      },
      {
        test: /\.sass$/,
        loader: "style!css?root=" + imgRoot +
          "!autoprefixer?ie 8,ff 17!sass?indentedSyntax" +
          "&includePaths[]=" +
          path.resolve(
            __dirname,
            "../../app/assets/components/ui/global/"
          )
      },
      { test: /\.(png|jpg|gif)$/,      loader: "url?prefix=img/&limit=5000" },
      { test: /\.(woff|eot|ttf|svg)$/, loader: "file?prefix=font/" },
    ],
    noParse: [
      path.join(__dirname, "../../node_modules", "jquery")
   ]
  },
    plugins: [
    new webpack.ProvidePlugin({
      React: "react",
      Fluxxor: "fluxxor"
    }),
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin(
        "bower.json",
        ["main"]
      )
    ),
    new webpack.HotModuleReplacementPlugin()
  ]
};
