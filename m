Return-Path: <linux-kernel+bounces-526197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B181A3FB76
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5415E18906C6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF311EE03D;
	Fri, 21 Feb 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="Q+oy6TDV"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76DB1EE028;
	Fri, 21 Feb 2025 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740155331; cv=none; b=Oxt+HubVihIiQ6YLZa98Qy62x5xxJjw2GVL2e2zb7mO2iBjM2zZ3+N21Re6t+CatgfEeaSrlUeB5d29+lrbJfpWelsc8AuawyMPiyl4+E2DyYO5qrFFJlz3O2TTyzZ6IDPmlRmV2k+AtGwHVXXN5ub8AfQ3E92DlS+yWwb4cvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740155331; c=relaxed/simple;
	bh=itDtkLuv9PHUCMQ37TmiQonIka0iF299AgH2m8mj9vU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dvzSXt0p9Ah/CLLHlmEVevFQm1Nv1vgv8VLr5V0SbdWqJ6H2x4wmTws+c2s703FQfgmNUHT5l4uU3oYardL7qMydL0E6rbsvqgqnQZeyYm+UdqiPkT3D3B2hSicfg4PKEBL1vsDE86wyPL0Q6CRE/fb7pDy6dQEQs9PjcnWy3Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=Q+oy6TDV; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-233.tugraz.at (vra-171-233.tugraz.at [129.27.171.233])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4YzwYC00wkz3xGX;
	Fri, 21 Feb 2025 17:28:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740155313;
	bh=A5/Vf9HW8Yy4Pzv/cgrk4LjgVOJx+yDRb5XqnCH19cE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Q+oy6TDVd8IkqCcuadMv4XLA6bxeK3zaqbOiqeIQAFY9VTMYpH1ZH3ZxEESZSTfwx
	 yfz6jMoqGbDsTMDzmnqYAS61rxBYftoAlgIk8CgNw/y49LIlPkWQlChtLPItqSa/7N
	 +tqxUwRjicObCRyXPzym8v7FecEKkIRcOTuOOJ5I=
Message-ID: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
  "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Fri, 21 Feb 2025 17:28:30 +0100
In-Reply-To: <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
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
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117

Am Freitag, dem 21.02.2025 um 12:48 +0300 schrieb Dan Carpenter:
> On Thu, Feb 20, 2025 at 04:40:02PM +0100, Martin Uecker wrote:
> > I mean "memory safe" in the sense that you can not have an OOB access
> > or use-after-free or any other UB.  The idea would be to mark certain
> > code regions as safe, e.g.
> >=20
> > #pragma MEMORY_SAFETY STATIC
>=20
> Could we tie this type of thing to a scope instead?  Maybe there
> would be a compiler parameter to default on/off and then functions
> and scopes could be on/off if we need more fine control.

At the moment my feeling is that tying it to a specific scope
would not be flexible enough.=20

The model I have in my mind are the pragmas GCC has
to turn on and off diagnostics for regions of code=20
(i.e. #pragma GCC diagnostic warning, etc.). These memory
safety modes would still be based on many different individual
warnings that are can then be jointly toggled using these
pragmas but which could also individually be toggled as usual.

>=20
> This kind of #pragma is basically banned in the kernel.  It's used
> in drivers/gpu/drm but it disables the Sparse static checker.

Why is this?

>=20
> > unsigned int foo(unsigned int a, unsigned int b)
> > {
> >   return a * b;
> > }
> >=20
> > static int foo(const int a[static 2])
> > {
> >   int r =3D 0;
> >   if (ckd_mul(&r, a[0], a[1]))
> >     return -1;
> >   return r;
> > }
> >=20
> > static int bar(int x)
> > {
> >   int a[2] =3D { x, x };
> >   return foo(a);
> > }
> >=20
> >=20
> > and the compiler would be required to emit a diagnostic when there
> > is any operation that could potentially cause UB.
>=20
> I'm less convinced by the static analysis parts of this...  The kernel
> disables checking for unsigned less than zero by default because there
> are too many places which do:
>=20
> 	if (x < 0 || x >=3D 10) {
>=20
> That code is perfectly fine so why is the compiler complaining?  But at
> the same time, being super strict is the whole point of Rust and people
> love Rust so maybe I have misread the room.

What is a bit weird is that on the one side there are people
who think we absolutely need=C2=A0 compiler-ensured memory safety
and this might be even worth rewriting code from scratch and
on the other side there are people who think that dealing with
new false positives in existing code when adding new warnings
is already too much of a burden.

> >=20
> > I would also have a DYNAMIC mode that traps for UB detected at
> > run-time (but I understand that this is not useful for the kernel).=20
>=20
> No, this absolutely is useful.  This is what UBSan does now.
>=20

Yes, it is similar to UBSan. The ideas to make sure that in the
mode there is *either* a compile-time warning *or* run-time
trap for any UB.  So if you fix all warnings, then any remaining
UB is trapped at run-time.

>   You're
> basically talking about exception handling.  How could that not be
> the most useful thing ever?

At the moment, I wasn't thinking about a mechanism to catch those
exceptions, but just to abort the program directly (or just emit
a diagnostic and continue. =20


BTW: Another option I am investigating it to have UBsan insert traps
into the code and then have the compiler emit a warning only when
it actually emits the trapping instruction after optimization. So
you only get the warning if the optimizer does not remove the trap. =20
Essentially, this means that one can use the optimizer to prove that
the code does not have certain issues. For example, you could use the=20
signed-overflow sanitizer to insert a conditional trap everywhere
where there could be signed overflow, and if the optimizer happens
to remove all such traps because they are unreachable, then it is
has shown that the code can never have a signed overflow at run-time.
This is super easy to implement (I have a patch for GCC) and
seems promising.  One problem with this is that any change in the
optimizer could change whether you get a warning or not.

Martin





>=20
> regards,
> dan carpenter
>=20


