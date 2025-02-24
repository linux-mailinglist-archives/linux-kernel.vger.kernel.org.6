Return-Path: <linux-kernel+bounces-529762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3EA42A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0680B1749A7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF458265CC5;
	Mon, 24 Feb 2025 18:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="i8vU9Uug"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C34265608;
	Mon, 24 Feb 2025 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420230; cv=none; b=ijBqcPWfeT9WI8YLE6rgJ6M1gnHi2fh7b5VETn2l0nXnvYjYBwPOW7w+4ZFbNAShhToXJLifyX9hyvNK7sMrz8CNontjjLj4y27KNSF9gCyDvNJj69x7WcsNpy1vRBpFJ+X1duEF5fUQNlKHyb4spTs51SOt/E2q59IQVz1GJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420230; c=relaxed/simple;
	bh=kgS6tl3sjqYHu8Z2Hut86zbfzpe9Le99z3Oiy4gdsDo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlTIsYtx1FW2QjS2o4WUe6Bf4iv0xwaTXrt0Y+sgKC5A/mER8IUAHA30TIq1sKM5VRcCR8PiPPj/3joCREnWCM7rJo/nQZpAA3/qNeDuEbMz/qfN20Q/V2KalZJyDHBTdoD6/tpjVrp5vsQc2fRgVZ0oIukFEJAWY6e4hs6afes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=i8vU9Uug; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-172-237.tugraz.at (vra-172-237.tugraz.at [129.27.172.237])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z1pWJ4xJYz3wgT;
	Mon, 24 Feb 2025 19:03:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740420206;
	bh=EhyQQ1r9GBwoAc8Pib4lGe285ISIQG0p+4Ce6uKE6+0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i8vU9UugBItrV4jUcKhF7RmuHr3OUuTFxxDtiabiFBGf8k5ofeYMT9kU4r4GdDrcC
	 xAPGSAsm4f5oKqSUpXoZDVPgNH5nLRMxmjcvdZrWGrm25B3Q8jMkbxYTHfpdDP4A4n
	 zuBwSJMffYJWSlcBZFr1rHQPc+q2IwonUIjjH5/E=
Message-ID: <636f5758062a5ba930e8a73454e15f2fe29fdccf.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Ventura Jack <venturajack85@gmail.com>, comex <comexk@gmail.com>
Cc: Piotr =?UTF-8?Q?Mas=C5=82owski?= <piotr@maslowski.xyz>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, David Airlie <airlied@gmail.com>, 
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Mon, 24 Feb 2025 19:03:24 +0100
In-Reply-To: <CAFJgqgSCW9XbVYr7yTa47Miax+LGM9jNNE5Yuw1xQE2BZ9gkTQ@mail.gmail.com>
References: 
	<CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
	 <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
	 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
	 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
	 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com>
	 <Z7VKW3eul-kGaIT2@Mac.home> <2025021954-flaccid-pucker-f7d9@gregkh>
	 <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <D7ZDF8NZGPS3.3QBMAVC1NTUDM@maslowski.xyz>
	 <E0BD1BDB-0EBC-4E27-9324-7CA70ACE194B@gmail.com>
	 <CAFJgqgSCW9XbVYr7yTa47Miax+LGM9jNNE5Yuw1xQE2BZ9gkTQ@mail.gmail.com>
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

Am Montag, dem 24.02.2025 um 02:08 -0700 schrieb Ventura Jack:
> On Sun, Feb 23, 2025 at 4:32=E2=80=AFPM comex <comexk@gmail.com> wrote:
> >=20
> > > On Feb 22, 2025, at 3:42=E2=80=AFPM, Piotr Mas=C5=82owski <piotr@masl=
owski.xyz> wrote:
> > >=20
> > > I'm sure you already know this, but the idea of safety in Rust isn't
> > > just about making elementary language constructs safe. Rather, it is
> > > primarily about designing types and code in such a way one can't "use
> > > them wrong=E2=80=9D.
> >=20
> > And importantly, it=E2=80=99s very hard to replicate this approach in C=
, even
> > in a hypothetical =E2=80=98C + borrow checker=E2=80=99, because C has n=
o generic types. =C2=A0
> >=20

One can have generic types in C.  Here is an example
for Option<T> (I called it "maybe").  I don't think
it is too bad (although still an experiment):=20

https://godbolt.org/z/YxnsY7Ted

(The example can also be be proven safe statically)

Here is an example for a vector type (with bounds
checking):

https://godbolt.org/z/7xPY6Wx1T

> > Not all abstractions need generics, but many do.
>=20
> True, a more expressive and complex language like Rust, C++, Swift,
> Haskell, etc. will typically have better facilities for creating good
> abstractions. That expressiveness has its trade-offs. I do think the
> costs of expressive and complex languages can very much be worth it
> for many different kinds of projects. A rule of thumb may be that a
> language that is expressive and complex, may allow writing programs
> that are simpler relative to if those programs were written in a
> simpler and less expressive language. But one should research and be
> aware that there are trade-offs for a language being expressive and
> complex. In a simplistic view, a language designer will try to
> maximize the benefits from expressiveness of a complex language, and
> try to minimize the costs of that expressiveness and complexity.
>=20
> Rust stands out due to its lifetimes and borrow checker, in addition
> to it being newer and having momentum.
>=20
> What are the trade-offs of a more complex language? One trade-off is
> that implementing a compiler for the language can be a larger and more
> difficult undertaking than if the language was simpler. As an example,
> to date, there is only one major Rust compiler, rustc, while gccrs is
> not yet ready. Another example is that it can be more difficult to
> ensure high quality of a compiler for a complex language than for a
> simpler language.

I also point out that the way Rust and C++ implement generics
using monomorphization has a substantial cost in terms of
compile time and code size.

Martin




