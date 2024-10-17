Return-Path: <linux-kernel+bounces-369269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8364A9A1B11
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B515F1C20896
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 06:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD384199954;
	Thu, 17 Oct 2024 06:53:54 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC628158205
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 06:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148034; cv=none; b=VIapN6PyMHWvon+fGF+KzMk59MkLHoFNPanCwM5rvFBfw6GeQSWB0xitHiNWS9ReEFJOExxA6z1JoMkzpKV3s3LdN03nu1IVAEtk9/OZJLdsGjx6MVuTh+cHKRHJ1wpzOmBOc8GG3Yy3qMqVM78Srcjt/1IZPOQCiaTMjn2ktvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148034; c=relaxed/simple;
	bh=t5Youc6wzd4Kk82D4EiRk12WiPSKIDBP+OePEjfuero=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zarce4ff/UjgUZsxWTecp60aJlYD9s13wdRfUUisNPRY4mXl4eEgIne+/rd3ZG/7Ik9puFbMdOqOT9S4lTOl+z24owltx+jiPkutg965HiMYCbQfjJ0hPil7PiwnkqlbgqXxe5NtrOeqX9P9DPC0O2bPxuXNDEwTLvBJ8eay0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KO9-00086h-IN; Thu, 17 Oct 2024 08:53:37 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1t1KO9-002U7V-3M; Thu, 17 Oct 2024 08:53:37 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2F6E354D6A;
	Thu, 17 Oct 2024 06:53:36 +0000 (UTC)
Date: Thu, 17 Oct 2024 08:53:36 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Frank Li <Frank.li@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next 03/13] net: fec: add missing header files
Message-ID: <20241017-sparkling-natural-wolf-9d6afa-mkl@pengutronix.de>
References: <20241016-fec-cleanups-v1-0-de783bd15e6a@pengutronix.de>
 <20241016-fec-cleanups-v1-3-de783bd15e6a@pengutronix.de>
 <ZxBuvUFfLsBVXKWO@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g4qxxt57zow6gt6m"
Content-Disposition: inline
In-Reply-To: <ZxBuvUFfLsBVXKWO@lizhi-Precision-Tower-5810>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--g4qxxt57zow6gt6m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.10.2024 21:56:13, Frank Li wrote:
> On Wed, Oct 16, 2024 at 11:51:51PM +0200, Marc Kleine-Budde wrote:
> > The fec.h isn't self contained. Add missing header files, so that it
> > can be parsed by language servers without errors.
>=20
> nit: wrap at 75 char

Fixed,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--g4qxxt57zow6gt6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmcQtG0ACgkQKDiiPnot
vG/lbwgAkb4ZZt+bPGECIXqleM2dKEneJimAq/XAdcotKSzF0rbrZfWkE0VOyjhG
N78Z/nzcQrdtaxnH8dpxhe4km6Nm286P3s2m/3FgaQUxATqvOKGOMIwCLNbr/Sgt
/2Y2BeYx1DxPhZicKpNWdjwjSxXg3Wd4CelIHVqRQ+gSSze655pRHJ7nLuMZUMwe
eE63vUZ7NO5kwdQZx2lQB98AHk95CP5+/B2QMrwmcxjxGm9Th7BVyhXmbzWAMFKB
HkK1bqZfMAhcuAv+OTXM5E+h3fTs4+0N9aH3SAA0Tf7TyyLUxGJm1AMzrkEneeEr
fmSkjvIYJlcphRcj4df5+xt1gfUMLQ==
=59tc
-----END PGP SIGNATURE-----

--g4qxxt57zow6gt6m--

