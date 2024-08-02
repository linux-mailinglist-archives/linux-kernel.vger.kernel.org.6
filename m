Return-Path: <linux-kernel+bounces-272314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CEA945A2F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 10:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F5F285C1C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B01C233D;
	Fri,  2 Aug 2024 08:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="VKPv4d95"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AACF1CAB3;
	Fri,  2 Aug 2024 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722588293; cv=none; b=QoDalRDhCCwYuXfgF5d+x3Dw4ZuF5Cd2CwK06vpzN/rmIZP4itQ+3K+zAjwykzMZBufg2nmEzVzB48mmp6omlvbBmtdlIkJ4Wn3snTLdCYKVtynPK/S84RujpoZaxhFAs/CztIfohoHtfutMBS/tnRQYU+GFl13/17HWemionvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722588293; c=relaxed/simple;
	bh=g+4DliHdgQHpi+jWQjM0rVbgeFDgc084HE5gOfkvZM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZHg3SB3pkfen2ygFDnZW/+P3p9y3JZc9gjTkUcNljJRB52brXxs76Fe5UFFQ194r3WeQmayLjB3NFY8j+V5gCEILW/0RZ01NkDMijqASKnwVAvITzz8uVK9xPuptejAc2HZzDIBImRQgGWWcWsaGsI1zFTFSZ+ZhUzdSDtHthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=VKPv4d95; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1722588291; x=1754124291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g+4DliHdgQHpi+jWQjM0rVbgeFDgc084HE5gOfkvZM0=;
  b=VKPv4d95S3BZ8M8B88YCY4s76woRBeADbs8OF58C4B/T+ZS8PCEz2EoC
   dA/eJ0qBsCtmrEMU2iwM+4iivrMrP6S1tdTRAP6t5ovvcUla+5M5FVkh5
   nqTQ/eIg9nWxjC7+SgxuUm9MuvYj2LVCRQwmbtkUEXEgmv6EaWYBq8XPT
   6g4aswSl+D1mLkHxVgqAJh+QDBPBdaSHDwJGjs/fSxxWyV+9I77uFyLMs
   W1bniYAkypE9slpBXxph3kTRJRxCjgU9DGzlcZitXmTI8KOc2fFeC6thH
   6vhXO40rZDoI8imXh5iL2GOWz/t/Q6oDsda/Dvv8AI9afS1iBUja+z+0t
   Q==;
X-CSE-ConnectionGUID: XV82H4fORUiyrVSRGyjEEA==
X-CSE-MsgGUID: x9OugVOdSjWVKrjR1lgdFA==
X-IronPort-AV: E=Sophos;i="6.09,257,1716274800"; 
   d="scan'208";a="30677919"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Aug 2024 01:44:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 2 Aug 2024 01:44:47 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 2 Aug 2024 01:44:44 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Date: Fri, 2 Aug 2024 11:44:28 +0300
Message-ID: <20240802084433.20958-2-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802084433.20958-1-andrei.simion@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Based on the datasheet [1] (Block Diagram) PVIN[1-4] and LVIN
represent the input voltage supply for each BUCKs respective LDOs.
Update the driver to align with the datasheet [1].

[1]: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP16502-High-Performance-PMIC-for-SAMA5DX-SAM9X6-MPUs-Data-Sheet-DS20006275A.pdf

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
 drivers/regulator/mcp16502.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 5de9d4fa5113..b34ae0bbba6f 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -107,9 +107,10 @@ static unsigned int mcp16502_of_map_mode(unsigned int mode)
 	return REGULATOR_MODE_INVALID;
 }
 
-#define MCP16502_REGULATOR(_name, _id, _ranges, _ops, _ramp_table)	\
+#define MCP16502_REGULATOR(_name, _id, _sn, _ranges, _ops, _ramp_table)	\
 	[_id] = {							\
 		.name			= _name,			\
+		.supply_name		= #_sn,				\
 		.regulators_node	= "regulators",			\
 		.id			= _id,				\
 		.ops			= &(_ops),			\
@@ -467,18 +468,18 @@ static const struct linear_range b234_ranges[] = {
 };
 
 static const struct regulator_desc mcp16502_desc[] = {
-	/* MCP16502_REGULATOR(_name, _id, ranges, regulator_ops, ramp_table) */
-	MCP16502_REGULATOR("VDD_IO", BUCK1, b1l12_ranges, mcp16502_buck_ops,
+	/* MCP16502_REGULATOR(_name, _id, _sn, _ranges, _ops, _ramp_table) */
+	MCP16502_REGULATOR("VDD_IO", BUCK1, pvin1, b1l12_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b1l12),
-	MCP16502_REGULATOR("VDD_DDR", BUCK2, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_DDR", BUCK2, pvin2, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_CORE", BUCK3, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_CORE", BUCK3, pvin3, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("VDD_OTHER", BUCK4, b234_ranges, mcp16502_buck_ops,
+	MCP16502_REGULATOR("VDD_OTHER", BUCK4, pvin4, b234_ranges, mcp16502_buck_ops,
 			   mcp16502_ramp_b234),
-	MCP16502_REGULATOR("LDO1", LDO1, b1l12_ranges, mcp16502_ldo_ops,
+	MCP16502_REGULATOR("LDO1", LDO1, lvin, b1l12_ranges, mcp16502_ldo_ops,
 			   mcp16502_ramp_b1l12),
-	MCP16502_REGULATOR("LDO2", LDO2, b1l12_ranges, mcp16502_ldo_ops,
+	MCP16502_REGULATOR("LDO2", LDO2, lvin, b1l12_ranges, mcp16502_ldo_ops,
 			   mcp16502_ramp_b1l12)
 };
 
-- 
2.34.1


