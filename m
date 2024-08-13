Return-Path: <linux-kernel+bounces-284311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD17194FFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E87B286A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3E717B433;
	Tue, 13 Aug 2024 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Mocamj1H";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HZDDitZt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC41F13A244;
	Tue, 13 Aug 2024 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723537360; cv=none; b=VpVkp4awgi2EugQWnMdg2jFxZrz+Zv9fzqGjV/v0ugtFAV2ISPk/CmcJtGF13I5GwCbs+ghl/7i3VncYBt5DkVHZfvJ2ZDTkSDP8auGeKJsLJXc7BjTdGIrYXmwyyae6AhyYPVysqaff+v/BWcgbCs+JGyn4SAMQIqlND1l57G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723537360; c=relaxed/simple;
	bh=mVeY6ZVPj7E9N3j7I8dipfZ8KuiUSOnB3yhLgNnkxxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UjCetKeLHkl/JzpyGbhSJ2LmfjEk+7d0ePp1chYzE8v+9hP4/lNvUceTcRZTH+m6s9cGiAZMj7BtZt+59T2Iaj5xHkWaib+v3vHMLVCtoACCpcLjdDnts/ljj9zCN9C7YilRfxrJhY5p8nP9hMbZDPyqx8sTAtwzR0PAS/8dy6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Mocamj1H; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HZDDitZt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723537358; x=1755073358;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zyxkgO7/FUdzfdJpMYDQ1IKiEHi3VrPpcDg8bJhaTA0=;
  b=Mocamj1HJISuZDJ1x6nTB/oc+mph4JvjYqOrfHrgEQbAecs2YzdvjQOw
   1mkBFqVP5/m9g3Dal/V2zUlZ5lqiqZJSTzdS2EvPTjtMEZ09R4xue4sZO
   nCAYLPRvLrhkPkBwUERM+TWhA0nVzrutzvw3xdmSduVykhQx5OHimiswM
   LI+yy74JDoEzPpSeD1mAvYXGGBqPTCVejD9ieajkZS4yKTxo7H9yM+dR8
   Xepj/tCa0Euo4eh2ubjDUvjdncqBKlU9FYdNyc/eMfqqQYWfBEVE5V96b
   N5u27KQiHNvQkRO31io8Rh7cYgq1bMwOVcnFrXVMH6qsE/yxuJQRbgocw
   g==;
X-CSE-ConnectionGUID: qn3u0PlLTIGUhiAU/TV59A==
X-CSE-MsgGUID: 790DRWhHRLSjCjppwmjIvw==
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="38378460"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 13 Aug 2024 10:22:36 +0200
X-CheckPoint: {66BB17CC-3-751552D8-F91D2344}
X-MAIL-CPID: 5F4738AD7D22CB1461ADB191A6F3620E_4
X-Control-Analysis: str=0001.0A782F26.66BB17CC.0053,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7A2FD164B7F;
	Tue, 13 Aug 2024 10:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723537351;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zyxkgO7/FUdzfdJpMYDQ1IKiEHi3VrPpcDg8bJhaTA0=;
	b=HZDDitZtfkxtq2od5UKZ1aljJJZsINrdm4WxXCJbSlxys+RMpwzQDM5zVaRse0I3lQcDZp
	H8X2GHyj4wCW8Wls8P09HvgxMgpduddpmzWrUqCXOAw0NIJZeH1IMIf7IzbXzkTfOO8/Cj
	r+KI1llg5noEcqZzj9vpOrLMEvS6UqFxtcVnrvWnA02Abm1TK4XQu+woqC9zw/Y1gp8t5l
	oKBSvwVoJWsdHu7yvMZjTZzF6vRwQ+JqqK4asu6jdlycJUSDBK6t1LWJP6M6MmHoX0YzpN
	Tj3zpOk55Li7NOm5X6+nOlaCawALDehg9bzNcMkBQXUqhgLVmRZq5461pyhpnw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Gregor Herburger <gregor.herburger@ew.tq-group.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux@ew.tq-group.com, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 03/17] arm64: dts: fsl-ls1088a: rename gpio admin_led_lower to admin-led-lower-hog
Date: Tue, 13 Aug 2024 10:22:34 +0200
Message-ID: <13576897.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240813-imx_warning-v1-3-3494426aea09@nxp.com>
References: <20240813-imx_warning-v1-0-3494426aea09@nxp.com> <20240813-imx_warning-v1-3-3494426aea09@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Dienstag, 13. August 2024, 06:34:58 CEST schrieb Frank Li:
> Rename node name admin_led_lower to admin-led-lower-hog to fix warning:
> arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dtb: gpio@76: 'admin_led_=
lower' does not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$'=
, 'pinctrl-[0-9]+'
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/a=
rm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> index d4867d6cf47cd..57f2082143c8a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
> @@ -220,7 +220,7 @@ sfpgpio: gpio@76 {
>  		#gpio-cells =3D <2>;
>  		gpio-controller;
> =20
> -		admin_led_lower {
> +		admin-led-lower-hog {
>  			gpio-hog;
>  			gpios =3D <13 GPIO_ACTIVE_HIGH>;
>  			output-low;
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



