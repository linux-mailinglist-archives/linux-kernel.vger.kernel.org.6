Return-Path: <linux-kernel+bounces-526808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C21A40390
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2031C3BD556
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF2820AF8E;
	Fri, 21 Feb 2025 23:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="W1tsNPJT"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD441E282D
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740181041; cv=none; b=NLOp1TrI2krxTaS8jrSbaFUU2pstZ3D/n5Zhg73VfbSPcVN0i3sozA20bDscviE9KmwZVcp6emxUW45hqIKVFViOJmxgdEsE0Y6Eb9ks7swd5Ku/IBSi8/WNNfYjZr//HxP3D6IqP+V6vsK3nSgcODYqzUdMTxnMY+ec1uOV03w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740181041; c=relaxed/simple;
	bh=QuF+YyezZll4mS5fKCVTOeni9saCkm+aBxjihJ8FwDw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nn9zgRPTcDJU6cznAsot65CV5D8wvuk0dUWiQLBtaYo7JlUJ55/1EebYKIBX13eH9xDI/TfL0b7mU65IWbfmns59b72a/1rYtxLwYqEaDTaysfLAd+Vq+amXr7NnyZZsQcehV+iYCQAipWDj3Ur8XSZDbJd8JRnTQacraOtSauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=W1tsNPJT; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from [192.168.0.221] (84-115-212-25.cable.dynamic.surfer.at [84.115.212.25])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z063d5md0z1LM09;
	Sat, 22 Feb 2025 00:37:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Z063d5md0z1LM09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740181022;
	bh=GNxPALT6bh+xjA6a7d7X+7z7j13roE7xzn3KU3dbAo4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=W1tsNPJT1j85pi/RTog1sdwJhpG92iWrusXw8Szw+27bdhzHK0O1jez4fwOruiSr7
	 fLgRQoDRlsC8v75XC66IC3av0dpQCluscHTHFL4oIjOzDNjeQTXBilwOyI4nF2DZnt
	 OKc84ejkKIwTXzL+SHkeEm6aKZsjZ53CVV/hmfUo=
Message-ID: <fd053f18e3856d070d695ea969b3fd635272e8e0.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Sat, 22 Feb 2025 00:37:01 +0100
In-Reply-To: <20250221172415.5b632ae6@gandalf.local.home>
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
	 <20250221172415.5b632ae6@gandalf.local.home>
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

Am Freitag, dem 21.02.2025 um 17:24 -0500 schrieb Steven Rostedt:
> On Fri, 21 Feb 2025 11:30:41 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > And yes, it's wrong in general. The problems with "x < 0" warning for
> > an unsigned 'x' are deep and fundamental, and macros that take various
> > types is only one (perhaps more obvious) example of how brokent that
> > garbage is.
>=20
> The bug I recently fixed, and I still constantly make, where this does
> help, is the difference between size_t vs ssize_t. I keep forgetting that
> size_t is unsigned, and I'll check a return of a function that returns
> negative on error with it.
>=20
> If I could just get a warning for this stupid mistake:
>=20
> 	size_t ret;
>=20
> 	ret =3D func();
> 	if (ret < 0)
> 		error();
>=20
>=20
> I'd be very happy.
>=20

GCC has this warning, it is called -Wtype-limits

https://godbolt.org/z/M787vjhfo

It is activated by -Wextra.

(anyway, not at all related to my proposal)

Martin






