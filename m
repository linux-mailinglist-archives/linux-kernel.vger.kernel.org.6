Return-Path: <linux-kernel+bounces-533791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22730A45E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75DBE189AA5F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFAE221F26;
	Wed, 26 Feb 2025 12:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="l1HqcCde";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="gIabMkuR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F78221DBC;
	Wed, 26 Feb 2025 12:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740571915; cv=none; b=T24X2rH8NRmFWiwB4oly/vCvOS4fU10Oz3TBG8+Miyeq0yE5EbmRK4UFl6Egu+B9pYOYV87RhVSiB8Tz24g8aYA+gsB2VeSqTBMnWzO7OiXMpOXXmkQx8A4Gxzou7xDEvr6TP5DvXXWazMk9Kd0ynaatlzOoFHeP2lHis2VRBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740571915; c=relaxed/simple;
	bh=4YKkxTEO6/vhJgPKqZabGq41lX474BCo+ADgo5Kr4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hNMU7y+udm42TODrjLH3u8gB8C0tqMXnXODkvY+bBPRd8zRauVSqxfKHKFjLHMc4UbIAkdf8HFY01Drh+LANPSo8ieRylXlS+34oDX7MIr5Rwnlh0E51SXjxqLMk67unE8WBzFxyzA/QGXl50fG6fE/V0a1lx4xzuhL/8LQHrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=l1HqcCde; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=gIabMkuR reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740571913; x=1772107913;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/pmbTD4zoQM5iCGF3tYVmluO/FUN08Skf4yJBgTYALo=;
  b=l1HqcCdeTx3Fa+38zlzTOv0Ycb/0mkf2WngqVYkO8pRSmYPTUJOafwAD
   Z39i4tJ2+CWP1DyvQ2dVP43kTEAXL8LNFvJFp2hNHm8Qzc/HxT588d2IZ
   8gt4NntvQivJEjNj8LGu1SLfefIS5aVe+DUNEowZMLO5aWWcdToJY+XME
   N9vjQWae/imw7ftzdk7X2yIelMlM0nvqgCoJLs2kd1BWBdMhcA9klLp+k
   6sZurQZNi+fcJrksCFXqfVupPzz6PVHoVxHCTb45xEJUu8cWmr1IIYqQP
   JPbSMOUzON1cj5uSxBkhNNHK0hFnr7I8ejghO0RtNtuSed0p6mTVprTGN
   g==;
X-CSE-ConnectionGUID: gBzX4PJ4QQSiaqg7GG/68g==
X-CSE-MsgGUID: Feg+Lb6pTEmmC38kdfvsRQ==
X-IronPort-AV: E=Sophos;i="6.13,317,1732575600"; 
   d="scan'208";a="42109020"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Feb 2025 13:11:44 +0100
X-CheckPoint: {67BF0500-13-F75C4246-F0BD6D90}
X-MAIL-CPID: 9D92D866341F7BCADD9B9A0C5F9DB091_3
X-Control-Analysis: str=0001.0A00211C.67BF04FF.009E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5DAC5160D68;
	Wed, 26 Feb 2025 13:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740571900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pmbTD4zoQM5iCGF3tYVmluO/FUN08Skf4yJBgTYALo=;
	b=gIabMkuRWpL/0WTn84gsuE09kT3XzdhirDQnqP6YySN5f+D1ARPWj2u/wVPtieFB1gdcZe
	q6/n7YBAaklGUKdnF5PMXh3pT4uerD+aERsadH3OVZvxhWdcuHrjkgYsJTDB9sfZkqJ/Uf
	fWkaVTYM4eMGWTH+ncwDCfcEFhUk8gg2O39IMcAHp3WEh5INpWTYEd8pdUkuOy1RUxHueg
	r+MAsUr0PNRuGIg/oqM/LII4ayDw1fTaj/86RoyKEznrfiEvPKOPnKNThe3Rq054bq87Pv
	tytXSrKfgKQrSoT11unZwCYAo4eKenw/LvzVaZ9FU6xdGhLtsaxp4ROkKOJZmA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, hongxing.zhu@nxp.com, Frank Li <Frank.Li@nxp.com>
Subject:
 Re: [PATCH 4/5] arm64: dts: imx95: add PCIe's msi-map and iommu-map property
Date: Wed, 26 Feb 2025 13:11:37 +0100
Message-ID: <1995746.PYKUYFuaPT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250128211559.1582598-4-Frank.Li@nxp.com>
References:
 <20250128211559.1582598-1-Frank.Li@nxp.com>
 <20250128211559.1582598-4-Frank.Li@nxp.com>
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

Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> Add PCIe's msi-map and iommu-map property because i.MX95 support smmu and
> its.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/d=
ts/freescale/imx95.dtsi
> index 6b8470cb3461a..2cebeda43a52d 100644
> --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
>  			assigned-clock-parents =3D <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
>  			power-domains =3D <&scmi_devpd IMX95_PD_HSIO_TOP>;
> +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) is 0x10~0x17 =
*/
> +			msi-map =3D <0x0 &its 0x10 0x1>,
> +				  <0x100 &its 0x11 0x7>;

Aren't you missing msi-map-mask =3D <0x1ff>; here? Similar to pcie1.
Either way, with this change PCIe on pcie0 is not working anymore,
regardless of msi-map-mask.

Without msi-map-mask:
> OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100=
, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 on (null)
> r8169 0000:03:00.0: error -EINVAL: enable failure
> r8169 0000:03:00.0: probe with driver r8169 failed with error -22

With msi-map-mask:
> OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 00000100=
, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, =
out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> r8169 0000:03:00.0: enabling device (0000 -> 0003)
> r8169 0000:03:00.0: enabling Mem-Wr-Inval
> r8169 0000:03:00.0: error -EIO: PCI read failed
> r8169 0000:03:00.0: probe with driver r8169 failed with error -5

Without msi-map/iommu-map:
> r8169 0000:03:00.0: enabling device (0000 -> 0003)
> r8169 0000:03:00.0: enabling Mem-Wr-Inval
> r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ =
166
> r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumm=
ing: ko]
> r8169 0000:03:00.0 enp3s0: renamed from eth0
> r8169 0000:03:00.0: enabling bus mastering
> r8169 0000:03:00.0 enp3s0: Link is Down

pcie1 works as expected. But this is only a single PCIe device, rather than
having a PCIe bridge.
Any idea what's wrong here?

Best regards,
Alexander

> +			iommu-map =3D <0x000 &smmu 0x10 0x1>,
> +				    <0x100 &smmu 0x11 0x7>;
> +			iommu-map-mask =3D <0x1ff>;
>  			fsl,max-link-speed =3D <3>;
>  			status =3D "disabled";
>  		};
> @@ -1640,6 +1646,14 @@ pcie1: pcie@4c380000 {
>  			assigned-clock-parents =3D <0>, <0>,
>  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
>  			power-domains =3D <&scmi_devpd IMX95_PD_HSIO_TOP>;
> +			/* pcie1's Devid(BIT[7:6]) is 0x10, stream id(BIT[5:0]) is 0x18~0x1f =
*/
> +			msi-map =3D <0x0 &its 0x98 0x1>,
> +				  <0x100 &its 0x99 0x7>;
> +			msi-map-mask =3D <0x1ff>;
> +			/* smmu have not Devid(BIT[7:6]) */
> +			iommu-map =3D <0x000 &smmu 0x18 0x1>,
> +				    <0x100 &smmu 0x19 0x7>;
> +			iommu-map-mask =3D <0x1ff>;
>  			fsl,max-link-speed =3D <3>;
>  			status =3D "disabled";
>  		};
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



