Return-Path: <linux-kernel+bounces-318894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 790AC96F4B6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97A041C23BEE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78701CEADE;
	Fri,  6 Sep 2024 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="cwPG5/RI"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC91CDA1B;
	Fri,  6 Sep 2024 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725627209; cv=none; b=ChsuJgAiu1kxfv0grNhDu/ickhxEz+MBtsjKwo3lBRIGYorvpq5dxLKUSjv9ExcvJFKzc1rcplREPCXzBl9pE5KbMeyoAimNuFBfkbiNwGOlUD7074tcV4amcbR0fDt2vIbEO9LV2D9b/hPIt7rDh0kj3VnIQ1GYIk4PJ/p3K9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725627209; c=relaxed/simple;
	bh=nDwWk14nrCIxkwniEAsLZrlHAIvuqthQka87j69o/CM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Il6k+EUhWVj3qnRoLLOCA7XwuGntjP6GWa7HAk9PgaQSbxXZhmDy2o46XgUW0IKnO3suEHik3lkM/oG+theYN736U6Rp7+TqL6UxyQG82fJ+RKHRNdSWofoE/Hk9RqiXgDTd7CWOEW38tdAg7DydhSo7B0YbegEjHzDazZV73n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=cwPG5/RI; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725627207; x=1757163207;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=nDwWk14nrCIxkwniEAsLZrlHAIvuqthQka87j69o/CM=;
  b=cwPG5/RI8bxyfB57WotR1bdMjAVFjWuCJxmFGyldh0fdjZXUu+PRePao
   45h1omRiCRXvh6CYjXg/3W2fKKgiN9M21+6AjT1CLaL+X5ds4HlTXKcT/
   NTntQpAEP1hBnROXaKeej8ZVMFOOvVJ0/QtbdIxKissjryjutmwvhF83a
   kd2i5RgAXlIkJkqe6IiBnysR0zgp8wj7B0er6RaX7ZA26kLKUC1mMjTCB
   s/mVh3YEn8GT/5vKzpNrBrkwloOfjzyoYrPSqpWaLYMa8mkl6CUIhSFIU
   MvF37HrAyWP9NrZ/1UkVONpoIvZdOQxawHFYrU5XM7h8ahwsoDH1RNNit
   g==;
X-CSE-ConnectionGUID: aks78ZCLRxOyTJZTZgJsDQ==
X-CSE-MsgGUID: RHWCcjJmTdeaHLs6RTts6A==
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="34534556"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Sep 2024 05:53:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 6 Sep 2024 05:53:22 -0700
Received: from DEN-DL-M70577.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 6 Sep 2024 05:53:20 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Fri, 6 Sep 2024 14:52:41 +0200
Subject: [PATCH 4/9] phy: sparx5-serdes: add ops to match data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240906-sparx5-lan969x-serdes-driver-v1-4-8d630614c58a@microchip.com>
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


