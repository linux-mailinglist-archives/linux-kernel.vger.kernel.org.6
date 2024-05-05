Return-Path: <linux-kernel+bounces-168958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F2A8BC031
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBE221C20A02
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 11:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1F81429E;
	Sun,  5 May 2024 11:05:51 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED1EDC
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714907150; cv=none; b=qpuPl7cFH1hJp/+Q7TBphvR9ZwECfxB3n3KFdjufFJRtFdI5ZcNvDJmfazceFVzc8W3aD6GdT7mBs9cIGkXPdT21k9H/4d3T9cDowdmNxkaSTyjjLroBUGrGapDpOaa0qZTQn1HlPtJQ+++3RO+0D0b0GWTLnhqsMamaCHVhhiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714907150; c=relaxed/simple;
	bh=eZA4s+ZMBw5TRGVx3Jl/8HUiKxeUMzduwhYJ0+bftno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGKEepFD3AG8/pWLBlMdbBLM6y+Xks3okhhLGeTJx/YoQrYF3I6asTqeJIM4JhpDj09c1OGcFAxP6Tc8MjZ8/ZDmqGNb0oqyorTt5MN6+KQpZYvWkU9vaSKYfDc+zItkBi8nC22ZPoJXPXca8Gk/PecL55+b1Mf0Ntj9iw/YHsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3Zgd-0000ZH-1d; Sun, 05 May 2024 13:05:43 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1s3Zgb-00G45Z-Bs; Sun, 05 May 2024 13:05:41 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 059742C9C8F;
	Sun,  5 May 2024 11:05:41 +0000 (UTC)
Date: Sun, 5 May 2024 13:05:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Francesco Valla <valla.francesco@gmail.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, fabio@redaril.me
Subject: Re: [PATCH v4 0/1] Documentation: networking: document ISO 15765-2
Message-ID: <20240505-mustard-scallop-of-passion-778627-mkl@pengutronix.de>
References: <20240501092413.414700-1-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="giijojktyeere3x7"
Content-Disposition: inline
In-Reply-To: <20240501092413.414700-1-valla.francesco@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--giijojktyeere3x7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01.05.2024 11:24:12, Francesco Valla wrote:
> While the in-kernel ISO 15765-2 (ISO-TP) stack is fully functional and
> easy to use, no documentation exists for it.
>=20
> This patch adds such documentation, containing the very basics of the
> protocol, the APIs and a basic example.

Applied to linux-can-next.

Thanks,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--giijojktyeere3x7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmY3aAAACgkQKDiiPnot
vG8mhwf5AXTWznnRJGWOZhBh/1fljmHZTelVngc4GrTuauVHbqciNyeFWZ8fJXnM
mRaGxxzTRn2yeTVWyQ6kV8FVqcnqy5WCBzlyMDBu6GDM7ev+o5E+8ayiZUpk3z6O
rnI1N27r31iooqGkoRxf+UwhXL9YkXk8CgUIV5urhkQzLhtWNgE1X4lsObsOwll+
Z7GoULauDqw5lwcnp78upHVCVmjTgYDkruYOZO3UR+22aGSaejvoF+mQgFPi/xtq
ReEwbJgIzc9gJNwx8raX1CF6Y64yG97ctQhw3tu/LvUwfziGQGbMQAG2JXXSUGi9
6+1jUJUh/xhMgvZXn5OejgQd/9K0Yw==
=zLcO
-----END PGP SIGNATURE-----

--giijojktyeere3x7--

