Return-Path: <linux-kernel+bounces-339276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A78EF986201
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFA11C271DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0289186285;
	Wed, 25 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="u8z3Lczp"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421C118452A;
	Wed, 25 Sep 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276032; cv=none; b=uHycZw9pRooYN3RJt8RA5Sm/gP8ulZyUvvPjJXIN3T5WQXKqyaK234CkkOGCPMVx8iEEziXbdfFYqAAzNqm9h/IDpSE/9+in8D5xEMS0/SeA5SBJVFtl5mZDOrBEsZxpZktADhlbPQoN73tCy+l6hy9BNnnjKV8tEdpjxAVq5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276032; c=relaxed/simple;
	bh=YCxbvf9bw6nRPMBwyErlOhpsvMANSV5kJ4bsWL6G7bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=dGCVpaOOLc6pqOzaDbDbJze+2Vo7W+xFiYvSdZHGlENogStRm+taN9qHxyl6myZiwZI4PrwVwd1srBI3l2FQ5PZdaxIH4SsMfVMMZjxaWiWtLrsDah+alOYMfmRzqripV61z58cSJv/5H0oHB4EBiWV+yeh0Z7su/siyrys7/9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=u8z3Lczp; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 0154A120020;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 0154A120020
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276020;
	bh=A10nef/Yh35uk4C2ZtKkxyn7HwyXdHBzhjd8HkQj9a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=u8z3LczpqGU1T1Wj4W5Ky4tFtufC9Oewuwf5k+UPqNNCix9LcdBBbM4Yo6EpQ1xTI
	 huPqwRSiDBS0I3k+aXG1YXC/5Q4hO2eBYbXhxdUl5D+e3sQR+jRMK+1zCWMexRMbTu
	 1ChAT7fvS4/kwVEBT2dp8iEc9x4kCKnAmNrBGgAgDklXyv7+Gv8UdQ5vNUJDQJ68Oz
	 lGA7kaXm930yRYUrGuBWPUu0g6W5RSiKftQtzC0REqGmei8eT5F/Cti29eANffhq1h
	 i7wXslOnoZ+295WTy9d49xdSF9holpP/oySzXdMj/6ZU5B2zv4XHMRZENCby33S2zL
	 juOXxM6kgwIyA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Wed, 25 Sep 2024 17:52:40 +0300
Subject: [PATCH v3 2/6] ASoC: codecs: Add NeoFidelity Firmware helpers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ntp-amps-8918-8835-v3-2-e2459a8191a6@salutedevices.com>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"Mark Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187980 [Sep 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for loading firmware for NeoFidelity amplifiers.

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 sound/soc/codecs/Kconfig  |   3 +
 sound/soc/codecs/Makefile |   2 +
 sound/soc/codecs/ntpfw.c  | 137 ++++++++++++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ntpfw.h  |  23 ++++++++
 4 files changed, 165 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 7092842480ef17d705920a6ac62a85158119352e..a911a81caf8b3941dc4a3117290739cb6ac802d3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2565,6 +2565,9 @@ config SND_SOC_NAU8825
 	tristate
 	depends on I2C
 
+config SND_SOC_NTPFW
+	tristate
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 54cbc3feae3277ae29d6ea8fe891d4d17e5c9b17..12f97fc8a9e7c410b0e8859f34b303caa677fcd2 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -189,6 +189,7 @@ snd-soc-nau8821-y := nau8821.o
 snd-soc-nau8822-y := nau8822.o
 snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
+snd-soc-ntpfw-y := ntpfw.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
 snd-soc-pcm1681-y := pcm1681.o
 snd-soc-pcm1789-codec-y := pcm1789.o
@@ -591,6 +592,7 @@ obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
 obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
+obj-$(CONFIG_SND_SOC_NTPFW)	+= snd-soc-ntpfw.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
 obj-$(CONFIG_SND_SOC_PCM179X)	+= snd-soc-pcm179x-codec.o
diff --git a/sound/soc/codecs/ntpfw.c b/sound/soc/codecs/ntpfw.c
new file mode 100644
index 0000000000000000000000000000000000000000..5ced2e966ab7d284c48a99f7ba9690d21b838c67
--- /dev/null
+++ b/sound/soc/codecs/ntpfw.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ntpfw.c - Firmware helper functions for Neofidelity codecs
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ */
+
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+
+#include "ntpfw.h"
+
+struct ntpfw_chunk {
+	__be16 length;
+	u8 step;
+	u8 data[];
+} __packed;
+
+struct ntpfw_header {
+	__be32 magic;
+} __packed;
+
+static bool ntpfw_verify(struct device *dev, const u8 *buf, size_t buf_size, u32 magic)
+{
+	const struct ntpfw_header *header = (struct ntpfw_header *)buf;
+	u32 buf_magic;
+
+	if (buf_size <= sizeof(*header)) {
+		dev_err(dev, "Failed to load firmware: image too small\n");
+		return false;
+	}
+
+	buf_magic = be32_to_cpu(header->magic);
+	if (buf_magic != magic) {
+		dev_err(dev, "Failed to load firmware: invalid magic 0x%x:\n", buf_magic);
+		return false;
+	}
+
+	return true;
+}
+
+static bool ntpfw_verify_chunk(struct device *dev, const struct ntpfw_chunk *chunk, size_t buf_size)
+{
+	size_t chunk_size;
+
+	if (buf_size <= sizeof(*chunk)) {
+		dev_err(dev, "Failed to load firmware: chunk size too big\n");
+		return false;
+	}
+
+	if (chunk->step != 2 && chunk->step != 5) {
+		dev_err(dev, "Failed to load firmware: invalid chunk step: %d\n", chunk->step);
+		return false;
+	}
+
+	chunk_size = be16_to_cpu(chunk->length);
+	if (chunk_size > buf_size) {
+		dev_err(dev, "Failed to load firmware: invalid chunk length\n");
+		return false;
+	}
+
+	if (chunk_size % chunk->step) {
+		dev_err(dev, "Failed to load firmware: chunk length and step mismatch\n");
+		return false;
+	}
+
+	return true;
+}
+
+static int ntpfw_send_chunk(struct i2c_client *i2c, const struct ntpfw_chunk *chunk)
+{
+	int ret;
+	size_t i;
+	size_t length = be16_to_cpu(chunk->length);
+
+	for (i = 0; i < length; i += chunk->step) {
+		ret = i2c_master_send(i2c, &chunk->data[i], chunk->step);
+		if (ret != chunk->step) {
+			dev_err(&i2c->dev, "I2C send failed: %d\n", ret);
+			return ret < 0 ? ret : -EIO;
+		}
+	}
+
+	return 0;
+}
+
+int ntpfw_load(struct i2c_client *i2c, const char *name, u32 magic)
+{
+	struct device *dev = &i2c->dev;
+	const struct ntpfw_chunk *chunk;
+	const struct firmware *fw;
+	const u8 *data;
+	size_t leftover;
+	int ret;
+
+	ret = request_firmware(&fw, name, dev);
+	if (ret) {
+		dev_warn(dev, "request_firmware '%s' failed with %d\n",
+			 name, ret);
+		return ret;
+	}
+
+	if (!ntpfw_verify(dev, fw->data, fw->size, magic)) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	data = fw->data + sizeof(struct ntpfw_header);
+	leftover = fw->size - sizeof(struct ntpfw_header);
+
+	while (leftover) {
+		chunk = (struct ntpfw_chunk *)data;
+
+		if (!ntpfw_verify_chunk(dev, chunk, leftover)) {
+			ret = -EINVAL;
+			goto done;
+		}
+
+		ret = ntpfw_send_chunk(i2c, chunk);
+		if (ret)
+			goto done;
+
+		data += be16_to_cpu(chunk->length) + sizeof(*chunk);
+		leftover -= be16_to_cpu(chunk->length) + sizeof(*chunk);
+	}
+
+done:
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ntpfw_load);
+
+MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
+MODULE_DESCRIPTION("Helper for loading Neofidelity amplifiers firmware");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/ntpfw.h b/sound/soc/codecs/ntpfw.h
new file mode 100644
index 0000000000000000000000000000000000000000..1cf10d5480ee7f55d093e578407de252f866f424
--- /dev/null
+++ b/sound/soc/codecs/ntpfw.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/**
+ * ntpfw.h - Firmware helper functions for Neofidelity codecs
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ */
+
+#ifndef __NTPFW_H__
+#define __NTPFW_H__
+#include <linux/i2c.h>
+#include <linux/firmware.h>
+
+/**
+ * ntpfw_load - load firmware to amplifier over i2c interface.
+ *
+ * @i2c		Pointer to amplifier's I2C client.
+ * @name	Firmware file name.
+ * @magic	Magic number to validate firmware.
+ * @return	0 or error code upon error.
+ */
+int ntpfw_load(struct i2c_client *i2c, const char *name, const u32 magic);
+
+#endif /* __NTPFW_H__ */

-- 
2.34.1


