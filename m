Return-Path: <linux-kernel+bounces-201179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7C28FBAB2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE9C1F21F2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A4414A09E;
	Tue,  4 Jun 2024 17:42:23 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6434F5F860;
	Tue,  4 Jun 2024 17:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717522942; cv=none; b=XhJ9ez/AzAeHa2WMYW9E3xw6twUoJPNHR1bkExdqgUFfnDJDxqmfio5XB/uelFUYLJpchy5zLIK78nlJOfu2uHIjfYe6rCH1mI4OllwCiMu7TTgG6pTJSYwEmK+jdkmYygLqCq0mP1OuWESdXQ/aaQdkpnej0ljpiBt8kJlPGVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717522942; c=relaxed/simple;
	bh=a8141EOsQxFmboV4YLmQ/aNMHC1QnCobXdkGlyO/faw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=jkluBZxwjohJRsRQjx5dDomBKMpAZUt33BsDgEmJyrtPRho9JMj4J38eVmT5tjcB/IRtH3oyApVxeXyqoF2HgSZiOXZOTkUJiHZPdhVGxI20dPDI0iJOIEEysdjIMtisvoo2UwiWW3GsEljnjyDU9mv0nJyD3FjeqTCMaAAX/ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id E08B675;
	Tue,  4 Jun 2024 19:42:16 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 04 Jun 2024 19:42:16 +0200
Message-Id: <D1RF2GI60GXE.3A3W7Q3W19GPN@kernel.org>
Subject: Re: [PATCH] dt-bindings: mtd: spi-nor: deprecate Everspin MRAM
 devices
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, "Thorsten Scherer"
 <t.scherer@eckelmann.de>, "Marek Vasut" <marex@denx.de>, "Imre Kaloz"
 <kaloz@openwrt.org>, "Andrew Lunn" <andrew@lunn.ch>, "Flavio Suligoi"
 <f.suligoi@asem.it>
From: "Michael Walle" <mwalle@kernel.org>
To: "Conor Dooley" <conor@kernel.org>
X-Mailer: aerc 0.16.0
References: <20240604074231.1874972-1-mwalle@kernel.org>
 <20240604-ladylike-gout-6fd6ae992712@spud>
In-Reply-To: <20240604-ladylike-gout-6fd6ae992712@spud>

On Tue Jun 4, 2024 at 7:01 PM CEST, Conor Dooley wrote:
> On Tue, Jun 04, 2024 at 09:42:31AM +0200, Michael Walle wrote:
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
>
> The idea here seems okay, but directing people to use the at25 binding,
> without actually documenting the replacement compatibles etc is far from
> ideal. I think even a wording change that points out that that these
> devices need to be documented in that file would be an improvement, the
> current wording makes it seem like the works been done.
> Until there's a replacement driver, I don't think you could really
> expect anyone to move to a new binding anyway.

Fair enough. The driver is already there and it basically works -
Flavio is already using it. It is just, that at the moment you have
to use the (deprecated) "atmel,at25" compatible and you'll have to
specify pagesize etc. That is really hacky, because F/MRAM devices
doesn't have a pagesize.

Anyway, I was already working on the at25 binding but then I've
noticed that the current FRAM binding is really hardcoded to cypress
devices and as mentioned in the commit message, I don't have any
hardware to actually write the proper driver support. Maybe we
should settle on the binding first, i.e.

 compatible =3D "everspin,mr25", "atmel,at25";
 size =3D <N>;

vs

 compatible =3D "everspin,mr25h256"; # no size needed

For reference, the already supported cypress fram has the following:

 compatible =3D "cypress,fm25", "atmel,at25";
 # no size needed, because the driver will figure it out by reading
 # the ID

Besides that, I would really get some feedback from the three
in-tree users on migrating to the EEPROM driver and thus away from
MTD.

-michael

