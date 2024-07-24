Return-Path: <linux-kernel+bounces-260990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911B893B149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4A6D1C21289
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F6215ECEB;
	Wed, 24 Jul 2024 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ftjkru99";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="BPnXI/xB"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF215E5D0;
	Wed, 24 Jul 2024 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825978; cv=none; b=Wu4x13UvLzvhv2EL+xGA+J3BOv3a+FtkvfSAmPGM0ZJH11skdZvp1tUk9OQ8wW6Y0tznP46dq21SE+lkzETRbeeot51C9ACyFNEVHE6P8KoRLlqRnTsGvgeK14/tXtmXw40NQrRpV+VZuXsFC4ChcQiKlNzrpIXkGjUMmYCi+y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825978; c=relaxed/simple;
	bh=cG1vxcg27UYNr6KO1Dw3Rty7LcY4a1pdn1b2VdxrMqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RPqtG0Ape5s4xOAPbb6s5PGpZWYw0QiEYIfWfhW0JuQIw/fA8huy1Y49OjV7GjyTOSdlHRpAJarpVIG8F0t8nhGPfTT0bpsGlYfqO2T+BuvD0+1ktdXrBJWFmwp2v2M49Ihf70waG8c+PJIs1tNPXBIa9s/9NJ8l/eWMnaEXbMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ftjkru99; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=BPnXI/xB reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825977; x=1753361977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VoRAr118RELuLU4PNp2N2Pwvgnpo2+h/bxpuDi77974=;
  b=ftjkru99Lc5VmMy7Pzy1zdr4ziXSDzJfI2QMKpchGlCIz59GK33HzXg7
   +UzmKeOvHW+Hs9gjdHGVFF/6BuZk4TIargcdqBdeGrl1XB5Kq728e9bQS
   YWQQLR7nuP+Q5bzS7ltfb3GP01596s7qGbM5e0nyq85+T9N/YzNiBpQzW
   wQO+oJrhPfilgNN5ST8Mt7iWr2aT0a7mpXTBq+1MmGooYbTqaTS8WCwie
   KCGqu2YrBHZdb/9vbUlrJTK2G8iq95XITvU5R0xXZbn7aTnfJ+vCNypoP
   pKh7YPy1IcjGMW4bGnkNCSLAXT4XgOyYkg0uKsieIbsPQ+2zt0LEvlzXh
   g==;
X-CSE-ConnectionGUID: ZC39gJLQRJiRB450Ypyp3Q==
X-CSE-MsgGUID: cqkZCC8QS8KM18wsbEqiCw==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058836"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:35 +0200
X-CheckPoint: {66A0FAB7-1D-E8EE7C4B-C1098986}
X-MAIL-CPID: 4CAE6E05A5E9BB3A4A3FF4AF72142B5A_5
X-Control-Analysis: str=0001.0A782F26.66A0FAB8.006C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 59B1F1634BB;
	Wed, 24 Jul 2024 14:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825975; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VoRAr118RELuLU4PNp2N2Pwvgnpo2+h/bxpuDi77974=;
	b=BPnXI/xB0ti2L7NtMgVrwVCwhv+MoJsqSBW/m2FtOGRQbO0Lw3oGc5TDMZa5tteyJJmshx
	TLIJB+jc9Ts58ZHeudqPyzitxLgr+uvJcSRxGDHX80LQIwflw/MNZUH6HktL817CdvRkMk
	ZVXlbXFpyUPIu/TqPpNvOWiPb6hiayYActAVELyO9PQ2O8Oe6QkeOyC9vwRrMDoF5widsA
	JtDWzEMC/6IlUI3Y2SUEk0w8aM4TPe71eKwpC+isN1iP7+g36mq/Ev/gdtvTGtoOWZvcb2
	TFSJcfnbRwb0H7SGZPpDwG23KdpzbYDM9kNPOY73oYQEklegfmTTDzomIkSAEg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] arm64: dts: freescale: imx93-tqma9352: set SION for cmd and data pad of USDHC
Date: Wed, 24 Jul 2024 14:59:01 +0200
Message-Id: <20240724125901.1391698-15-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

imx93 pad integrate has one issue, refer to ERR052021:

ERR052021 uSDHC: Sometimes uSDHC does not work under VDD_SOC low
		 drive mode and nominal mode
Description:
uSDHC PADs have one integration issue.
When CMD/DATA lines direction change from output to input, uSDHC
controller begin sampling, the integration issue will make input
enable signal from uSDHC propagated to the PAD with a long delay,
thus the new input value on the pad comes to uSDHC lately. The
uSDHC sampled the old input value and the sampling result is wrong.

Workaround:
Set uSDHC CMD/DATA PADs iomux register SION bit to 1, then PADs will
propagate input to uSDHC with no delay, so correct value is sampled.

This issue will wrongly trigger the start bit when sample the USDHC
command response, cause the USDHC trigger command CRC/index/endbit
error, which will finally impact the tuning pass window, espically
will impact the standard tuning logic, and can't find a correct delay
cell to get the best timing.

This follows changes made for i.MX93 EVK with commit
bb89601282fc ("arm64: dts: imx93-11x11-evk: set SION for cmd and data pad of USDHC")

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 22 ++++++++++---------
 .../freescale/imx93-tqma9352-mba93xxla.dts    | 22 ++++++++++---------
 .../boot/dts/freescale/imx93-tqma9352.dtsi    | 19 ++++++++--------
 3 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 9a21fbf986fe..d7c067450503 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -870,32 +870,34 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X5 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
 			/* HYS | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000138e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X6 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000139e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index b9a22d6c1de2..0409dffe844c 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -820,32 +820,34 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00			0x1000
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_hs: usdhc2hsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X5 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05be
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
 			/* HYS | PU | FSEL_3 | DSE X3 */
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x138e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x138e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x138e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000138e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc2_uhs: usdhc2uhsgrp {
 		fsl,pins = <
 			/* PD | FSEL_3 | DSE X6 */
 			MX93_PAD_SD2_CLK__USDHC2_CLK			0x05fe
 			/* HYS | PU | FSEL_3 | DSE X4 */
-			MX93_PAD_SD2_CMD__USDHC2_CMD			0x139e
-			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x139e
-			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x139e
-			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x139e
-			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x139e
+			MX93_PAD_SD2_CMD__USDHC2_CMD			0x4000139e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0		0x4000139e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1		0x4000139e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2		0x4000139e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3		0x4000139e
 			/* FSEL_2 | DSE X3 */
 			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT		0x010e
 		>;
diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
index 63b02552c55d..ac9f94baf4cd 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352.dtsi
@@ -269,6 +269,7 @@ MX93_PAD_SD2_RESET_B__GPIO3_IO07	0x106
 		>;
 	};
 
+	/* enable SION for data and cmd pad due to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			/* PD | FSEL 3 | DSE X5 */
@@ -276,16 +277,16 @@ MX93_PAD_SD1_CLK__USDHC1_CLK		0x5be
 			/* HYS | FSEL 0 | no drive */
 			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1000
 			/* HYS | FSEL 3 | X5 */
-			MX93_PAD_SD1_CMD__USDHC1_CMD		0x11be
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400011be
 			/* HYS | FSEL 3 | X4 */
-			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x119e
-			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x119e
-			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x119e
-			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x119e
-			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x119e
-			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x119e
-			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x119e
-			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x119e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000119e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000119e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000119e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000119e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000119e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000119e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000119e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000119e
 		>;
 	};
 
-- 
2.34.1


