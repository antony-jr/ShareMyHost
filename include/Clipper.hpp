#ifndef CLIPPER_HPP_INCLUDED
#define CLIPPER_HPP_INCLUDED 
#include <QObject>
#include <QString>

class Clipper : public QObject
{
    Q_OBJECT
    Q_PROPERTY(NOTIFY clipped)
public:
    explicit Clipper(QObject *parent = nullptr);
    ~Clipper();
    Q_INVOKABLE void clip(QString);
signals:
    void clipped();
};

#endif
