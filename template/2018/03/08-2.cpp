#include <pybind11/embed.h>
#include <pybind11/pybind11.h>
#include <utility>

namespace py = pybind11;
using std::pair;

void hello(py::args args, py::kwargs kwargs)
{
    for (const py::handle& arg : args)
    {
        py::print(py::str(arg));
    }
    for (const pair<py::handle, py::handle>& kv : kwargs)
    {
        py::print(py::str(kv.first), "=", py::str(kv.second));
    }
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
    py::exec("hello('hello', a = 1, b = 2, abc = 123)", scope);

    return 0;
}
