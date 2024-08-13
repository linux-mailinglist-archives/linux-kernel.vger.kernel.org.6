Return-Path: <linux-kernel+bounces-284312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59F794FFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69F51C22D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8713CA99;
	Tue, 13 Aug 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WoTWoDGa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="E0jWcZ1m"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B218E29;
	Tue, 13 Aug 2024 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537403; cv=none; b=BN8uweSWqsK5co5O/pFRyNTUe9YzBYd1+qqudJhQXfUJL9yV9utub27RYSFuBWfEpKwgU9t6+JU3E7bQq8IqEDWVCE1sHWPMKcAIJkK99CwUuQvuqDn3Wq+XniVq5D6uyo9iyfFTNCMQsMznQ9gukhslBhqhI9Uav/JCGuJ3Znw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537403; c=relaxed/simple;
	bh=egZQa+e65TaynMMGJkSXoDp1rTV21M4BINmITsK9/t8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSHFsAlMWuB9ByrAkwZJ6+30AedgqVVQRocadIhVC75oc/H3tS5ZKJy4g+0hZ8yd33KZfJBElFaG2t84nn7DQpC1lVcJTqfcd1Rab6V3gkwS5+wzl0R660g0A1Elx5YC6X/Yc7isGYzG3EoHuEhNaSkfAzCyaVQon5PYRN8/n20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WoTWoDGa; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=E0jWcZ1m reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723537400; x=1755073400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B5nJiHDDu7grJbrlKZ32dTnhWF/f3QNqwuRtqlqc3So=;
  b=WoTWoDGa22BOQBMGq7MQZt4CBraXF+nEgXXwN6cOc8XzCMIrk6+0D6i6
   booMcUmlF8ku9kTlp+8K6+VdxyYafyXO7PcIobPTWPazibMlzLJEBbdKR
   BMKRJDWO2WtdxiKWDjSZbOQv/dCnTvUVMNjSijygqdmwsddrBv0nLxh03
   EgCUTTR6ZcfRZ6WbLwbBiA6mvcKLQD6zTYjDDCEmk8FEcVEfrQbw6im3D
   qIMg+8nV+VB6cZ0TDNiihT4Rgz0T06kzfQndaLaLFj75G603mTf5Uofj8
   rTVQ9p3sDPz6rwMHuWMa2T2d13niRgZvW3IoyGsvrAOljBVMiwOZw5vJJ
   Q==;
X-CSE-ConnectionGUID: WcCANwMgQQ+FoKVTPOabxw==
X-CSE-MsgGUID: vwMbqkxTQDC6uPAUBvtgPg==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38378484"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:23:18 +0200
X-CheckPoint: {66BB17F6-25-E9ED6009-C4B0BEC8}
X-MAIL-CPID: 94195F67F5049CCE8BC86E5E540D924F_3
X-Control-Analysis: str=0001.0A782F28.66BB17F6.017B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BDB8216A295;
	Tue, 13 Aug 2024 10:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723537394;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=B5nJiHDDu7grJbrlKZ32dTnhWF/f3QNqwuRtqlqc3So=;
	b=E0jWcZ1mrG2XTVMm40GELz5j5gyZIf7MnnmcJ0ZuJUeq0zDZkzt5+CgRoWIb0wdxiBK6cB
	CczPwaV1i+/dG02l8WEtP8xSRHSoK0A2CMn46/LCVdo3SJ5DBrkON0AisO2oMPdj/iAbwR
	HSepr15xXt3g/65cwjQd6js0qZ7gTnAzAwAO52aJxUBlRijjIr7a1ahu1ZsoUM0xFcKLiy
	1WcHhyuQMnXRRg4YfWjvkmMBqqf7rsBai4iRvVX0qZSdH34KEgNdjT2fC85p0GvZnrr02S
	EtquTSG7GRgsRcQx2/Zilx5hzzxCl5mLKJ0AcZAd82YbCX1s2H9dAhNbWzOR2w==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 04/17] arm64: dts: imx8mm-venice: rename rs485_en as rs485-en-hog
Date: Tue, 13 Aug 2024 10:23:08 +0200
Message-ID: <3307532.aeNJFYEL58@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-4-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-4-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:34:59 CEST schrieb Frank Li:
> Rename gpio rs485_en as rs485-en-hog to fix below warning:
> arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtb:
>   gpio@30230000: 'rs485_en' does not match any of the regexes: '^(hog-[0-=
9]+|.+-hog(-[0-9]+)?)$', 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso | 2=
 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso     | 4=
 ++--
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso     | 4=
 ++--
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso | 2=
 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso     | 4=
 ++--
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso     | 4=
 ++--
>  6 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-=
rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.=
dtso
> index 47d3c0c49e8a0..bb2056746f8c9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs232-rts.dtso
> @@ -16,7 +16,7 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-low;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.=
dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> index 7fcd8c851159a..45ac8bdce8699 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs422.dtso
> @@ -19,14 +19,14 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  		line-name =3D "rs485_en";
>  	};
> =20
> -	rs485_hd {
> +	rs485-hd-hog {
>  		gpio-hog;
>  		gpios =3D <2 GPIO_ACTIVE_HIGH>;
>  		output-low;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.=
dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> index b19e38fc27bae..30aa620d7004d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx-0x-rs485.dtso
> @@ -19,14 +19,14 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  		line-name =3D "rs485_en";
>  	};
> =20
> -	rs485_hd {
> +	rs485-hd-hog {
>  		gpio-hog;
>  		gpios =3D <2 GPIO_ACTIVE_HIGH>;
>  		output-high;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-=
rts.dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.=
dtso
> index c0f6aece844a0..b1a9f35e1dfa7 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs232-rts.dtso
> @@ -16,7 +16,7 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-low;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.=
dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> index e909cbd8db4bc..44ebc0a58c51a 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs422.dtso
> @@ -19,14 +19,14 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  		line-name =3D "rs485_en";
>  	};
> =20
> -	rs485_hd {
> +	rs485-hd-hog {
>  		gpio-hog;
>  		gpios =3D <2 GPIO_ACTIVE_HIGH>;
>  		output-low;
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.=
dtso b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> index 1508cb5175b3e..2f8a7ac408739 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx-0x-rs485.dtso
> @@ -19,14 +19,14 @@
>  /plugin/;
> =20
>  &gpio4 {
> -	rs485_en {
> +	rs485-en-hog {
>  		gpio-hog;
>  		gpios =3D <0 GPIO_ACTIVE_HIGH>;
>  		output-high;
>  		line-name =3D "rs485_en";
>  	};
> =20
> -	rs485_hd {
> +	rs485-hd-hog {
>  		gpio-hog;
>  		gpios =3D <2 GPIO_ACTIVE_HIGH>;
>  		output-high;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



