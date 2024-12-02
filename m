Return-Path: <linux-kernel+bounces-428034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A37409E0918
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69B93282330
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 16:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ABE1D95A3;
	Mon,  2 Dec 2024 16:53:33 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AEC52F76
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 16:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158413; cv=none; b=lQ4kRLruwyX8Z4grf4ZFl/qudbe/gVZcbBkLYV/9jPGSDlKD+pF/lkLeouSwP4zSkAeUAoi65NT3Z6SZwS3LOi+tq41XBXisBRUxSpKkkVVVIgPa+epb15lVIyG/D0FRsrI8lDL3wi1jNJVsHA0dZx47gqtKXNnrh8n9ufV/mNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158413; c=relaxed/simple;
	bh=klKH3RyoOaJCrXHvRvq9NFyNn0uyJB3GIr99zeWJSos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2OjleZL1Dmm2N5ZaoEP8aTQd29vwxo2urmMFy7g1A71+VI766zsAH/pEQflUby0kwH2ArsB0HlRXW4+RiuepeVM6OgUB9Pej3JkqhGvz6TX4Er8C/UTrEHPCsp44l2/z4OCH19pRo6KBt1qz5395b2FimHDqMPW4bbgH3ZKEdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI9fk-00087b-1U; Mon, 02 Dec 2024 17:53:20 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tI9fi-001KRE-1C;
	Mon, 02 Dec 2024 17:53:19 +0100
Received: from pengutronix.de (pd9e59fec.dip0.t-ipconnect.de [217.229.159.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id BECBD383973;
	Mon, 02 Dec 2024 16:53:18 +0000 (UTC)
Date: Mon, 2 Dec 2024 17:53:18 +0100
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Schocher <hs@denx.de>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, kernel@pengutronix.de, 
	David Jander <david@protonic.nl>
Subject: Re: [PATCH 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible
Message-ID: <20241202-stereotyped-otter-of-agility-44b71b-mkl@pengutronix.de>
References: <20241202-mb85rs128ty-v1-0-a660b6490dc8@pengutronix.de>
 <20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s577esmvwab2woq7"
Content-Disposition: inline
In-Reply-To: <20241202-mb85rs128ty-v1-2-a660b6490dc8@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--s577esmvwab2woq7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/3] dt-bindings: mtd: mchp48l640 add mb85rs128ty
 compatible
MIME-Version: 1.0

On 02.12.2024 17:35:21, Jonas Rebmann wrote:
> Add a compatible string to support Fujitsu MB85RS128TY.
>=20
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.y=
aml b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> index 0ff32bd00bf6aee279fa78c624d8d47c6162f7f1..973f06b665dbbcb9ea1090418=
eb18fbe2285acef 100644
> --- a/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> +++ b/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      items:
       ^^^^^
I think you need to change to "oneOf"

>        - const: microchip,48l640
> +      - const: fujitsu,mb85rs128ty
> =20
>    reg:
>      maxItems: 1

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--s577esmvwab2woq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmdN5fsACgkQKDiiPnot
vG8UNAf/Q0okczdUcs5kfrn7qodwy1gJZ1E3wkuMmNmcw4x/WrjD4EfQqkFY2YvK
z9Xme7Hvl6o4Cwg6jyQj3RB6S4CsLwhAPCtJ0XWFbg6Tg9x6KExvGAT1gSqXQ9ax
Rud4h6YlzmevP5mISgYL3oZg2L1G0TuO4DPp+Qr78hvgN6oOxmCPE64xQa8/yQWj
HBRfgrYw5xlJ+TIbTKCx4gGS7tIDi8k2uie/GzuN8GG0YCrYfoTeVMmQJuRlNxhY
Nu4CnQTe36vAvvSvv8bWlboHa4VTI+1w+B5qIG4E9etiG4wPU1IVdI7xH/btNYn/
B+Me2jGYLRWkmSvHpwKT9ilEpwXhAw==
=jMo0
-----END PGP SIGNATURE-----

--s577esmvwab2woq7--

