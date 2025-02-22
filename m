Return-Path: <linux-kernel+bounces-527000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D753A40610
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 08:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1C6189D863
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 07:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCFB202C3A;
	Sat, 22 Feb 2025 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="J16ksXje"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D9A1FA15E;
	Sat, 22 Feb 2025 07:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740208832; cv=none; b=tMxTscY2h0Jc1U75FPoq4juAb/farlP9WAdk7Ta6EUQKvZis9yMsyIwHObLxndDzgWuY+6jHtr+kos9fmAjtSY5JhZwq66SABtNdkxthq6t8IPOgG721K3IQyu1PY0Vw1E29afXs7G7N7QqEwzvgRZa6E3gd/lbvmGtLO3Wp8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740208832; c=relaxed/simple;
	bh=oagXNzkOV6KSuctkCl5gvSg2Z1l3eJ73jxyB1wAI6Js=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=burB0DDB2etN3k20H9/9WCyPsDHt0NV7kikJnmkTrRGMQyk9wQ/MfnOY09AnVoBI1sqDjZd/By+s3R5RpxLO2IPUiEpu/ems5vOy6q8uIZL2VXMhkefgLlrLXm+AyTn4wS4Smja8/C1XZT/mVxBXDMwBbcbytv6Z15OItul5zsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=J16ksXje; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-156.tugraz.at (vra-171-156.tugraz.at [129.27.171.156])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z0JL519GMz3wGD;
	Sat, 22 Feb 2025 08:20:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740208815;
	bh=SmYAkhIaHBL8Km4TDg1K0OIvSYnVEOYNlWg73OMrNRc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=J16ksXjeKtAfbR1UV3GeK0MInBhz4XIycAc3r+x7p1gbNeNMWCj6yyDv/bmwnRbGQ
	 c2HavY7eNd08wsYSDkoMUvVXUbVS+n9Ankd5Kuvqz91qB4/DF2zmCyRp8UrTTlR00+
	 ciEGzkM6mQ5YQeKzUQuKcquz/YNSFhwTw+aYNIEY=
Message-ID: <e525cd59ebec54b153f56b602b545007fc03f12a.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Boqun
 Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org,  ksummit@lists.linux.dev
Date: Sat, 22 Feb 2025 08:20:12 +0100
In-Reply-To: <CAHk-=wj5Rt_xhp_n4_gEyGG9LKFOiTrsvN0ueo3q5PyjJPU+AQ@mail.gmail.com>
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
	 <008cc0939c130ee24fbc71a0407ff82772076668.camel@tugraz.at>
	 <CAHk-=wj5Rt_xhp_n4_gEyGG9LKFOiTrsvN0ueo3q5PyjJPU+AQ@mail.gmail.com>
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

Am Freitag, dem 21.02.2025 um 12:11 -0800 schrieb Linus Torvalds:
> On Fri, 21 Feb 2025 at 11:59, Martin Uecker <uecker@tugraz.at> wrote:
> >=20
> > The standardized version of __attribute__(()) would look like
> >=20
> > [[safety(ON)]];
> > ....
> >=20
> > [[safety(OFF)]];
> >=20
> > which is not bad (and what C++ seems to plan for profiles),
> > but this also does not nest and is a bit more limited to where
> > it can be used relative _Pragma.  I don't really see any advantage.
> >=20
> > GCC has
> >=20
> > #pragma GCC diagnostic push "-Wxyz"
> > #pragma GCC diagnostic pop
> >=20
> > for nesting. Also not great.
>=20
> I realize that the manual nesting model can be useful, but I do think
> the "default" should be to aim for always associating these kinds of
> things with actual code (or data), and use the normal block nesting
> rules.
>=20
> If you are writing safe code - or better yet, you are compiling
> everything in safe mode, and have to annotate the unsafe code - you
> want to annotate the particular *block* that is safe/unsafe. Not this
> kind of "safe on/safe off" model.
>=20
> At least with the __attribute__ model (or "[[..]]" if you prefer that
> syntax) it is very much designed for the proper nesting behavior.
> That's how attributes were designed.

There is no way to attach a GCC attribute to
a compound-statement.   For [[]] this is indeed allowed,
so you could write

void f()
{
	[[safety(DYNAMIC)]] {
	}
}

but then you also force the user to create compound-statement.
Maybe this is what we want, but it seems restrictive.  But I
will need to experiment with this anyhow to find out what works
best.

>=20
> Afaik #pragma has _no_ such mode at all (but hey, most of it is
> compiler-specific random stuff, so maybe some of the #pragma uses are
> "this block only"), and I don't think _Pragma() is not any better in
> that respect (but again, since it has no real rules, again I guess it
> could be some random thing for different pragmas).

For all the STDC pragmas that already exist in ISO C, they are
effective until the end of a compund-statement.  These pragmas
are all for floating point stuff.

void f()
{
#pragma STDC FP_CONTRACT ON
}
// state is restored

but you also toggle it inside a compund-statement


void f()
{
#pragma STDC FP_CONTRACT ON
   xxx;
#pragma STDC FP_CONTRACT OFF
   yyy;
}
// state is restored


The problem with those is currently, that GCC does not=C2=A0
implement them. =20

I will need to think about this more.

Martin



