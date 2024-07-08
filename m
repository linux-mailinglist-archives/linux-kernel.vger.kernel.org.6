Return-Path: <linux-kernel+bounces-244288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D899792A23B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65922B221B9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E386126;
	Mon,  8 Jul 2024 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="XafgyACI"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC4080626
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440221; cv=none; b=BXUAdFGFIfvo6jQSVl/g3kc5UOn4UifQec5UZBvJyX6gjv4yLFO/zDkW82W/tqFWm3o0nonm6oDNFImmga/dNJycmlax5Os0kwOq+tDQRKWyBBoWSsk21XbN1ufRkSZXan5C2JADHRvaQmSfJbdrUsNegUKpXbhQJsk2hdDtr2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440221; c=relaxed/simple;
	bh=inVF0yDlJwx1XjCOWcT/9QCl++0l8BnRyQfDPjikvUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXJw/SjFjB9k2sHunCk4RI2dfvRowZLXJgPwclYMYnoWI/oP1WRPuABplFlMqLtiR6xvr5t+BRv/EqZkaOsSydoFvNnJEkZVGRpNafiJByn/r0B2ispInZDauge2IbXuOn2irpjMbPH833IZZASpbHRS7oloz1TauKMJbjo2r8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=XafgyACI; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 899011C009C; Mon,  8 Jul 2024 14:03:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1720440210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YY97RgeMbh9wOA+Obh+XjFzS98vI+HNK++z74/sgzM=;
	b=XafgyACIB2fsOH2E1Uyd3yxY816/21rhB3TdP64+W2O1ccK9ruJEVJwsbq208QQgtjWs1U
	aUwd9Bg2gzsbyVBXux+Guhj7KR3s+1+yl+Xx7hlJX243SL6SN59t2SBtaxDb6GTJt2eO91
	dc0F4OHpoq4dyZPI9r5qSxCvzoI3ZKM=
Date: Mon, 8 Jul 2024 14:03:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZovVkj7Pqy0/KU63@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
 <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
 <ZnABbKrIzmmEoFEV@duo.ucw.cz>
 <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
 <CAHk-=wgnwBE=n_K9q7x6R-bzQ-vRiLeYUciWTJtMokLC_1a7gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ujEK8zbOZlk+0bAX"
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnwBE=n_K9q7x6R-bzQ-vRiLeYUciWTJtMokLC_1a7gw@mail.gmail.com>


--ujEK8zbOZlk+0bAX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Ok, so machine is ready to be thrown out of window, again. Trying to
> > play 29C3 video should not make machine completely unusable ... as in
> > keyboard looses keystrokes in terminal.
>=20
> Well, that at least sounds like you can bisect it with a very clear test-=
case?
>=20
> Even if you don't bisect all the way, just doing a handful of
> bisections tends to narrow things down enough that we can at least
> guess at what general kind of area it is...

So... I guess I now know what went on.

We got summer here, and I was running notebook closed. Appartently
that affects cooling a _lot_. Open lid means more dust, but also
better cooling...

Best regards (and sorry for the noise),
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ujEK8zbOZlk+0bAX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZovVkgAKCRAw5/Bqldv6
8tfnAKC5g0vCQCN9TVacqksrHNCgyk2UaACbBKob9Ei7ddtRjyaKOGBfF2C02Qs=
=Z5ej
-----END PGP SIGNATURE-----

--ujEK8zbOZlk+0bAX--

