Return-Path: <linux-kernel+bounces-292034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797D6956A60
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5F0285169
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A73616D304;
	Mon, 19 Aug 2024 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="XyoGk7qx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="MnLvnKwA"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6526F16D4E1;
	Mon, 19 Aug 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069080; cv=none; b=Z55z2MGWYypQs3OM5Sy6KnDrEOaFlTbdHaHnhlWfR1vCoRyzhaiwDFEpc7aZrfKtwUrst8nvP+HYMcreAkM0tFYDvZF2h9G2cJstOe0lJ6GHUOOBn/0MtqYqu7Tbu83FhaZJ63wm/Wr6/6YcqoW8UvT4vhfPthUPVGI16KgPA/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069080; c=relaxed/simple;
	bh=UFj7o0I1uAR3nL9hdP2lbFZ4yh7qQBKhrCwgR0BhTho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JtdpY4UIAvPiH99z2Gl/b+x6jnJywD3KVJ9wXLOrKHWoZEAv3KKhAMHuBWDPr13KnY8tgls/ihrtJLVvL5ySqSBaCmEMn39PpGwAl0ygkYEJQBhl8sK7F4G65uC/ZoAE4kx0L9YHBzSypu1HvnYGYLh+L0ROjT8CWIdYY4WUWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=XyoGk7qx; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=MnLvnKwA reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069078; x=1755605078;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kx8pIHV6g3mIbA5X/rXCeKoJhLKVkPosxnF36c+xp+w=;
  b=XyoGk7qxli4mvZ775DLgmEknvSoH8V5NBfuNTSg08b3CSmJaEgDFOwY4
   WAuBXLC6dxAnlUFE8cEURusmneTU9N6rbSA+vNgM3tAiUEfjuPfSJEsZq
   BUYM37fS9WCR2HsAWGhjy0brKR8+v3CQ6aKgoiB9lwhVOePSrMPVhkL0F
   6ingVXHZQ54RlwB3B51Hg+pm9zXZ/ax2XM3GWDWm6OybEWfLS5JGtFGY7
   LAVbScoIBJ0jqEYDLKlyC9CiGdD0dgI+DT+LZXUc7qzLKJOwpnwbA8jl6
   48l4a5dw3ySjc/7u05ZH7lshjA7RkTD8QGkZA/Wr5ZZkHRjyoZGI7Vd0n
   A==;
X-CSE-ConnectionGUID: 1UZUV1PnQMqYoyIuxZua1Q==
X-CSE-MsgGUID: KqcCXsmcR8WUIY3SYEg16w==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467146"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:37 +0200
X-CheckPoint: {66C334D5-2B-FF00FE11-F2A862FD}
X-MAIL-CPID: D07DC3652FDC96BA2A46A75103BD2EA3_5
X-Control-Analysis: str=0001.0A782F19.66C334D6.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DCC4C164E99;
	Mon, 19 Aug 2024 14:04:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069073; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=kx8pIHV6g3mIbA5X/rXCeKoJhLKVkPosxnF36c+xp+w=;
	b=MnLvnKwAmZduPPx20YFdHLXm0zy4RES4wkaeCFoVuVPwWfFVz1bYQkJOpwAEMFZ0rpldpU
	XVpNoTsDkbNbznTBHKcFVt6AA1EfSHJYRUFSosPvUTLwiJQvOmjxBhjPr0qARY0UBQMq1m
	ZSjfG+IFwzqaHvWShUiYa2Kn+N46YBPi39PM0L0HP5sbiey0E3QI5t4jTYHXdoCQnkwrng
	nKpmKEwdbrEyGFNaB6PKkTt0Xj5GDno26O5hp6XlExXupAp69yrSUKkKcZQFiCu7jKYUd8
	K+bcsfO5GQDkMYjFGJJYDKX5ukPGXInx12drLFzhraq8mW0K4L+isXpeGfPGig==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v2 11/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: add missing pad configurations
Date: Mon, 19 Aug 2024 14:03:25 +0200
Message-Id: <20240819120328.229622-12-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
References: <20240819120328.229622-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

- add missing (and currently unused) pad groups
- assign muxed GPIO pads for X1 to gpio2 node

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index c673428a87999..60b288f89a530 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -289,6 +289,11 @@ tcpc-irq-hog {
 	};
 };
 
+&gpio2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpio2>;
+};
+
 &lpi2c3 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -654,6 +659,28 @@ MX93_PAD_GPIO_IO25__CAN2_TX			0x039e
 		>;
 	};
 
+	pinctrl_gpio2: gpio2grp {
+		fsl,pins = <
+			/* HYS | PD | FSEL_2 | DSE X4 */
+			MX93_PAD_GPIO_IO16__GPIO2_IO16			0x151e
+			MX93_PAD_GPIO_IO17__GPIO2_IO17			0x151e
+			MX93_PAD_GPIO_IO18__GPIO2_IO18			0x151e
+			MX93_PAD_GPIO_IO19__GPIO2_IO19			0x151e
+			MX93_PAD_GPIO_IO20__GPIO2_IO20			0x151e
+			MX93_PAD_GPIO_IO21__GPIO2_IO21			0x151e
+			MX93_PAD_GPIO_IO26__GPIO2_IO26			0x151e
+		>;
+	};
+
+	pinctrl_jtag: jtaggrp {
+		fsl,pins = <
+			MX93_PAD_DAP_TCLK_SWCLK__JTAG_MUX_TCK		0x051e
+			MX93_PAD_DAP_TDI__JTAG_MUX_TDI			0x1200
+			MX93_PAD_DAP_TDO_TRACESWO__JTAG_MUX_TDO		0x031e
+			MX93_PAD_DAP_TMS_SWDIO__JTAG_MUX_TMS		0x1200
+		>;
+	};
+
 	pinctrl_lpi2c3: lpi2c3grp {
 		fsl,pins = <
 			/* SION | HYS | OD | FSEL_3 | DSE X4 */
@@ -688,6 +715,14 @@ MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x1000
 		>;
 	};
 
+	pinctrl_mipi_csi: mipicsigrp {
+		fsl,pins = <
+			MX93_PAD_CCM_CLKO3__CCMSRCGPCMIX_CLKO3		0x051e /* MCLK */
+			MX93_PAD_GPIO_IO10__GPIO2_IO10			0x051e /* TRIGGER */
+			MX93_PAD_GPIO_IO11__GPIO2_IO11			0x1400 /* SYNC */
+		>;
+	};
+
 	pinctrl_pexp_irq: pexpirqgrp {
 		fsl,pins = <
 			/* HYS | FSEL_0 | No DSE */
@@ -709,6 +744,13 @@ MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x1000
 		>;
 	};
 
+	pinctrl_tc9595: tc9595-grp {
+		fsl,pins = <
+			/* HYS | PD | FSEL_0 | no DSE */
+			MX93_PAD_CCM_CLKO4__GPIO4_IO29			0x1400
+		>;
+	};
+
 	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO06__TPM5_CH0			0x57e
-- 
2.34.1


