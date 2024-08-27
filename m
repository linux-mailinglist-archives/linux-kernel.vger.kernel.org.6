Return-Path: <linux-kernel+bounces-303176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3AD9608A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E8901C2288D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407381A00E2;
	Tue, 27 Aug 2024 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Hm5AzqL/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EjoBRGKI"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBAD19E7D1;
	Tue, 27 Aug 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724758082; cv=none; b=Hvq9IIcx4mdIP4l9QxX8EN/JoCkWxMxgeFLHe3pwVgHqjh2TN83dWKbymI5oYttyKfWYIiglYmxzobYApQDF3Zpn3t3a7UiLM3r4U7FVBCbIlkSbKDxdtgJDPiPOVOuGvREJ1nLeW5wiYE63vQn6mDshy7iVLECLMKTe72KgiZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724758082; c=relaxed/simple;
	bh=4gyqfKs+tLOGvXNMDLu1SnmVy4qS5p61g1+E5uo/tYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iO/+rsqwSGj43gftJnPfd4JCZBUWwIefTcgZjv48uaz/5suwvAoAr0jekIpoeFUxgQuarRCc6zAj2En0s436DtHwCYMmGDfF60DWWCmikyVkU7Eyjn2niHFEiB5ngG6fjmotQs+Vs3TQrJ3Po57/TxW1tBflGN2M1IHzKVj4dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Hm5AzqL/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EjoBRGKI reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724758080; x=1756294080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H594hvymOuVyU4IRA+6IzWfGdTMX7wzroXd1GVZo3i4=;
  b=Hm5AzqL/5dyFM7T1QZ4Hyygtp4mytePpM6GPLh7Z89pEPFo2xD/B2iGs
   +SDcJ2IpfZ40o0m0Kc1TZY44YvNDBunzOPN6KRnb+/NpfxX2bz2PVPCQI
   fmO93AugBmKjfyXrGau/M9XkyBkb8/gjSwGrhgArzjR2+7ppFzkAvxSDi
   NaWT0qT+I+kuh06zPBWOjLi7/kRzvXjtuiF+MQDwt4PxuGvXeT9BiGgK1
   nJg1IwTewe+dwWGkqQ9fN/R8NvNAzKBEYLzqelpYfmi+MLSYV/4T8SGmT
   QV5/zexNpTsqG6DRwBSzrYvCvCfGZe1l4aP788Vh2BicxYnFoTFuI+Zbe
   Q==;
X-CSE-ConnectionGUID: M40X6Ie/TWq3pDfF8ecKxA==
X-CSE-MsgGUID: V2QOWBIpRJ2/u/qaC3o1Eg==
X-IronPort-AV: E=Sophos;i="6.10,180,1719871200"; 
   d="scan'208";a="38609560"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Aug 2024 13:27:57 +0200
X-CheckPoint: {66CDB83D-13-5FF8EC80-F6CEE9F8}
X-MAIL-CPID: 78A325EE22E9AD5A01AB969032D4A1D2_0
X-Control-Analysis: str=0001.0A782F17.66CDB83D.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 314DB163F46;
	Tue, 27 Aug 2024 13:27:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724758073;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=H594hvymOuVyU4IRA+6IzWfGdTMX7wzroXd1GVZo3i4=;
	b=EjoBRGKIDWEjVLScvKCr/b+KfQJdhoHw1O02dsbWEavaL9Yy0g0PgrTxm7QjA031esybSs
	zLjeQWstY1suPg3HslD9XHGcxUBf5R/2fkjMe6jCYXEA+vP8IGxKcKbjnORHuukId0LkZt
	4C/W6oE6En7NEAIa+gfcO47Oxz9MLEPkKwAHpxeb0NPTIYm8UzvE0W4w2keVI3AzRJvZPD
	0QxAdOkQFKI4ssNC8KQ1oLsz2KnlmMPtjbfxzUAk/3X9yxMKQUzGqJ9Nm+pMbOQjc3Dz8h
	ixxjf4FrjSZvy5vId2wNJ1UqGytZ/TSBCJ8OWN8ZSjXC/vTkHm2TII/C6qzjYA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "festevam@gmail.com" <festevam@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Tue, 27 Aug 2024 13:27:51 +0200
Message-ID: <2200558.irdbgypaU6@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <PN3P287MB18296998E37E061AC496F2D58B882@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io> <20240822-calm-dinosaur-of-music-33db22-mkl@pengutronix.de> <PN3P287MB18296998E37E061AC496F2D58B882@PN3P287MB1829.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Freitag, 23. August 2024, 06:42:24 CEST schrieb Tarang Raval:
> Hi alexander,
>=20
> Thank you for your feedback, Regarding your suggestion to switch to the U=
SB connector node
>=20
> >> +     extcon_usb: extcon-usbotg1 {
> >> +             compatible =3D "linux,extcon-usb-gpio";
> >
> >Please refer to Documentation/devicetree/bindings/extcon/extcon-usb-gpio=
=2Eyaml:
>=20
> I couldn=E2=80=99t find the Documentation/devicetree/bindings/extcon/extc=
on-usb-gpio.yaml file as mentioned. Instead, I located the extcon-usb-gpio.=
txt file, but it doesn=E2=80=99t contain documentation about connectors.

Sorry, I thought my patch [1] was already applied. Meanwhile another one is=
 applied instead [2].

[1] https://lore.kernel.org/all/20240215093214.796821-2-alexander.stein@ew.=
tq-group.com/
[2] https://lore.kernel.org/all/b4b96be5-fad6-458c-a236-9b6761eac968@kernel=
=2Eorg/

> >> Deprecated, use USB connector node instead.
> >>
> >> deprecated: true
> >
> >Switch to connectors instead.
>=20
> I referred to the following YAML file:
>=20
> link : https://www.kernel.org/doc/Documentation/devicetree/bindings/conne=
ctor/usb-connector.yaml
>=20
> Could you please confirm if this is the correct file to refer to?

Yeah, that's the one I'm referring to.

Thanks
Alexander
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



