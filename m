Return-Path: <linux-kernel+bounces-400214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 006C59C0A78
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AB4B22BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49159213157;
	Thu,  7 Nov 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Tg2iT9d1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="No6iMnSt"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3E1DFDAD;
	Thu,  7 Nov 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994887; cv=none; b=NgD5iHSmPN2wuW9a2dqr/tn+aGncW6PoiJa461n+Wz+KUe2ygymHlMMBSEJmWEA8fucjuwYyg6EuQZ9iXM3QyRhQxiaxBlBqWf1gywg8D2zasgXs8E6WjQ5xx2HFKIVS0AfvKkVh6wNSeKa2koCp4MCBTXexlby/A3NlIZQQmgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994887; c=relaxed/simple;
	bh=Ih5uy2mORL7zgF9t3dZwcn5wEoQiBF6asjcDp6PLZzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmvNjSkcyA/ZmzEziMtjD3lU1yu/eG6aRL9IqkUbqO9Ggl7F66BgbK/wXVv8MlIVC1afkTN+yEtfmWKiF1OZbGd1iXL0xb/kwrASqBQDpfFTJBCDiyWcR4dtXU3WHcjUPkPC68TxhLk9cZdskPSJOCa0yuaDIY8Xo4qr6SzH3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Tg2iT9d1; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=No6iMnSt reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730994884; x=1762530884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68iYgYZPtTrqGDWuMYx5z5BMV4YrJufQaee60Zp3m/s=;
  b=Tg2iT9d1a8wGC2b2mUjr22O8jtfx+41gy5ql0WrvLBf9IHUSycxTJtSl
   hh0a9zqFQ7nlmlHN0iSikAs0y4jCPASyE2i7cyiQXQkE73hqY1jT7xaJ+
   zuYd0npBE6YGkq0rBj7oKXmU4Al8Qtyo4JDWH2ELRKqkHhVEAc6R6WuK4
   FNFhUFaM+KnlB0HaFEgRCJkp8NalXpPVxmWBfM7xZ/zwv36VEnEsHzXhS
   34WJxolpkzxGnC3Y9eDk9dpCH73OnMUIAUxwqsYxpdWIUf9cnKzwtO0oI
   fNFNT2WZmaGU53gd4QAphAUH8lgfGk9j/wSqJGZFNDcPEd0sdohaKDZ1W
   A==;
X-CSE-ConnectionGUID: LKRP2YrGS4ONzZAbOb2EiA==
X-CSE-MsgGUID: MDn25V+cRaaaZRjeLpSeFA==
X-IronPort-AV: E=Sophos;i="6.12,135,1728943200"; 
   d="scan'208";a="39916599"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Nov 2024 16:54:41 +0100
X-CheckPoint: {672CE2C1-19-5736D786-D50827BE}
X-MAIL-CPID: C8E8D31C487399C5B2FEDBBF237F0518_2
X-Control-Analysis: str=0001.0A682F17.672CE2C1.0089,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C6BCF16145B;
	Thu,  7 Nov 2024 16:54:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730994876;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=68iYgYZPtTrqGDWuMYx5z5BMV4YrJufQaee60Zp3m/s=;
	b=No6iMnStLW+6z6qd0KOV7E/8Og4zat+TPgQM1mTFFG7ZRt2onLR3PI7q48V6fH+i8/55qZ
	oMoyIXArrvKNSJoCqpRjnNJfWROoppfaT3AqxD+iQJdcaeG15xXy5sfBXIb57JwxfHYeJG
	xqbEAAyOnnR26cmBp4zp8iGMFXRNh/S1nAa3R4zEqmIbikhN+v4JF1pOKTB1ehNG9i3SjF
	OWYRS1wKwH1mXr/UvU1V9Ja+idGCa5y/LSzj8cRTbN2Elu6ZEcY92dZL2xIU6/CpJqzk25
	6j2TLjRWumG4crJGCCw0SUoqdo889W+KeDEQWOhucpWXNMtN0KZE1n7fbe+whA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Pengfei Li <pengfei.li_1@nxp.com>, Frank Li <Frank.li@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, joao.goncalves@toradex.com, frieder.schrempf@kontron.de, marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com, mwalle@kernel.org, Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com, tharvey@gateworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Date: Thu, 07 Nov 2024 16:54:34 +0100
Message-ID: <2966679.e9J7NaK4W3@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZyzXcktk/sjAtNCg@lizhi-Precision-Tower-5810>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com> <20241108022703.1877171-3-pengfei.li_1@nxp.com> <ZyzXcktk/sjAtNCg@lizhi-Precision-Tower-5810>
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

Am Donnerstag, 7. November 2024, 16:06:26 CET schrieb Frank Li:
> On Thu, Nov 07, 2024 at 06:27:02PM -0800, Pengfei Li wrote:
> > The i.MX 91 family features an Arm Cortex-A55 running at up to
> > 1.4GHz, support for modern LPDDR4 memory to enable platform longevity,
> > along with a rich set of peripherals targeting medical, industrial
> > and consumer IoT market segments.
> >
> > The design of the i.MX91 platform is very similar to i.MX93.
> > The mainly difference between i.MX91 and i.MX93 is as follows:
> > - i.MX91 removed some clocks and modified the names of some clocks.
> > - i.MX91 only has one A core
>=20
> - pinmux change
>=20
> >
> > Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx91-pinfunc.h | 770 ++++++++++++++++++
> >  arch/arm64/boot/dts/freescale/imx91.dtsi      |  66 ++
> >  2 files changed, 836 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91-pinfunc.h
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx91.dtsi
> >
> [snip]
> > diff --git a/arch/arm64/boot/dts/freescale/imx91.dtsi b/arch/arm64/boot=
/dts/freescale/imx91.dtsi
> > new file mode 100644
> > index 000000000000..a9f4c1fe61cc
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx91.dtsi
> > @@ -0,0 +1,66 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#include "imx91-pinfunc.h"
> > +#include "imx93.dtsi"
> > +
> > +&{/thermal-zones/cpu-thermal/cooling-maps/map0} {
> > +	cooling-device =3D
> > +		<&A55_0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> > +};
> > +
> > +&clk {
> > +	compatible =3D "fsl,imx91-ccm";
> > +};
> > +
> > +&eqos {
> > +	clocks =3D <&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN>,
> > +			<&clk IMX91_CLK_ENET1_QOS_TSN_GATE>;
> > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET1_QOS_TSN>;
> > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > +};
> > +
> > +&fec {
> > +	clocks =3D <&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR_GATE>,
> > +			<&clk IMX91_CLK_ENET_TIMER>,
> > +			<&clk IMX91_CLK_ENET2_REGULAR>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +	assigned-clocks =3D <&clk IMX91_CLK_ENET_TIMER>,
> > +				<&clk IMX91_CLK_ENET2_REGULAR>;
> > +	assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV2>,
> > +					<&clk IMX93_CLK_SYS_PLL_PFD0_DIV2>;
> > +	assigned-clock-rates =3D <100000000>, <250000000>;
> > +};
> > +
> > +&i3c1 {
> > +	clocks =3D <&clk IMX93_CLK_BUS_AON>,
> > +			<&clk IMX93_CLK_I3C1_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&i3c2 {
> > +	clocks =3D <&clk IMX93_CLK_BUS_WAKEUP>,
> > +			<&clk IMX93_CLK_I3C2_GATE>,
> > +			<&clk IMX93_CLK_DUMMY>;
> > +};
> > +
> > +&tmu {
> > +	status =3D "disabled";
> > +};
> > +
> > +/* i.MX91 only has one A core */
> > +/delete-node/ &A55_1;
> > +
> > +/* i.MX91 not has cm33 */
> > +/delete-node/ &cm33;
> > +
> > +/* i.MX91 not has power-domain@44461800 */
> > +/delete-node/ &mlmix;
>=20
> If someone want to use it in overlay file, /delete-node/ will not work.

Do you expect someone including this SoC-dtsi in an overlay?
I personally don't, well I'll welcome other comments.

As imx93 is an upgrade to imx91, there is also the possibility to do it
the other way around, similar to imx7s and imx7d. The latter one including
imx7.dtsi and adding additionally peripherals.

Best regards
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



