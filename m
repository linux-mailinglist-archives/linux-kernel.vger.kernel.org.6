Return-Path: <linux-kernel+bounces-214597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A328A9086F1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D242285253
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDCB1922DB;
	Fri, 14 Jun 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="KPa+R5oK"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279B146A7A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355745; cv=none; b=IDZnsnWMdAEO7IDcEGhDJWLhn1GEUisTUE/kaSj2QwqVLjuFsfT3QdbnHXERFKhgbm32k+9oHK7kYYNPBWTS1cKgtAaAl4ypC/mucm68WeayAkrUdTJNLyB2OzTTqVqlCk9NdZ/CuxPKPP6ZI9u/bVrDHeKYQTlaT4kP123AiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355745; c=relaxed/simple;
	bh=kLmziNlU4IUEgtUcJiUaFf1IZylaN9GSdXDb3FGyVUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Do8C3mRJXuuOMhVyZ/Z9CXrjsOViQIMStZP+kG436iaauVCOkmUuzOXBhpQNxWceCqV/REC20POp+DHzNnRUue0q4c3Vn688HWg3Huy09Wvl4UHEOh0XtsoS1oSbmeruT1G7vdv+7HhOQPsJ+SLcVSDEfbbfVFxh58E1+jCdENk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=KPa+R5oK; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 0EC2F1C00A6; Fri, 14 Jun 2024 11:02:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718355739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gajs+YblsbGQm7Fi/g3ZN116bv4CeCZehq41ao50w6c=;
	b=KPa+R5oKiqXt0nb3JGCEWUks7t6CvwkjeG6hBTijaj2tQzqjTSWmuzzD8n8vGhMSHV9iLI
	rzKWnzkDu4xynF5CkQrLGNjmNGQNIlXV59zkL378ei5yr3ncoUkJeKCHfL3TpQe14MDxmq
	mXA71RrWoNl7iVRkllVeJq6QlifCy1Q=
Date: Fri, 14 Jun 2024 11:02:18 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZmwHGviv/6J6FQLf@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iUClFSfoZ6LpOrmC"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>


--iUClFSfoZ6LpOrmC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2024-06-13 09:17:24, Linus Torvalds wrote:
> On Thu, 13 Jun 2024 at 04:09, Pavel Machek <pavel@ucw.cz> wrote:
> >
> > I tried ~6.10-rc1 for a week or so, and it something was very wrong with
> > the performance, likely to do with graphics. Thinkpad X220.
> >
> > It looked like GPU is working way harder than usual, leading to
> > machine overheating and thermal throttling, making machine _really_
> > unusable.
> >
> > I went back to 6.9, and things seem better. At least "have to buy new
> > machine" feeling is gone.
> >
> > Unfortunately, these GPU perfromance issues are not exactly to
> > confirm/debug. Hints would be welcome.
>=20
> Well, it sounds like it is a big enough performance issue that you can
> definitely feel it fairly easily.
>=20
> Which would make a bisection possible?

I wanted to go and buy new computer last week. This week ... well, the
machine is not fastest but I'm not looking forward to reinstall.

If I can get at least basic metric on the gpu (%idle? which process
use how much time?), it might be feasible. Is there tool similar for
top?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--iUClFSfoZ6LpOrmC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmwHGgAKCRAw5/Bqldv6
8kUSAKC85Q6k4DyIkV87JqoZKa6H540SuQCfXQNnxa5OTKOh2nC8UbDDAQwgjcM=
=W9G0
-----END PGP SIGNATURE-----

--iUClFSfoZ6LpOrmC--

