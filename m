Return-Path: <linux-kernel+bounces-576570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A9A7113E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82B5F170373
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022D719DF48;
	Wed, 26 Mar 2025 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W0VjzKfB"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73511199938;
	Wed, 26 Mar 2025 07:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742973745; cv=none; b=K5vyETkoiIuyXauuolKwNM48aH7a9UZYXIJP+K/v409MbA+pjYV+kQ/7lJzHlWAkWVPFfsvcdKVz/HSyyD0f4XOf+HptHwjxQXvQ4OCnVIXj2M9KUntTKu6ERPOeN4V3r8SOFz6Aprc/s03i4hMyddn8iY3XGlnBMbHTvkLgMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742973745; c=relaxed/simple;
	bh=8VYqpJBwzckNJtWP0ZHwgshXfd1CjjdPlbtTRY4ocIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnhQYDZhXDA39MrjG3cUy7MQck/c8VBHQMlXYT1mgGAMWkO+GeO1p8LRTtGqV64SP0VYtsiYTo3YStUy/8b8iBI+ICzZuCo/Ht2enDnqxztI1vCSCV0/71uMjWKWJwwX3FAO14P9LuuvhC9j3sLZt1mhs1TtvtFW6K6QI6NuS5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W0VjzKfB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1742973744; x=1774509744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8VYqpJBwzckNJtWP0ZHwgshXfd1CjjdPlbtTRY4ocIs=;
  b=W0VjzKfBZzWXuzQQk0H0mqEhmyaqcOrosJMaYuMwqLkLD9Jmaqtih7kS
   TSVLPp/qxVV2ZK8S1rHzVAKv6ZrrcTUMcRH0k3ZKMDl8YTMCW5DQzMdV8
   awpGSwtTftvynV/NH1grBli4MhiRyJxiz/sYI6IYEcp9mTqlqF1OpdH5L
   M+3KPwiwNVNd6j1uYKyMkS7n5JK27/8r1aMfyVlmvFwVbdkyiH8P804kB
   MlK2rzG0SE3twbUsOG4fvCJUMvHuZS7uj74fkzvDCr9ioyeZy2vuH1UV8
   lqoBDpDdVrgIoqnbUZDSed05aT+RZhxLuwZ1A9KMfTtossciXn7wx+W2a
   g==;
X-CSE-ConnectionGUID: QApF+UAWRZutY2upgn7tGQ==
X-CSE-MsgGUID: VAFzNfzLQ5+vOs3yEZkekg==
X-IronPort-AV: E=Sophos;i="6.14,277,1736838000"; 
   d="scan'208";a="271100166"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Mar 2025 00:22:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 26 Mar 2025 00:22:02 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Wed, 26 Mar 2025 00:21:56 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <tudor.ambarus@linaro.org>,
	<pratyush@kernel.org>, <mwalle@kernel.org>, <miquel.raynal@bootlin.com>,
	<richard@nod.at>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v2 1/3] mtd: spi-nor: sfdp: parse SFDP SST vendor map and register EUI addresses into NVMEM framework
Date: Wed, 26 Mar 2025 12:51:38 +0530
Message-ID: <20250326072140.172244-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250326072140.172244-1-manikandan.m@microchip.com>
References: <20250326072140.172244-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Some SST flash like SST26VF064BEUI serial quad flash memory is programmed
at the factory with a globally unique EUI-48 and EUI-64 identifiers stored
in the SFDP vendor parameter table and it is permanently write-protected.

Add SST Vendor table SFDP parser to read the EUI-48 and EUI-64
Mac Addresses and allocate them using resource-managed devm_kcalloc
which will be freed on driver detach.

Regitser the Addresses into NVMEM framework and parse them when
requested using the nvmem properties in the DT by the net drivers.
In kernel the Ethernet MAC address relied on U-Boot env variables or
generated a random address, which posed challenges for boards without
on-board EEPROMs or with multiple Ethernet ports.
This change ensures consistent and reliable MAC address retrieval
from QSPI benefiting boards like the sama5d29 curiosity and
sam9x75 curiosity.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 drivers/mtd/spi-nor/sfdp.c  | 161 ++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h |   7 ++
 2 files changed, 168 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 21727f9a4ac6..920708ae928a 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -31,6 +31,7 @@
 					 * Register Map Offsets for Multi-Chip
 					 * SPI Memory Devices.
 					 */
+#define SFDP_MCHP_SST_ID	0x01bf
 
 #define SFDP_SIGNATURE		0x50444653U
 
@@ -1344,6 +1345,163 @@ static int spi_nor_parse_sccr_mc(struct spi_nor *nor,
 	return ret;
 }
 
+#define SFDP_MCHP_PARAM_TABLE_LEN	28
+#define SFDP_SST26VF064BEUI_ID		0xFF4326BFU
+
+#define SFDP_MCHP_EUI48			0x30
+#define SFDP_MCHP_EUI48_MASK		GENMASK(7, 0)
+#define SFDP_MCHP_EUI48_MAC_LEN		6
+
+#define SFDP_MCHP_EUI64			0x40
+#define SFDP_MCHP_EUI64_MASK		GENMASK(31, 24)
+#define SFDP_MCHP_EUI64_MAC_LEN		8
+
+/**
+ * spi_nor_mchp_sfdp_read_addr()- read callback to copy the EUI-48 or EUI-68
+ *				  Addresses for device that request via NVMEM
+ *
+ * @priv: User context passed to read callbacks.
+ * @offset: Offset within the NVMEM device.
+ * @val: pointer where to fill the ethernet address
+ * @bytes: Length of the NVMEM cell
+ *
+ * Return: 0 on success, -EINVAL  otherwise.
+ */
+static int spi_nor_mchp_sfdp_read_addr(void *priv, unsigned int off,
+				       void *val, size_t bytes)
+{
+	struct spi_nor *nor = priv;
+
+	if (SFDP_MCHP_PARAM_TABLE_LEN == nor->mchp_eui->vendor_param_length) {
+		switch (bytes) {
+		case SFDP_MCHP_EUI48_MAC_LEN:
+			memcpy(val, nor->mchp_eui->ethaddr_eui48, SFDP_MCHP_EUI48_MAC_LEN);
+			break;
+		case SFDP_MCHP_EUI64_MAC_LEN:
+			memcpy(val, nor->mchp_eui->ethaddr_eui64, SFDP_MCHP_EUI64_MAC_LEN);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * spi_nor_parse_mchp_sfdp() - Parse the Microchip vendor specific parameter table
+ *			       Read and store the EUI-48 and EUI-64 address to
+ *			       struct spi_nor_sst_mchp_eui_info if the addresses are
+ *			       programmed in the SST26VF064BEUI sst flag
+ *
+ * @nor:		pointer to a 'struct spi_nor'
+ * @sccr_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the Microchip vendor parameter header length and version.
+ *
+ * Return: 0 on success of if addresses are not programmed, -errno otherwise.
+ */
+static int spi_nor_parse_mchp_sfdp(struct spi_nor *nor,
+				   const struct sfdp_parameter_header *mchp_header)
+{
+	struct nvmem_device *nvmem;
+	struct nvmem_config nvmem_config = { };
+	struct spi_nor_sst_mchp_eui_info *mchp_eui;
+	u32 *dwords, addr, sst_flash_id;
+	size_t len;
+	int ret = 0, size = 0;
+
+	if (SFDP_MCHP_PARAM_TABLE_LEN != mchp_header->length)
+		return -EINVAL;
+
+	addr = SFDP_PARAM_HEADER_PTP(mchp_header);
+	/* Get the SST SPI NOR FLASH ID */
+	ret = spi_nor_read_sfdp_dma_unsafe(nor, addr, sizeof(sst_flash_id),
+					   &sst_flash_id);
+	if (ret < 0)
+		return ret;
+
+	/* Check the SPI NOR FLASH ID */
+	if (le32_to_cpu(sst_flash_id) != SFDP_SST26VF064BEUI_ID)
+		return -EINVAL;
+
+	len = mchp_header->length * sizeof(*dwords);
+	dwords = kmalloc(len, GFP_KERNEL);
+	if (!dwords)
+		return -ENOMEM;
+
+	ret = spi_nor_read_sfdp(nor, addr, len, dwords);
+	if (ret)
+		goto out;
+
+	le32_to_cpu_array(dwords, mchp_header->length);
+
+	mchp_eui = devm_kzalloc(nor->dev, sizeof(*mchp_eui), GFP_KERNEL);
+	if (!mchp_eui) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (SFDP_MCHP_EUI48 == FIELD_GET(SFDP_MCHP_EUI48_MASK,
+					 dwords[SFDP_DWORD(25)])) {
+		mchp_eui->ethaddr_eui48 = devm_kcalloc(nor->dev,
+						       SFDP_MCHP_EUI48_MAC_LEN,
+						       sizeof(u8), GFP_KERNEL);
+		if (!mchp_eui->ethaddr_eui48) {
+			ret = -ENOMEM;
+			devm_kfree(nor->dev, mchp_eui);
+			goto out;
+		}
+		memcpy(mchp_eui->ethaddr_eui48, (u8 *)&dwords[SFDP_DWORD(25)] + 1,
+		       SFDP_MCHP_EUI48_MAC_LEN);
+		size = SFDP_MCHP_EUI48_MAC_LEN;
+	}
+
+	if (SFDP_MCHP_EUI64 == FIELD_GET(SFDP_MCHP_EUI64_MASK,
+					 dwords[SFDP_DWORD(26)])) {
+		mchp_eui->ethaddr_eui64 = devm_kcalloc(nor->dev,
+						       SFDP_MCHP_EUI64_MAC_LEN,
+						       sizeof(u8), GFP_KERNEL);
+		if (!mchp_eui->ethaddr_eui64) {
+			ret = -ENOMEM;
+			devm_kfree(nor->dev, mchp_eui->ethaddr_eui48);
+			devm_kfree(nor->dev, mchp_eui);
+			goto out;
+		}
+		memcpy(mchp_eui->ethaddr_eui64, (u8 *)&dwords[SFDP_DWORD(27)],
+		       SFDP_MCHP_EUI64_MAC_LEN);
+		size += SFDP_MCHP_EUI64_MAC_LEN;
+	}
+
+	/*
+	 * Return if SST26VF064BEUI sst flash is not programmed
+	 * with EUI-48 or EUI-64 information
+	 */
+	if (!size) {
+		devm_kfree(nor->dev, mchp_eui);
+		goto out;
+	}
+
+	mchp_eui->vendor_param_length = mchp_header->length;
+	nor->mchp_eui = mchp_eui;
+	nvmem_config.word_size = 1;
+	nvmem_config.stride = 1;
+	nvmem_config.dev = nor->dev;
+	nvmem_config.size = size;
+	nvmem_config.priv = nor;
+	nvmem_config.reg_read = spi_nor_mchp_sfdp_read_addr;
+
+	nvmem = devm_nvmem_register(nor->dev, &nvmem_config);
+	if (IS_ERR(nvmem)) {
+		dev_err(nor->dev, "failed to register NVMEM device: %ld\n",
+			PTR_ERR(nvmem));
+		ret = PTR_ERR(nvmem);
+	}
+
+out:
+	kfree(dwords);
+	return ret;
+}
+
 /**
  * spi_nor_post_sfdp_fixups() - Updates the flash's parameters and settings
  * after SFDP has been parsed. Called only for flashes that define JESD216 SFDP
@@ -1564,6 +1722,9 @@ int spi_nor_parse_sfdp(struct spi_nor *nor)
 			err = spi_nor_parse_sccr_mc(nor, param_header);
 			break;
 
+		case SFDP_MCHP_SST_ID:
+			err = spi_nor_parse_mchp_sfdp(nor, param_header);
+			break;
 		default:
 			break;
 		}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index cdcfe0fd2e7d..051078d23ea1 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -339,6 +339,12 @@ struct flash_info;
 struct spi_nor_manufacturer;
 struct spi_nor_flash_parameter;
 
+struct spi_nor_sst_mchp_eui_info {
+	u8 vendor_param_length;
+	u8 *ethaddr_eui48;
+	u8 *ethaddr_eui64;
+};
+
 /**
  * struct spi_nor - Structure for defining the SPI NOR layer
  * @mtd:		an mtd_info structure
@@ -408,6 +414,7 @@ struct spi_nor {
 	u32			flags;
 	enum spi_nor_cmd_ext	cmd_ext_type;
 	struct sfdp		*sfdp;
+	struct spi_nor_sst_mchp_eui_info *mchp_eui;
 	struct dentry		*debugfs_root;
 
 	const struct spi_nor_controller_ops *controller_ops;
-- 
2.25.1


