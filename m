Return-Path: <linux-kernel+bounces-296727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33B95AE46
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A37D281DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B368F146D42;
	Thu, 22 Aug 2024 06:57:57 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BDB13C67A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309877; cv=none; b=Dn5s80EMWDB9Duokb/CR60ksxDvJMYaQkK7HlQM0l2RiGAJgdSXUvUfKeZNQV2gkicNm73ry2z5JbTeXIFHDNo0dpoJQycoTlgMdl0VdQNsK8yc3FLchTcLMl+NWCSFW+l0hfxo8bC6qm8kr4YN+el/eC5hzZ86oh7GBnd38v78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309877; c=relaxed/simple;
	bh=rcwYFWBuVEqugIL3+TmhwsI6q5+w1RF8LMjxJ5ZtDDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akxx/NXTZd2toKJB1kJfmketz++0+4rcFZ7Myccdv8SorymUw4BxWCUvcT7fIeO58sdIKa7ZOE8b0FnfOSynx+Gr/VEiLM0U+5vNbBVtP7bRp8c2LxSPXhz/RaeNXhMZoydEgDOps9JYiQObrkuuhlsLfHhuGqLFnHgunun7kvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh1lO-0007Fz-3q; Thu, 22 Aug 2024 08:57:42 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sh1lM-002Bmu-8k; Thu, 22 Aug 2024 08:57:40 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E1B40323555;
	Thu, 22 Aug 2024 06:57:39 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:57:39 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: krzk+dt@kernel.org, festevam@gmail.com, shawnguo@kernel.org, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <20240822-holistic-fearless-bloodhound-e9095e-mkl@pengutronix.de>
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
 <20240821-cute-cougar-of-atheism-3a9121-mkl@pengutronix.de>
 <PN3P287MB18298292CD27FD9D8365C9178B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="akk7pndg6oxvtlb3"
Content-Disposition: inline
In-Reply-To: <PN3P287MB18298292CD27FD9D8365C9178B8F2@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--akk7pndg6oxvtlb3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Tarang Raval,

let's continue discussing things on the mailing list.

On 22.08.2024 06:42:49, Tarang Raval wrote:
> Thank you for the feedback. I noticed that some mainline DTS files,
> including the current upstream DTS, use edge-triggered interrupts.

I was talking about the mcp2515 CAN chip connected to SPI only. Can you
point me to the upstream DTS?

> Could you please help me understand the reasoning behind the
> preference for level-triggered interrupts over edge-triggered ones

If an edge interrupt occurs while the driver is in the ISR, it may
lose this interrupt. The driver will not process the pending interrupt
and CAN communication will get stuck.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--akk7pndg6oxvtlb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbG4WAACgkQKDiiPnot
vG8kGAf/YDP7MXRD+Qcq7trdKx0MDBUEx0ks63XIIn6Neu6whSQKPYb0myoqs9Wl
6N6s5yeIAHaas6pAzvCnJuhuyhHBxqHTHJ+qu3bnS5zHlEqADZMCYV9JqiAZ+jgq
yGZjBMt1vy+c9c/so+lEB/AtVWR6ai05coNXHKOQTdu+4qXPddbFcRHNFJnb442j
J/FAdNZWGQYFwlgjW5besT7HfzX+huZc4v4P4UeaphZh8U9xAGV75okKlFyNft9U
bn5PMGC84XibSpJmp6FxY5L6fMahIO//GobJmO88oGut+EjcXhFDUBG/4AOZCh79
muiySXjvO4tsjFchpnX985mfkx3AWg==
=jajG
-----END PGP SIGNATURE-----

--akk7pndg6oxvtlb3--

