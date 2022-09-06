const { src, dest, parallel, watch, series, scripts } = require('gulp');
const autoprefix = require("gulp-autoprefixer"),
    connect    = require("gulp-connect"),
    gulp       = require("gulp"),
    bourbon    = require("bourbon").includePaths,
    neat       = require("bourbon-neat").includePaths,
    cssmin     = require('gulp-cssmin'),
    cleanCSS = require('gulp-clean-css');
    jsmin     = require('gulp-jsmin'),
    sass       = require("gulp-sass"),
    concat = require('gulp-concat-util');




const paths = {
  sass: ["./scss/style.scss"]
};


function watchFiles() {
    watch(["./scss/"], css);
}


// function css() {
//     return src(paths.sass)
//         .pipe(sass())
//         .pipe(autoprefix("last 2 versions"))
//         .pipe(cssmin())
//         .pipe(dest("./css"));
// }
function css() {
    return src(paths.sass)
        .pipe(sass())
        .pipe(autoprefix("last 2 versions"))
        .pipe(cleanCSS())
        .pipe(dest("./css"));
}



exports.css = css;
exports.default = series(
    series(css), 
    parallel(watchFiles)
);