#include "sort_handle.h";

struct SORT_STRUCT {
    int* array;
    int length;
}

SORT_HANDLE prepareSort(int* array, int length) {
    struct SORT_STRUCT*  context = malloc(sizeof(struct SORT_STRUCT));
    context->array = array;
    context->length = length;

return context;
}

void sort(SORT_HANDLE context) {
}