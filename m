Return-Path: <linux-kernel+bounces-546472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE61A4FB15
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05F027A7412
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF972066E0;
	Wed,  5 Mar 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="peay0k+J"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D62066C1;
	Wed,  5 Mar 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168947; cv=none; b=o3JTrP6+fC2D/my+mz3Sr0i9deuXPwIb7Euo9R/WKt6Y26/Bua6YVWlJk33roibyEBEgJLI0NemNrahNa9A0a9hUMZWrfqjzsDufZ+iRlj1JJFvv5NTZhrt1GPW55PxNYUe2ZmYwR/OjRaAXRUiLp0CzY7QP/48Ue7B/tTJKTwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168947; c=relaxed/simple;
	bh=1GtvXobR4QJuxhCHEMflNdXfof/DYGcFZWntS1I2zN8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlZAqv79bpBDlYIGE0hVldVFdVVVrB+TGm7/D8muKXvgJ7MMo6i+J81Wo9x4ayUEbbWzDH7OzDyL3vDLhxOKhuFdWxU2TrBIDX2ycnm3feIcLnQHHBpFyqSYt3JISYOqQye8JyjADNNrbUnsziCSSQyOoBR2ZtVkJN1kYD8aWIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=peay0k+J; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741168945; x=1772704945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1GtvXobR4QJuxhCHEMflNdXfof/DYGcFZWntS1I2zN8=;
  b=peay0k+JNBzizW8HxqdR+fAv0dzI3GBW9lOD+GJ8l15bp0TMr4LA3SuH
   s4zIHyhtkvtFyNLpQPwmhpoR75CZth5v85iQXezCHV987VNYsilxt0ll/
   1Gzv/OkTSxG3kQQ41Cdphf/v5AJAsXJRsTU2uIEOw0ejSlTC/tL7aDqvE
   XRIf4vPzogYJ/2UAzYECRtLgyW5sq/Q4AjUn9ItBCcV02lKsp719xZ6qj
   qNmGaLjmaCPIRk/7DdoEB85a57TJuHs353Q+j03uU/QjAC2ubu4zizK/7
   1ff+QM8S3mryb28iUU4ut88jC8JB3EESPbMCEmh5fN4S8677lRi+TgKh0
   A==;
X-CSE-ConnectionGUID: KcHvf2KYQPGphZh43VuJpQ==
X-CSE-MsgGUID: TYea7XcjRjqr57KKC+M1iQ==
X-IronPort-AV: E=Sophos;i="6.14,222,1736838000"; 
   d="scan'208";a="205983630"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Mar 2025 03:02:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Mar 2025 03:01:54 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 5 Mar 2025 03:01:47 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <manikandan.m@microchip.com>, Varshini Rajendran
	<varshini.rajendran@microchip.com>
Subject: [PATCH 1/2] mtd: spi-nor: sst: register SFDP region into NVMEM framework to read MAC Address
Date: Wed, 5 Mar 2025 15:31:33 +0530
Message-ID: <20250305100134.1171124-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Varshini Rajendran <varshini.rajendran@microchip.com>

EUI identifier and the MAC Address of the Ethernet Interface is stored
after the SFDP table of contents starting at address 0x260 in the
QSPI memory.
Register the entire SFDP region read by the spi-nor (nor->sfdp) into the
NVMEM framework and read the MAC Address when requested using the nvmem
properties in the DT by the net drivers.

In kernel the Ethernet MAC address relied on U-Boot env variables or
generated a random address, which posed challenges for boards without
on-board EEPROMs or with multiple Ethernet ports.
This change ensures consistent and reliable MAC address retrieval from QSPI,
benefiting boards like the sama5d29 curiosity and sam9x75 curiosity.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
[manikandan.m@microchip.com: Integrate the nvmem->read callback framework]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/mtd/spi-nor/sst.c | 62 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/mtd/spi-nor/sst.c b/drivers/mtd/spi-nor/sst.c
index 175211fe6a5e..a0abf201ad41 100644
--- a/drivers/mtd/spi-nor/sst.c
+++ b/drivers/mtd/spi-nor/sst.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/mtd/spi-nor.h>
+#include <linux/nvmem-provider.h>
 
 #include "core.h"
 
@@ -13,6 +14,8 @@
 
 #define SST26VF_CR_BPNV		BIT(3)
 
+#define SST26VF_SFDP_EUI48	0x30
+
 static int sst26vf_nor_lock(struct spi_nor *nor, loff_t ofs, u64 len)
 {
 	return -EOPNOTSUPP;
@@ -56,8 +59,67 @@ static int sst26vf_nor_late_init(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * sst26vf_sfdp_mac_addr_read() - check if the EUI-48 MAC Address is programmed
+ * and read the data from the prestored SFDP data
+ *
+ * @priv: User context passed to read callbacks.
+ * @offset: Offset within the NVMEM device.
+ * @val: pointer where to fill the ethernet address
+ * @bytes: Length of the NVMEM cell
+ *
+ * Return: 0 on success, -EINVAL  otherwise.
+ */
+static int sst26vf_sfdp_mac_addr_read(void *priv, unsigned int off,
+				      void *val, size_t bytes)
+{
+	struct spi_nor *nor = priv;
+	struct sfdp *sfdp = nor->sfdp;
+	loff_t offset = off;
+	size_t sfdp_size;
+
+	/*
+	 * Check if the EUI-48 MAC address is programmed in the next six address
+	 * locations.
+	 * @off is programmed in the DT and stores the start of MAC Address
+	 * byte, (off - 1) stores the bit length of the Extended Unique
+	 * Identifier
+	 */
+	if (SST26VF_SFDP_EUI48 != *((u8 *)sfdp->dwords + (offset - 1)))
+		return -EINVAL;
+
+	sfdp_size = sfdp->num_dwords * sizeof(*sfdp->dwords);
+	memory_read_from_buffer(val, bytes, &offset, sfdp->dwords,
+				sfdp_size);
+	return 0;
+}
+
+static struct nvmem_config sst26vf_sfdp_nvmem_config = {
+	.word_size = 1,
+	.stride = 1,
+};
+
+static int sst26vf_nor_post_sfdp(struct spi_nor *nor)
+{
+	struct nvmem_device *nvmem;
+
+	sst26vf_sfdp_nvmem_config.dev = nor->dev;
+	sst26vf_sfdp_nvmem_config.size = nor->sfdp->num_dwords * sizeof(*nor->sfdp->dwords);
+	sst26vf_sfdp_nvmem_config.priv = nor;
+	sst26vf_sfdp_nvmem_config.reg_read = sst26vf_sfdp_mac_addr_read;
+
+	nvmem = devm_nvmem_register(nor->dev, &sst26vf_sfdp_nvmem_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(nor->dev, "failed to register NVMEM device: %ld\n", PTR_ERR(nvmem));
+		return PTR_ERR(nvmem);
+	}
+
+	return 0;
+}
+
 static const struct spi_nor_fixups sst26vf_nor_fixups = {
 	.late_init = sst26vf_nor_late_init,
+	.post_sfdp = sst26vf_nor_post_sfdp,
 };
 
 static const struct flash_info sst_nor_parts[] = {
-- 
2.25.1


