Return-Path: <linux-kernel+bounces-526361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD063A3FDAA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46A4188DC9E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED899250BEB;
	Fri, 21 Feb 2025 17:42:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4182505D6;
	Fri, 21 Feb 2025 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159757; cv=none; b=af2tC7I1zw6NibloLU2zDxOz9R7HJBeqWqqbDMd5EaG90bXaXaLRoL8ckJrqiJ1oKgsyauPt1K5yZ7K7sjeCc55AXCHmFAB2RHpoqF4K4vaTOlW1Tj+SonaFfx/S/6Xbp6tULy5u0hVrRz4i7UY9iU04pgea7B3N1NPaCT2ns0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159757; c=relaxed/simple;
	bh=QkYfDbjnv+vobxu+zskSAvJbE4xs/szNp3fe2BEoQ/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzMhvBeaSfkYmhwQm0AF9QQxD84K1TNkjibFqHE6yr70VWUbJF5EVa+3GBA6fR63v2nyWYNqYqFXhxFLcB7c4G86Y6hh1udUhgrlMtekRRIeL5cv2to2fNvJyz15dZCzoHe3bB9Z5gQOqaOB/pDmfhEROLUmIWWQIinHNRlN+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11275C4CED6;
	Fri, 21 Feb 2025 17:42:35 +0000 (UTC)
Date: Fri, 21 Feb 2025 12:43:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Uecker <uecker@tugraz.at>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: Rust kernel policy
Message-ID: <20250221124304.5dec31b2@gandalf.local.home>
In-Reply-To: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
References: <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	<CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	<a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	<Z7VKW3eul-kGaIT2@Mac.home>
	<2025021954-flaccid-pucker-f7d9@gregkh>
	<4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	<2025022024-blooper-rippling-2667@gregkh>
	<1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	<2025022042-jot-favored-e755@gregkh>
	<b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	<caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	<61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Feb 2025 17:28:30 +0100
Martin Uecker <uecker@tugraz.at> wrote:


> >=20
> > This kind of #pragma is basically banned in the kernel.  It's used
> > in drivers/gpu/drm but it disables the Sparse static checker. =20
>=20
> Why is this?

Because they are arcane and even the gcc documentation recommends avoiding
them.

 "Note that in general we do not recommend the use of pragmas"
 https://gcc.gnu.org/onlinedocs/gcc/Pragmas.html



>=20
> >  =20
> > > unsigned int foo(unsigned int a, unsigned int b)
> > > {
> > >   return a * b;
> > > }
> > >=20
> > > static int foo(const int a[static 2])
> > > {
> > >   int r =3D 0;
> > >   if (ckd_mul(&r, a[0], a[1]))
> > >     return -1;
> > >   return r;
> > > }
> > >=20
> > > static int bar(int x)
> > > {
> > >   int a[2] =3D { x, x };
> > >   return foo(a);
> > > }
> > >=20
> > >=20
> > > and the compiler would be required to emit a diagnostic when there
> > > is any operation that could potentially cause UB. =20
> >=20
> > I'm less convinced by the static analysis parts of this...  The kernel
> > disables checking for unsigned less than zero by default because there
> > are too many places which do:
> >=20
> > 	if (x < 0 || x >=3D 10) {
> >=20
> > That code is perfectly fine so why is the compiler complaining?  But at
> > the same time, being super strict is the whole point of Rust and people
> > love Rust so maybe I have misread the room. =20
>=20
> What is a bit weird is that on the one side there are people
> who think we absolutely need=C2=A0 compiler-ensured memory safety
> and this might be even worth rewriting code from scratch and
> on the other side there are people who think that dealing with
> new false positives in existing code when adding new warnings
> is already too much of a burden.

Actually, I would be perfectly fine with fixing all locations that have
x < 0 where x is unsigned, even if it's in a macro or something. Those
could be changed to:

	if ((signed)x < 0 || x >=3D 10) {

If they want to allow unsigned compares.

>=20
> > >=20
> > > I would also have a DYNAMIC mode that traps for UB detected at
> > > run-time (but I understand that this is not useful for the kernel).  =
=20
> >=20
> > No, this absolutely is useful.  This is what UBSan does now.
> >  =20
>=20
> Yes, it is similar to UBSan. The ideas to make sure that in the
> mode there is *either* a compile-time warning *or* run-time
> trap for any UB.  So if you fix all warnings, then any remaining
> UB is trapped at run-time.

As long as we allow known UB. We have code that (ab)uses UB behavior in gcc
that can't work without it. For instance, static calls. Now if the compiler
supported static calls, it would be great if we can use that.

What's a static call?

It's a function call that can be changed to call other functions without
being an indirect function call (as spectre mitigations make that horribly
slow). We use dynamic code patching to update the static calls.

It's used for functions that are decided at run time. For instance, are we
on AMD or Intel to decide which functions to implement KVM.

What's the UB behavior? It's calling a void function with no parameters
that just returns where the caller is calling a function with parameters.
That is:

	func(a, b, c)

where func is defined as:

	void func(void) { return ; }

>=20
> >   You're
> > basically talking about exception handling.  How could that not be
> > the most useful thing ever? =20
>=20
> At the moment, I wasn't thinking about a mechanism to catch those
> exceptions, but just to abort the program directly (or just emit
> a diagnostic and continue. =20

Aborting the kernel means crashing the system.

-- Steve

