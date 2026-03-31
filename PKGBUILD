pkgname=atha
pkgver=1.0
pkgrel=1
pkgdesc="Simple package manager wrapper for Arch Linux"
arch=('any')
url="https://github.com/USERNAME/atha"
license=('MIT')

depends=('bash' 'pacman')

source=("https://github.com/USERNAME/atha/archive/refs/heads/main.tar.gz")

md5sums=('SKIP')

package() {
    cd "$srcdir/atha-main"

    install -Dm755 atha "$pkgdir/usr/bin/atha"
    cp -r commands "$pkgdir/usr/lib/atha"
}
