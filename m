Return-Path: <linux-kernel+bounces-371179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC82F9A376E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 519D0B23ACD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C68418A952;
	Fri, 18 Oct 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JU9PiKp+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="H3H2Y8u1"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DCB189F30;
	Fri, 18 Oct 2024 07:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729237299; cv=none; b=D6P3AsOzvmOYy4YwllTLpN/38J6+JAp+NiJ7ladlwSCebHBGuv2DZ7RZVmQgPDgzDBYwavUmhuWSJAXY4nwE7FfE4tInpgHnWsWpdYYqpvODC4Ycr/SqrG0oPUlf2I7Ic3pH/lktcCXpk1fOXWnVIGBhf/0IsskAh7keSd7Ko48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729237299; c=relaxed/simple;
	bh=zeorLqXwbtDU9Ji0qYCz0EAZPImDc2a41C+O4R/qBMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9xtLLtb/UwviHFGGHa8wwcuOKoOs2gR9KhZjasmeoA3TCUMI0RUy1B0LzZy5k1VhKFzHY5/gDR7oDOefmYRvMvWQ7VHzPWjTQmWi5JEmb/ML7gP7rQzUFgs/KOjlnfK3UaHyIeZYT9DoV7PJyGnnRI27w5kJpTvYOwgunRwzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JU9PiKp+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=H3H2Y8u1 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1729237297; x=1760773297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xeVr9bMa2g6GiJcg+BiL+ToWNVTX7ISYMLWf5g6EiHA=;
  b=JU9PiKp+356pijr5UQFSuytmwr7Gk5Ej4DZ7bKWdlbh5xR2AQYrCvl60
   NnAAKtKLL7SZax/Xm+4DRRHPZvgAOXYlsdspBQKFDWAEI4PkuSO794zU9
   4Qd3oFhqs6ZQ1xGgozKIlU/oze2nzWKtg5q/j0ReE6T9A02/5IYlHfCXf
   LmlImmModKe8C4KXvvrx4fXAhy2VNWhFibOFanTuufReZlltqYurBo0Db
   UxwdLspNz1LAFsxScpPe4mjnQ6FUXZTz0SjgXm8snxdY6ZaPdzK0rWuuy
   //EW1tXzXdoMMORbeF0hL+Nh6Osl3EsjNhJt191F6veENf1AZt9yp04FY
   A==;
X-CSE-ConnectionGUID: 3XNvjDrAS+OoW0X0RTXriA==
X-CSE-MsgGUID: 4A1sKUj4QPGFMM1y/1dU1g==
X-IronPort-AV: E=Sophos;i="6.11,213,1725314400"; 
   d="scan'208";a="39535077"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 18 Oct 2024 09:41:34 +0200
X-CheckPoint: {6712112E-27-65F98A6A-FADAF7F3}
X-MAIL-CPID: 569D6674B48E1ED74031FBDC5821AFF1_5
X-Control-Analysis: str=0001.0A682F17.6712112F.0012,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D9101691E1;
	Fri, 18 Oct 2024 09:41:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1729237290;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xeVr9bMa2g6GiJcg+BiL+ToWNVTX7ISYMLWf5g6EiHA=;
	b=H3H2Y8u1YDan8E3dryRPfWJ9Jnp+AbNScbVqtK5iv9od2o3XLrbCb32GKPSMXYUcDMrsR1
	zjwOUUVmspacY31yc6uHGVfYmIuFxkv5UnCzbwWkm+FmrfOqahC1O7mAoHJ4PpmJIrnndz
	LDKMx8P1onz1OXtZs3PmwoXzJMy4DmEThQmqae0+r3GNeCjgRWaoJIXSG4Z30r4AyEj1Z7
	wiDTUryhpj1y/IYrhkYqbrMhtvKzUVa4CuiPxpVolflaU8Y7vTU6T1hWdMReQGsbmOtEax
	VhrTJV6q0RS1048HlXHMsuiOn3e8FI6fe4hbXHHjFrStRDPsadbUeNGADCLqJw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, marex@denx.de, stefan@agner.ch, dmitry.baryshkov@linaro.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH 2/5] arm64: dts: imx8mp-kontron-smarc-eval-carrier: Add HDMI connector
Date: Fri, 18 Oct 2024 09:41:29 +0200
Message-ID: <2237341.NgBsaNRSFp@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20241018064813.2750016-3-victor.liu@nxp.com>
References: <20241018064813.2750016-1-victor.liu@nxp.com> <20241018064813.2750016-3-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Freitag, 18. Oktober 2024, 08:48:10 CEST schrieb Liu Ying:
> Add a HDMI connector to connect with i.MX8MP HDMI TX output.
> This is a preparation for making the i.MX8MP LCDIF driver use
> drm_bridge_connector which requires the DRM_BRIDGE_ATTACH_NO_CONNECTOR
> flag.  With that flag, the DW HDMI bridge core driver would
> try to attach the next bridge which is the HDMI connector.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Looks similar to imx8mp-tqma8mpql-mba8mpxl.dts, so:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  .../imx8mp-kontron-smarc-eval-carrier.dts     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carr=
ier.dts b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.d=
ts
> index 2173a36ff691..815f313a2d33 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-kontron-smarc-eval-carrier.dts
> @@ -29,6 +29,17 @@ extcon_usbc: usbc {
>  		id-gpios =3D <&gpio1 10 GPIO_ACTIVE_HIGH>;
>  	};
> =20
> +	hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	sound {
>  		compatible =3D "simple-audio-card";
>  		simple-audio-card,bitclock-master =3D <&codec_dai>;
> @@ -108,6 +119,14 @@ &hdmi_tx {
>  	pinctrl-0 =3D <&pinctrl_hdmi>;
>  	ddc-i2c-bus =3D <&i2c3>;
>  	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint =3D <&hdmi_in>;
> +			};
> +		};
> +	};
>  };
> =20
>  &hdmi_tx_phy {
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/




