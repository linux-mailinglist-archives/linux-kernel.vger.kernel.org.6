Return-Path: <linux-kernel+bounces-526453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BFDA3FED7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3181188F08A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E5E2512FD;
	Fri, 21 Feb 2025 18:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="JCg4unUf"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19701F03F2;
	Fri, 21 Feb 2025 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740162690; cv=none; b=taaqg06K6KdM6kFELQrsLYPb1LPxTcOzCCKQ5ll75QWUe4Q/NcWggjLEp5/hb9rYFRW7jgVXFnBR0mA4eDvRoTmfTxFpcVx7ziHf5xT72axTFC099OmjuxndF42S9yIt29Rw4ZTrAXwFjKZsqVAp5/0MlJ8GgeVVOIFInh1DrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740162690; c=relaxed/simple;
	bh=MxpumlDwhnylpkxHEgoZ0MXmhXAvcnQNyZqB93PA5AY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zb7Am+3APyH9gL9t/cHQJ8u3GCY2vDBbXCft6S8PrK2mfwxkBu/2xSl9Zxf0P/MaVTk3NGqk63OtKLSZfnn9sz7Dj6heJp6pw0/t/LeynRBg1nYgiBopcNTyM8I5BtmzG5Llg6e+975r/eyU8NlRbSi2HhZuI6Ai/tmc6lO7sx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=JCg4unUf; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-233.tugraz.at (vra-171-233.tugraz.at [129.27.171.233])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4YzzGl5gKZz1LLyr;
	Fri, 21 Feb 2025 19:31:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4YzzGl5gKZz1LLyr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740162672;
	bh=/+dtQ4s+qGuePICY9AN+id1kJcoRIC7mJUtJi5sAuCs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JCg4unUf2mZWL8AqlPSBPf7kO5cMjGm1uMeqrNChJEUDiE6EO5aEjL3cb6NxkwiHj
	 zqWdd3XRmYeg2I1Stxr9SLA94cPZVze+lrjna6OXiGdb2wJR5XgLjKEJj+8MAOxU1A
	 dZ8b1YyhZIduyrlFpYyw4EW21v41/gep59bbslSg=
Message-ID: <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Greg KH
 <gregkh@linuxfoundation.org>, Boqun Feng <boqun.feng@gmail.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>, rust-for-linux
 <rust-for-linux@vger.kernel.org>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Fri, 21 Feb 2025 19:31:11 +0100
In-Reply-To: <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
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

Am Freitag, dem 21.02.2025 um 10:07 -0800 schrieb Linus Torvalds:
> On Fri, 21 Feb 2025 at 09:42, Steven Rostedt <rostedt@goodmis.org> wrote:
> >=20
> > Because they are arcane and even the gcc documentation recommends avoid=
ing
> > them.
> >=20
> >  "Note that in general we do not recommend the use of pragmas"
> >  https://gcc.gnu.org/onlinedocs/gcc/Pragmas.html
>=20
> Yeah, #pragma is complete garbage and should never be used. It's a
> fundamentally broken feature because it doesn't work AT ALL with a
> very core piece of C infrastructure: the pre-processor.
>=20
> Now, we all hopefully know that the C pre-processor is the _real_
> fundamental problem here in how limited it is, but it is what it is.
> Given the fact of how weak C pre-processing is, adding a feature like
> #pragma was a complete failure.

Isn't this what _Pragma() is for? =20

>=20
> So gcc - and other compilers - have figured out alternatives to pragma
> that actually work within the context of the C pre-processor. The main
> one tends to be to use __attribute__(()) to give magical extra
> context.

The issue with __attribute__ is that it is always tied to a specific
syntactic construct.  Possible it could be changed, but then I do
not see a major difference to _Pragma, or?

...[Linus' rant]...

>=20
> This is non-negotiable. Anybody who thinks that a compiler is valid
> warning about
>=20
>          if (x < 0 || x >=3D 10) {
>=20
> just because 'x' may in some cases be an unsigned entity is not worth
> even discussing with.

Do you think the warning is useless in macros, or in general?

Martin





