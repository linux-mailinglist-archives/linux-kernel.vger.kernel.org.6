Return-Path: <linux-kernel+bounces-224044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA99911C78
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33FC1F21476
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C522169AD0;
	Fri, 21 Jun 2024 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abe8VxSQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667BE14038F;
	Fri, 21 Jun 2024 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953805; cv=none; b=VsJKo7UCZnZm6N9OijQ6xJRJI+FWKvtnPg7Dmhi4urUhMuxKTT7snjdTBHeRJVojjoS1VSKoKApqL8NY/Ew8Gj8XxsBQEvcvBzsfp6LTYXlvsus4a4gr90fZSKL6XC1Hg6BLVVfZTxTdzGnR6VRHgiOqK0cMiFOjSn2bPgD6tKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953805; c=relaxed/simple;
	bh=n65H7FsUgfmgUo7tOvRNM/n2pfXo1WYRu0MNCvY3RO4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=Yburv432IFwuf/ExAQhE+aselFmRwcF6WebkdCBG03FGMXEIWyPU/PyV83sAxcfIXkTtyIwBBIx1ycR3hCTZXg1U/7fZt8KO3ySSzvpZCExczGjROIDkIucsq+buSiUesOAARpu4R0XkHdljDbNpAAoopzvoLcyMARvkhTCzeDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abe8VxSQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4142C4AF07;
	Fri, 21 Jun 2024 07:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718953805;
	bh=n65H7FsUgfmgUo7tOvRNM/n2pfXo1WYRu0MNCvY3RO4=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=abe8VxSQaHu9setF8pMa+ryHBejechFVrzVwWO1cOpwuSrohWAaxIftnWbmXu15LZ
	 k3bcHBkak8igmAKbkPwINg/vIjYyCJTBKEzMJImXzBKG/LktEvXeoiqjUpeItjOa9f
	 JjVKIhmPQ5LOzC8GsafbStVyb2su0AR5ErOMobNHoezlCtj4Tn3MlmeRXpz4AW+ipc
	 TjhBZMoXXOj2KzBiN2o4OWipljXn7uGrigmY80E2+oajB1oxnpQE8MSItgzkt8yzma
	 H4jhK1a0aFCzgpIG5bN/O5qDa9kLnyWxTp7RJeMAcFcFRdZyrXnRj5f7F33xrzKRm5
	 g814XmF7xQJEw==
Content-Type: multipart/signed;
 boundary=2166d04db5b2b3c19279014449532fc9d1958729fc6021e7fe2f711ac40d;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 21 Jun 2024 09:09:56 +0200
Message-Id: <D25I9KDHREE9.29RPCOHXUA70A@kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
Cc: <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Thorsten Scherer"
 <t.scherer@eckelmann.de>, "Marek Vasut" <marex@denx.de>, "Imre Kaloz"
 <kaloz@openwrt.org>, "Andrew Lunn" <andrew@lunn.ch>, "Flavio Suligoi"
 <f.suligoi@asem.it>
From: "Michael Walle" <mwalle@kernel.org>
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>, "Miquel
 Raynal" <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240604074231.1874972-1-mwalle@kernel.org>
 <23574950.6Emhk5qWAg@steina-w>
In-Reply-To: <23574950.6Emhk5qWAg@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

--2166d04db5b2b3c19279014449532fc9d1958729fc6021e7fe2f711ac40d
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Jun 21, 2024 at 8:49 AM CEST, Alexander Stein wrote:
> Hi everyone,
>
> sorry for being late to the party. I just noticed this discussion while
> reading [1].
>
> Am Dienstag, 4. Juni 2024, 09:42:31 CEST schrieb Michael Walle:
> > These devices are more like an AT25 compatible EEPROM instead of
> > flashes. Like an EEPROM the user doesn't need to explicitly erase the
> > memory, nor are there sectors or pages. Thus, instead of the SPI-NOR
> > (flash) driver, one should instead use the at25 EEPROM driver.
> >=20
> > Signed-off-by: Michael Walle <mwalle@kernel.org>
> > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > Cc: Thorsten Scherer <t.scherer@eckelmann.de>
> > Cc: Marek Vasut <marex@denx.de>
> > Cc: Imre Kaloz <kaloz@openwrt.org>
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> > The referenced binding only supports the true AT25 compatible EEPROMs
> > where you have to specify additional properties like size and page size
> > or cypress FRAM devices where all the properties are discovered by the
> > driver. I don't have the actual hardware, therefore I can't work on a
> > proper driver and binding. But I really want to deprecate the use of
> > these EEPROM like devices in SPI-NOR. So as a first step, mark the
> > devices in the DT bindings as deprecated.
> >=20
> > There are three in-tree users of this. I hope I've CCed all the relevan=
t
> > people. With the switch to the at25 driver also comes a user-space
> > facing change: there is no more MTD device. Instead there is an "eeprom=
"
> > file in /sys now, just like for every other EEPROM.
> >=20
> > Marek already expressed, that the sps1 dts can likely be removed
> > altogether. I'd like to hear from the other board DTS maintainers if
> > they seem some problems moving to the EEPROM interface - or maybe that
> > device isn't used at all anyway. So in the end, we can hopefully move
> > all the users over to the at25 driver.
>
> So instead of spi-nor you want to use at25 for this MRAM devices?

Yes.

> AFAICS at25 is a spi only driver, but spi-nor is a spi-mem driver. So I a=
m
> wondering if at25 driver is capable of using QSPI hosts.

spi-mem support could be added to the at25 driver. But probably
mainly because there are SPI controllers out there which only have
an interface to attach memory (like the FlexSPI from NXP).

> Everspin EMxxLXB devices are capable of running in xSPI modes.
> Regarding QSPI (DSPI/OSPI as well) I assumed spi-nor is a given, but mayb=
e
> I am completely wrong here. Maybe someone could clarify this.

These newer devices should also support the erase command, right? So
they can be a "real" flash. If they support SFDP, the would even be
supported out of the box. The mentioned everspin devices are much
older and behaves more like an EEPROM instead of a flash.

-michael

>
> Best regards,
> Alexander
>
> [1] https://lore.kernel.org/linux-kernel/20240405100104.480779-1-f.suligo=
i@asem.it/
>
> > ---
> >  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b=
/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > index 6e3afb42926e..2dccb6b049ea 100644
> > --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> > @@ -21,7 +21,6 @@ properties:
> >                (m25p(40|80|16|32|64|128)|\
> >                n25q(32b|064|128a11|128a13|256a|512a|164k)))|\
> >                atmel,at25df(321a|641|081a)|\
> > -              everspin,mr25h(10|40|128|256)|\
> >                (mxicy|macronix),mx25l(4005a|1606e|6405d|8005|12805d|256=
35e)|\
> >                (mxicy|macronix),mx25u(4033|4035)|\
> >                (spansion,)?s25fl(128s|256s1|512s|008k|064k|164k)|\
> > @@ -42,6 +41,14 @@ properties:
> >                - spansion,s25fs512s
> >            - const: jedec,spi-nor
> >        - const: jedec,spi-nor
> > +
> > +      # Deprecated bindings
> > +      - items:
> > +          - pattern: "^everspin,mr25h(10|40|128|256)$"
> > +          - const: jedec,spi-nor
> > +        description:
> > +          Deprecated binding, use Documentation/devicetree/bindings/ee=
prom/at25.yaml.
> > +        deprecated: true
> >      description:
> >        SPI NOR flashes compatible with the JEDEC SFDP standard or which=
 may be
> >        identified with the READ ID opcode (0x9F) do not deserve a speci=
fic
> >=20


--2166d04db5b2b3c19279014449532fc9d1958729fc6021e7fe2f711ac40d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZnUnRBIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/j+8AGAtupdesFKhkaz5tdt6TTk5KypeDUg4kse
swSjdUykLgrXafelPJzbZaqZjzhMB3K2AX9R9MmawdLhS0RaUIcpMzilo1ydQJC0
8dpqaL0EmIYFMTWc/qrtPiwaBp8eegqUK9E=
=LIns
-----END PGP SIGNATURE-----

--2166d04db5b2b3c19279014449532fc9d1958729fc6021e7fe2f711ac40d--

