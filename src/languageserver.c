#include "document.h"
#include "reader.h"


static const R_CallMethodDef CallEntries[] = {
    {"document_backward_search", (DL_FUNC) &document_backward_search, 5},
    {"stdin_read_char", (DL_FUNC) &stdin_read_char, 1},
    {"stdin_read_line", (DL_FUNC) &stdin_read_line},
    {NULL, NULL, 0}
};

void R_init_languageserver(DllInfo *dll) {
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
