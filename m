Return-Path: <linux-kernel+bounces-569113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AB6A69EA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E8D17939E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855771EBFEB;
	Thu, 20 Mar 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RuL+8Ee3"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E9B1C1F0F;
	Thu, 20 Mar 2025 03:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440725; cv=none; b=iOTeFkgrKDrpsQoTqRNlw1irH7oNKRXre5oO2niC7YnTQkSQWzIZetA6uMsBjyJINixBQIvnrX9yJcasinyvmP+FgppoFm9QdHKukdEoTL/W46gVjcI1PlC6vh3ZTVTImNdO3UYjXEhKtkwq8tP406K8vIdKV/JEiljY7HR0PFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440725; c=relaxed/simple;
	bh=3cY/oRm++6rY0dxRaksji3vzbvwVmUN2xptKS1J94F0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zy723ppHUTVcKHAkU2VIoCdDGPVQErDccPFcK8I0FF+eOwbkbx/1f9MGqZVmDAG80qYld0c0avMeLSZEs/V4mgm+Z+OJV+yLmYX2O1nRgsj+YYIC3GTwDbqgcRMgck77oi5fK0VH4UkpsZqdjKD6M/7p2pfm1Acu7RTnJ8h7CWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RuL+8Ee3; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: feca9066053911f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3tYPMQX6wnKKjFPm5H3yIDtC2Vil3IkuL0tU9vSFlBM=;
	b=RuL+8Ee3itROJTOXHBjL4t0edMVnaD40rEiNg6ZDAuG3x51Ro79CR7BQSCCDmmL2sK3yxEh9tW8IAonLpKmlkS4pONgIHXq6dIbKKyza99q/Wrh956cDEegjLj31iNPJv9qnYrdAWv7WYxfXlb5Cur+oLQuK9TI8sZaQr7JMGBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:b912db9b-82f8-443a-94e7-79c914a2f5fa,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:76bf554a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: feca9066053911f0aae1fd9735fae912-20250320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1100177566; Thu, 20 Mar 2025 11:18:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 11:18:27 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 11:18:26 +0800
From: hailong.fan <hailong.fan@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sound-open-firmware@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<Jjian.Zhou@mediatek.com>, <Xiangzhi.Tang@mediatek.com>, hailong.fan
	<hailong.fan@mediatek.com>
Subject: [PATCH 1/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
Date: Thu, 20 Mar 2025 11:17:24 +0800
Message-ID: <20250320031753.13669-2-hailong.fan@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250320031753.13669-1-hailong.fan@mediatek.com>
References: <20250320031753.13669-1-hailong.fan@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add support of SOF on MediaTek mt8196 SoC.
MT8196 has a Cadence HiFi-5 DSP core that is responsible for running the
operating system and application programs. The IPC communication between
the AP and DSP is based on shared DRAM and mailbox interrupt.

Signed-off-by: hailong.fan <hailong.fan@mediatek.com>
---
 sound/soc/sof/mediatek/Kconfig                |   9 +
 sound/soc/sof/mediatek/Makefile               |   1 +
 sound/soc/sof/mediatek/mt8196/Makefile        |   4 +
 sound/soc/sof/mediatek/mt8196/mt8196-clk.c    | 100 +++
 sound/soc/sof/mediatek/mt8196/mt8196-clk.h    |  23 +
 sound/soc/sof/mediatek/mt8196/mt8196-loader.c |  61 ++
 sound/soc/sof/mediatek/mt8196/mt8196.c        | 650 ++++++++++++++++++
 sound/soc/sof/mediatek/mt8196/mt8196.h        | 109 +++
 8 files changed, 957 insertions(+)
 create mode 100644 sound/soc/sof/mediatek/mt8196/Makefile
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.h
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-loader.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.h

diff --git a/sound/soc/sof/mediatek/Kconfig b/sound/soc/sof/mediatek/Kconfig
index 4a2eddf6009a..ff89c4b1e052 100644
--- a/sound/soc/sof/mediatek/Kconfig
+++ b/sound/soc/sof/mediatek/Kconfig
@@ -42,4 +42,13 @@ config SND_SOC_SOF_MT8195
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+config SND_SOC_SOF_MT8196
+	tristate "SOF support for MT8196 audio DSP"
+	select SND_SOC_SOF_MTK_COMMON
+	depends on MTK_ADSP_IPC
+	help
+	  This adds support for Sound Open Firmware for Mediatek platforms
+	  using the mt8196 processors.
+	  Say Y if you have such a device.
+	  If unsure select "N".
 endif ## SND_SOC_SOF_MTK_TOPLEVEL
diff --git a/sound/soc/sof/mediatek/Makefile b/sound/soc/sof/mediatek/Makefile
index 29c5afb2f3d6..3e36d538679e 100644
--- a/sound/soc/sof/mediatek/Makefile
+++ b/sound/soc/sof/mediatek/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_SND_SOC_SOF_MTK_COMMON) += mtk-adsp-common.o
 obj-$(CONFIG_SND_SOC_SOF_MT8195) += mt8195/
 obj-$(CONFIG_SND_SOC_SOF_MT8186) += mt8186/
+obj-$(CONFIG_SND_SOC_SOF_MT8196) += mt8196/
diff --git a/sound/soc/sof/mediatek/mt8196/Makefile b/sound/soc/sof/mediatek/mt8196/Makefile
new file mode 100644
index 000000000000..c9d10374b900
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+snd-sof-mt8196-objs := mt8196.o mt8196-clk.o mt8196-loader.o
+obj-$(CONFIG_SND_SOC_SOF_MT8196) += snd-sof-mt8196.o
+
diff --git a/sound/soc/sof/mediatek/mt8196/mt8196-clk.c b/sound/soc/sof/mediatek/mt8196/mt8196-clk.c
new file mode 100644
index 000000000000..80ea24ce4722
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/mt8196-clk.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Hailong Fan <hailong.fan@mediatek.com>
+ */
+
+// Hardware interface for mt8196 DSP clock
+
+#include <linux/clk.h>
+#include <linux/io.h>
+
+#include "../../sof-audio.h"
+#include "../../ops.h"
+#include "../adsp_helper.h"
+#include "mt8196.h"
+#include "mt8196-clk.h"
+
+static const char *adsp_clks[ADSP_CLK_MAX] = {
+	[CLK_TOP_ADSP_SEL] = "clk_top_adsp_sel",
+	[CLK_TOP_CLK26M] = "clk_top_clk26m",
+	[CLK_TOP_ADSPPLL] = "clk_top_adsppll",
+
+};
+
+int mt8196_adsp_init_clock(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	struct device *dev = sdev->dev;
+	int i;
+
+	priv->clk = devm_kcalloc(dev, ADSP_CLK_MAX, sizeof(*priv->clk), GFP_KERNEL);
+	if (!priv->clk)
+		return -ENOMEM;
+
+	for (i = 0; i < ADSP_CLK_MAX; i++) {
+		priv->clk[i] = devm_clk_get(dev, adsp_clks[i]);
+
+		if (IS_ERR(priv->clk[i]))
+			return PTR_ERR(priv->clk[i]);
+	}
+
+	return 0;
+}
+
+static int adsp_enable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+	struct device *dev = sdev->dev;
+	int ret;
+
+	ret = clk_prepare_enable(priv->clk[CLK_TOP_ADSP_SEL]);
+	if (ret) {
+		dev_err(dev, "%s clk_prepare_enable(audiodsp) fail %d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void adsp_disable_all_clock(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	clk_disable_unprepare(priv->clk[CLK_TOP_ADSP_SEL]);
+}
+
+int mt8196_adsp_clock_on(struct snd_sof_dev *sdev)
+{
+	struct device *dev = sdev->dev;
+	int ret;
+
+	ret = adsp_enable_all_clock(sdev);
+	if (ret) {
+		dev_err(dev, "failed to adsp_enable_clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CK_EN,
+				      UART_BT_EN | DMA_AXI_EN | DMA1_EN,
+				      UART_BT_EN | DMA_AXI_EN | DMA1_EN);
+	if (ret < 0)
+		dev_err(sdev->dev, "Failed to update CK register: %d\n", ret);
+
+	ret = snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_UART_CTRL,
+				      UART_BCLK_CG | UART_RSTN,
+				      UART_BCLK_CG | UART_RSTN);
+	if (ret < 0)
+		dev_err(sdev->dev, "Failed to update UART register: %d\n", ret);
+
+
+	return 0;
+}
+
+void mt8196_adsp_clock_off(struct snd_sof_dev *sdev)
+{
+	snd_sof_dsp_write(sdev, DSP_REG_BAR, ADSP_UART_CTRL, 0);
+	adsp_disable_all_clock(sdev);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8196/mt8196-clk.h b/sound/soc/sof/mediatek/mt8196/mt8196-clk.h
new file mode 100644
index 000000000000..766db95c9517
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/mt8196-clk.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Hailong Fan <hailong.fan@mediatek.com>
+ */
+
+#ifndef __MT8196_CLK_H
+#define __MT8196_CLK_H
+
+struct snd_sof_dev;
+
+/* DSP clock */
+enum adsp_clk_id {
+	CLK_TOP_ADSP_SEL,
+	CLK_TOP_CLK26M,
+	CLK_TOP_ADSPPLL,
+	ADSP_CLK_MAX
+};
+
+int mt8196_adsp_init_clock(struct snd_sof_dev *sdev);
+int mt8196_adsp_clock_on(struct snd_sof_dev *sdev);
+void mt8196_adsp_clock_off(struct snd_sof_dev *sdev);
+#endif
diff --git a/sound/soc/sof/mediatek/mt8196/mt8196-loader.c b/sound/soc/sof/mediatek/mt8196/mt8196-loader.c
new file mode 100644
index 000000000000..7053e5ca3c3f
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/mt8196-loader.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Hailong Fan <hailong.fan@mediatek.com>
+ */
+
+// Hardware interface for mt8196 DSP code loader
+
+#include <sound/sof.h>
+#include "mt8196.h"
+#include "../../ops.h"
+
+void mt8196_sof_hifixdsp_boot_sequence(struct snd_sof_dev *sdev, u32 boot_addr)
+{
+	/* step1. clr ADSP_ALTVEC_C0 */
+	snd_sof_dsp_write(sdev, DSP_SECREG_BAR, ADSP_ALTVEC_C0, 0);
+	snd_sof_dsp_write(sdev, DSP_SECREG_BAR, ADSP_ALTVECSEL, 0);
+
+	/* step2. set core boot address */
+	snd_sof_dsp_write(sdev, DSP_SECREG_BAR, ADSP_ALTVEC_C0, boot_addr);
+	snd_sof_dsp_write(sdev, DSP_SECREG_BAR, ADSP_ALTVECSEL, ADSP_ALTVECSEL_C0);
+
+	/* step3. set RUNSTALL to stop core */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_HIFI_RUNSTALL,
+				RUNSTALL, RUNSTALL);
+
+	/* enable mbox 0 & 1 IRQ */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_MBOX_IRQ_EN,
+				DSP_MBOX0_IRQ_EN | DSP_MBOX1_IRQ_EN,
+				DSP_MBOX0_IRQ_EN | DSP_MBOX1_IRQ_EN);
+
+	/* step4. assert core reset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CFGREG_SW_RSTN,
+				SW_RSTN_C0 | SW_DBG_RSTN_C0,
+				SW_RSTN_C0 | SW_DBG_RSTN_C0);
+
+	/* hardware requirement */
+	udelay(1);
+
+	/* step5. release core reset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CFGREG_SW_RSTN,
+				SW_RSTN_C0 | SW_DBG_RSTN_C0,
+				0);
+
+	/* step6. clear RUNSTALL to start core */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_HIFI_RUNSTALL,
+				RUNSTALL, 0);
+}
+
+void mt8196_sof_hifixdsp_shutdown(struct snd_sof_dev *sdev)
+{
+	/* set RUNSTALL to stop core */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_HIFI_RUNSTALL,
+				RUNSTALL, RUNSTALL);
+
+	/* assert core reset */
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_CFGREG_SW_RSTN,
+				SW_RSTN_C0 | SW_DBG_RSTN_C0,
+				SW_RSTN_C0 | SW_DBG_RSTN_C0);
+}
+
diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.c b/sound/soc/sof/mediatek/mt8196/mt8196.c
new file mode 100644
index 000000000000..364069ce9954
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/mt8196.c
@@ -0,0 +1,650 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Hailong Fan <hailong.fan@mediatek.com>
+ */
+
+/*
+ * Hardware interface for audio DSP on mt8196
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of_platform.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/module.h>
+
+#include <sound/sof.h>
+#include <sound/sof/xtensa.h>
+#include "../../ops.h"
+#include "../../sof-of-dev.h"
+#include "../../sof-audio.h"
+#include "../adsp_helper.h"
+#include "../mtk-adsp-common.h"
+#include "mt8196.h"
+#include "mt8196-clk.h"
+
+static void sof_reg_write_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset, u32 value,
+				u8 bits, u8 len)
+{
+	u32 mask, val;
+	int ret;
+
+	mask = GENMASK(len + bits - 1, bits);
+	val = (value << bits) & mask;
+
+	ret = snd_sof_dsp_update_bits(sdev, bar, offset, mask, val);
+	if (ret < 0)
+		dev_err(sdev->dev, "Failed to update DSP register: %d\n", ret);
+}
+
+static u32 reg_read_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset, u8 bits, u8 len)
+{
+	u32 target_bit_field, curr_value;
+
+	target_bit_field = GENMASK(len + bits - 1, bits);
+	curr_value = snd_sof_dsp_read(sdev, bar, offset);
+
+	return (curr_value & target_bit_field) >> bits;
+}
+
+static int mt8196_get_mailbox_offset(struct snd_sof_dev *sdev)
+{
+	return MBOX_OFFSET;
+}
+
+static int mt8196_get_window_offset(struct snd_sof_dev *sdev, u32 id)
+{
+	return MBOX_OFFSET;
+}
+
+static int mt8196_send_msg(struct snd_sof_dev *sdev,
+			   struct snd_sof_ipc_msg *msg)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	sof_mailbox_write(sdev, sdev->host_box.offset, msg->msg_data,
+			  msg->msg_size);
+
+	return mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_REQ, MTK_ADSP_IPC_OP_REQ);
+}
+
+static void mt8196_dsp_handle_reply(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->sdev->ipc_lock, flags);
+	snd_sof_ipc_process_reply(priv->sdev, 0);
+	spin_unlock_irqrestore(&priv->sdev->ipc_lock, flags);
+}
+
+static void mt8196_dsp_handle_request(struct mtk_adsp_ipc *ipc)
+{
+	struct adsp_priv *priv = mtk_adsp_ipc_get_data(ipc);
+	u32 p; /* panic code */
+	int ret;
+
+	/* Read the message from the debug box. */
+	sof_mailbox_read(priv->sdev, priv->sdev->debug_box.offset + sizeof(u32),
+			 &p, sizeof(p));
+
+	/* Check to see if the message is a panic code 0x0dead*** */
+	if ((p & SOF_IPC_PANIC_MAGIC_MASK) == SOF_IPC_PANIC_MAGIC) {
+		snd_sof_dsp_panic(priv->sdev, p, true);
+	} else {
+		snd_sof_ipc_msgs_rx(priv->sdev);
+
+		/* tell DSP cmd is done */
+		ret = mtk_adsp_ipc_send(priv->dsp_ipc, MTK_ADSP_IPC_RSP, MTK_ADSP_IPC_OP_RSP);
+		if (ret)
+			dev_err(priv->dev, "request send ipc failed");
+	}
+}
+
+static struct mtk_adsp_ipc_ops dsp_ops = {
+	.handle_reply		= mt8196_dsp_handle_reply,
+	.handle_request		= mt8196_dsp_handle_request,
+};
+
+static int platform_parse_resource(struct platform_device *pdev, void *data)
+{
+	struct resource *mmio;
+	struct resource res;
+	struct device_node *mem_region;
+	struct device *dev = &pdev->dev;
+	struct mtk_adsp_chip_info *adsp = data;
+	int ret;
+
+	ret = of_reserved_mem_device_init(dev);
+	if (ret) {
+		dev_err(dev, "of_reserved_mem_device_init failed\n");
+		return ret;
+	}
+
+	mem_region = of_parse_phandle(dev->of_node, "memory-region", 1);
+	if (!mem_region) {
+		dev_err(dev, "no memory-region sysmem phandle\n");
+		return -ENODEV;
+	}
+
+	ret = of_address_to_resource(mem_region, 0, &res);
+	of_node_put(mem_region);
+	if (ret) {
+		dev_err(dev, "of_address_to_resource sysmem failed\n");
+		return ret;
+	}
+
+	adsp->pa_dram = (phys_addr_t)res.start;
+	if (adsp->pa_dram & DRAM_REMAP_MASK) {
+		dev_err(dev, "adsp memory(%#x) is not 4K-aligned\n",
+			(u32)adsp->pa_dram);
+		return -EINVAL;
+	}
+
+	adsp->dramsize = resource_size(&res);
+	if (adsp->dramsize < TOTAL_SIZE_SHARED_DRAM_FROM_TAIL) {
+		dev_err(dev, "adsp memory(%#x) is not enough for share\n",
+			adsp->dramsize);
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "dram pbase=%pa size=%#x\n", &adsp->pa_dram, adsp->dramsize);
+
+	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!mmio) {
+		dev_err(dev, "no ADSP-CFG register resource\n");
+		return -ENXIO;
+	}
+
+	adsp->va_cfgreg = devm_ioremap_resource(dev, mmio);
+	if (IS_ERR(adsp->va_cfgreg))
+		return PTR_ERR(adsp->va_cfgreg);
+
+	adsp->pa_cfgreg = (phys_addr_t)mmio->start;
+	adsp->cfgregsize = resource_size(mmio);
+
+	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
+	if (!mmio) {
+		dev_err(dev, "no SRAM resource\n");
+		return -ENXIO;
+	}
+
+	adsp->pa_sram = (phys_addr_t)mmio->start;
+	adsp->sramsize = resource_size(mmio);
+
+	dev_dbg(dev, "sram pbase=%pa size=%#x\n", &adsp->pa_sram, adsp->sramsize);
+
+	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sec");
+	if (!mmio) {
+		dev_err(dev, "no SEC register resource\n");
+		return -ENXIO;
+	}
+
+	adsp->va_secreg = devm_ioremap_resource(dev, mmio);
+	if (IS_ERR(adsp->va_secreg))
+		return PTR_ERR(adsp->va_secreg);
+
+	adsp->pa_secreg = (phys_addr_t)mmio->start;
+	adsp->secregsize = resource_size(mmio);
+
+	dev_dbg(dev, "secreg pbase=%pa size=%#x\n", &adsp->pa_secreg, adsp->secregsize);
+
+	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bus");
+	if (!mmio) {
+		dev_err(dev, "no BUS register resource\n");
+		return -ENXIO;
+	}
+
+	adsp->va_busreg = devm_ioremap_resource(dev, mmio);
+	if (IS_ERR(adsp->va_busreg))
+		return PTR_ERR(adsp->va_busreg);
+
+	adsp->pa_busreg = (phys_addr_t)mmio->start;
+	adsp->busregsize = resource_size(mmio);
+
+	dev_dbg(dev, "busreg pbase=%pa, vbase=%pa, size=%#x\n", &adsp->pa_busreg,
+		&adsp->va_busreg, adsp->busregsize);
+
+	return 0;
+}
+
+static void adsp_sram_power_on(struct snd_sof_dev *sdev)
+{
+	int i;
+
+	for (i = 0; i < ADSP_SRAM_CHANNEL_NUM; i++) {
+		sof_reg_write_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_CON, 0, i, 1);
+		while (1) {
+			if (reg_read_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_ACK, i, 1) == 0)
+				break;
+		}
+	}
+}
+
+static void adsp_sram_power_off(struct snd_sof_dev *sdev)
+{
+	int i;
+
+	for (i = 0; i < ADSP_SRAM_CHANNEL_NUM; i++) {
+		sof_reg_write_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_CON, 1, i, 1);
+		while (1) {
+			if (reg_read_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_ACK, i, 1) == 1)
+				break;
+		}
+	}
+}
+
+/*  Init the basic DSP DRAM address */
+static int adsp_memory_remap_init(struct snd_sof_dev *sdev, struct mtk_adsp_chip_info *adsp)
+{
+	u32 from, to;
+
+	from = ADSP_REMAP_REGION_FROM(DRAM_PHYS_BASE_FROM_DSP_VIEW, DSP_DRAM_SIZE);
+	to = (u32)ADSP_REMAP_REGION_TO(adsp->pa_dram);
+
+	snd_sof_dsp_write(sdev, DSP_BUSREG_BAR, AUDIO_BUS_CFG_RSV_10, from);
+	snd_sof_dsp_write(sdev, DSP_BUSREG_BAR, DSP_C0_EMI_MAP_ADDR, to);
+
+	snd_sof_dsp_update_bits(sdev, DSP_BUSREG_BAR, AUDIO_BUS_CFG_BUS_REMAP_CTRL, 1, 1);
+
+	return 0;
+}
+
+static int mt8196_run(struct snd_sof_dev *sdev)
+{
+	u32 adsp_bootup_addr;
+
+	adsp_bootup_addr = SRAM_PHYS_BASE_FROM_DSP_VIEW;
+	dev_dbg(sdev->dev, "HIFIxDSP boot from base : 0x%08X\n", adsp_bootup_addr);
+	mt8196_sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
+
+	return 0;
+}
+
+static int mt8196_dsp_probe(struct snd_sof_dev *sdev)
+{
+	struct platform_device *pdev = container_of(sdev->dev, struct platform_device, dev);
+	struct adsp_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	sdev->pdata->hw_pdata = priv;
+	priv->dev = sdev->dev;
+	priv->sdev = sdev;
+
+	priv->adsp = devm_kzalloc(&pdev->dev, sizeof(struct mtk_adsp_chip_info), GFP_KERNEL);
+	if (!priv->adsp)
+		return -ENOMEM;
+
+	ret = platform_parse_resource(pdev, priv->adsp);
+	if (ret)
+		return ret;
+
+	sdev->bar[SOF_FW_BLK_TYPE_IRAM] = devm_ioremap(sdev->dev,
+						       priv->adsp->pa_sram,
+						       priv->adsp->sramsize);
+	if (!sdev->bar[SOF_FW_BLK_TYPE_IRAM]) {
+		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
+			&priv->adsp->pa_sram, priv->adsp->sramsize);
+		return -ENOMEM;
+	}
+
+	priv->adsp->va_sram = sdev->bar[SOF_FW_BLK_TYPE_IRAM];
+	dev_dbg(sdev->dev, "pa_sram %pa,va: %pa, size %#x\n",
+			&priv->adsp->pa_sram, &priv->adsp->va_sram, priv->adsp->sramsize);
+
+	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(sdev->dev,
+						       priv->adsp->pa_dram,
+						       priv->adsp->dramsize);
+
+	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
+		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
+			&priv->adsp->pa_dram, priv->adsp->dramsize);
+		return -ENOMEM;
+	}
+
+	priv->adsp->va_dram = sdev->bar[SOF_FW_BLK_TYPE_SRAM];
+
+	dev_dbg(sdev->dev, "pa_dram %pa, va: %pa, size %#x\n",
+			&priv->adsp->pa_dram, &priv->adsp->va_dram, priv->adsp->dramsize);
+
+
+	sdev->bar[DSP_REG_BAR] = priv->adsp->va_cfgreg;
+	sdev->bar[DSP_SECREG_BAR] = priv->adsp->va_secreg;
+	sdev->bar[DSP_BUSREG_BAR] = priv->adsp->va_busreg;
+
+	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
+	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
+
+	/* set default mailbox offset for FW ready message */
+	sdev->dsp_box.offset = mt8196_get_mailbox_offset(sdev);
+
+	/* enable adsp clock before touching registers */
+	ret = mt8196_adsp_init_clock(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "mt8196_adsp_init_clock failed\n");
+		return ret;
+	}
+
+	ret = mt8196_adsp_clock_on(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "mt8196_adsp_clock_on fail!\n");
+		return ret;
+	}
+
+	ret = adsp_memory_remap_init(sdev, priv->adsp);
+	if (ret) {
+		dev_err(sdev->dev, "adsp_memory_remap_init fail!\n");
+		return ret;
+	}
+
+	adsp_sram_power_on(sdev);
+
+	priv->ipc_dev = platform_device_register_data(&pdev->dev, "mtk-adsp-ipc",
+						      PLATFORM_DEVID_NONE,
+						      pdev, sizeof(*pdev));
+	if (IS_ERR(priv->ipc_dev)) {
+		ret = PTR_ERR(priv->ipc_dev);
+		dev_err(sdev->dev, "failed to create mtk-adsp-ipc device\n");
+		goto err_adsp_off;
+	}
+
+	priv->dsp_ipc = dev_get_drvdata(&priv->ipc_dev->dev);
+	if (!priv->dsp_ipc) {
+		ret = -EPROBE_DEFER;
+		dev_err(sdev->dev, "failed to get drvdata\n");
+		goto exit_pdev_unregister;
+	}
+
+	mtk_adsp_ipc_set_data(priv->dsp_ipc, priv);
+	priv->dsp_ipc->ops = &dsp_ops;
+
+	return 0;
+
+exit_pdev_unregister:
+	platform_device_unregister(priv->ipc_dev);
+err_adsp_off:
+	adsp_sram_power_off(sdev);
+	mt8196_adsp_clock_off(sdev);
+
+	return ret;
+}
+
+static void mt8196_dsp_remove(struct snd_sof_dev *sdev)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	platform_device_unregister(priv->ipc_dev);
+	mt8196_sof_hifixdsp_shutdown(sdev);
+	adsp_sram_power_off(sdev);
+	mt8196_adsp_clock_off(sdev);
+}
+
+static int mt8196_dsp_shutdown(struct snd_sof_dev *sdev)
+{
+	return snd_sof_suspend(sdev->dev);
+}
+
+static int mt8196_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
+{
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_IO_CONFIG, ADSP_CLK_SEL, 0);
+	clk_set_parent(priv->clk[CLK_TOP_ADSP_SEL], priv->clk[CLK_TOP_CLK26M]);
+	mt8196_sof_hifixdsp_shutdown(sdev);
+	adsp_sram_power_off(sdev);
+	mt8196_adsp_clock_off(sdev);
+
+	return 0;
+}
+
+static int mt8196_dsp_resume(struct snd_sof_dev *sdev)
+{
+	int ret;
+	struct adsp_priv *priv = sdev->pdata->hw_pdata;
+
+	ret = mt8196_adsp_clock_on(sdev);
+	if (ret) {
+		dev_err(sdev->dev, "mt8196_adsp_clock_on fail!");
+		return ret;
+	}
+
+	clk_set_parent(priv->clk[CLK_TOP_ADSP_SEL], priv->clk[CLK_TOP_ADSPPLL]);
+	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_IO_CONFIG, ADSP_CLK_SEL, BIT(31));
+	adsp_sram_power_on(sdev);
+
+	return 0;
+}
+
+/* on mt8196 there is 1 to 1 match between type and BAR idx */
+static int mt8196_get_bar_index(struct snd_sof_dev *sdev, u32 type)
+{
+	return type;
+}
+
+static int mt8196_pcm_hw_params(struct snd_sof_dev *sdev,
+				struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_sof_platform_stream_params *platform_params)
+{
+	platform_params->cont_update_posn = 1;
+
+	return 0;
+}
+
+static snd_pcm_uframes_t mt8196_pcm_pointer(struct snd_sof_dev *sdev,
+					    struct snd_pcm_substream *substream)
+{
+	int ret;
+	snd_pcm_uframes_t pos;
+	struct snd_sof_pcm *spcm;
+	struct sof_ipc_stream_posn posn;
+	struct snd_sof_pcm_stream *stream;
+	struct snd_soc_component *scomp = sdev->component;
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+
+	spcm = snd_sof_find_spcm_dai(scomp, rtd);
+	if (!spcm) {
+		dev_warn_ratelimited(sdev->dev, "warn: can't find PCM with DAI ID %d\n",
+				     rtd->dai_link->id);
+		return 0;
+	}
+
+	stream = &spcm->stream[substream->stream];
+	ret = snd_sof_ipc_msg_data(sdev, stream, &posn, sizeof(posn));
+	if (ret < 0) {
+		dev_warn(sdev->dev, "failed to read stream position: %d\n", ret);
+		return 0;
+	}
+
+	memcpy(&stream->posn, &posn, sizeof(posn));
+	pos = spcm->stream[substream->stream].posn.host_posn;
+	pos = bytes_to_frames(substream->runtime, pos);
+
+	return pos;
+}
+
+static void mt8196_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
+{
+	u32 dbg_pc, dbg_data, dbg_inst, dbg_ls0stat, dbg_status, faultinfo;
+
+	/* dump debug registers */
+	dbg_pc = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGPC);
+	dbg_data = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGDATA);
+	dbg_inst = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGINST);
+	dbg_ls0stat = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGLS0STAT);
+	dbg_status = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGSTATUS);
+	faultinfo = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PFAULTINFO);
+
+	dev_info(sdev->dev, "adsp dump : pc %#x, data %#x, dbg_inst %#x,",
+		 dbg_pc, dbg_data, dbg_inst);
+	dev_info(sdev->dev, "ls0stat %#x, status %#x, faultinfo %#x",
+		 dbg_ls0stat, dbg_status, faultinfo);
+
+	mtk_adsp_dump(sdev, flags);
+}
+
+/*
+ * DL_24CH, DL1, UL0, UL1, UL2 are registered as SOF FE, so creating the corresponding
+ * SOF BE to complete the pipeline.
+ */
+static struct snd_soc_dai_driver mt8196_dai[] = {
+{
+	.name = "SOF_DL_24CH",
+	.playback = {
+		.channels_min = CHAN_MIN,
+		.channels_max = CHAN_MAX,
+	},
+},
+{
+	.name = "SOF_DL1",
+	.playback = {
+		.channels_min = CHAN_MIN,
+		.channels_max = CHAN_MAX,
+	},
+},
+{
+	.name = "SOF_UL0",
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+	},
+},
+{
+	.name = "SOF_UL1",
+	.capture = {
+		.channels_min = CHAN_MIN,
+		.channels_max = CHAN_MAX,
+	},
+},
+{
+	.name = "SOF_UL2",
+	.capture = {
+		.channels_min = CHAN_MIN,
+		.channels_max = CHAN_MAX,
+	},
+},
+};
+
+/* mt8196 ops */
+static struct snd_sof_dsp_ops sof_mt8196_ops = {
+	/* probe and remove */
+	.probe		= mt8196_dsp_probe,
+	.remove		= mt8196_dsp_remove,
+	.shutdown	= mt8196_dsp_shutdown,
+
+	/* DSP core boot */
+	.run		= mt8196_run,
+
+	/* Block IO */
+	.block_read	= sof_block_read,
+	.block_write	= sof_block_write,
+
+	/* Mailbox IO */
+	.mailbox_read	= sof_mailbox_read,
+	.mailbox_write	= sof_mailbox_write,
+
+	/* Register IO */
+	.write		= sof_io_write,
+	.read		= sof_io_read,
+	.write64	= sof_io_write64,
+	.read64		= sof_io_read64,
+
+	/* ipc */
+	.send_msg		= mt8196_send_msg,
+	.get_mailbox_offset	= mt8196_get_mailbox_offset,
+	.get_window_offset	= mt8196_get_window_offset,
+	.ipc_msg_data		= sof_ipc_msg_data,
+	.set_stream_data_offset = sof_set_stream_data_offset,
+
+	/* misc */
+	.get_bar_index	= mt8196_get_bar_index,
+
+	/* stream callbacks */
+	.pcm_open	= sof_stream_pcm_open,
+	.pcm_hw_params	= mt8196_pcm_hw_params,
+	.pcm_pointer	= mt8196_pcm_pointer,
+	.pcm_close	= sof_stream_pcm_close,
+
+	/* firmware loading */
+	.load_firmware	= snd_sof_load_firmware_memcpy,
+
+	/* Firmware ops */
+	.dsp_arch_ops = &sof_xtensa_arch_ops,
+
+	/* DAI drivers */
+	.drv		= mt8196_dai,
+	.num_drv	= ARRAY_SIZE(mt8196_dai),
+
+	/* Debug information */
+	.dbg_dump = mt8196_adsp_dump,
+	.debugfs_add_region_item = snd_sof_debugfs_add_region_item_iomem,
+
+	/* PM */
+	.suspend	= mt8196_dsp_suspend,
+	.resume		= mt8196_dsp_resume,
+
+	/* ALSA HW info flags */
+	.hw_info =	SNDRV_PCM_INFO_MMAP |
+			SNDRV_PCM_INFO_MMAP_VALID |
+			SNDRV_PCM_INFO_INTERLEAVED |
+			SNDRV_PCM_INFO_PAUSE |
+			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
+};
+
+static struct snd_sof_of_mach sof_mt8196_machs[] = {
+	{
+		.compatible = "mediatek,mt8196",
+		.sof_tplg_filename = "sof-mt8196.tplg",
+	},
+	{}
+};
+
+static const struct sof_dev_desc sof_of_mt8196_desc = {
+	.of_machines = sof_mt8196_machs,
+	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
+	.ipc_default		= SOF_IPC_TYPE_3,
+	.default_fw_path = {
+		[SOF_IPC_TYPE_3] = "mediatek/sof",
+	},
+	.default_tplg_path = {
+		[SOF_IPC_TYPE_3] = "mediatek/sof-tplg",
+	},
+	.default_fw_filename = {
+		[SOF_IPC_TYPE_3] = "sof-mt8196.ri",
+	},
+	.nocodec_tplg_filename = "sof-mt8196-nocodec.tplg",
+	.ops = &sof_mt8196_ops,
+};
+
+static const struct of_device_id sof_of_mt8196_ids[] = {
+	{ .compatible = "mediatek,mt8196-dsp", .data = &sof_of_mt8196_desc},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sof_of_mt8196_ids);
+
+/* DT driver definition */
+static struct platform_driver snd_sof_of_mt8196_driver = {
+	.probe = sof_of_probe,
+	.remove = sof_of_remove,
+	.shutdown = sof_of_shutdown,
+	.driver = {
+	.name = "sof-audio-of-mt8196",
+		.pm = &sof_of_pm,
+		.of_match_table = sof_of_mt8196_ids,
+	},
+};
+module_platform_driver(snd_sof_of_mt8196_driver);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_DESCRIPTION("SOF support for MT8196 platforms");
+MODULE_IMPORT_NS("SND_SOC_SOF_XTENSA");
+MODULE_IMPORT_NS("SND_SOC_SOF_MTK_COMMON");
diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.h b/sound/soc/sof/mediatek/mt8196/mt8196.h
new file mode 100644
index 000000000000..ac2d5a7683e1
--- /dev/null
+++ b/sound/soc/sof/mediatek/mt8196/mt8196.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Author: Hailong Fan <hailong.fan@mediatek.com>
+ */
+
+#ifndef __MT8196_H
+#define __MT8196_H
+
+struct mtk_adsp_chip_info;
+struct snd_sof_dev;
+
+#define DSP_REG_BAR			4
+#define DSP_SECREG_BAR			5
+#define DSP_BUSREG_BAR			6
+#define CHAN_MIN			1
+#define CHAN_MAX			2
+
+/*****************************************************************************
+ *                  R E G I S T E R       TABLE
+ *****************************************************************************/
+/* dsp cfg */
+#define ADSP_CFGREG_SW_RSTN		0x0000
+#define SW_DBG_RSTN_C0			BIT(0)
+#define SW_RSTN_C0			BIT(4)
+#define ADSP_IO_CONFIG			0x000C
+#define ADSP_CLK_SEL			BIT(31)
+#define ADSP_HIFI_RUNSTALL		0x0108
+#define TRACEMEMREADY			BIT(15)
+#define RUNSTALL			BIT(12)
+#define ADSP_IRQ_MASK			0x0030
+#define ADSP_DVFSRC_REQ			0x0040
+#define ADSP_DDREN_REQ_0		0x0044
+#define ADSP_SEMAPHORE			0x0064
+#define ADSP_WDT_CON_C0			0x007C
+#define ADSP_MBOX_IRQ_EN		0x009C
+#define DSP_MBOX0_IRQ_EN		BIT(0)
+#define DSP_MBOX1_IRQ_EN		BIT(1)
+#define DSP_MBOX2_IRQ_EN		BIT(2)
+#define DSP_MBOX3_IRQ_EN		BIT(3)
+#define DSP_MBOX4_IRQ_EN		BIT(4)
+#define DSP_PDEBUGPC			0x013C
+#define DSP_PDEBUGDATA			0x0140
+#define DSP_PDEBUGINST			0x0144
+#define DSP_PDEBUGLS0STAT		0x0148
+#define DSP_PDEBUGSTATUS		0x014C
+#define DSP_PFAULTINFO			0x0150
+#define ADSP_CK_EN			0x1000
+#define DMA1_EN				BIT(12)
+#define DMA_AXI_EN			BIT(13)
+#define UART_BT_EN			BIT(14)
+#define DMA_EN				BIT(4)
+#define UART_EN				BIT(5)
+#define ADSP_UART_CTRL			0x1010
+#define UART_BCLK_CG			BIT(0)
+#define UART_RSTN			BIT(3)
+
+/* dsp sec */
+#define ADSP_PRID			0x0
+#define ADSP_ALTVEC_C0			0x04
+#define ADSP_ALTVECSEL			0x0C
+#define MT8196_ADSP_ALTVECSEL_C0	1
+
+#define ADSP_ALTVECSEL_C0		MT8196_ADSP_ALTVECSEL_C0
+
+/* dsp bus */
+#define AUDIO_BUS_CFG_RSV_10		0x30
+#define ADSP_SRAM_POOL_CON		0x190
+#define ADSP_SRAM_POOL_ACK		0x1A0
+#define ADSP_SRAM_CHANNEL_NUM		6
+#define DSP_SRAM_POOL_PD_MASK		0xF00F /* [0:3] and [12:15] */
+#define DSP_C0_EMI_MAP_ADDR		0xA00  /* ADSP Core0 To EMI Address Remap */
+#define DSP_C0_DMAEMI_MAP_ADDR		0xA08  /* DMA0 To EMI Address Remap */
+#define AUDIO_BUS_CFG_BUS_REMAP_CTRL  0x016C
+#define AUDIO_BUS_DSP2EMI_REMAP0      0x0A00
+#define AUDIO_BUS_DSP2EMI_REMAP1      0x0A04
+#define AUDIO_BUS_DMA2EMI_REMAP0      0x0A08
+#define AUDIO_BUS_DMA2EMI_REMAP1      0x0A0C
+
+/* DSP memories */
+#define MBOX_OFFSET			0x500000 /* DRAM */
+#define MBOX_SIZE			0x1000   /* consistent with which in memory.h of sof fw */
+#define DSP_DRAM_SIZE			0x900000 /* 9M */
+
+/*remap dram between AP and DSP view, 4KB aligned*/
+#define SRAM_PHYS_BASE_FROM_DSP_VIEW	0x4e100000 /* MT8196 DSP view */
+#define DRAM_PHYS_BASE_FROM_DSP_VIEW	0x90000000 /* MT8196 DSP view */
+#define DRAM_REMAP_SHIFT		12
+#define DRAM_REMAP_MASK			0xFFF
+ /* remap */
+#define ADSP_REMAP_REGION
+#define ADSP_EMI_REMAP_SET_TOTAL    (4)
+#define EMI_REMAP_REGION			(AUDIO_BUS_CFG_RSV_10)
+#define EMI_REMAP_REPLACE			(AUDIO_BUS_DSP2EMI_REMAP0)
+#define EMI_REMAP_EN				(1U)
+#define ROUNDUP(a, b)				(((a) + ((b)-1)) & ~((b)-1))
+#define MIX_BEGIN_AND_END_ADDR(begin, end)		\
+					(((begin >> 16) & 0xFFFF) | (end & 0xFFFF0000))
+#define ADSP_REMAP_REGION_FROM(start, size)		MIX_BEGIN_AND_END_ADDR(start, \
+							ROUNDUP((start + size), 0x10000))
+#define ADSP_REMAP_REGION_TO(start)		((start >> 25) << 9)
+
+#define SIZE_SHARED_DRAM_DL			0x40000 /*Shared buffer for Downlink*/
+#define SIZE_SHARED_DRAM_UL			0x40000 /*Shared buffer for Uplink*/
+#define TOTAL_SIZE_SHARED_DRAM_FROM_TAIL	(SIZE_SHARED_DRAM_DL + SIZE_SHARED_DRAM_UL)
+
+void mt8196_sof_hifixdsp_boot_sequence(struct snd_sof_dev *sdev, u32 boot_addr);
+void mt8196_sof_hifixdsp_shutdown(struct snd_sof_dev *sdev);
+#endif
-- 
2.45.2


