#include "soup-perl.h"


MODULE = HTTP::Soup::Buffer  PACKAGE = HTTP::Soup::Buffer  PREFIX = soup_buffer_


SV*
data (SoupBuffer *buffer)
	CODE:
		RETVAL = newSVpv(buffer->data, buffer->length);

	OUTPUT:
		RETVAL


gsize
length (SoupBuffer *buffer)
	CODE:
		RETVAL = buffer->length;

	OUTPUT:
		RETVAL

