Return-Path: <linux-kernel+bounces-292031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4943D956A59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 14:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE269285BF5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211A816CD3F;
	Mon, 19 Aug 2024 12:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Fj5aeiA3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XZLe8KJJ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F3B16CD24;
	Mon, 19 Aug 2024 12:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724069069; cv=none; b=Hr4L+OYyERDXFbo3nOjuq7iqNYXjcba7TEWiGwtwGREpaE5pM4nu+Kw7B1LW5Wiy0NeYCQh7ilcyiR+YjsGqpDQVjMv1ztkLAVh/jQ3QCbjD/FbMRKPfrnfcasmAStMAb3Woyh6QbwH9hKpd6LnXoAEyqmJmRQVgIYBbQ6trJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724069069; c=relaxed/simple;
	bh=kbfUoJN93ouKh0tsEpsvUXC8OPB0r6o/A0g4sf9dwH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VcmLY8ExV7K/NE7vMzpuo7vt8ChRPX0ZMJzV3pVxTR0W8G/JWF8w6H37Hfbtb85/A2hNGJC/8I+S8SRnVzAEiIg+ZplMXraopkuPxK7wx9BST1QI9wPwRsL9SWlnexpVSTJOqUZtJ87cpHV1QROjlMnynTgJgtFPiv9rrPISAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Fj5aeiA3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XZLe8KJJ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724069067; x=1755605067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSUXeT/7pJ/Mt2BOmAmoES1hscG9qVheVB/BNRpeBkE=;
  b=Fj5aeiA3KadZzTKxY82hCHGQnPo2WrBX1Iwe00fhuoyofn94A9bxDy2k
   QytQYL0clztZrMj9t/YGGjlZPV+3tYrQuDhAG52GTJl4QjbWEdDm5NzXx
   pwMBTOuejgEml71rhHJaya68uOQMN2yUbe5g/X9vOArRM0CydOAt7fJex
   G5ZA1ND5K3vnSfMF9MmrrsLa0Faq+gUbh6ler5aBT5c6rSoxudq53lQpL
   NuHrLGakQkgdQh8d3c+tSe3+kZ6YG1MYr0EAkwgTalvc0nFj62MPo5hfJ
   GOeiAkWI2aSdlOi6eyAaLHn559DHH6DvfxiKAFbWxHMlHylKKTcsFCDKr
   Q==;
X-CSE-ConnectionGUID: baAP0VNPSdWdiAfdXyQxYg==
X-CSE-MsgGUID: O3Tu2azIR5aL/ezmq25VHQ==
X-IronPort-AV: E=Sophos;i="6.10,159,1719871200"; 
   d="scan'208";a="38467141"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2024 14:04:26 +0200
X-CheckPoint: {66C334CA-32-FF00FE11-F2A862FD}
X-MAIL-CPID: 83B8667D26F41B82D9FD5CC7456ACBD6_5
X-Control-Analysis: str=0001.0A782F24.66C334CB.0007,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 79CCD1688FA;
	Mon, 19 Aug 2024 14:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724069062; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pSUXeT/7pJ/Mt2BOmAmoES1hscG9qVheVB/BNRpeBkE=;
	b=XZLe8KJJ0aAw8mu1dAlZJK2Npz0T0lkU8JWZjrSyQPDR424wzcsz6zBlw7N23geF6fvJOP
	nX3iwD1mxKXQyvXJ727JbNlWMmpjti30Q0d5jpAIrjb4zR1aRVJGIUxwCYurmwiJOF4GuC
	AuZoaHlo1eJG+Q0L8JgYbXXaYsxKZIvzgu8VdXv3ZNTdBuipOeHscMjQ60b/dHFgsZfS9a
	8BrldWiQC49wGGmdOESOA5VmhkYJ4ksG5ILB2hZE2mqt4BjLsTAUJAozTYnVIwpnhuxoY2
	rX2OC1bUs1Ri7BG5qfyIm/oqW6rRCc6qrtlrG2FuI37w2PdU8isvkKOHJAxpbg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 09/14] arm64: dts: freescale: imx93-tqma9352-mba93xxca: add RTC / temp sensor IRQ
Date: Mon, 19 Aug 2024 14:03:23 +0200
Message-Id: <20240819120328.229622-10-alexander.stein@ew.tq-group.com>
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

The IRQ lines from devices on SoM are connected to CPU GPIO on
this mainboard.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../freescale/imx93-tqma9352-mba93xxca.dts    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
index 9673b93ba4702..74e1347e25ea8 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxca.dts
@@ -495,6 +495,22 @@ &lpuart8 {
 	status = "okay";
 };
 
+&pcf85063 {
+	/* RTC_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pcf85063>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+};
+
+&se97_som {
+	/* TEMP_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_temp_sensor_som>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &tpm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tpm5>;
@@ -653,6 +669,12 @@ MX93_PAD_GPIO_IO03__LPSPI6_SCK		0x3fe
 		>;
 	};
 
+	pinctrl_pcf85063: pcf85063grp {
+		fsl,pins = <
+			MX93_PAD_SAI1_RXD0__GPIO1_IO14			0x1000
+		>;
+	};
+
 	pinctrl_pexp_irq: pexpirqgrp {
 		fsl,pins = <
 			MX93_PAD_SAI1_TXC__GPIO1_IO12		0x1306
@@ -665,6 +687,13 @@ MX93_PAD_GPIO_IO09__GPIO2_IO09		0x1306
 		>;
 	};
 
+	pinctrl_temp_sensor_som: tempsensorsomgrp {
+		fsl,pins = <
+			/* HYS | FSEL_0 | no DSE */
+			MX93_PAD_SAI1_TXFS__GPIO1_IO11			0x1000
+		>;
+	};
+
 	pinctrl_tpm5: tpm5grp {
 		fsl,pins = <
 			MX93_PAD_GPIO_IO06__TPM5_CH0		0x57e
-- 
2.34.1


