Return-Path: <linux-kernel+bounces-174185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0358C0B65
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 08:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E4E1F234C3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 06:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2D4149DF2;
	Thu,  9 May 2024 06:15:54 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CC149E01;
	Thu,  9 May 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715235353; cv=none; b=ix7wnG31EQZbfHeXtx3sN+/nxhgLVJh+90KuUAsMfUQ5QqkAeHNzovwmF3jky7zABu3LwcvrVQXFZstZR+6M3xDyhdJJRhNyEkum36w8FE5PduGlRSVjlc0giZo0kB/Vu809h2PfBkjKD48oeeRH7yaZpbNdd4Oe0uo7m43J5Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715235353; c=relaxed/simple;
	bh=ThKVGa3d/Z0vLgTeLU9vkg+jHMgQCwzahfmHqGQoftw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=t4Oiwf5mFw5LLcbZTkdrWBLHqNSUsatjyrggStUrvyb8PbIR706MFBJt5wWQS65OZoUpTdmeXGck+PcsPqlNAc/QQNcQWhxGdbi55kuUbrA3Cf5D2tv1rUbMOhNOk6bjVXLf9L8WLdUXPftjSmz2B28tYO2wnYuL/DAk2f37xNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 52E981A1F47;
	Thu,  9 May 2024 08:15:41 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 090291A1F45;
	Thu,  9 May 2024 08:15:41 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 111D4183486A;
	Thu,  9 May 2024 14:15:39 +0800 (+08)
From: Richard Zhu <hongxing.zhu@nxp.com>
To: conor@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com,
	conor+dt@kernel.org
Cc: hongxing.zhu@nxp.com,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	imx@lists.linux.dev
Subject: [PATCH v4 1/3] dt-bindings: phy: phy-imx8-pcie: Add header file for i.MX8Q HSIO SerDes PHY
Date: Thu,  9 May 2024 13:56:19 +0800
Message-Id: <1715234181-672-2-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
References: <1715234181-672-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add lane index and HSIO configuration definitions of the i.MX8Q HSIO
SerDes PHY into header file.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 include/dt-bindings/phy/phy-imx8-pcie.h | 29 +++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/dt-bindings/phy/phy-imx8-pcie.h b/include/dt-bindings/phy/phy-imx8-pcie.h
index 8bbe2d6538d8..8f65a77fca09 100644
--- a/include/dt-bindings/phy/phy-imx8-pcie.h
+++ b/include/dt-bindings/phy/phy-imx8-pcie.h
@@ -11,4 +11,33 @@
 #define IMX8_PCIE_REFCLK_PAD_INPUT	1
 #define IMX8_PCIE_REFCLK_PAD_OUTPUT	2
 
+/*
+ * Regarding the design of i.MX8QM HSIO subsystem, HSIO module can be
+ * confiured as following three use cases.
+ *
+ * Define different configurations refer to the use cases, since it is
+ * mandatory required in the initialization.
+ *
+ * On i.MX8QXP, HSIO module only has PCIEB and one lane PHY.
+ * Define "IMX8Q_HSIO_CFG_PCIEB" for i.MX8QXP platforms.
+ *
+ * +----------------------------------------------------+----------+
+ * |                               | i.MX8QM            | i.MX8QXP |
+ * |-------------------------------|--------------------|----------|
+ * |                               | Lane0| Lane1| Lane2| Lane0    |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAX2SATA    | PCIEA| PCIEA| SATA |          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAX2PCIEB   | PCIEA| PCIEA| PCIEB|          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEAPCIEBSATA | PCIEA| PCIEB| SATA |          |
+ * |-------------------------------|------|------|------|----------|
+ * | IMX8Q_HSIO_CFG_PCIEB          | -    | -    | -    | PCIEB    |
+ * +----------------------------------------------------+----------+
+ */
+#define IMX8Q_HSIO_CFG_PCIEAX2SATA	0x1
+#define IMX8Q_HSIO_CFG_PCIEAX2PCIEB	0x2
+#define IMX8Q_HSIO_CFG_PCIEAPCIEBSATA	(IMX8Q_HSIO_CFG_PCIEAX2SATA | IMX8Q_HSIO_CFG_PCIEAX2PCIEB)
+#define IMX8Q_HSIO_CFG_PCIEB		IMX8Q_HSIO_CFG_PCIEAX2PCIEB
+
 #endif /* _DT_BINDINGS_IMX8_PCIE_H */
-- 
2.37.1


