Return-Path: <linux-kernel+bounces-527103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D853A4075A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4394209DE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF07C205E2F;
	Sat, 22 Feb 2025 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="FmnnHWlT"
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9E3202C3D;
	Sat, 22 Feb 2025 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740219939; cv=none; b=gumsKQi1ludnTuIfzSE4vAv7GIdiHI4sSYGRhcIVStXGU72zfY0NEc+muJnHo9meMUGEbVPFQs3Ux0CabXBZY+HJdQbAaNciymvU98Fu+RD7E3du7tayyNRVMU9c71IMlBY8JgD2p94qbb//G9fu+rLNd58Eg7FjFSiqZPV0TB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740219939; c=relaxed/simple;
	bh=tyiAHtbLAJ21Cb31CY2CQ3GNp9d61odjzjZboJuuuEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYY6aIgPZDwcKTcb0ZDQ6StsCRTPQYvw8RVXoTFZ0zZ6OdGeIo+Oe6Ylt6JiWurh0+DpRmdHHEewLureCF9jpzMC8wQ/xSHnp1Q174tkGlJ+zNTbKiLOv5g29kUYqfk6sTfeZkt6HX5/9bnmpB2jCokMCIjc4nlnI0/Mpb+cTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=FmnnHWlT; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
Received: from vra-171-156.tugraz.at (vra-171-156.tugraz.at [129.27.171.156])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4Z0NRp29k4z3wpW;
	Sat, 22 Feb 2025 11:25:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1740219928;
	bh=OmyxfvODvDL9ve3sSlMaD3r+xn6MspfOsKhfHrgpN38=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FmnnHWlTI0iuO6ENDIA1fmuCzc+ZVMvTPmCVoMWMRDEFU245u52QrxBmWZmoIWzGb
	 RzIhOK2ysFtnrRJfouAjRrGfnoJAlW+898bkJjbE0Z7czoFL2VrlRj/dJmJKdZy8x+
	 NGamuXUcb8n7bMfx7l+rR329cE8kfAqVMt/+J3NU=
Message-ID: <5eb6554f5f600f09d5072bc524757912a36c5057.camel@tugraz.at>
Subject: Re: Rust kernel policy
From: Martin Uecker <uecker@tugraz.at>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, Greg KH <gregkh@linuxfoundation.org>, Boqun Feng
 <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
 rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie
 <airlied@gmail.com>, linux-kernel@vger.kernel.org,  ksummit@lists.linux.dev
Date: Sat, 22 Feb 2025 11:25:26 +0100
In-Reply-To: <1cf1d64b-128d-4dbe-8427-98405652944b@stanley.mountain>
References: <4e316b01634642cf4fbb087ec8809d93c4b7822c.camel@tugraz.at>
	 <2025022024-blooper-rippling-2667@gregkh>
	 <1d43700546b82cf035e24d192e1f301c930432a3.camel@tugraz.at>
	 <2025022042-jot-favored-e755@gregkh>
	 <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
	 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain>
	 <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
	 <20250221124304.5dec31b2@gandalf.local.home>
	 <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
	 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
	 <1cf1d64b-128d-4dbe-8427-98405652944b@stanley.mountain>
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

Am Samstag, dem 22.02.2025 um 12:45 +0300 schrieb Dan Carpenter:
> On Fri, Feb 21, 2025 at 07:31:11PM +0100, Martin Uecker wrote:
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
> This is a fair question.  In smatch I often will turn off a static
> checker warnings if they're inside a macro.  For example, macros will
> have NULL checks which aren't required in every place where they're
> used so it doesn't make sense to warn about inconsistent NULL checking
> if the NULL check is done in a macro.
>=20
> In this unsigned less than zero example, we can easily see that it works
> to clamp 0-9 and the compiler could silence the warning based on that.
> I mentioned that Justin filtered out idiomatic integer overflows like
> if (a < a + b) { and we could do the same here.  That would silence most
> of the false positives.  It's a culture debate not a technical problem.
>=20
> Silencing the checks inside macros would silence quite a few of the
> remaining false positives.  In Smatch, I've silenced a few false
> positives that way for specific macros but I haven't felt the need to
> go all the way and turning the check off inside all macros.
>=20
> There are also a handful of defines which can be zero depending on the
> circumstances like DPMCP_MIN_VER_MINOR:
>=20
> 	if (dpmcp_dev->obj_desc.ver_minor < DPMCP_MIN_VER_MINOR)
> 		return -ENOTSUPP;
>=20
> Or another example is in set_iter_tags()
>=20
>         /* This never happens if RADIX_TREE_TAG_LONGS =3D=3D 1 */
>         if (tag_long < RADIX_TREE_TAG_LONGS - 1) {
>=20
> The other thing is that in Smatch, I don't try to silence every false
> positives.  Or any false positives.  :P  So long as I can handle the work
> load of reviewing new warnings it's fine. I look at a warning once and
> then I'm done.

Thanks, this is useful.  I was asking because it would be relatively
easy to tweak the warnings in GCC too. GCC has similar heuristics for
other warnings to turn them off in macros and one can certainly also
make it smarter.  (Again, the two problems here seem lack of communication
and lack of resources.  One needs to understand what needs to be done
and someone has to do it. But even a limited amount of time/money could
make a difference.)

Martin


>=20


