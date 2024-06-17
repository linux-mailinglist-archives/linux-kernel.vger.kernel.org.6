Return-Path: <linux-kernel+bounces-216999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9755B90A987
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 269DE282DB0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998D61922C9;
	Mon, 17 Jun 2024 09:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="lPSYoCQD"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143AA19148E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616440; cv=none; b=tOGtrafeKZlJc3fZvibOLhCO6MHQKfgXq31x/v0cLBGGkl9Tkw7KEt/KxFJ43sgWmg/zQu2Cpz77xtEatm8OMhOLcRjJBBDrDDuAjP2+eYX0BPQY81IR7fO2+6HB95gs+jxUoe1VUmGGDZMd4WI8CKk+f9am9ix16hQ6iUyc+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616440; c=relaxed/simple;
	bh=RUuK+9xggdkd1n6yDTvofXB/CDyOTTP0PsAGkSPe2vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9K0liObLkNyPygBEDBY0+oRAFbtqaJZI2sNSjg2hV9catBnOtS4p2cs3J7cZkohOdHjZnSVVBx+x1bkscQP2qoePPfJNGatA2LG3i4Ngoia/nK9BrC248c7BEmgJ3io1gc2dsmJBokFMsy8qgYzoGhfanidYkoeMwn0NQp9MjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=lPSYoCQD; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 3C33C1C0082; Mon, 17 Jun 2024 11:27:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718616429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q78lj1sUEBcoY/15sYRrAFgGfIDd8guUOyzA9hwkQF4=;
	b=lPSYoCQDOtGjrGL02ITIfPC8gJwkHB01Ka6tUcjFlmSiHf8SokRFcy0RhbHQ2zOKi+ttui
	PcKR9RHm/UHYda4Oe59RJn1ZLyJ2xzX9BeYn7F3x9OvxoDGL4gykBPnmtkGHGbCWeDvKtD
	rh8ItSSMVDFhykGiFI5YIEDguoMKCD4=
Date: Mon, 17 Jun 2024 11:27:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZnABbKrIzmmEoFEV@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
 <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="H6pKU+jOd+U1bE+H"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>


--H6pKU+jOd+U1bE+H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Let's bring in the actual gpu people.. Dave/Jani/others - does any of
> > this sound familiar? Pavel says things have gotten much slower in
> > 6.10: "something was very wrong with the performance, likely to do
> > with graphics"
>=20
> Actually, maybe it's not graphics at all. Rafael just sent me a pull
> request that fixes a "turbo is disabled at boot, but magically enabled
> at runtime by firmware" issue.
>=20
> The 6.10-rc1 kernel would notice that turbo was disabled, and stopped
> noticing that it magically got re-enabled.
>=20
> Pavel, that was with a very different laptop, but who knows... That
> would match the "laptop is much slower" thing.
>=20
> So current -git might be worth checking.

So... I went to (then) current -git and I don't want to replace my
machine any more. So the problem should not exist in current mainline.

(I did not have good objective data, so I'm not 100% sure problem was
real in the first place. More like 90% sure.)

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--H6pKU+jOd+U1bE+H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnABbAAKCRAw5/Bqldv6
8m6EAJ9actiKleBb8+OFvKoQQ4jA7+2hiQCfWrGkGnyPYT4Nsoq7QcejUXecs3U=
=xxmc
-----END PGP SIGNATURE-----

--H6pKU+jOd+U1bE+H--

