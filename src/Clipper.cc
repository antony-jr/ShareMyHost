#include <Clipper.hpp>
#include <QClipboard>
#include <QApplication>

Clipper::Clipper(QObject *parent) :
    QObject(parent) {
}

Clipper::~Clipper() {
}

void Clipper::clip(QString content) {
    QClipboard *clipboard = QApplication::clipboard();
    if(!clipboard) {
        return;
    }
    clipboard->setText(content);
    emit clipped();
}
