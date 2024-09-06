Return-Path: <linux-kernel+bounces-318897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7739D96F4BB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A39911C23A68
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3BD1CE712;
	Fri,  6 Sep 2024 12:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ifomYIFP"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F301CE6E8;
	Fri,  6 Sep 2024 12:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627248; cv=none; b=U+eLcDrIw+f2vKGTTx7IoyapL9k6ojQlKZ/k7fH5x64jHpATJF0BvIkfGXsv+V8Sa609R7rBCgzPFq01699+4Ew04tUwrtgTje/dnNmUE2WC+7EvHjCwXWTKL8ymPk6yqFUUxK6KItzBPN4guv2y88yKevxxXivMy84LN54iMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627248; c=relaxed/simple;
	bh=AlVAS36lPr5nte9AlFxlAgXuPIW2QqGeW0nzZYxYbUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=A6BXv/07jGQdHAuO6eGm4yx2n0ZkG+IzUlKpfEqNLSw66UVSCQAflc+B/PwNdk2gtpvBfs6BPOrkZHa3Us0MVHWoQOsMsZ6/TWL+fRv36/QqqAIiWw26gb8lcMoOQq9Xk4yL7NNWtlUStEnfi16cFH0cC+sMychawOtLVy8yakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ifomYIFP; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627245; x=1757163245;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AlVAS36lPr5nte9AlFxlAgXuPIW2QqGeW0nzZYxYbUo=;
  b=ifomYIFPfwhqUr14bRRlQOvuoxh4KWi4kTFrg0a1Y/HE2JMWNUCHZ40F
   5ikSaZdLwwaVwiz1c8ka45kIGaQt3lSzvhSkOsNBi9Wzk2NajAGSGbmkS
   2M+tArhzHRreqCMKkHlBQTIHQvwSKFkhTJ3SB1dojtECaK3mXOvHZeFJ2
   UcYsmYK7jmcjIuGoybB5DYcdnoYmyXOkcXdVB5Mqsv2lsguWDkQGanPR2
   TsTzIcjOLnnzcqUl3b6kXsoBZ4gs89rcKLceBt4XuccI/cEhQKcrUKoJq
   NEns/TU4rlMddiu4lItzFIk7RxtHiIaqFpd+B93mWxnUXBb+tOd/8ectt
   A==;
X-CSE-ConnectionGUID: sLMTJciFQoOe3QYYo7sv+w==
X-CSE-MsgGUID: OalJaReFTrSgwf+gWS1XUA==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="31334927"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:54:04 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:24 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:22 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:42 +0200
Subject: [PATCH 5/9] phy: sparx5-serdes: add function for getting the CMU
 index
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-5-8d630614c58a@microchip.com>
References: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
In-Reply-To: <20240906-sparx5-lan969x-serdes-driver-v1-0-8d630614c58a@microchip.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: <linux-phy@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
X-Mailer: b4 0.14-dev

The SERDES to CMU mapping is different on Sparx5 and lan969x. Therefore
create a function for getting the CMU index on Sparx5.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 11 ++---------
 drivers/phy/microchip/sparx5_serdes.h |  9 +++++++++
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index b1376a142b14..5b918a2716dd 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -28,14 +28,6 @@
 /* Optimal power settings from GUC */
 #define SPX5_SERDES_QUIET_MODE_VAL 0x01ef4e0c
 
-enum sparx5_10g28cmu_mode {
-	SPX5_SD10G28_CMU_MAIN = 0,
-	SPX5_SD10G28_CMU_AUX1 = 1,
-	SPX5_SD10G28_CMU_AUX2 = 3,
-	SPX5_SD10G28_CMU_NONE = 4,
-	SPX5_SD10G28_CMU_MAX,
-};
-
 enum sparx5_sd25g28_mode_preset_type {
 	SPX5_SD25G28_MODE_PRESET_25000,
 	SPX5_SD25G28_MODE_PRESET_10000,
@@ -1648,7 +1640,7 @@ static int sparx5_sd10g28_apply_params(struct sparx5_serdes_macro *macro,
 	if (params->skip_cmu_cfg)
 		return 0;
 
-	cmu_idx = sparx5_serdes_cmu_get(params->cmu_sel, lane_index);
+	cmu_idx = priv->data->ops.serdes_cmu_get(params->cmu_sel, macro->sidx);
 	err = sparx5_cmu_cfg(priv, cmu_idx);
 	if (err)
 		return err;
@@ -2520,6 +2512,7 @@ static const struct sparx5_serdes_match_data sparx5_desc = {
 	},
 	.ops = {
 		.serdes_type_set      = &sparx5_serdes_type_set,
+		.serdes_cmu_get       = &sparx5_serdes_cmu_get,
 	},
 };
 
diff --git a/drivers/phy/microchip/sparx5_serdes.h b/drivers/phy/microchip/sparx5_serdes.h
index 785c7fe0bbeb..a7e92c1330e9 100644
--- a/drivers/phy/microchip/sparx5_serdes.h
+++ b/drivers/phy/microchip/sparx5_serdes.h
@@ -26,6 +26,14 @@ enum sparx5_serdes_mode {
 	SPX5_SD_MODE_SFI,
 };
 
+enum sparx5_10g28cmu_mode {
+	SPX5_SD10G28_CMU_MAIN = 0,
+	SPX5_SD10G28_CMU_AUX1 = 1,
+	SPX5_SD10G28_CMU_AUX2 = 3,
+	SPX5_SD10G28_CMU_NONE = 4,
+	SPX5_SD10G28_CMU_MAX,
+};
+
 struct sparx5_serdes_macro {
 	struct sparx5_serdes_private *priv;
 	u32 sidx;
@@ -44,6 +52,7 @@ struct sparx5_serdes_consts {
 
 struct sparx5_serdes_ops {
 	void (*serdes_type_set)(struct sparx5_serdes_macro *macro, int sidx);
+	int (*serdes_cmu_get)(enum sparx5_10g28cmu_mode mode, int sd_index);
 };
 
 struct sparx5_serdes_match_data {

-- 
2.34.1


