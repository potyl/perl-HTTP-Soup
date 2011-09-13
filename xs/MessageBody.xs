#include "soup-perl.h"


MODULE = HTTP::Soup::MessageBody  PACKAGE = HTTP::Soup::MessageBody  PREFIX = soup_message_body_


SV*
data (SoupMessageBody *body, const char *val = NULL)
	CODE:
		if (items > 1) {
			body->data = val;
			/* We can't return the 'data' array since we don't know it's length yet */
			RETVAL = NULL;
		}
		else {
			RETVAL = newSVpv(body->data, body->length);
		}

	OUTPUT:
		RETVAL


gint64
length (SoupMessageBody *body, gint64 val = 0)
	CODE:
		if (items > 1) body->length = val;
		RETVAL = body->length;

	OUTPUT:
		RETVAL

