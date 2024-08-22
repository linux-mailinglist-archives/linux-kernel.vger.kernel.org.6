Return-Path: <linux-kernel+bounces-296662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2B095AD5E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37332869DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1AE13A3EC;
	Thu, 22 Aug 2024 06:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Aj6dlKNz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="lJT/kkIx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584B81727;
	Thu, 22 Aug 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724307736; cv=none; b=QtcLZy3hLrD01ufA3jnfxdqcSP8Tru5/1yN+hPvwEZFnc+4OcwrTI2Ed0ZJ3RdD89qV5EbcILJloHMHKIcCkBVkkvnGH6REnKkCXxpnfoFJzxddbI4edXN/dvpnqD1lHR/8YKbDXXfoqq91LGtWoe5ZEZSRq8n+McYE0o9hhFuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724307736; c=relaxed/simple;
	bh=csktVlUd6zjngU+kiQAqMkHQ0LItDogAIQxKiC3ue38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KkZ6CWhjbeDUsOGHgvYJhTgYbdkGGW/zdkuPo7xPojVrsV8mDq7c3RoCnpZt9suUv8gMR021oV1FJmp+b/YYkESADHyE4Kj9bhClnd5IATRzs8Idvc6rcDTp/Jd1jqoZzKGD5NAk7YjlmDh+w6j8KJDvqQPK3+BH8xD7a40/uoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Aj6dlKNz; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=lJT/kkIx reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724307732; x=1755843732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcacUbyWZpubuOZfhpUp0O/XtbHaSh9hAtoPucDtrT8=;
  b=Aj6dlKNzkNYTgj1uNGaZVqdFqTSq9dw/cU+lVf7xxskYxJ2vaxuAXU2I
   zbXUsspLHjatq17TX9G9zd8KW/HIz0sy1Y3W3XdaoXga9s0+/Xiejt1bI
   tn+HNWHKjZPUJMn7nY7wrAHPHRT63RJzrymWYJqaJw/uiLgNl7MqVxRrf
   lM85yR7cH5m/b4uqfg2OlRK9VmsocmYQqBupySM3fug5rVy7GoTh1hL20
   b/M7sJBqOp9T4RndoY+sIJfQYTik2LylwAVCqdwaVN13siPhatZ37DBlJ
   yteWr6CbskWh17tW5C6BVEI7zsB2UwEoq/N/a2z6nyPy91pVbGcmmgN7s
   g==;
X-CSE-ConnectionGUID: E6tHCRO9QM2p7DUS4trJQw==
X-CSE-MsgGUID: /jOy0pFhQ4SItQ8rvlmKdQ==
X-IronPort-AV: E=Sophos;i="6.10,166,1719871200"; 
   d="scan'208";a="38527603"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 Aug 2024 08:22:09 +0200
X-CheckPoint: {66C6D911-3F-C661815F-E221238E}
X-MAIL-CPID: 816D29BFA19136B10F9B9F48EDBA3AC2_1
X-Control-Analysis: str=0001.0A782F16.66C6D911.0129,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D51C9169465;
	Thu, 22 Aug 2024 08:22:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724307725;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HcacUbyWZpubuOZfhpUp0O/XtbHaSh9hAtoPucDtrT8=;
	b=lJT/kkIxxTFg3RbJfT65e8khXpzaNFX2GY/oZ40cpYo4wu0AwYVTgHngkgZbLmEfD1oCHy
	l9FDur+S3iSfUNi3qsbukLP+pX8cyOgdSQlpI8pGQEYmHM7JYG19IKBnokwsEFQ3TbNH6I
	QnqZ8M2dzkGWDzXZgFjsyPE0VCoLRLmsE8qRz7RheYg4V8HqEGH6o11Ja7wVAeI4lsrM/j
	bc+HDus/QTMAcuG9gtGJK82nDXOmGYRCDF10i32Y1l4NReqJFGI3rTQps/m2sdnbKXlgA6
	VAqyfswpLVQ5KZbbeumTAJ6cL6OTtraIilnC4thVQysBr/Xb8FfGACJGQGhO2Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: krzk+dt@kernel.org, festevam@gmail.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tarang.raval@siliconsignals.io, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tarang Raval <tarang.raval@siliconsignals.io>
Subject: Re: [PATCH v2] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals Support
Date: Thu, 22 Aug 2024 08:22:03 +0200
Message-ID: <1979640.PYKUYFuaPT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
References: <20240821135817.56393-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Mittwoch, 21. August 2024, 15:58:17 CEST schrieb Tarang Raval:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
>=20
>     * Wi-Fi
>     * Audio
>     * SD card
>     * RTC
>     * CAN bus
>     * USB OTG
>=20
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>
> ---
>=20
> Changes in v2:
>=20
> 1. Updated the node name and pinctrl name
> 2. Removed the 'regulators' container
> 3. Removed a stray blank line
> 4. Removed non-existent properties
> 5. Removed unused node and pinctrl
>    - modem-reset
>    - pinctrl_uart1
> 6. Defined the CAN transceiver reset GPIO separately
> ---
>  .../dts/freescale/imx8mm-emtop-baseboard.dts  | 323 ++++++++++++++++++
>  1 file changed, 323 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts b/a=
rch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> index 7d2cb74c64ee..322338e626ce 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-emtop-baseboard.dts
> @@ -11,6 +11,113 @@ / {
>  	model =3D "Emtop Embedded Solutions i.MX8M Mini Baseboard V1";
>  	compatible =3D "ees,imx8mm-emtop-baseboard", "ees,imx8mm-emtop-som",
>  		"fsl,imx8mm";
> +
> +	extcon_usb: extcon-usbotg1 {
> +	        compatible =3D "linux,extcon-usb-gpio";

Please refer to Documentation/devicetree/bindings/extcon/extcon-usb-gpio.ya=
ml:
> Deprecated, use USB connector node instead.
>
> deprecated: true

Switch to connectors instead.

> +	        pinctrl-names =3D "default";
> +	        pinctrl-0 =3D <&pinctrl_extcon_usb>;
> +	        id-gpio =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
> +	        enable-gpio =3D <&gpio1 12 GPIO_ACTIVE_LOW>;

Use id-gpios and enable-gpios.

> +	};
> +

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



