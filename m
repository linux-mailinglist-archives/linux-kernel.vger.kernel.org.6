Return-Path: <linux-kernel+bounces-220884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC7B690E892
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF9F1C2317E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E2513212E;
	Wed, 19 Jun 2024 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="PgZ2z4/6"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926F13212C
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793844; cv=none; b=JDDpN15dj3YtgcAR5yR9WmmKOMJi14bwm9aVrMZhfj3xueBWMw3Bo5oVPoK9x1dkUqpp3SDjggv9hDjBttdG7+cinDhzI3lZnc6OklxPEJQog1ARZAfjAC9X9Q4uwlAO3tIvriBoykaCw5oy1sPvtpUpu5udRrIzTVg1rxfBylY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793844; c=relaxed/simple;
	bh=LNor9A50N389aJLJp6+WNl31YOpXk7EeMWH/JW3Gbcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEyq65Du110Y2ZqdrT+/AkXkchV4SgnEQ700iA/gkgtxgFX5JMNIbf2hInp90eI02SaJ+RecyX5tBC/MMT8bc0tv0h/+Pn0x9ePuVeJ+2cQLNpMgl2l3ErE32nZoM13eOf4a6GncaRSwjvpbypt37bB99+7RCEmW/N/GKy6nfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=PgZ2z4/6; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id E13451C009C; Wed, 19 Jun 2024 12:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718793838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo9RiiSSC/ZbBTBqmG8HeRvLXY/RIIoNbA30ISvJUoQ=;
	b=PgZ2z4/6URfgbVQwjQo/bCy4eqsH/PuYqqNqksu3WkoxLbe9FKm+mxAyyuektKRQgzU5IH
	twT4V37ySrBgxua1Xrn6YhX2zCHPLivEFh2DequUF+ABhr24XHJZzh+lpAh7DlhMQCoOrR
	abkcaW2qjg4lQucbCD6qANdupRGZ9F8=
Date: Wed, 19 Jun 2024 12:43:58 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: Linux 6.10-rc1
Message-ID: <ZnK2bmDFuwX8E5rY@duo.ucw.cz>
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
 <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
 <ZmwHGviv/6J6FQLf@duo.ucw.cz>
 <CAHk-=wigB-wVK+4=NuYJxoKLnoUXB52J5WU2hpKj2de6vGuY7g@mail.gmail.com>
 <CAHk-=wjcdUUip96PnfC+iRjAwPHn3XKsgcohk1ad5VcckCFVKA@mail.gmail.com>
 <ZnABbKrIzmmEoFEV@duo.ucw.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="piExBvh6QckgN0jN"
Content-Disposition: inline
In-Reply-To: <ZnABbKrIzmmEoFEV@duo.ucw.cz>


--piExBvh6QckgN0jN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > Let's bring in the actual gpu people.. Dave/Jani/others - does any of
> > > this sound familiar? Pavel says things have gotten much slower in
> > > 6.10: "something was very wrong with the performance, likely to do
> > > with graphics"
> >=20
> > Actually, maybe it's not graphics at all. Rafael just sent me a pull
> > request that fixes a "turbo is disabled at boot, but magically enabled
> > at runtime by firmware" issue.
> >=20
> > The 6.10-rc1 kernel would notice that turbo was disabled, and stopped
> > noticing that it magically got re-enabled.
> >=20
> > Pavel, that was with a very different laptop, but who knows... That
> > would match the "laptop is much slower" thing.
> >=20
> > So current -git might be worth checking.
>=20
> So... I went to (then) current -git and I don't want to replace my
> machine any more. So the problem should not exist in current mainline.
>=20
> (I did not have good objective data, so I'm not 100% sure problem was
> real in the first place. More like 90% sure.)

Ok, so machine is ready to be thrown out of window, again. Trying to
play 29C3 video should not make machine completely unusable ... as in
keyboard looses keystrokes in terminal.

https://media.ccc.de/v/29c3-5333-en-gsm_cell_phone_network_review_h264#t=3D=
340

dmesg is kind-of unhappy:

[130729.891961] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[130733.311644] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[130736.534601] i915 0000:00:02.0: [drm] *ERROR* Atomic update failure on p=
ipe A (start=3D617818 end=3D617819) time 159 us, min 1017, max 1023, scanli=
ne start 1012, end 1024
[130738.625131] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[130745.451785] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
=2E..
[131631.941091] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[131634.817628] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[131639.536918] usb 2-1.2.3: reset low-speed USB device number 13 using ehc=
i-pci
[131790.153952] i915 0000:00:02.0: [drm] GPU HANG: ecode 6:1:95ffffbc, in X=
org [3043]
[131790.154245] i915 0000:00:02.0: [drm] GT0: Resetting chip for stopped he=
artbeat on rcs0
[131790.255994] i915 0000:00:02.0: [drm] Xorg[3043] context reset due to GP=
U hang

Wifi is a bit too active, even on fairly idle system:

    430 root     -51   0       0      0      0 S   0.3   0.0   8:48.74 irq/=
17-iwlwifi                                 =20
Ideas welcome, especially some way to see what graphics is doing.

Best regards,
								Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--piExBvh6QckgN0jN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnK2bgAKCRAw5/Bqldv6
8vkSAKCYZujnIFEfpnaKXQ736XmOoaRtZACeIxVRbAkJLd/Pnd3AN4nAg9UzEiY=
=Jm95
-----END PGP SIGNATURE-----

--piExBvh6QckgN0jN--

