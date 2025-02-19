Return-Path: <linux-kernel+bounces-521425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704AEA3BD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D96AA167FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EDC1DF97F;
	Wed, 19 Feb 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0kMR+0s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E871C3C15;
	Wed, 19 Feb 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965075; cv=none; b=UJSt9U/aF4d9vKFafSQpJcq2wlE30WvA1Werva0nbwBWQxvPrQ74e1jpW59To/KcR/Uc/c0Fu3jIRoUoRQ4jzy0uLbK6JiHxQyhtePOs1Zrs//aCnzULV1ZRnja+loc/0ZqU+o3mZu8ShGg+o29YqZZrudGskQzCit4Aru04wWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965075; c=relaxed/simple;
	bh=KZYjJr32GoihH2r+zIe/05ep2vB4mY9HEap1vgQ1zdA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LKR/3VoA1GNH4hfjhE2ohC5w2+4ycDIkXusop56hKi/+kLXEYC5M15akXGUiYGYbQkBZKZIKi3rwcoK4xEvq9BtvxNCS+tKvOi1Ian9RGq08VPjVpHMVNw4jA0qa2RoZa84sJ7OLghzI7Ih7KPuywoIxKNevBpThe6aYvLbyijE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0kMR+0s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C2BC4CEE6;
	Wed, 19 Feb 2025 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739965075;
	bh=KZYjJr32GoihH2r+zIe/05ep2vB4mY9HEap1vgQ1zdA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=M0kMR+0sLcSwubstQzQgRBkpVvs/jnstbHaAND6nwsMm5q5MT2oRgWtGWjqquNTn/
	 jFSCgpox/D7D0ue8wYybwjEgpF8H47gw7iXnRynIudd3Duh5RVgdTpG4LGoOXVvMqS
	 LDbY2RJSt1T2T7S9WTGMOLL45yhHc4EakisNgWIgCUH9LJEQyWapIySa+KVO7Tle8t
	 wYUnICMy5YWwWrpb42xcvYTGslWUayTMaOPPYawJ+MlzboUs+/5rEAvT8iHspY81d2
	 jkn22W5faYzJTc7A0d6s755yoxrdln3l5a6dD23KSDNb9Am1O2d+EdAYttoIGu4iwe
	 EXzpfTS4uGdEw==
Message-ID: <c84254c0164de551189a1f92ddec71f5dc222e42.camel@kernel.org>
Subject: Re: Rust kernel policy
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Christoph Hellwig
 <hch@infradead.org>,  Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Date: Wed, 19 Feb 2025 13:37:50 +0200
In-Reply-To: <CAPM=9txBg1m=qp9=nHJXS1h2XB8TSL1tj6CF=Z802u=YX7hBDg@mail.gmail.com>
References: <Z7SwcnUzjZYfuJ4-@infradead.org>
	 <36783d51be7576fcdbf8facc3c94193d78240816.camel@kernel.org>
	 <4cbd3baf81ca3ff5e8c967b16fc13673d84139e8.camel@kernel.org>
	 <e63089e15c6f4d19e77d2920d576e0134d8b7aa7.camel@kernel.org>
	 <Z7T5_WGX_VXBby9k@boqun-archlinux>
	 <615ce44fa528ad7be28ba518e14a970f04481078.camel@kernel.org>
	 <CAPM=9txBg1m=qp9=nHJXS1h2XB8TSL1tj6CF=Z802u=YX7hBDg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-19 at 16:35 +1000, Dave Airlie wrote:
> On Wed, 19 Feb 2025 at 16:20, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> >=20
> > On Tue, 2025-02-18 at 13:22 -0800, Boqun Feng wrote:
> > > FWIW, usually Rust code has doc tests allowing you to run it with
> > > kunit,
> > > see:
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 https://docs.kernel.org/rust/testing.h=
tml
> >=20
> > I know this document and this was what I used to compile DMA
> > patches.
> > Then I ended up into "no test, no go" state :-)
> >=20
> > I put this is way. If that is enough, or perhaps combined with
> > submitting-patches.rst, why this email thread exists?
>=20
> There is users for the DMA stuff (now there should be some more
> tests), the problem is posting the users involves all the precursor
> patches for a bunch of other subsystems,
>=20
> There's no nice way to get this all bootstrapped, two methods are:
>=20
> a) posting complete series crossing subsystems, people get pissed off
> and won't review because it's too much
> b) posting series for review that don't have a full user in the
> series, people get pissed off because of lack of users.
>=20
> We are mostly moving forward with (b) initially, this gets rust folks
> to give reviews and point out any badly thought out rust code, and
> give others some ideas for what the code looks like and that it
> exists
> so others don't reinvent the wheel.
>=20
> Maybe we can add more rust tests to that particular patch series? but
> this is the wrong thread to discuss it, so maybe ask on that thread
> rather on this generic thread.

Here's one way to do it:

1. Send the patch set as it is.
2. Point out to Git tree with branch containing the patches + patches
   for e.g. driver (hopefully for something that QEMU is able to emulate)
   and other stuff/shenanigans that allows to test them.

Then I can go and do git remote add etc. and compile a BuildRoot image
using my environment by setting LINUX_OVERRIDER_SRCIDR, test it and
call it a day.

> Dave.

[1] https://codeberg.org/jarkko/linux-tpmdd-test

BR, Jarkko

