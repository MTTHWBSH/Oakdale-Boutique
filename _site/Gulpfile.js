var gulp = require('gulp'),
	shell = require('gulp-shell'),
	minifyHTML = require('gulp-minify-html'),
	imagemin = require('gulp-imagemin'),
	pngquant = require('imagemin-pngquant'),
	jpegtran = require('imagemin-jpegtran'),
	gifsicle = require('imagemin-gifsicle'),
	optipng = require('imagemin-optipng');

gulp.task('default', ['html', 'images']);

gulp.task('jekyll', function() {
  return gulp.src('index.html', { read: false })
    .pipe(shell([
      'bundle exec jekyll build'
  ]));
});

gulp.task('serve', ['html', 'images'], function() {
  return gulp.src('index.html', { read: false })
  .pipe(shell([
    'bundle exec jekyll s'
  ]));
});


gulp.task('html', ['jekyll'], function() {
  var opts = {
    conditionals: true,
    quotes:true
  };
 
  return gulp.src('_site/*/*.html')
    .pipe(minifyHTML(opts))
    .pipe(gulp.dest('_site/'));
});

gulp.task('images', ['jekyll'], function () {
    return gulp.src('assets/images/**')
        .pipe(imagemin({
            progressive: true,
            svgoPlugins: [{removeViewBox: false}],
            use: [pngquant(), jpegtran(), optipng(), gifsicle()]
        }))
        .pipe(gulp.dest('_site/images'));
});
