#include <pybind11/embed.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

void hello()
{
    printf("Hello, world!\n");
}

int main()
{
    // python インタプリタを起動する
    py::scoped_interpreter interpreter;

    // main モジュール上に hello 関数を定義する
    py::module main_module = py::module::import("__main__");
    main_module.def("hello", &hello);

    // python スクリプトから hello 関数を呼び出す
    py::object scope = main_module.attr("__dict__");
    py::exec("hello()", scope);

    return 0;
}
