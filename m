Return-Path: <linux-kernel+bounces-313134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DA396A0B5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09E51F2957D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5686815B102;
	Tue,  3 Sep 2024 14:31:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0713D518
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373900; cv=none; b=QwXwYbWGgBbMgeY5RKCUT3838cK3MfdCTaXoAX5TJlZiyYaY7oGFKfGcmf+20Wekeh7Dr8Qp4GiRMcn3MPHaloB3sSnES2Bt42y/VxOM/YYbqLi+cqISiSpWkc2b02HoAGFLXq2GuCAE12kdJRtndbtxRbara5UesnvxOyhY2eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373900; c=relaxed/simple;
	bh=EqGFIA81wnRezVMfHSYdxtcN967iyCH9/w9O9okFG2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0wmEjAWCnhIugKeHA1mh0UHpsAUU+x2x+sIJeL1zEIy4Phs20kEoTtQty5GL+j+UwVA+NHVZFfG5MvQxG/6oxneDu0ZKpDuuD9KhF6foguhU63fB5l1SBTd34bzQ0fv3k8E86oVyP/L0iK8DFm8PlbLrnLvFSZKf9Kr9NxADdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1slUYy-00046g-5J; Tue, 03 Sep 2024 16:31:20 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1slUYx-005DeT-8T; Tue, 03 Sep 2024 16:31:19 +0200
Received: from pengutronix.de (pd9e5994e.dip0.t-ipconnect.de [217.229.153.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D9EEF331669;
	Tue, 03 Sep 2024 14:31:18 +0000 (UTC)
Date: Tue, 3 Sep 2024 16:31:18 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, devicetree@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>, 
	Tarang Raval <tarang.raval@siliconsignals.io>, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>, shawnguo@kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <20240903-amazing-shaggy-ant-6751f7-mkl@pengutronix.de>
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
 <172537334994.875077.18308965320836312656.robh@kernel.org>
 <CAOMZO5BNYopFt=_o5qrK7piwxYwF4E10DzCKPW4oh0k4Yj0hUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uj5endkg7ttsx65g"
Content-Disposition: inline
In-Reply-To: <CAOMZO5BNYopFt=_o5qrK7piwxYwF4E10DzCKPW4oh0k4Yj0hUQ@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--uj5endkg7ttsx65g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.09.2024 11:28:29, Fabio Estevam wrote:
> On Tue, Sep 3, 2024 at 11:26=E2=80=AFAM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
>=20
> > New warnings running 'make CHECK_DTBS=3Dy freescale/imx8mm-emtop-basebo=
ard.dtb' for 20240903091720.443091-1-tarang.raval@siliconsignals.io:
> >
> > arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dtb: /soc@0/bus@30=
800000/spba-bus@30800000/spi@30830000/can@0: failed to match any schema wit=
h compatible: ['microchip,mcp2515']
>=20
> There is a patch from Frank to address this compatible:
>=20
> https://lore.kernel.org/lkml/20240814164407.4022211-1-Frank.Li@nxp.com/T/

It's in net-next (for v6.12) with 09328600c2f9 ("dt-bindings: can:
convert microchip,mcp251x.txt to yaml").

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--uj5endkg7ttsx65g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbXHbMACgkQKDiiPnot
vG9j4Qf/RkUhlwPsrPQTurTEXeycXn3Vdwx8e3Z7uSNRip0XtR/yXpFfO49nOldd
isCHKkNv8flTk9+xh2PEieP1f+jN61TwZt/4R923Oby6qfvFQ/C65HsLFcKbgi+u
YvpIljMTBV88CTb9EAIhAhvr/pRdtB6yRXSKKgQoASg2FQB/7WTISVy42Y0o/9TU
a+uNuH6irUuX3RNYhztYtD0J0umTAfGK83LVQ65XMvLnln+BPgkuvZmPRBisx7pF
BiWwGn/9qH5CVrjYvWr0PKTM89BR3sfMpc5E1haMacRDPqHCqZDDt23D72j8Ih7o
cb6QVe7gh4qDg+5rSrVTw2M6+BCyFQ==
=SicB
-----END PGP SIGNATURE-----

--uj5endkg7ttsx65g--

