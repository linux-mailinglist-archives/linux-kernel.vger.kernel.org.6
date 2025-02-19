Return-Path: <linux-kernel+bounces-521639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C52A3C03B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2063B920D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8231E7C23;
	Wed, 19 Feb 2025 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+oJ4hdy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C645C14;
	Wed, 19 Feb 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739972431; cv=none; b=oB9qqCSiypSarOPMeJo++3nqMqPfh9LIfpwBkdbYE3bDAzgw6SHR/IuCqiIDfBNX3F4rZFey6dEtjVsRa6Zu1Nx71pWsYcuLbpQ+rmFioLkwCU95vcROFn6sjgbq7/+zxVkb59mKduEEU8Zj+hpEwRAOKhYyjf7twluGSQdS5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739972431; c=relaxed/simple;
	bh=Ou5pxRezs1aBOt3lM/TjdmGtd6VomJ3FNkyrguOOr08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dV6vLeZHi/W13cFCRZzxV9Hd5cpSVwsnCMIx9rw82STUAnXZHeR6oMd9ga2Ng/HfyzfuAuKjrdZNEW8HD5hJnXKk3jv5sQFo+Yp7qZHtPfbQJxzNjgDYbPUx03gC2EGZWKfmAjQmslL4dH7iNWc67vB6Ed5N+Sux5tJ9aZlsiJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+oJ4hdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F5EC4CED1;
	Wed, 19 Feb 2025 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739972430;
	bh=Ou5pxRezs1aBOt3lM/TjdmGtd6VomJ3FNkyrguOOr08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=o+oJ4hdyECBra1THVr/8eFpFQhLg2bnNUT167GbdCNDq+ZMWpFJEpVjKyT2MJUAqj
	 1qjXAb83qsndH+sG5f2mg9mKciz4YBp/f3M3i1yXSCKPZG8x1wIhXIVICJwSVi8Kot
	 TGSoiQR4Py6/czmIBxL84zr9lK+2iLlDruOSkQF3yn1p26WmMlZ6Q5ut837mESOm8p
	 PygKz7ig5S6IN5qHmTXAqn3uOHurf333GEiBHtWuiZk4yEZ/tekYDhpuvuELjj9fIp
	 lqsa/KjzIueQ+Op3svL3W9oj6mihPzMFuFq8RHtn7B/GwikL6de/OYGRzGpW/wkWnE
	 5RdEBn/+EF42w==
Message-ID: <db09c80285c412725a1857588d2a38f987a28996.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dave Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Christoph Hellwig	 <hch@infradead.org>, Miguel Ojeda
 <miguel.ojeda.sandonis@gmail.com>,  rust-for-linux
 <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH	 <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, 	ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 15:40:25 +0200
In-Reply-To: <CAMuHMdWNQfmNgMBkkMezeUt573fczzyf7FhXKEo7621xuhWC4Q@mail.gmail.com>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
	 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
	 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
	 <Z7T5_WGX_VXBby9k@boqun-archlinux>
	 <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
	 <CAPM=9txBg1m=qp9=nHJXS1h2XB8TSL1tj6CF=Z802u=YX7hBDg@mail.gmail.com>
	 <c84254c0164de551189a1f92ddec71f5dc222e42.camel@kernel.org>
	 <CAMuHMdWNQfmNgMBkkMezeUt573fczzyf7FhXKEo7621xuhWC4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 14:25 +0100, Geert Uytterhoeven wrote:
> Hi Jarkko,
>=20
> On Wed, 19 Feb 2025 at 12:39, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> > On Wed, 2025-02-19 at 16:35 +1000, Dave Airlie wrote:
> > > On Wed, 19 Feb 2025 at 16:20, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > > On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> > > > > FWIW, usually Rust code has doc tests allowing you to run it
> > > > > with
> > > > > kunit,
> > > > > see:
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://docs.kernel.org/rust/testi=
ng.html
> > > >=20
> > > > I know this document and this was what I used to compile DMA
> > > > patches.
> > > > Then I ended up into "no test, no go" state :-)
> > > >=20
> > > > I put this is way. If that is enough, or perhaps combined with
> > > > submitting-patches.rst, why this email thread exists?
> > >=20
> > > There is users for the DMA stuff (now there should be some more
> > > tests), the problem is posting the users involves all the
> > > precursor
> > > patches for a bunch of other subsystems,
> > >=20
> > > There's no nice way to get this all bootstrapped, two methods
> > > are:
> > >=20
> > > a) posting complete series crossing subsystems, people get pissed
> > > off
> > > and won't review because it's too much
> > > b) posting series for review that don't have a full user in the
> > > series, people get pissed off because of lack of users.
> > >=20
> > > We are mostly moving forward with (b) initially, this gets rust
> > > folks
> > > to give reviews and point out any badly thought out rust code,
> > > and
> > > give others some ideas for what the code looks like and that it
> > > exists
> > > so others don't reinvent the wheel.
> > >=20
> > > Maybe we can add more rust tests to that particular patch series?
> > > but
> > > this is the wrong thread to discuss it, so maybe ask on that
> > > thread
> > > rather on this generic thread.
> >=20
> > Here's one way to do it:
> >=20
> > 1. Send the patch set as it is.
>=20
> You mean the series from b) above, right?
> (To be repeated for each subsystem for which you have such a series).

Ya.
>=20
> > 2. Point out to Git tree with branch containing the patches +
> > patches
> > =C2=A0=C2=A0 for e.g. driver (hopefully for something that QEMU is able=
 to
> > emulate)
> > =C2=A0=C2=A0 and other stuff/shenanigans that allows to test them.
>=20
> Exactly.

OK, great. As long as I have some reasonable means to put it live,
I'm totally fine.=20

>=20
> Gr{oetje,eeting}s,
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Geert
>=20

BR, Jarkko

