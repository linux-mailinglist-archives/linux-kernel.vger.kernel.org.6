Return-Path: <linux-kernel+bounces-298307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B195C577
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB8621F225E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746FE77F11;
	Fri, 23 Aug 2024 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FxtpdeRA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Qnw9Ikln"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0E93F9F9;
	Fri, 23 Aug 2024 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394498; cv=none; b=e+YcKXKeWbmt+7dmhAAINsAbqEAPmIXXi/+vXenDfOL//Js1vNdJLaIVWeQPwacS5zCjJkXuiake0GLo/dRe7f7pNbBiVYDidZMX1+GY6iCHEkmVxPDnss0OgdeXTf/YKWU4cuUjpqmYmdUv1yT+HfTn4r7Eqx2zQHSXK6LCv3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394498; c=relaxed/simple;
	bh=lA9bKhtjUQMECgS6x1OcRtqEQn4zIHoANXSOuPPLqcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kzt0B9v2PRqXqP6Ff4ppF3qB4ro0Gux/eOgjkgK7IUnqoV3/takDKyT+zce/jfRFWSnKQ897dxNb8J+1PgbjVOR4UMfBatEuc+icALof8x2waybaghGjm3Hh2f5x2aRnrOtOlk1BKm5zYfx4PcPCqBgPU867CCyaFVJC8OITk4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FxtpdeRA; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Qnw9Ikln reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724394495; x=1755930495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xbast0cN6Jy/gxT6Fnxt08kJvl3a05tYYkEiG/y3n8M=;
  b=FxtpdeRAGQLxdKXEBISJN78XPvjBKSrsDB+jndvjZ43YSD+qcyAs9ryO
   CH0IUJVaU6eSAb2jthh2P6wLo6mCmx4MOj9jhr/YkQb1q9nxOGDPlTxoC
   0i7xAERN27XWuf5qLzq5F83iWPvWSrEPa++E+sxOt/3rBZDYsdFdOFLpl
   ohZIYICSZbwYgpGLEbCQMtzlHQ4FNR72rcea0zUsrW6bXrWRFOMxnW7ZF
   hluKh+woGeqT+Ejp/BYFvlWIdpRA+jDCTMqmWttA6OXDqnBYpky3fpiSF
   Jz6ZXGFUQjHWKP3MOyhUDE29Ml2mGI9cU49LCjZoS6J7ipVQtfZFpGAA1
   A==;
X-CSE-ConnectionGUID: QN9sJb91SxGvOdTBMTyRbA==
X-CSE-MsgGUID: xYziBBf3T7yxRojJJkYtUA==
X-IronPort-AV: E=Sophos;i="6.10,169,1719871200"; 
   d="scan'208";a="38551070"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 23 Aug 2024 08:28:07 +0200
X-CheckPoint: {66C82BF7-A-6568578B-E2E34638}
X-MAIL-CPID: 18533A58E4AB3FE89540CAEF9C99C5D7_3
X-Control-Analysis: str=0001.0A782F1E.66C82BF7.007B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AB1651695DA;
	Fri, 23 Aug 2024 08:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724394482;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Xbast0cN6Jy/gxT6Fnxt08kJvl3a05tYYkEiG/y3n8M=;
	b=Qnw9IklnrgLnz06bCXzMx5lQubSVpPYNb0E6lk7e5zpE5kcA3P7WbUs1852x+Bo/cdNv6G
	Ux7suOlzV2I0Swp/ojdv18Q3fs9H+fJUMfSqFvMQMZO1c5veAubxzae5+L+xEpl9PBUrtT
	a9xFqWQljZNr+Tm/xOnt0fbVuo4w7DHIPd1bJ6KJyi4jx1XBdd1GwYFu1bN5c27jURun+N
	ucRKj0zhU7ZAlLlOwwyAnQD5mrThfDJhoN3KxqDL8L8uuvO4k/xGARwZ4JOyK0Xf8ZvDId
	OE4hkdKOHVaBP58SwLFM1jkw+23prAAJW93M/j77DrD0jKxlfd07XDr/H1lepQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [PATCH v2] arm64: dts: imx8mp-evk: Add native HDMI output
Date: Fri, 23 Aug 2024 08:28:00 +0200
Message-ID: <3242009.5fSG56mABF@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240823021257.1067054-1-victor.liu@nxp.com>
References: <20240823021257.1067054-1-victor.liu@nxp.com>
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

Am Freitag, 23. August 2024, 04:12:57 CEST schrieb Liu Ying:
> J17 on i.MX8mp EVK base board is a HDMI type A connector.
> It connects with i.MX8mp HDMI PHY.  Add support for it.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
> v2:
> * Change label hdmi_out to hdmi_in. (Alexander)
>=20
>  arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 46 ++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/bo=
ot/dts/freescale/imx8mp-evk.dts
> index 938347704136..d26930f1a9e9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
> @@ -56,6 +56,18 @@ memory@40000000 {
>  		      <0x1 0x00000000 0 0xc0000000>;
>  	};
> =20
> +	native-hdmi-connector {
> +		compatible =3D "hdmi-connector";
> +		label =3D "HDMI OUT";
> +		type =3D "a";
> +
> +		port {
> +			hdmi_in: endpoint {
> +				remote-endpoint =3D <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	pcie0_refclk: pcie0-refclk {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
> @@ -408,6 +420,28 @@ &flexcan2 {
>  	status =3D "disabled";/* can2 pin conflict with pdm */
>  };
> =20
> +&hdmi_pvi {
> +	status =3D "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hdmi>;
> +	status =3D "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint =3D <&hdmi_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_tx_phy {
> +	status =3D "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency =3D <400000>;
>  	pinctrl-names =3D "default";
> @@ -604,6 +638,10 @@ &lcdif1 {
>  	status =3D "okay";
>  };
> =20
> +&lcdif3 {
> +	status =3D "okay";
> +};
> +
>  &micfil {
>  	#sound-dai-cells =3D <0>;
>  	pinctrl-names =3D "default";
> @@ -858,6 +896,14 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
>  		>;
>  	};
> =20
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins =3D <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0x1c2
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0x1c2
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC		0x10
> +		>;
> +	};
> +
>  	pinctrl_hog: hoggrp {
>  		fsl,pins =3D <
>  			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD		0x40000010
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



