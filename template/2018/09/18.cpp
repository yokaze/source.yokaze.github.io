#include <pybind11/embed.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

int main(void)
{
    py::scoped_interpreter interpreter;
    py::module sys_module = py::module::import("sys");
    py::print(sys_module);
    return 0;
}
