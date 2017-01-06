const path = require('path')
const webpack = require('webpack')
const ExtractTextPlugin = require("extract-text-webpack-plugin")

const NODE_ENV = process.env.NODE_ENV

module.exports = {
  devtool: 'inline-source-map',
  node: {
    fs: 'empty',
    module: 'empty'
  },
  entry: path.join(__dirname, 'client', 'index.js'),
  resolve: {
    extensions: ['.js', '.json']
  },
  output: {
    publicPath: '/',
    path: path.join(__dirname, 'priv', 'static'),
    filename: 'js/index.js'
  },
  module: {
    loaders: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loader: 'babel-loader'
      },
      {
        test: /\.scss$/,
        loader: ExtractTextPlugin.extract({
          fallbackLoader: 'style-loader',
          loader: 'css-loader!autoprefixer-loader!sass-loader'
        })
      },
      {
        test: /\.css$/,
        include: /node_modules/,
        loaders: ['style-loader', 'css-loader']
      },
      {
        test: /\.svg/,
        loader: 'svg-url-loader'
      }
    ]
  },
  plugins: [
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: JSON.stringify(NODE_ENV)
      }
    }),
    new ExtractTextPlugin('css/app.css')
  ]
}
