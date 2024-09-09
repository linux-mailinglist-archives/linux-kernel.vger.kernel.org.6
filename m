Return-Path: <linux-kernel+bounces-321661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA2A971DC1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC569283859
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96E325624;
	Mon,  9 Sep 2024 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zMdo5nk0"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F301CD0C;
	Mon,  9 Sep 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894911; cv=none; b=Gc0jY2B1Mr9lEW8Zw8Dduq1GcQv+9e+VBUrx5JRj9sVKWHPPGmlza8dEgRKED0itM4UQOLI3uVU00htEJWfgQ14uas2SYVbvLanWrgF2UD//9Jp/xITwALNwxpT+a8/mirstUmS/kbHJPTkRroXhPcxaSyQw8/PlkgbaFMIo4zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894911; c=relaxed/simple;
	bh=nDwWk14nrCIxkwniEAsLZrlHAIvuqthQka87j69o/CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DLpdsP06QF1baQgA8hmvvML0Zjzzn/f40GzsUFa8ZPUbec07zrZwLWgBKKzVd3qgJCXijvi+6jM2kEh4KHXB2xqH1mPjxb7iwtU7zunfNXUZ1Har8lfHTCA5bR3XpNsUtBNwpAU+w+hR64H8TBhy6ebIgU4tOFBWdytziCtTKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zMdo5nk0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725894908; x=1757430908;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nDwWk14nrCIxkwniEAsLZrlHAIvuqthQka87j69o/CM=;
  b=zMdo5nk0YMIR/9AmIXyTyzwP6Hybb9lSBD8H5xTHgdGA9XTaz/TeVutX
   MZjMWPIYbNTDRWbOb1X501vYWSwf3RrhHe6C9HtTX+s7yqvqDwpjYbfEa
   LsLRfXcmBtt2ARVa3VXj3DwjJZ2ienrUdSdnL4nohPTC6f5Tw7nBYbkVL
   3BshuGv7N9xxzAYInuLfpPO0j1g4VMdWhIZ9M9ZY/G3nu4b2owRxLmQsM
   WrZvaZ3i7KF/OWE4QT8IVzYdBT4ysk0MxInD0E2z6R8OoCEaQaYu9Fzb5
   esZVmf816C8SDSGGTDtGg4U9s4PSY9luEfsWrD9Qp+fA/rxQSJmOHTQW1
   Q==;
X-CSE-ConnectionGUID: OODVxLZSSk2nq4Lyt+sbMw==
X-CSE-MsgGUID: unyaGTgMRuCFj2dD6oLDJg==
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; 
   d="scan'208";a="31428908"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Sep 2024 08:15:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Sep 2024 08:15:03 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 9 Sep 2024 08:15:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 9 Sep 2024 17:14:44 +0200
Subject: [PATCH v2 4/9] phy: sparx5-serdes: add ops to match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240909-sparx5-lan969x-serdes-driver-v2-4-d695bcb57b84@microchip.com>
References: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
In-Reply-To: <20240909-sparx5-lan969x-serdes-driver-v2-0-d695bcb57b84@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

We need to handle code differently in a few places. Add a struct:
sparx5_serdes_ops for this purpose, and populate it a with function to
set the SERDES type.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 29 +++++++++++++++++++----------
 drivers/phy/microchip/sparx5_serdes.h | 27 ++++++++++++++++-----------
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 9c91545dd8e1..b1376a142b14 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -2373,6 +2373,20 @@ static const struct phy_ops sparx5_serdes_ops = {
 	.owner		= THIS_MODULE,
 };
 
+static void sparx5_serdes_type_set(struct sparx5_serdes_macro *macro, int sidx)
+{
+	if (sidx < SPX5_SERDES_10G_START) {
+		macro->serdestype = SPX5_SDT_6G;
+		macro->stpidx = macro->sidx;
+	} else if (sidx < SPX5_SERDES_25G_START) {
+		macro->serdestype = SPX5_SDT_10G;
+		macro->stpidx = macro->sidx - SPX5_SERDES_10G_START;
+	} else {
+		macro->serdestype = SPX5_SDT_25G;
+		macro->stpidx = macro->sidx - SPX5_SERDES_25G_START;
+	}
+}
+
 static int sparx5_phy_create(struct sparx5_serdes_private *priv,
 			   int idx, struct phy **phy)
 {
@@ -2389,16 +2403,8 @@ static int sparx5_phy_create(struct sparx5_serdes_private *priv,
 	macro->sidx = idx;
 	macro->priv = priv;
 	macro->speed = SPEED_UNKNOWN;
-	if (idx < SPX5_SERDES_10G_START) {
-		macro->serdestype = SPX5_SDT_6G;
-		macro->stpidx = macro->sidx;
-	} else if (idx < SPX5_SERDES_25G_START) {
-		macro->serdestype = SPX5_SDT_10G;
-		macro->stpidx = macro->sidx - SPX5_SERDES_10G_START;
-	} else {
-		macro->serdestype = SPX5_SDT_25G;
-		macro->stpidx = macro->sidx - SPX5_SERDES_25G_START;
-	}
+
+	priv->data->ops.serdes_type_set(macro, idx);
 
 	phy_set_drvdata(*phy, macro);
 
@@ -2512,6 +2518,9 @@ static const struct sparx5_serdes_match_data sparx5_desc = {
 		.sd_max       = 33,
 		.cmu_max      = 14,
 	},
+	.ops = {
+		.serdes_type_set      = &sparx5_serdes_type_set,
+	},
 };
 
 /* Client lookup function, uses serdes index */
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 87c44bbaf368..785c7fe0bbeb 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -26,13 +26,29 @@ enum sparx5_serdes_mode {
 	SPX5_SD_MODE_SFI,
 };
 
+struct sparx5_serdes_macro {
+	struct sparx5_serdes_private *priv;
+	u32 sidx;
+	u32 stpidx;
+	enum sparx5_serdes_type serdestype;
+	enum sparx5_serdes_mode serdesmode;
+	phy_interface_t portmode;
+	int speed;
+	enum phy_media media;
+};
+
 struct sparx5_serdes_consts {
 	int sd_max;
 	int cmu_max;
 };
 
+struct sparx5_serdes_ops {
+	void (*serdes_type_set)(struct sparx5_serdes_macro *macro, int sidx);
+};
+
 struct sparx5_serdes_match_data {
 	const struct sparx5_serdes_consts consts;
+	const struct sparx5_serdes_ops ops;
 	const struct sparx5_serdes_io_resource *iomap;
 	int iomap_size;
 };
@@ -45,17 +61,6 @@ struct sparx5_serdes_private {
 	const struct sparx5_serdes_match_data *data;
 };
 
-struct sparx5_serdes_macro {
-	struct sparx5_serdes_private *priv;
-	u32 sidx;
-	u32 stpidx;
-	enum sparx5_serdes_type serdestype;
-	enum sparx5_serdes_mode serdesmode;
-	phy_interface_t portmode;
-	int speed;
-	enum phy_media media;
-};
-
 /* Read, Write and modify registers content.
  * The register definition macros start at the id
  */

-- 
2.34.1


