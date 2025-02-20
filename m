Return-Path: <linux-kernel+bounces-523020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2A8A3D108
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB5EF7A7FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 05:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1A01DFE3A;
	Thu, 20 Feb 2025 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LWlus79I"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB4BA930
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740030807; cv=none; b=NjWvMh+H92lC34XhkysKl7TVfSOlh3lqmP3C0IumwqohzrbXo6AEGSg+4XofaELl7T9teymxzx+WsaEaCa/k3HSJ77oKfc6Q+/VCdUWWQ8n1zUFivgSAeLhk0Tq5M17mbze55/+5K4OXrwai0irP6xNr8lueEUON6BrobBCfTXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740030807; c=relaxed/simple;
	bh=23uAUqD4eF/XUPX1PwVhFaSmnK6teNTJ7mdwU8z7ALA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpwy4pcGa/+ROZHFlp6pB3SzKkY/mypSAeeEsmTiCMvEnHYTaemscRkJ87rgmXTUNfn+iV8ah7eEsW0VV1XgnqbqS3pqoP7jvbQWvLs3/ejFJNOKRIgOdOfAPMh4+CcFZ2DdUNrslem/e1jPaS5lMiqFWtg0ue1v/xYywQroDiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LWlus79I; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740030805; x=1771566805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=23uAUqD4eF/XUPX1PwVhFaSmnK6teNTJ7mdwU8z7ALA=;
  b=LWlus79IK5E3rkZWnb8SkkAhzpEuIv6EILDUjsEwNhWnYNRuBPXGq3q3
   n/bJQhEsp6CyTG6Ko/LhKzYovjRvU/yR8LIiuF5Dh4tLMS5exTXZW6DQS
   89uKKd3xttjnLJslxqk4dDCwuopTyBSCXa8O0f542qqd2b4F/IlgOYlju
   dmigjcDEJljMPZvsRa0bPr/v0FLzEXgUmSOB2o3uqJ51HFex5/upM7EXn
   Z8fS10pEd+7VfW/YV6Ny9eeh07vOU6uJKgSakZ840Pa3MtifnpWnZI8BV
   33tkq4Gwj77BPzDZ2w1/aMRyLMztfAZHpuLc6D+H99SIaL3KEx1fp7jAO
   Q==;
X-CSE-ConnectionGUID: rBsYg2s3SBypivTWQV4Ygg==
X-CSE-MsgGUID: 2sE9eV6ETVGZ4t1c151u/w==
X-IronPort-AV: E=Sophos;i="6.13,300,1732604400"; 
   d="scan'208";a="38313356"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2025 22:53:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 19 Feb 2025 22:53:11 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 19 Feb 2025 22:53:08 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <varshini.rajendran@microchip.com>,
	<javier.carrasco.cruz@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH v2] drivers: soc: atmel: fix the args passed to AT91_SOC for sam9x7 SoC
Date: Thu, 20 Feb 2025 11:23:02 +0530
Message-ID: <20250220055302.284558-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Fix the arguments passed to the AT91_SOC for sam9x7 SoC
updating the SoC revision is skipped since the DBGU Chip ID Register
in sam9x7 SoC does not store the current version of the device.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
[manikandan.m@microchip.com: update CIDR Macros, skip updating the SoC
revision]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
changes in v2:
- update the version_mask to 0 for sam9x7 SoC to skip upating the SoC revision
- add AT91_CIDR_VALUE_MASK to mask bits 0 to 30 as per the datasheet
- update the SAM9X7_CIDR_MATCH macro
---
 drivers/soc/atmel/soc.c | 42 +++++++++++++++++++++++------------------
 drivers/soc/atmel/soc.h |  4 ++--
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 298b542dd1c0..3e0b8ba4f8ba 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -26,6 +26,7 @@
 #define AT91_CIDR_VERSION_MASK_SAMA7G5	GENMASK(3, 0)
 #define AT91_CIDR_EXT			BIT(31)
 #define AT91_CIDR_MATCH_MASK		GENMASK(30, 5)
+#define AT91_CIDR_VALUE_MASK		GENMASK(30, 0)
 #define AT91_CIDR_MASK_SAMA7G5		GENMASK(27, 5)
 
 static const struct at91_soc socs[] __initconst = {
@@ -102,26 +103,26 @@ static const struct at91_soc socs[] __initconst = {
 		 "sam9x60 8MiB SDRAM SiP", "sam9x60"),
 #endif
 #ifdef CONFIG_SOC_SAM9X7
-	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
-		 AT91_CIDR_VERSION_MASK, SAM9X70_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X70_EXID_MATCH,
 		 "sam9x70", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
-		 AT91_CIDR_VERSION_MASK, SAM9X72_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X72_EXID_MATCH,
 		 "sam9x72", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_MATCH_MASK,
-		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X75_EXID_MATCH,
 		 "sam9x75", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1M_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X75_D1M_EXID_MATCH,
 		 "sam9x75 16MB DDR2 SiP", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D5M_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X75_D5M_EXID_MATCH,
 		 "sam9x75 64MB DDR2 SiP", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D1G_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X75_D1G_EXID_MATCH,
 		 "sam9x75 125MB DDR3L SiP ", "sam9x7"),
-	AT91_SOC(SAM9X7_CIDR_MATCH, SAM9X75_D2G_EXID_MATCH,
-		 AT91_CIDR_VERSION_MASK, SAM9X75_EXID_MATCH,
+	AT91_SOC(SAM9X7_CIDR_MATCH, AT91_CIDR_VALUE_MASK,
+		 0, SAM9X75_D2G_EXID_MATCH,
 		 "sam9x75 250MB DDR3L SiP", "sam9x7"),
 #endif
 #ifdef CONFIG_SOC_SAMA5
@@ -370,8 +371,10 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
 
 	soc_dev_attr->family = soc->family;
 	soc_dev_attr->soc_id = soc->name;
-	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
-					   AT91_CIDR_VERSION(cidr, soc->version_mask));
+	if (soc->version_mask)
+		soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%X",
+						   AT91_CIDR_VERSION(cidr, soc->version_mask));
+
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {
 		kfree(soc_dev_attr->revision);
@@ -382,8 +385,11 @@ struct soc_device * __init at91_soc_init(const struct at91_soc *socs)
 
 	if (soc->family)
 		pr_info("Detected SoC family: %s\n", soc->family);
-	pr_info("Detected SoC: %s, revision %X\n", soc->name,
-		AT91_CIDR_VERSION(cidr, soc->version_mask));
+	if (soc->version_mask)
+		pr_info("Detected SoC: %s, revision %X\n", soc->name,
+			AT91_CIDR_VERSION(cidr, soc->version_mask));
+	else
+		pr_info("Detected SoC: %s\n", soc->name);
 
 	return soc_dev;
 }
diff --git a/drivers/soc/atmel/soc.h b/drivers/soc/atmel/soc.h
index 2c78e54255f7..2503a80856bc 100644
--- a/drivers/soc/atmel/soc.h
+++ b/drivers/soc/atmel/soc.h
@@ -44,7 +44,7 @@ at91_soc_init(const struct at91_soc *socs);
 #define AT91SAM9X5_CIDR_MATCH		0x019a05a0
 #define AT91SAM9N12_CIDR_MATCH		0x019a07a0
 #define SAM9X60_CIDR_MATCH		0x019b35a0
-#define SAM9X7_CIDR_MATCH		0x09750020
+#define SAM9X7_CIDR_MATCH		0x09750030
 #define SAMA7G5_CIDR_MATCH		0x00162100
 
 #define AT91SAM9M11_EXID_MATCH		0x00000001
@@ -69,11 +69,11 @@ at91_soc_init(const struct at91_soc *socs);
 
 #define SAM9X70_EXID_MATCH		0x00000005
 #define SAM9X72_EXID_MATCH		0x00000004
+#define SAM9X75_EXID_MATCH		0x00000000
 #define SAM9X75_D1G_EXID_MATCH		0x00000018
 #define SAM9X75_D2G_EXID_MATCH		0x00000020
 #define SAM9X75_D1M_EXID_MATCH		0x00000003
 #define SAM9X75_D5M_EXID_MATCH		0x00000010
-#define SAM9X75_EXID_MATCH		0x00000000
 
 #define SAMA7G51_EXID_MATCH		0x3
 #define SAMA7G52_EXID_MATCH		0x2
-- 
2.25.1


