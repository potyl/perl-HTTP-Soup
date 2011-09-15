#ifndef _SOUP_PERL_PRIVATE_H_
#define _SOUP_PERL_PRIVATE_H_

#include "soup-perl.h"

GPerlCallback*
soupperl_message_callback_create (SV *func, SV *data);

void
soupperl_message_callback (SoupSession *session, SoupMessage *msg, gpointer data);

#endif /* _SOUP_PERL_PRIVATE_H_ */
