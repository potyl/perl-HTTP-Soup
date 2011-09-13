#include "soup-perl.h"


MODULE = HTTP::Soup::Buffer  PACKAGE = HTTP::Soup::Buffer  PREFIX = soup_buffer_


SV*
data (SoupBuffer *buffer, const char *val = NULL)
	CODE:
		if (items > 1) {
			buffer->data = val;
			/* We can't return the 'data' array since we don't know it's length yet */
			RETVAL = NULL;
		}
		else {
			RETVAL = newSVpv(buffer->data, buffer->length);
		}

	OUTPUT:
		RETVAL


gsize
length (SoupBuffer *buffer, gsize val = 0)
	CODE:
		if (items > 1) buffer->length = val;
		RETVAL = buffer->length;

	OUTPUT:
		RETVAL

