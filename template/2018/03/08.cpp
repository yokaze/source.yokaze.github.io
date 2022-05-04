#include <pybind11/embed.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

int main()
{
    // python インタプリタを起動する
    py::scoped_interpreter interpreter;

    // numpy の各種オブジェクトを取得する
    py::module numpy = pybind11::module::import("numpy");
    py::object zeros = numpy.attr("zeros");
    py::object float32 = numpy.attr("float32");
    py::object int32 = numpy.attr("int32");

    // numpy.ndarray を作る
    py::object f32_array = zeros(10, py::arg("dtype") = float32);
    py::object i32_array = zeros(10, py::arg("dtype") = int32);

    // 配列の文字列表現を標準出力に書き出す
    py::print(py::repr(f32_array));
    py::print(py::repr(i32_array));

    return 0;
}
