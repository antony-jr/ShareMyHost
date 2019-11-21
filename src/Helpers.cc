#include <Helpers.hpp>

QMetaMethod getMethod(QObject *object, const char *function) {
    auto metaObject = object->metaObject();
    return metaObject->method(metaObject->indexOfMethod(QMetaObject::normalizedSignature(function)));
}


