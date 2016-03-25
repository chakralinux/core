# Maintainer: Fabian Kosmale

pkgname=openblas
_pkgname=OpenBLAS
pkgver=0.2.17
pkgrel=1
pkgdesc="An optimized BLAS library based on GotoBLAS2 1.13 BSD "
arch=('i686' 'x86_64')
url="http://www.openblas.net/"
license=('BSD')
depends=('gcc-libs')
makedepends=('perl' 'gcc-fortran')
conflicts=('blas' 'cblas')
options=(!makeflags !emptydirs staticlibs)
source=(${_pkgname}-v${pkgver}.tar.gz::http://github.com/xianyi/OpenBLAS/archive/v${pkgver}.tar.gz)
sha256sums=('0fe836dfee219ff4cadcc3567fb2223d9e0da5f60c7382711fb9e2c35ecf0dbf')

build() {
  cd "$srcdir/$_pkgname-$pkgver"

  unset CFLAGS
  unset CXXFLAGS
  # using and OPENMP=1 should be the most sensible option
  # see https://github.com/xianyi/OpenBLAS/wiki/faq for  details
  # we use NO_LAPACK, as LAPACK should be provided by our lapack package
  make USE_OPENMP=1 NO_LAPACK=1 MAJOR_VERSION=3 DYNAMIC_ARCH=1
}

package() {
  cd "$srcdir/$_pkgname-$pkgver"

  make PREFIX="$pkgdir/usr" MAJOR_VERSION=3 install
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

  # Remove reference to ${pkgdir}
  sed -i -e "s|${pkgdir}||" "${pkgdir}/usr/lib/cmake/openblas/OpenBLASConfig.cmake"
}

# vim:set ts=2 sw=2 et:
