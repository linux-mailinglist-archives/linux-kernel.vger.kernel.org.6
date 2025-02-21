Return-Path: <linux-kernel+bounces-526559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F30A4003E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72ED7AFA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25AB253340;
	Fri, 21 Feb 2025 19:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="tktMuV4i"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2270525291E;
	Fri, 21 Feb 2025 19:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167987; cv=none; b=mfGjHCQCdzKw8N8wfOrjd8U9CUdU/1qsdEz4EPtBeE0ACsLTRGKhXIHeM5O+hioh/CNaBJOJdZnFtRJ9jf+0IL4BjeALTd0DUutF2vgIOw98eapT9jyDGXQK1UW/xp8s+kLN9nLDzwFBktWHyMd6ENQ8Fn5LcdweIREKVSCSa6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167987; c=relaxed/simple;
	bh=aun+RPo8XWnUox5THxIKBXlvYRObBaQI2FEDg4/W19k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gcLtLKlF+HNt51XVBwpj7cmW0kRdWTYmGNPWd8fw/plHh/11bV1KaQmH1pv83jRKRH4V6v8GSYuXbOKstNE0ngF3OvcNKYKn5U2ewxi5h11ddZbTtlaprWYJ9KYME+VAEeBebzNTAvHNF3lfeNuUu5rgu3M4FOhSWe4O72V/Szg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=tktMuV4i; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-233.tugraz.at (vra-171-233.tugraz.at [129.27.171.233])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z01Dl0Llcz1JJCW;
	Fri, 21 Feb 2025 20:59:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z01Dl0Llcz1JJCW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740167976;
	bh=daHf1z8lJ31bFj+fSX9TjMZapPE1WbLyymgeRwxtVNo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=tktMuV4ieti8guHZ8t9O0LF+NrvjbAD1OfN0/GAtqrfHDYDXp6rqornOihXdduPn3
	 Owby2PWHLt4nU1bkC/StUSz2IFiYcSUxow3Z7WGd7S5acShC5apTDdrGowcPaohFZN
	 wZYwMD4kJ2Ae96+oImzuiDCnCpm4uBIJqakgIu5o=
Message-ID: <008cc0939c130ee24fbc71a0407ff82772076668.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Boqun
 Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org,  ksummit@lists.linux.dev
Date: Fri, 21 Feb 2025 20:59:34 +0100
In-Reply-To: <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
	 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <2025022042-jot-favored-e755@gregkh>
	 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	 <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	 <20250221124304.5dec31b2@gandalf.local.home>
	 <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
	 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
	 <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 0.0
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.116

Am Freitag, dem 21.02.2025 um 11:30 -0800 schrieb Linus Torvalds:
> On Fri, 21 Feb 2025 at 10:31, Martin Uecker <uecker@tugraz.at> wrote:
> >=20
> > The issue with __attribute__ is that it is always tied to a specific
> > syntactic construct.  Possible it could be changed, but then I do
> > not see a major difference to _Pragma, or?
>=20
> Oh, _Pragma() is certainly more usable from a pre-processor
> standpoint, but it's still garbage exactly because it doesn't nest,
> and has no sane scoping rules, and is basically compiler-specific.
>=20
> Don't use it.
>=20
> It's not any better than __attribute__(()), though. The scoping rules
> for _pragma() are basically completely random, and depends on what you
> do. So it might be file-scope, for example (some pragmas are for
> things like "this is a system header file, don't warn about certain
> things for this"), or it might be random "manual scope" like "pragma
> pack()/unpack()".
>=20
> It's still complete garbage.

The standardized version of __attribute__(()) would look=C2=A0like

[[safety(ON)]];
....

[[safety(OFF)]];

which is not bad (and what C++ seems to plan for profiles),
but this also does not nest and is a bit more limited to where
it can be used relative _Pragma.  I don't really see any advantage.

GCC has=20

#pragma GCC diagnostic push "-Wxyz"
#pragma GCC diagnostic pop

for nesting. Also not great.

>=20
> > > This is non-negotiable. Anybody who thinks that a compiler is valid
> > > warning about
> > >=20
> > >          if (x < 0 || x >=3D 10) {
> > >=20
> > > just because 'x' may in some cases be an unsigned entity is not worth
> > > even discussing with.
> >=20
> > Do you think the warning is useless in macros, or in general?
>=20
> Oh, I want to make it clear: it's not ":useless". It's MUCH MUCH
> WORSE. It's actively wrong, it's dangerous, and it makes people write
> crap code.
>=20
> And yes, it's wrong in general. The problems with "x < 0" warning for
> an unsigned 'x' are deep and fundamental, and macros that take various
> types is only one (perhaps more obvious) example of how brokent that
> garbage is.
>=20
> The whole fundamental issue is that the signedness of 'x' MAY NOT BE
> OBVIOUS, and that the safe and human-legible way to write robust code
> is to check both limits.
>=20
> Why would the signedness of an expression not be obvious outside of macro=
s?
>=20
> There's tons of reasons. The trivial one is "the function is large,
> and the variable was declared fifty lines earlier, and you don't see
> the declaration in all the places that use it".
>=20
> Remember: source code is for HUMANS. If we weren't human, we'd write
> machine code directly. Humans don't have infinite context. When you
> write trivial examples, the type may be trivially obvious, but REAL
> LIFE IS NOT TRIVIAL.
>=20
> And honestly, even if the variable type declaration is RIGHT THERE,
> signedness may be very non-obvious indeed. Signedness can depend on
>=20
>  (a) architecture (example: 'char')
>=20
>  (b) typedef's (example: too many to even mention)
>=20
>  (c) undefined language behavior (example: bitfields)
>=20
>  (d) various other random details (example: enum types)
>=20
> Dammit, I'm done with this discussion. We are not enabling that
> shit-for-brains warning. If you are a compiler person and think the
> warning is valid, you should take up some other work. Maybe you can
> become a farmer or something useful, instead of spreading your manure
> in technology.
>=20
> And if you think warning about an extra "x < 0" check is about
> "security", you are just a joke.

Just in case this was lost somewhere in this discussion:=C2=A0
it was not me=C2=A0proposing to add this warning.=20

Martin

>=20
>               Linus


