Return-Path: <linux-kernel+bounces-399953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AD29C06EF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3970284BE3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EBC212D39;
	Thu,  7 Nov 2024 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T7/4SHIN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pRwh6o2k"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2F20F5B1;
	Thu,  7 Nov 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984801; cv=none; b=jRH3tYvHLRrX5QBgeqwGsXrvg0f+6yjm4xgVUDJghjKdE2rGK8UTTZap+YxU9B4PRQFz7kp6HhKwN7sQUcIMeqQUKCmzzvE1515pAs6tahMAST6gxzze85Af9SeSOVbLzyu0GLP2PR8X3pCRUbauy/eO1cSmhj6Tf+F6I7/0RR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984801; c=relaxed/simple;
	bh=Jx1nSyDIfhBUi9FQg/o/hfd5mS6yoA8D+2mJPDtz2qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCcDT9e3MuNzBegh+ocSBI2wvXK6arF1o8D+UCLMY1D91P1f0N0UKqPDFRpqx13tzvKJN+S1QFlVDKHWz2djp72bTcdJArrFndlYqdNbqRpXBiV0kDTMyC22iEooDhG7+eK5LXfuSTdEBiDYeLD5HaxsHMLMRN4PgZ2LzhoDnzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=T7/4SHIN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pRwh6o2k reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1730984797; x=1762520797;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Br6j9tCD7gey4qn/vnRgBNealpC4+9i3aXfalCeYdjY=;
  b=T7/4SHINqPDUGpKL4DJc29LTCSL5KlcXvKurvUQuNzVzcFFxiuo0aN/v
   MqVHvE/6xWZ1KWKNjebLe+Ncn9oWsNwQxg+/0xuA10hWARj0kWk/LAcAu
   XoPzOG/1ASgs0GsrmboLGE8NDOZDmvLfjIk2AyH5jAxvyVGExaJue0Q6v
   FrFxHvDJYTR5hatMIGM7Pnx2UiaBJLoBDW2nuT72w9gRVQJJ5rhEILsNP
   7IexXnsO3OFmJR9Sv3mB9SqGW4J8s721Jm2cUw2zoAv9HqYPlX5nMdsuO
   cg4bBNRr6FUW9CKBgLd7CLV6K+GyUi2/pIAj3+4XNyhEh9QFn78Ulzr6Q
   Q==;
X-CSE-ConnectionGUID: +ng6v8WES5qSaYqsyOTeLw==
X-CSE-MsgGUID: BSiAM4hKRbeF+0LucP8ebQ==
X-IronPort-AV: E=Sophos;i="6.12,266,1728943200"; 
   d="scan'208";a="39912117"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 07 Nov 2024 14:06:34 +0100
X-CheckPoint: {672CBB5A-B-F5DC7025-F79421CB}
X-MAIL-CPID: A4A1CF9EA10526AAB45BE20D0F4302DB_0
X-Control-Analysis: str=0001.0A682F25.672CBB5A.007A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98D5B16486F;
	Thu,  7 Nov 2024 14:06:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1730984789;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Br6j9tCD7gey4qn/vnRgBNealpC4+9i3aXfalCeYdjY=;
	b=pRwh6o2kI6cs3FUXrpAfae/cn1kML4uB1wFP/V33+GJenfaOoEtobo7UGticUQfXOXt6Wh
	9ZJE7ZJzg+Jc/Z/4B/9eHs+rFsR9PnY6sj2d4A4NBiMF4ce7wK/ceN9fGPWjC/0KOChEVd
	i45m2u/SkVU4ViBeNvRtNC68sIVG9Xfu8ATyVFdCGLZImpqcrQohirSWRgysbrH8ecbA8f
	B+Xzsp5K0/qahF3rA2wqxCg2+DkPpnBLKo/86MyfeHWSvpVdodB1tVw2WZIw4Qe3zPPzy3
	/ZeEHruT+KsdIqmm5AaYo2aFBapIBwCZLNB5lX7X1+RH414Msi5pAhyqYVBgCA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, Pengfei Li <pengfei.li_1@nxp.com>, linux-arm-kernel@lists.infradead.org
Cc: joao.goncalves@toradex.com, frieder.schrempf@kontron.de, marex@denx.de, hvilleneuve@dimonoff.com, peng.fan@nxp.com, m.othacehe@gmail.com, mwalle@kernel.org, Max.Merchel@ew.tq-group.com, hiago.franco@toradex.com, tharvey@gateworks.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, ping.bai@nxp.com, ye.li@nxp.com, aisheng.dong@nxp.com, frank.li@nxp.com, Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: Re: [PATCH 2/3] arm64: dts: freescale: Add i.MX91 dtsi support
Date: Thu, 07 Nov 2024 14:06:27 +0100
Message-ID: <1907807.tdWV9SEqCh@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <2350046.ElGaqSPkdT@steina-w>
References: <20241108022703.1877171-1-pengfei.li_1@nxp.com> <20241108022703.1877171-3-pengfei.li_1@nxp.com> <2350046.ElGaqSPkdT@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Am Donnerstag, 7. November 2024, 13:49:50 CET schrieb Alexander Stein:
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
>=20
> Is it just me or is the alignment of new lines not matching?
>=20
>=20
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
>=20
> Here as well: Is it just me or is the alignment of new lines not matching?
>=20
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
>=20
> Why does the TMU needs to be disabled instead of deleted?
>=20
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
> >=20
>=20
> Shouldn't the following node also be removed?
> * mipi_csi
> * dsi
> * lvds_bridge
> * lcdif_to_dsi
> * lcdif_to_ldb

Add mu1 and mu2 to that list.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



