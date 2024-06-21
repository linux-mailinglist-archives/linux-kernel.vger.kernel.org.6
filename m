Return-Path: <linux-kernel+bounces-225139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F33912C69
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D360AB27516
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D798A1607AD;
	Fri, 21 Jun 2024 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b="GAHwt3Ng"
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E1E129A7B
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718990712; cv=none; b=oZc7l8MGqx1jp0DjhUtdKYoucOndMLHWFK3XLq7Zi28yc+o2zC+2YrjU7ieM/Qpwwcu+AlORWHD1NRPkH6hijX9/gtpt8hImAtCZ3hy6H163/+T1HTqVaqf62zSpMXWoZRZPfk/aS87ekZtskrWo6zfZHvyXmz6YC6FwJSms0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718990712; c=relaxed/simple;
	bh=nqQ6rwUDudOVLD+y4Ywsq9YADm/xyJ2u6MWLZ/I/hp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itMSp74zJjQhCzKNcu4sJA5Yblj2PUVPucoilzSDSEnd1egPx9uE8HXwdC3pMq1apYZ4vnpABfHaNishhqWS0EFlQdDivC5v/qFe5pPh3sVmwF/eyzTLXfV3BkMrV24DZV+6sR0XqRPh2Evcvm740nbiVW4gR0f+qBLTytKaw2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz; spf=pass smtp.mailfrom=ucw.cz; dkim=pass (1024-bit key) header.d=ucw.cz header.i=@ucw.cz header.b=GAHwt3Ng; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucw.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucw.cz
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 79A501C0098; Fri, 21 Jun 2024 19:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
	t=1718990700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BdiGiqxre9gyA5OMrbkSKDrBhhoRtLwT7ZTr2IVHfww=;
	b=GAHwt3NgW0B9LyuLCG2g3l0yBHMphX7lVglp4LtOXh4HhTFtJ5JBWqEpx98sM4WNj3mrbA
	M9OnTWURQb17Jz7xrGlx1gzyO5OLdimsV7Tow8qN5aeabyAk4zttjkBoScGRU+4AyJXsea
	BBjoFXauipP1U0DGHRXTWnqLL5xzB2Y=
Date: Fri, 21 Jun 2024 19:23:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: martin f krafft <madduck@madduck.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: USB device causing reboot
Message-ID: <ZnW2+S+lxJoOCjFt@duo.ucw.cz>
References: <rqlax4nkaff2vhzgtlvldh7wggtvlpc4n2ryx3m7hk3d6v3ssm@aknbt3urp44l>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sGmF+d/LeZkZzkdt"
Content-Disposition: inline
In-Reply-To: <rqlax4nkaff2vhzgtlvldh7wggtvlpc4n2ryx3m7hk3d6v3ssm@aknbt3urp44l>


--sGmF+d/LeZkZzkdt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I built myself a new computer with quality components, and was=20
> surprised to have kernel 6.8.9 randomly reboot (at least once per=20
> day). Thanks to netconsole, I was able to see one of the last=20
> messages prior to reboot:
>=20
> ```
> [30315.872267] xhci_hcd 0000:0c:00.3: Controller not ready at resume -19
> [30315.872295] xhci_hcd 0000:0c:00.3: PCI post-resume error -19!
> [30315.872298] xhci_hcd 0000:0c:00.3: HC died; cleaning up
> [30315.872316] usb 3-1: USB disconnect, device number 2
> ```
>=20
> So I removed `xhci_hcd` for a test, and the system didn't reboot=20
> anymore. So I removed all USB devices, loaded it again, and=20
> subsequently proceeded to add back the USB devices one by one.
>=20
> Turns out the bad boy is the combination of a [Genesys Logic=20
> Hub](https://linux-hardware.org/?id=3Dusb:05e3-0608), a [MosArt=20
> Wireless=20
> Mouse](https://linux-hardware.org/index.php?id=3Dusb:062a-4102)=20
> plugged into a USB2.0 port on the motherboard.
>=20
> After I moved the hub to a USB1.1 port, the problem didn't occur=20
> again.
>=20
> I am happy it works now, and not really keen on wanting to keep=20
> testing this (I am using the system, and reboots are painful), but I=20
> also think this is a bug, and wanted to ask what I could provide to=20
> help isolate the issue, and permit a fix being developed?

You may want to try most recent kernel, and cc usb developers. See
MAINTAINERS file.

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--sGmF+d/LeZkZzkdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZnW2+QAKCRAw5/Bqldv6
8teEAKCYomwYX0ByAjfW/fnYUF85HY+/6QCgwsE4UyAJRQ2LOhVC0+eoibPSrho=
=Sk4k
-----END PGP SIGNATURE-----

--sGmF+d/LeZkZzkdt--

