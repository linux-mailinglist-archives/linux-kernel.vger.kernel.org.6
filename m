Return-Path: <linux-kernel+bounces-380019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B539AE76E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DF55B23730
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EAC1E5717;
	Thu, 24 Oct 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T/K8raOS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="RdTj2nYm"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D661E2009;
	Thu, 24 Oct 2024 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778762; cv=none; b=TfhO7M8v4Ex3X9C977UC88NUyiOP7Vue4lnvUNhlQZFfbkMxfiefwXf3lHYRs8LgqSIfZ7NdEAKnnYBg7QJr1D6dsYLN0zVX4Gk1qG2KlaCVHuXiLcpVre3oAVT+HqujtHuJtRMcj62hEGmuha1bUQNbjIO5yc0AOU0a3FcTu/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778762; c=relaxed/simple;
	bh=q+Oe0bTom/S230sfkLA0xaDCMKVJbIM9iCi+2pFjYhM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS8tv2RGAtd2jTY6lvQvDkkxuHM8EvzUnK0EUA+jIlS2gCgmkVWMRdpz3eVssTWH10qhHYkOobulLt3K3503MbEnS24+Tzzi+jPmslVibd5vJY+9/c1fTDd9rEM6m76Qx86X2Se16HSjHN9dPYjanFQsFS0dY7dpdRwMt0acfv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=T/K8raOS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=RdTj2nYm reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729778758; x=1761314758;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=B4rZ85uABm1rBWYYFvnPSd8gxVULaUc5YT80QXzNgb4=;
  b=T/K8raOSHfb3kTWqYsIOn6trU1hbpS9vkcnAa3pDO2yUC2DkA/XvQNO7
   sksHWrkX6tDpEX7m5LZXOzmraXSKisrpfSDEy8JUzZhicbc/4HJNCkhV/
   e+92LjA09OqH1t4eq35qMJgMs/txyntUMeBuhq5pc3WDecWKlvqKyxSeE
   mMAf4AzvkiWbwGJYwmh3zyPuSKLCw+yDsECvNAQkxI1xSxog/WMw7A1Zf
   HAUCnRAfYib6d/SkvBBr8kMseNHrHFrPJDn1/CNbqmy7aI9JGis84PnFh
   DLPd1Zv63Yt1jbIYH3yhdxQWEgIwdKWxQbXpimGwrhDELpSsX2XwYhN4l
   w==;
X-CSE-ConnectionGUID: 4+/5weJtQWig6PIjf/4DBQ==
X-CSE-MsgGUID: UOiXlctXSkuUnieqcw8T6g==
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="39654474"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Oct 2024 16:05:49 +0200
X-CheckPoint: {671A543D-F-65F98A6A-FADAF7F3}
X-MAIL-CPID: 3E82C7D35B6B9BF454F6351958F5EAB0_5
X-Control-Analysis: str=0001.0A682F1D.671A543D.008C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E867B1614D7;
	Thu, 24 Oct 2024 16:05:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729778745; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B4rZ85uABm1rBWYYFvnPSd8gxVULaUc5YT80QXzNgb4=;
	b=RdTj2nYmrsEIh0AFTJcu9izdoML6Yywu/vHG9n0EbmEzC9JQMSehsZHnQbfmT8H1LMNqpL
	VK62Ga92/ChQ64VURPbHX3ogPlbTNJbM7Yv/OIAjaId2MaLm2nQfLAflvOrXbGKbp9f40Y
	7TndtjmJ32pTMMs9VzFTfmm7pHiJa2/pPcuex1A3lusjBQppLs3WJv9vgMaOsQvMauNeRW
	trv9ZSU3zrTnqlgFDcBRBUINA4m3EBUkbrUmFSTj2+2mJfbuFETxxDXd/y7jSsSiFseB+Q
	RTSkvd3c9JrdhZx0rvg2y69rbM9keP1GDGGxOfK6QsdZOlDvWeOSZzctO+Dzlw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, "open list:TQ SYSTEMS BOARD & DRIVER SUPPORT" <linux@ew.tq-group.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] arm64: dts: imx8mn-tqma8mqnl-mba8mx-usbot: fix coexistence of output-low and output-high in GPIO
Date: Thu, 24 Oct 2024 16:05:43 +0200
Message-ID: <8443837.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241023210313.1390767-1-Frank.Li@nxp.com>
References: <20241023210313.1390767-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

thanks for noticing the issue and also providing a patch.

Am Mittwoch, 23. Oktober 2024, 23:03:13 CEST schrieb Frank Li:
> Fix the issue where both 'output-low' and 'output-high' exist under GPIO
> hog nodes  (rst_usb_hub_hog and sel_usb_hub_hog) when applying device
> tree overlays. Since /delete-property/ is not supported in the overlays,
> setting 'output-low' results in both properties being present. The
> workaround is to disable these hogs and create new ones with 'output-low'
> as needed.
>=20
> Fix below CHECK_DTBS warning:
> arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtb: sel-usb=
=2Dhub-hog:
>    {'output-low': True, 'gpio-hog': True, 'gpios': [[1, 0]], 'output-high=
': True, 'phandle': 108, '$nodename': ['sel-usb-hub-hog']}
>        is valid under each of {'required': ['output-low']}, {'required': =
['output-high']
>=20
> Fixes: 3f6fc30abebc ("arm64: dts: imx8mn: tqma8mqnl-mba8mx: Add USB DR ov=
erlay")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Thanks, this works as intended. If this overlay applied the USB OTG connect=
or (X19) can be used.

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> Alex:
> 	I have not hardware to run it. I check dtb output is correct.
> ---
>  .../imx8mn-tqma8mqnl-mba8mx-usbotg.dtso       | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg=
=2Edtso b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> index 96db07fc9bece..1f2a0fe70a0a2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-tqma8mqnl-mba8mx-usbotg.dtso
> @@ -29,12 +29,37 @@ usb_dr_connector: endpoint {
>  	};
>  };
> =20
> +/*
> + * rst_usb_hub_hog and sel_usb_hub_hog have property 'output-high',
> + * dt overlay don't support /delete-property/. Both 'output-low' and
> + * 'output-high' will be exist under hog nodes if overlay file set
> + * 'output-low'. Workaround is disable these hog and create new hog with
> + * 'output-low'.
> + */
> +
>  &rst_usb_hub_hog {
> -	output-low;
> +	status =3D "disabled";
> +};
> +
> +&expander0 {
> +	rst-usb-low-hub-hog {
> +		gpio-hog;
> +		gpios =3D <13 0>;
> +		output-low;
> +		line-name =3D "RST_USB_HUB#";
> +	};
>  };
> =20
>  &sel_usb_hub_hog {
> -	output-low;
> +	status =3D "disabled";
> +};
> +
> +&gpio2 {
> +	sel-usb-low-hub-hog {
> +		gpio-hog;
> +		gpios =3D <1 GPIO_ACTIVE_HIGH>;
> +		output-low;
> +	};
>  };
> =20
>  &usbotg1 {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



