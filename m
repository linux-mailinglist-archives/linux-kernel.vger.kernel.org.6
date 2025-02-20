Return-Path: <linux-kernel+bounces-523860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBCFA3DC30
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9603A160C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EC01BD9FA;
	Thu, 20 Feb 2025 14:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="kLKtEQvS"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A7B1BC073;
	Thu, 20 Feb 2025 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060574; cv=none; b=lsXIbBrxU7hkJcx1gdBBq/i7svsQe5e6Zw5DWxsf5FKvNImj6ZenmqMPgLkvoUrN7B8dBana/cMDbBN5eVMK6/QzAOE2SFDZCrukLLqiK8HfO61HRgv+myNNYzPqdmWwKtgUeN7WUl8lnqHgbLeDUm4jVvQZeIuDOpETrWOzJAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060574; c=relaxed/simple;
	bh=i3lojv9jXoafhxwWr5vyNvm/ejeuGaXs3UkBEGJVqbg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U6IQvj/DwutsHVKZOIg6TxC7oQMGt0b+lHkTdmGXr00rVtY4sicTDCNuy7jtd+rYvDcdoJEG1Gz4zbiacGg6PiLQD45/pBVHXiSww1V8XnVzHnVRdW2HyqBvxnuRrO2GubhOaQ6jXUSRUmgy+XU9kgGbnUoOPscgh9UQwYIAmoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=kLKtEQvS; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-197.tugraz.at (vra-171-197.tugraz.at [129.27.171.197])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4YzFW60G74z3wZp;
	Thu, 20 Feb 2025 15:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740060564;
	bh=HztTRfmRt7WiQiZUmT+AkwOLG4UPjcXadpDkmMR2uVE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kLKtEQvSAsAM0lJQ13jTmiBk4YudiFJERltVS/TR98sarsF9pUDFYiTXrcei0lauz
	 cZ1/DTfk/mWTJ9iyjoX8FI48XvDTiR4L4PjGEIyQNI8lxY5W/PQBdj3ccnNM/Quajy
	 kexFPU8TTDDDE54FvGeQkY1BKcT5tPf7FA2QUUjA=
Message-ID: <1f31a16d3898e0e9b5d94f9bcc12a1b73ac97982.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>,
  "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev, Justin Stitt
 <justinstitt@google.com>, Kees Cook <keescook@chromium.org>
Date: Thu, 20 Feb 2025 15:09:21 +0100
In-Reply-To: <962fa158-5315-4d93-afb1-8a1c08787ad8@stanley.mountain>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
	 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <962fa158-5315-4d93-afb1-8a1c08787ad8@stanley.mountain>
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

Am Donnerstag, dem 20.02.2025 um 16:46 +0300 schrieb Dan Carpenter:
> On Thu, Feb 20, 2025 at 09:57:29AM +0100, Martin Uecker wrote:
> > In particulary, I have a relatively concrete plan to have a memory safe
> > mode for C that can be toggled for some region of code and would make
> > sure there is no UB or memory safety issues left (I am experimenting wi=
th
> > this in the GCC FE).=C2=A0 So the idea is that one could start to activ=
ate this
> > for certain critical=C2=A0regions of code to make sure there is no sign=
ed
> > integer overflow or OOB access in it.
>=20
> I don't think diferentiating between signed and unsigned integer
> overflows is useful.  In the kernel, most security issues from integer
> overflows are from unsigned integer overflows.  Kees says that we
> should warn about "Unexpected" behavior instead of "Undefined".  In fact,
> Justin Stitt has done the opposite of what you're doing and only checks
> for unsigned overflows.  He created a sanitizer that warns about integer
> overflows involving size_t type (which is unsigned), because sizes are
> so important.  (Checking only size_t avoids probably the largest source
> of harmless integer overflows which is dealing with time).

I agree with you.  We were also discussing an attribute that
can be attached to certain unsigned types to indicate that
wrapping is an error.=C2=A0

My more limited aim (because my personal time is very limited)
is to define a memory safe subset and in such a subset you can
not have UB.  Hence, I am more focussed on signed overflow at
the moment, but I agree that safety in general must go beyond=C2=A0
this.

But this is why I want the kernel community to be more involved,
to get more resources and more experience into these discussions.

>=20
> The sanitizer has a list of exceptions like if (a < a + b) where the
> integer overflow is idiomatic.  But the concern was that there might be
> other deliberate integer overflows which aren't in the exception list so
> Justin also created a macro to turn off the santizer.
>=20
> 	x =3D wrapping_ok(a + b);

Indeed. This is the main issue with unsigned wraparound. Exactly
because it was always defined, simply screening for wraparound
yields many false positives.=20

(BTW: Rust is also not perfectly immune to such errors:
https://rustsec.org/advisories/RUSTSEC-2023-0080.html)


>=20
> What I would like is a similar macro so we could write code like:
>=20
> 	x =3D saturate_math(a + b + c + d * d_size);
>=20
> If anything overflowed the result would be ULONG_MAX.  In the kernel,
> we have the size_add() and size_mul() macros which do saturation math
> instead of wrapping math but we'd have to say:
>=20
> 	x =3D size_add(a, size_add(b, size_add(c, size_add(size_mul(d, d_size)))=
));
>=20
> Which is super ugly.  Maybe we could create something like this macro?
>=20
> #define saturate_math(x) ({             \
>         unsigned long res;              \
>         __trap_overflow(label_name));   \
>         res =3D (x);                      \
>         if (0) {                        \
> lable_name:                             \
>                 res =3D ULONG_MAX;        \
>         }                               \
>         res;                            \
> })
>=20

We added checked arhithmetic to C23, we could add saturating
math to C2Y if this is needed.  (although I admit I do not fully
understand the use case of saturating math, a saturated value
still seems to be an error? Statistics, where it does not matter?)

In general, if people have good ideas what compilers or the language
standard can do to help, please talk to us. It is possible to
improve compilers and/or the language itself.


Martin



