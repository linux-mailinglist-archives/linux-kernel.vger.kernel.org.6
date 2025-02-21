Return-Path: <linux-kernel+bounces-526436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A536FA3FEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6478E704E00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A702512E7;
	Fri, 21 Feb 2025 18:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="DCM21qme"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F231F0E36;
	Fri, 21 Feb 2025 18:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162234; cv=none; b=E51uctd2RN2Y6vJTuW2bTEXiXA4GequuZN+AET8cMzliITJi3Iubp1yqG5KBqUd9vM0WPww+5PdObX+wQIIqOxkZDpjCw44nacEx7U8kZo3zmOhZB892PqPfltoc6pG9MMD7Gxwub1O1aAf4XmRHlPrnqOUpSBWxvU8gD5QeqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162234; c=relaxed/simple;
	bh=JJS7QruWUFJ8IeCrfzhQBFz5px6Z310Jl8emUW2sx0g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaaQDsOtQ2ioguDQMG+3i4YBFDbVO5ODZqf8LgCLQqJdB8es3paCddCuSPBxSAi3jPRlfpDhKooVvYc0DsNuc0ReKVomOxXKwkqYxjWSu+f77UYd2cKW4daHR0Rr4hefGNJyQY8NfByCERFSHaeMd6Vokjha0+CZ6bdTjYLmTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=DCM21qme; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-233.tugraz.at (vra-171-233.tugraz.at [129.27.171.233])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Yzz625GkKz3wgg;
	Fri, 21 Feb 2025 19:23:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740162219;
	bh=ddA/arXohRuHGlkh46j54jfFS3gTQITB9tdWH3dQ5Lw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DCM21qmecSKhNZWipPsk23RCL9gQnFwN3GWXMkfpyRX89+1clbKf8PBdYoSPdaxVE
	 qoliRK/3fjbOUPsx4eI/xWuT6rdhRyzPUj0yKg1kWLGPihm9JWUS2F8HWHhByvv0dv
	 I2s8e1jxKibPB/pPeYO2d9COznu5QhGepBzkZ6gA=
Message-ID: <59a4f3f7641c47494b53f788684aa703a02acca1.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Fri, 21 Feb 2025 19:23:38 +0100
In-Reply-To: <20250221124304.5dec31b2@gandalf.local.home>
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

Am Freitag, dem 21.02.2025 um 12:43 -0500 schrieb Steven Rostedt:
> On Fri, 21 Feb 2025 17:28:30 +0100
> Martin Uecker <uecker@tugraz.at> wrote:
>=20
>=20
> > >=20
> > > This kind of #pragma is basically banned in the kernel.  It's used
> > > in drivers/gpu/drm but it disables the Sparse static checker. =20
> >=20
> > Why is this?
>=20
> Because they are arcane and even the gcc documentation recommends avoidin=
g
> them.
>=20
>  "Note that in general we do not recommend the use of pragmas"
>  https://gcc.gnu.org/onlinedocs/gcc/Pragmas.html

If you click on the link that provides the explanation, it says

"It has been found convenient to use __attribute__ to achieve a natural
attachment of attributes to their corresponding declarations, whereas
#pragma is of use for compatibility with other compilers or constructs
that do not naturally form part of the grammar. "

Regions of code do not naturally form part of the grammar, and
this is why I would like to use pragmas here. =20


But I still wonder why it affects sparse?

...


> >=20
> > > >=20
> > > > I would also have a DYNAMIC mode that traps for UB detected at
> > > > run-time (but I understand that this is not useful for the kernel).=
  =20
> > >=20
> > > No, this absolutely is useful.  This is what UBSan does now.
> > >  =20
> >=20
> > Yes, it is similar to UBSan. The ideas to make sure that in the
> > mode there is *either* a compile-time warning *or* run-time
> > trap for any UB.  So if you fix all warnings, then any remaining
> > UB is trapped at run-time.
>=20
> As long as we allow known UB. We have code that (ab)uses UB behavior in g=
cc
> that can't work without it. For instance, static calls. Now if the compil=
er
> supported static calls, it would be great if we can use that.
>=20
> What's a static call?
>=20
> It's a function call that can be changed to call other functions without
> being an indirect function call (as spectre mitigations make that horribl=
y
> slow). We use dynamic code patching to update the static calls.
>=20
> It's used for functions that are decided at run time. For instance, are w=
e
> on AMD or Intel to decide which functions to implement KVM.
>=20
> What's the UB behavior? It's calling a void function with no parameters
> that just returns where the caller is calling a function with parameters.
> That is:
>=20
> 	func(a, b, c)
>=20
> where func is defined as:
>=20
> 	void func(void) { return ; }

Calling a function declared in this way with arguments
would be rejected by the compiler, so I am not sure how
this works now.

If you used=20

void func();

to declare the function, this is not possible anymore in C23.


But in any case, I think it is a major strength of C that you can
escape its rules when necessary. I do not intend to change this.
I just want to give people a tool to prevent unintended consequences
of UB.

Martin


