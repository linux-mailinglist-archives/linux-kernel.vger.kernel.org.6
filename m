Return-Path: <linux-kernel+bounces-284313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1994FFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B771F214FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715118E29;
	Tue, 13 Aug 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="fw8Qq5Ia";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HbUN1uCX"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4F914F9EF;
	Tue, 13 Aug 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537410; cv=none; b=r7UgN/3nSfhrwPa8q7Vn9gaDY3t8LcKm4ugxWFnLlXFeq7l9gsQvmhSD0iDEgsyjS8EO5n5ewV0Q2Cm2SyGiAgKYUzf+pszC9U5ZwAEGv4F0cvsnHmZN0tx1nmgcomFKi42wrGXJoYuFUjh48FqbGOZElMj8cdqY9R5eqJI92eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537410; c=relaxed/simple;
	bh=IFg72+mtzh6RQ+UZ9+MPJIqB7b67Bf1PYBeDr/mTG9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjcKcoGddRK3/w6TwLDsh2ZcX0tHGH5n4bb7CKod6S3t8Onrhcla3UgaL8/DhY6r1GRPv07SRLSkKYKDEIqYzOFd4sFoLzvIqQbcWfOvP5wUTDCTMa7vJ68yySZpTbNAJLJalRRXSbZCSVZD61sq4FsKA3ZnuwAA8tBdRtu5LSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=fw8Qq5Ia; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HbUN1uCX reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723537407; x=1755073407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MlwmbhRm0FvrhPiqCXfvDAjoDBrL4s2spBnviZM0XpY=;
  b=fw8Qq5Ia0oTMSVDF8MoBjdVvHB/kqoYh0gr0xxic5DU0pTvBo4l0toRe
   m/L3ooD3uKMPlWqxlnA7OlYTFgw/xMIVdC+OqRPi2+y4Xm9wpF1nScjnz
   yRclHBH8c7AYzYC/j5vbVZukLZJHgu0x9WMk0e5YiCNdwebkOmBYYQGXJ
   E5TJNigrXdZcMllWMjA2dcACJpG1JrhtBfX1jvO+icMCzc6MfR5mnA28H
   KHgdL1R2Jv55zZlJ0H+f0UQk4giRMP3XsqkE5GF+CVNFhI8FpZgizMNQc
   v0c9i/q/hTmpNZDC/cY5TrsP+S65hCEHjx/btdSg2RGnGxevaGKde6NNN
   w==;
X-CSE-ConnectionGUID: 5ka7yRuTSRW8NNsvv+A4Tw==
X-CSE-MsgGUID: Id8x26jBQKSOYVLnG6uPcg==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38378492"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:23:27 +0200
X-CheckPoint: {66BB17FE-24-751552D8-F91D2344}
X-MAIL-CPID: 0C1D0021246A170C4EA5DC951AE37C8A_4
X-Control-Analysis: str=0001.0A782F28.66BB17FF.0042,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 67FF416473E;
	Tue, 13 Aug 2024 10:23:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723537402;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MlwmbhRm0FvrhPiqCXfvDAjoDBrL4s2spBnviZM0XpY=;
	b=HbUN1uCX+m5v8o7rvxcpPAs+Fg+VGKEqzl6bFfJt2V2aRBitaHvpF+kynroo3WUu3KY0P4
	XJUYXjm2+BN3jFklGezrLVDbcnUIKDOdJFW9djhezqnvNPHpijQUmE2BR5cR8qbWOANWRq
	H6r8QmcEm1uM45ToNGoWIiRGvx6KKvKl1aelbDEbImkJWTb43CnNqMY0j3d0tcqLA03do7
	u1fdFETYzmwg+Ang0Iybr2rZiCVb3Wljib7/Q1T4pZw7Qlobs0iAZtOBgBz05RIbZvdizd
	d24WhPUvTLpiEw783riohLdvtty48cb2UyLzSZfdS29pzu0F7dkbkwaB+yT5gw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 05/17] arm64: dts: imx8mm-phygate: rename uart4_rs485_en to uart4-rs485-en-hog
Date: Tue, 13 Aug 2024 10:23:24 +0200
Message-ID: <8413236.T7Z3S40VBb@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-5-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-5-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:35:00 CEST schrieb Frank Li:
> Rename gpio uart4_rs485_en to uart4-rs485-en-hog to fix below warning:
> arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtb:
>   gpio@30220000: 'uart4_rs485_en' does not match any of the regexes: '^(h=
og-[0-9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dtso | =
2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dtso | =
2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-r=
s232.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs23=
2.dtso
> index f1f38b739ef76..78f4e8d5814da 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dt=
so
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs232.dt=
so
> @@ -18,7 +18,7 @@ &gpio3 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_gpio3_hog>;
> =20
> -	uart4_rs485_en {
> +	uart4-rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <20 GPIO_ACTIVE_HIGH>;
>  		output-low;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-r=
s485.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs48=
5.dtso
> index 1d8951e1a47e8..66288948bdd39 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dt=
so
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l-rs232-rs485.dt=
so
> @@ -19,7 +19,7 @@ &gpio3 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_gpio3_hog>;
> =20
> -	uart4_rs485_en {
> +	uart4-rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <20 GPIO_ACTIVE_HIGH>;
>  		output-high;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



