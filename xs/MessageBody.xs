#include "soup-perl.h"


MODULE = HTTP::Soup::MessageBody  PACKAGE = HTTP::Soup::MessageBody  PREFIX = soup_message_body_


SV*
data (SoupMessageBody *body)
	CODE:
		RETVAL = newSVpv(body->data, body->length);

	OUTPUT:
		RETVAL


gint64
length (SoupMessageBody *body)
	CODE:
		RETVAL = body->length;

	OUTPUT:
		RETVAL

