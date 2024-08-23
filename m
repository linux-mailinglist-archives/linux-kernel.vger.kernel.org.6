Return-Path: <linux-kernel+bounces-300523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1101595E4BB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 20:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44CB1F214B1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 18:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157BE16EC19;
	Sun, 25 Aug 2024 18:47:37 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E24778C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 18:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724611656; cv=none; b=oFlSPsMyvoXrxRw2suORbDFTrXLWst+DUgY7R5KkIONG55rH6b7e6azt6E00dRemlGpRGrV+wbx1HUBgjOTo5Dme0VC5wiqeyhnBgn7kP1XacT2EQ8uezIhye14cmHMjT1dxm/hKSYwT2COL7xhH7/cEOB73le8xCtOkOocvNNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724611656; c=relaxed/simple;
	bh=O/7y1BOiwtlj5xGNQ0xs73F0TB1wZAvE87D1/HoMSp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+aiKChXFVax+9C/k/Ru20vGff491O85IwaueuGwqHaoe34Df0gk9X1QT/mbyahvMumz5F7ipNgwEZ776kEqmxF6g7/8xqQY3WsdXLgljK42Bun2++jmiv+eqGF9Q5o8D/G16UJc7KhYVGZqssDQi+EOUCM1k7md3rRZSbOqEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1siIGg-0006m5-RD; Sun, 25 Aug 2024 20:47:14 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1siIGf-0030Xc-EV; Sun, 25 Aug 2024 20:47:13 +0200
Received: from pengutronix.de (unknown [IPv6:2a0a:edc0:0:701:6bf1:9aed:c5c2:5c56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9FB09325443;
	Fri, 23 Aug 2024 12:36:48 +0000 (UTC)
Date: Fri, 23 Aug 2024 14:36:47 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, krzk+dt@kernel.org, festevam@gmail.com, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <20240823-demonic-jolly-chital-fb4d61-mkl@pengutronix.de>
References: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iesc4bfsdftuxohg"
Content-Disposition: inline
In-Reply-To: <20240823120158.19294-1-tarang.raval@siliconsignals.io>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--iesc4bfsdftuxohg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23.08.2024 17:31:57, Tarang Raval wrote:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
>=20
> 	* Wi-Fi
> 	* Audio
> 	* SD card
> 	* RTC
> 	* CAN bus
> 	* USB OTG
>=20
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
>=20
> Changes in v2:
>=20
> 1. Updated the node name and pinctrl name.
> 2. Removed the 'regulators' container.
> 3. Removed a stray blank line.
> 4. Removed non-existent properties.
> 5. Removed unused node and pinctrl:
>    -modem-reset
>    -pinctrl_uart1
> 6. Defined the CAN transceiver reset GPIO separately.
>=20
> Change in v3:
>=20
> 1. Removed 'can-connector'.
> 2. Use USB connector instead of extcon_usb.
> 3. Changed id-gpio to id-gpios.
> 4. Use Level trigger IRQ in the CAN node.
> 5. Corrected the compatible property of RTC.
> 6. Added blank lines to separate the pinctrl groups.
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 326 ++++++++++++++++++
>  1 file changed, 326 insertions(+)

[...]

> +/* CAN BUS */
> +&ecspi2 {
> +        pinctrl-names =3D "default";
> +        pinctrl-0 =3D <&pinctrl_ecspi2>;
> +        status =3D "okay";
> +
> +        can: can@0 {
> +                compatible =3D "microchip,mcp2515";
> +                reg =3D <0>;
> +                pinctrl-names =3D "default";
> +                pinctrl-0 =3D <&pinctrl_canbus>;
> +                clocks =3D <&osc_can>;
> +                interrupt-parent =3D <&gpio1>;
> +                interrupts =3D <14 IRQ_TYPE_LEVEL_HIGH>;

Have you actually tested this?
Previously there was: "interrupts =3D <14 IRQ_TYPE_EDGE_FALLING>;",
meaning the IRQ triggers on the edge "1 -> 0". It doesn't look correct,
if you say now there is an IRQ at level "1".

> +                spi-max-frequency =3D <10000000>;
> +        };
>  };

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--iesc4bfsdftuxohg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbIglwACgkQKDiiPnot
vG/OWQf9FkXLvVKzVzNOGUcIOCbSF3IxVHcLdinwDSB1sOMSkfUTUacmR58NC+hx
/c/M3Z3+ZwbOseCs5Aup1RYQ74DylZdWDXfsnpShDxm9/hCDoLluc1ELqt6WrBEU
siBzXms2l4n1NIklW3pSMfR+sJR5+UnavvLogsFy7LgggjIOFEYIwl3hatwtHA/o
nOT67UXKcQpqDQ6qGKZxDTCh1NX+VyAQm69QWGH30m7DXM0oJCO0hn12PXBOEd6E
Caq7RrLw1zMCVu1vGcbfLGdXI0t9YINfFlbhCC4scenGhD97fMQr/Jgxj8/6O/a0
ehd+08pK+pIHfXBPmgdKx3XdQ/cN1w==
=1Lb5
-----END PGP SIGNATURE-----

--iesc4bfsdftuxohg--

