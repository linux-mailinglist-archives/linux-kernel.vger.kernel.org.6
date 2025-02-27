Return-Path: <linux-kernel+bounces-535767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52F5A476E5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB75F1886B39
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BD22256C;
	Thu, 27 Feb 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TN97eSS4";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="B+a5xCB9"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C38F213E71;
	Thu, 27 Feb 2025 07:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740642868; cv=none; b=e3J4v9JpxJsfG+uKmMzsqUztrLISIuiHER74SakaYcpFqkAVSFcZZSXpPLmLWVA2JRxdOAwidf0LWmbrg901Jc+9XNBO4Aa/8GfCVYS+5Ll2C31gI7Kf2sbcGvwPEZK0oOM+oji51cnI8TNaDiT526GIcqmS2uV9yEPIPwFay6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740642868; c=relaxed/simple;
	bh=gKP+HPUfZ/iyWjjMxkh/8jwcoJeZQbMC30EFoiZHSIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M041NNk11eAWrG8eWe7EJF0s2BvnEMP7Z7XEK9D6XwpJXZ28u6sMj4Kvm3e5DXtvC7XCCkzb6wjOJWw0xZpOV9w6G6t239bT9n5r+f3ynrB7JRofFVMkQ8MOI6z3dYv2ph20n7Df8r818cOi1Bqi6QNrIfDhAtyFp9eD7+LqzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TN97eSS4; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=B+a5xCB9 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1740642863; x=1772178863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0mh903Tl/7cUd39WI18L3D6eoWPHbIyqsPwJT/VcPf0=;
  b=TN97eSS4kdtemU//Kd3oO71vE9HpDNBlF6rYCsiuvI7P7qa24Jff8s+B
   61o/SAYpsxcLorwkp3bwchzlbGyX0Ddpr0Ivv+Oo9JYJ2PQ+RdO7pK99f
   ns/ZEmJg1Q0FMwwQsJpcUQeFDt3T2KKLa0Qqbo5lC5zWDMoS/1xcTAN1C
   VRCaSHBeecCpw5sXShTWhOYnCZAPpbFpHpXuRKdff63FzeOwxXfnxaYK/
   aFcYeffg2mSE3g/n1iBZXZsfEtyhB8TS2NOVHzjAmfjMxwQfeHYdVQ2HQ
   DK6UUZbt/K8/QsnP8+KI3NJxwSa9dIMJP80L+xvBLbDOmEztAAlQNGvop
   w==;
X-CSE-ConnectionGUID: Ck3HWf67S/OMpiyvzNYQ9g==
X-CSE-MsgGUID: FQVwbvuGRn2wu1C46w4n7g==
X-IronPort-AV: E=Sophos;i="6.13,319,1732575600"; 
   d="scan'208";a="42136081"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 27 Feb 2025 08:54:20 +0100
X-CheckPoint: {67C01A2C-28-28232521-C0C2250B}
X-MAIL-CPID: 3A71BC18731FA9BA389573B3C3E8AF0B_4
X-Control-Analysis: str=0001.0A00211A.67C01A2C.0081,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C8E916420B;
	Thu, 27 Feb 2025 08:54:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1740642856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mh903Tl/7cUd39WI18L3D6eoWPHbIyqsPwJT/VcPf0=;
	b=B+a5xCB9zF6qjZFJLUnSEasgungo1G+9se7sUty2+SI7Drl08QvkrAsfc+qRrQgXAxip1l
	170LlGYTu3pRmHwEGPsAhS/e7fJi0kCKVUR2VgdrYYmAEKWkSfLDkaOz1t0h/h1vWmUv1H
	Rfb911jO6P4qrV23NU/X2+ABbSVfWPB4147EJOLEqWB0BUMAVTFW5lqScON5XZ3XQzm2LL
	OzSjWkHW7cb0BDYqvtSJ8sOEz4WUnqEcBsTOBlpS+ryPCn8w5jSN6Dp07vaoKkktUWqBew
	6Mp62/hrD44rk8mhJccDXJsISyMxWcASQ9ibe6cxC6M8yfzGoJFu1m2ydhNslw==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, hongxing.zhu@nxp.com
Subject:
 Re: [PATCH 4/5] arm64: dts: imx95: add PCIe's msi-map and iommu-map property
Date: Thu, 27 Feb 2025 08:54:13 +0100
Message-ID: <1819305.VLH7GnMWUR@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <Z79B3pH0BwxJseHK@lizhi-Precision-Tower-5810>
References:
 <20250128211559.1582598-1-Frank.Li@nxp.com> <1995746.PYKUYFuaPT@steina-w>
 <Z79B3pH0BwxJseHK@lizhi-Precision-Tower-5810>
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

Am Mittwoch, 26. Februar 2025, 17:31:26 CET schrieb Frank Li:
> On Wed, Feb 26, 2025 at 01:11:37PM +0100, Alexander Stein wrote:
> > Hi Frank,
> >
> > Am Dienstag, 28. Januar 2025, 22:15:58 CET schrieb Frank Li:
> > > Add PCIe's msi-map and iommu-map property because i.MX95 support smmu=
 and
> > > its.
> > >
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> > >  arch/arm64/boot/dts/freescale/imx95.dtsi | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/bo=
ot/dts/freescale/imx95.dtsi
> > > index 6b8470cb3461a..2cebeda43a52d 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
> > > @@ -1573,6 +1573,12 @@ pcie0: pcie@4c300000 {
> > >  			assigned-clock-parents =3D <0>, <0>,
> > >  						 <&scmi_clk IMX95_CLK_SYSPLL1_PFD1_DIV2>;
> > >  			power-domains =3D <&scmi_devpd IMX95_PD_HSIO_TOP>;
> > > +			/* pcie0's Devid(BIT[7:6]) is 0x00, stream id(BIT[5:0]) is 0x10~0=
x17 */
> > > +			msi-map =3D <0x0 &its 0x10 0x1>,
> > > +				  <0x100 &its 0x11 0x7>;
> >
> > Aren't you missing msi-map-mask =3D <0x1ff>; here? Similar to pcie1.
> > Either way, with this change PCIe on pcie0 is not working anymore,
> > regardless of msi-map-mask.
>=20
> Yes, it should have msi-map-mask. During my test, I have not enable enetc
> so I have not found this problem.

Just to be clear: This is not about enetc. This works fine here.

> > Without msi-map-mask:
> > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 0000=
0100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > OF: /soc/pcie@4c300000: no msi-map translation for id 0x300 on (null)
> > > r8169 0000:03:00.0: error -EINVAL: enable failure
> > > r8169 0000:03:00.0: probe with driver r8169 failed with error -22
> >
> > With msi-map-mask:
> > > OF: /soc/pcie@4c300000: iommu-map, using mask 000001ff, id-base: 0000=
0100, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 000001=
00, out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > r8169 0000:03:00.0: error -EIO: PCI read failed
> > > r8169 0000:03:00.0: probe with driver r8169 failed with error -5
>=20
> Can you try remove iommu-map and keep msi-map? then remove msi-map and
> keep iommu-map to check which one cause this problem.

With only msi-map removed, but smmu enabled:
> arm-smmu-v3 490d0000.iommu: event 0x10 received:
> arm-smmu-v3 490d0000.iommu:      0x0000001100000010
> arm-smmu-v3 490d0000.iommu:      0x0000020a00000000
> arm-smmu-v3 490d0000.iommu:      0x000000009b0cc000
> arm-smmu-v3 490d0000.iommu:      0x0000000000000000
> arm-smmu-v3 490d0000.iommu: event: F_TRANSLATION client: 0000:01:00.0 sid=
: 0x11 ssid: 0x0 iova: 0x9b0cc000 ipa: 0x0
> arm-smmu-v3 490d0000.iommu: priv data read s1 "Input address caused fault=
" stag: 0x0 r8169 0000:03:00.0
> enp3s0: Link is Down

With only iommu-map removed, both smmu enabled or disabled:
> OF: /soc/pcie@4c300000: msi-map, using mask 000001ff, id-base: 00000100, =
out-base: 00000011, length: 00000007, id: 00000300 -> 00000011
> r8169 0000:03:00.0: enabling device (0000 -> 0003)
> r8169 0000:03:00.0: enabling Mem-Wr-Inval
> r8169 0000:03:00.0: error -EIO: PCI read failed
> r8169 0000:03:00.0: probe with driver r8169 failed with error -5

Only if smmu is disabled and msi-map is removed the driver probes
successfully:
> r8169 0000:03:00.0: enabling device (0000 -> 0003)
> r8169 0000:03:00.0: enabling Mem-Wr-Inval
> r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, IRQ =
160
> r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx checksumm=
ing: ko]
> r8169 0000:03:00.0 enp3s0: renamed from eth0
> r8169 0000:03:00.0: enabling bus mastering
> r8169 0000:03:00.0 enp3s0: Link is Down

> >
> > Without msi-map/iommu-map:
> > > r8169 0000:03:00.0: enabling device (0000 -> 0003)
> > > r8169 0000:03:00.0: enabling Mem-Wr-Inval
> > > r8169 0000:03:00.0 eth0: RTL8168g/8111g, d8:9d:b9:00:16:10, XID 4c0, =
IRQ 166
> > > r8169 0000:03:00.0 eth0: jumbo features [frames: 9194 bytes, tx check=
summing: ko]
> > > r8169 0000:03:00.0 enp3s0: renamed from eth0
> > > r8169 0000:03:00.0: enabling bus mastering
> > > r8169 0000:03:00.0 enp3s0: Link is Down
> >
> > pcie1 works as expected. But this is only a single PCIe device, rather =
than
> > having a PCIe bridge.
> > Any idea what's wrong here?
>=20
> Can you help dump more information at for PCIe bridge case:
>=20
> imx_pcie_add_lut(), need rid and sid information.
> drivers/pci/controller/dwc/pci-imx6.c

Just to be clear, without msi-map and iommu-map I get:
> imx6q-pcie 4c380000.pcie: rid: 0x0, sid: 0x18
> imx6q-pcie 4c380000.pcie: rid: 0x100, sid: 0x19

This function get called once for each device.
Maybe the whole PCIe bus might help here, so I've put lspci output here as =
well.

$ lspci
0000:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0000:01:00.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
0000:02:01.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
0000:02:02.0 PCI bridge: Pericom Semiconductor Device a303 (rev 03)
0000:03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8=
168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
0000:04:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8=
168/8211/8411 PCI Express Gigabit Ethernet Controller (rev 0c)
0001:00:00.0 PCI bridge: Philips Semiconductors Device 0000
0001:01:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network =
Connection
0002:00:00.0 Ethernet controller: Philips Semiconductors Device e101 (rev 0=
4)
0002:00:01.0 Generic system peripheral [0807]: Philips Semiconductors Devic=
e e001 (rev 03)
0002:00:08.0 Ethernet controller: Philips Semiconductors Device e101 (rev 0=
4)
0002:00:10.0 Ethernet controller: Philips Semiconductors Device e101 (rev 0=
4)
0002:00:18.0 System peripheral: Philips Semiconductors Device ee02 (rev 04)
0003:01:00.0 System peripheral: Philips Semiconductors Device ee00 (rev 04)
0003:01:01.0 Generic system peripheral [0807]: Philips Semiconductors Devic=
e e001 (rev 03)

$ lspci -t
=2D[0000:00]---00.0-[01-ff]----00.0-[02-04]--+-01.0-[03]----00.0
                                           \-02.0-[04]----00.0
=2D[0001:00]---00.0-[01-ff]----00.0
=2D[0002:00]-+-00.0
           +-01.0
           +-08.0
           +-10.0
           \-18.0
=2D[0003:01]-+-00.0
           \-01.0

Thanks and best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



