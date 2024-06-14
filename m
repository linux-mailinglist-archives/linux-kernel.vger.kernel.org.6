Return-Path: <linux-kernel+bounces-215472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DEC909345
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5D091C20B69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 20:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F151A3BDC;
	Fri, 14 Jun 2024 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="TeCLKarI"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC9C1A2549
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718396030; cv=none; b=H4WsWIH/nfbCw/ww1CpejtXbLzrcazq1NnXGaciGUE/IryJIjVfkVrLg2veKWeGAev98YGElPCC/eXAH8NYCr8SDudmjXxFLbr+XxXqxaH+GcKZ4XGfNaC/m9/nCqeoEbSlw9R/Lw2ERu4A7fVOU9jBvoq+EnBPSKzOGTizFu60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718396030; c=relaxed/simple;
	bh=Md8vvcMEZpHAinWIZ5HUKptV3NshGoYH7Q8rDWj7NcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kI++9G0WdsGH05fX3fpCt3DB+MBX56IZdqdZuBclPrQRgifV/r9F0oXhvxs83lqzCbJczfxY3la1pANccNaa3jefvfxvWuINdFg1P9cu0EEHS8Halp41ZA4pfBZwxK60biHQ5bfPs03VMREPsob/EhOIVKakxS4k9BvMYJDDaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=TeCLKarI; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 847B01C009D; Fri, 14 Jun 2024 22:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718396024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z8ZU3Qerhy8BbHEZ0VEi1vZnCyP+NEN+cexQC5goGM=;
	b=TeCLKarIVylkNJZTOfyxXHpPRwWdxGrp02dM41hB3seAXL0JZuXpPsoxGavoGMz20eNklc
	GhORYoeUsYJjdMUdl+S3YwhzYU2eEHjMSOPNCaA9D2/C3ly7VJwJ8+hntnzTHtIVxxEwcV
	hj1GnrpwHcAx2hMsSKLhH7e848e3qUw=
Date: Fri, 14 Jun 2024 22:13:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZmykeKxwkPEOp9UM@duo.ucw.cz>
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
	protocol="application/pgp-signature"; boundary="9jY3Fdg/BAZtCs3r"
Content-Disposition: inline
In-Reply-To: <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>


--9jY3Fdg/BAZtCs3r
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

Ok, let me check. That sounds like something that could make machine
hotter.

My problem seems to be that machine seems to run way hotter with 6.10,
and when it hovers around the 97C limit, it is unusable with all the
throttling.

It gets unusable with 6.9 at 97C, too, it is just that it is harder to
make it so hot with 6.9.

(And yes, I'm running Chromium, and yes, that means websites influence
this. Media playback also does, 1080p video pushes thermals close to
the limits even on good kernels.)

Thanks and best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--9jY3Fdg/BAZtCs3r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZmykeAAKCRAw5/Bqldv6
8gIcAJ9B4RKjJ+DF3U4YiKKPR2TtRW0KEQCgpTFbTJaqCrmvTB23IRLtTeGI328=
=ruMg
-----END PGP SIGNATURE-----

--9jY3Fdg/BAZtCs3r--

