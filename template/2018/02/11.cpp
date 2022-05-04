#include <pybind11/embed.h>
#include <pybind11/pybind11.h>

namespace py = pybind11;

int main()
{
    py::scoped_interpreter interpreter;
    py::print("Hello, world!");

    return 0;
}
