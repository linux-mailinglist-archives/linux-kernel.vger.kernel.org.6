Return-Path: <linux-kernel+bounces-523234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A66FBA3D3D1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2751890E75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3651EBFFD;
	Thu, 20 Feb 2025 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="iHI39HL9"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41577179A7;
	Thu, 20 Feb 2025 08:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041862; cv=none; b=gp3jxy0Zja4SeAh779dT8AbQrn1doOgsPFFNfGU9Hg/onk23Yn5LNpjQcjlH01bPsY99zF14clGSE5kBeD6Ar9MnM8q/smtaFpoH4sZcT8PNQx+G2rXyeDgtmcxfLGvfz+++HztLqZGkRaHY8xXHsDbf1MUH+gBx/THaK2xpD2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041862; c=relaxed/simple;
	bh=G/gVJPNMpPDZIVUs4ZDdcewvmRtxv1X63Vhw+bB/80c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AqTk9ty7JUTZF3xEhebEATFiXgDgFY3t7evfd+sMfK8QZ75yJjFQdQG0vxbiQHkzC5cMjr6o1Rz9tM3ixTE/XVdXDry/vAKXVfSKvTa4alPUArZ+ZFw8Rg23xeNbgdNYHo3sKjB9hp4vEVZzb8QKBJ6PYPkxSDTaPkF2jKQq184=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=iHI39HL9; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-197.tugraz.at (vra-171-197.tugraz.at [129.27.171.197])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Yz6bG0M1fz1JJCX;
	Thu, 20 Feb 2025 09:57:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailrelay.tugraz.at 4Yz6bG0M1fz1JJCX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740041851;
	bh=534sbKTPRc7qHLB2YPR/YBjYkUkFE06mby8ks5Lw8Ew=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iHI39HL91aLUMbJnTq4yXwFllS62GrBQfohmv+pnMIj/wTJM5uoySVWEhL2NEUs+1
	 x0QBcWAmPMfKMET/U6IjWAxNvwF3c9zHw1KfDsTZB8St6knyJQXn13oyTno6KG9was
	 4oxDoyM5+3vFKVa2NDgtvBBX/OfZHM4Er0hNoss8=
Message-ID: <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig
 <hch@infradead.org>, rust-for-linux <rust-for-linux@vger.kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>,  David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Thu, 20 Feb 2025 09:57:29 +0100
In-Reply-To: <2025022024-blooper-rippling-2667@gregkh>
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

Am Donnerstag, dem 20.02.2025 um 08:10 +0100 schrieb Greg KH:
> On Thu, Feb 20, 2025 at 08:03:02AM +0100, Martin Uecker wrote:
> > Am Mittwoch, dem 19.02.2025 um 06:39 +0100 schrieb Greg KH:
> > > On Tue, Feb 18, 2025 at 07:04:59PM -0800, Boqun Feng wrote:
> > > > On Tue, Feb 18, 2025 at 04:58:27PM -0800, H. Peter Anvin wrote:
> > > > [...]
> > > > > > >=20
> > ...
> > >=20
> > >=20
> > > I'm all for moving our C codebase toward making these types of proble=
ms
> > > impossible to hit, the work that Kees and Gustavo and others are doin=
g
> > > here is wonderful and totally needed, we have 30 million lines of C c=
ode
> > > that isn't going anywhere any year soon.  That's a worthy effort and =
is
> > > not going to stop and should not stop no matter what.
> >=20
> > It seems to me that these efforts do not see nearly as much attention
> > as they deserve.
>=20
> What more do you think needs to be done here?  The LF, and other
> companies, fund developers explicitly to work on this effort.  Should we
> be doing more, and if so, what can we do better?

Kees communicates with the GCC side and sometimes this leads to
improvements, e.g. counted_by (I was peripherily involved in the
GCC implementation). But I think much much more could be done,
if there was a collaboration between compilers, the ISO C working
group, and the kernel community to design and implement such
extensions and to standardize them in ISO C.

>=20
> > I also would like to point out that there is not much investments
> > done on C compiler frontends (I started to fix bugs in my spare time
> > in GCC because nobody fixed the bugs I filed), and the kernel=C2=A0
> > community also is not currently involved in ISO C standardization.
>=20
> There are kernel developers involved in the C standard committee work,
> one of them emails a few of us short summaries of what is going on every
> few months.  Again, is there something there that you think needs to be
> done better, and if so, what can we do?
>=20
> But note, ISO standards work is really rough work, I wouldn't recommend
> it for anyone :)

I am a member of the ISO C working group. Yes it it can be painful, but
it is also interesting and people a generally very nice.

There is currently no kernel developer=C2=A0actively involved, but this wou=
ld
be very helpful.

(Paul McKenney is involved in C++ regarding atomics and Miguel is
also following what we do.)

>=20
> > I find this strange, because to me it is very obvious that a lot more
> > could be done towards making C a lot safer (with many low hanging fruit=
s),
> > and also adding a memory safe=C2=A0subset seems possible.
>=20
> Are there proposals to C that you feel we should be supporting more?

There are many things.

For example, there is an effort to remove cases of UB.  There are about
87 cases of UB in the core language (exlcuding preprocessor and library)
as of C23, and we have removed 17 already for C2Y (accepted by WG14 into
the working draft) and we have concrete propsoals for 12 more. =C2=A0This
currently focusses on low-hanging fruits, and I hope we get most of the
simple cases removed this year to be able to focus on the harder issues.

In particulary, I have a relatively concrete plan to have a memory safe
mode for C that can be toggled for some region of code and would make
sure there is no UB or memory safety issues left (I am experimenting with
this in the GCC FE).=C2=A0 So the idea is that one could start to activate =
this
for certain critical=C2=A0regions of code to make sure there is no signed
integer overflow or OOB access in it.   This is still in early stages, but
seems promising. Temporal memory safety is harder and it is less clear
how to do this ergonomically, but Rust shows that this can be done.


I also have a proposal for a length-prefixed string type and for=C2=A0
polymorhic types / genericity, but this may not be so relevant to the
kernel at this point.

Even more important than ISO C proposals would be compiler extensions
that can be tested before standardization.


Martin




