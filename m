Return-Path: <linux-kernel+bounces-284326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AAE94FFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 474D01C22522
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB4B13B2B2;
	Tue, 13 Aug 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="QKib4JFS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="f7U1MbxW"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5A6BFC0;
	Tue, 13 Aug 2024 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537926; cv=none; b=KjKhz/z7x+2mLgA54N2QfK1/jbkQK/bpaElD2oB4dy+BITXOdwEr3tZNdnpYG/xo2qxvpzrfuuqjg7wLOQK2p+zisu/NxT6D+/UdzjDxg6BN6wS8V0QT78TNYznQcFPFMLQEpaRp8SkZL5M9010L530gRfn3Z0yu+okV4NjPFOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537926; c=relaxed/simple;
	bh=lEgV73oQFb4wSPPKQYw/Kz/gUusFzSP+RDDMV2j5zvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7dxeW/ZWGWmfKKgicTorFPk8PhPqLisuZSOTRTE409hWDGPnWiE5FZA19V6tS8vXrs0AJmea/WOYHNNSvXRWaIHkDMwm/0sswSjKl/ARBouVCd5bCGIwQdg2eSV6OEP7p7FvxebuVoVR4Jq58K11ZQ7E6bUJ9rGEzs43rI/pxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=QKib4JFS; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=f7U1MbxW reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723537925; x=1755073925;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SoUo98Y/KDhV7rpJ07j6/bY/KoM1M5CslouXTk6xr6s=;
  b=QKib4JFSsqOQycq/lSUAC8oJ+iCMGAp57B6hD1QfOeyHqJZ+5Ge6sty2
   gRs0xTbcVZm07nhsAeyrdusizDej2FRZF5mKiYXMo3798yikIzklrmi3g
   Yrg1F4P50kXiuSU4Ovk024kqEUfNUuItRt02li6658+XVCkTYGHfBRMne
   Ez4EHW8Ma7vVv/jiEwPV7lOEtp1LoQozqmAOn5N2hCProIqMYsWksflky
   mtZA6SPOlkIYzpeWCahnR+TceXW65nzOo8X2dYeyj6rl7YL55woB/fREG
   mQ/R2EdWytRNBUY6fRHGvgnFyrJhGQCMEaPie+2czJh0nXHpZf9/WkkX1
   A==;
X-CSE-ConnectionGUID: vGd+0kVFQiKGuuo/XImVXw==
X-CSE-MsgGUID: gZ+q8cY4Rpq48ZcAUaia6w==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38378889"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:32:02 +0200
X-CheckPoint: {66BB1A02-34-2C7A84BB-EFCBC4CF}
X-MAIL-CPID: 862DDC47C70EC59211A7B638BF404C29_2
X-Control-Analysis: str=0001.0A782F1E.66BB1A03.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 292F316A381;
	Tue, 13 Aug 2024 10:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723537918;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SoUo98Y/KDhV7rpJ07j6/bY/KoM1M5CslouXTk6xr6s=;
	b=f7U1MbxWI7PKKpMLHpKITmuKiPBqwLodORc8x3brT7LuBOYYQnvSi0xjlvDHUUzJLf+Bk4
	BBVogR8wbrNSInsGu9BK6mfmditXIc7KJ0JRSxmK0Elle8oxIgD4a3WxXotY0uN1T63yma
	0VMwwblvBFtkqKQDqItD7jD6cbEztKJEMFzkZByPTIKaEXRqK43kwm8QuXZfrC9834gcUz
	xoU6jcU+U/XJvdqpDk5fOjKJMDKliE3ar3fgLQusHUMRiO1R3kg0M/tSFZ50RynmIMKjpG
	8gdzyMuZ0apgv+2QOQp0CwFQ3p+r1DQDmPpKe4M0eXNOvymQ4i+0H306F4aOQA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 07/17] arm64: dts: fsl-ls1012a-frdm: move clock-sc16is7xx under root node
Date: Tue, 13 Aug 2024 10:32:00 +0200
Message-ID: <3581541.iIbC2pHGDl@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-7-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-7-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:35:02 CEST schrieb Frank Li:
> Move fixed clock "clock-sc16is7x" from dspi to root node to fix below
> warning:
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dtb:
>     serial@0: Unevaluated properties are not allowed ('clock-sc16is7xx' w=
as unexpected)
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts b/arch/ar=
m64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> index 2517528f684fe..75081ce3e9a6f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
> @@ -20,6 +20,12 @@ sys_mclk: clock-mclk {
>  		clock-frequency =3D <25000000>;
>  	};
> =20
> +	sc16is7xx_clk: clock-sc16is7xx {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <24000000>;
> +	};
> +
>  	reg_1p8v: regulator-1p8v {
>  		compatible =3D "regulator-fixed";
>  		regulator-name =3D "1P8V";
> @@ -69,12 +75,6 @@ serial@0 {
>  		clocks =3D <&sc16is7xx_clk>;
>  		interrupt-parent =3D <&gpio1>;
>  		interrupts =3D <13 IRQ_TYPE_EDGE_FALLING>;
> -
> -		sc16is7xx_clk: clock-sc16is7xx {
> -			compatible =3D "fixed-clock";
> -			#clock-cells =3D <0>;
> -			clock-frequency =3D <24000000>;
> -		};
>  	};
>  };
> =20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



