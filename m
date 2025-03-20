Return-Path: <linux-kernel+bounces-569114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D1AA69EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6EF1894D04
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E421EB9F3;
	Thu, 20 Mar 2025 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="e+XDd+qZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9B149DFF;
	Thu, 20 Mar 2025 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440726; cv=none; b=c0UGDx0mbDsGLhn0X74z1lNC3cs5Wa48ku7Yqs6avYF+FaHBmevCzKR/c8IbAXFKVyEwQBkxTMb2Cd5jj1gX7XdwTuVLvVPnx9Cc97rgMNilb2JHirkvYSmvKwMHhNoEl1+o1s1yEeLdrCdo3OaAMtg49WTUjXUJIryyxZIx8Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440726; c=relaxed/simple;
	bh=bl50Ftiuo0Lw0u62jeSenOkLcpE5ZP0Qj+A71bP/pV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv74U7sVbjcyHY2E9rOsLOxlOu1lboasJ7uC4Ok8Q0+p6lJvScxUVh4tP5lhjyI45TTsG9m2Qy4rJ/ZYoaYV3SZrsBiMQOkvDT1AKZBPTcWsO9+eiSl/yi0RurMA6KXWGG7i1YZDXAeWGTr0lBc0ySvb+mf33J+1SswlqYjXat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=e+XDd+qZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0194c2da053a11f0aae1fd9735fae912-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Dc8FTTmQUPssSR+0L7w8BIPfBM922jSVMcz1txzmmtc=;
	b=e+XDd+qZ8hEBvIarcPnYfcv7+1c7wvcEOHLLV3HxUatZ23U9cgIySy32qtTIjneTe47ZcP/W+Hfhckf4xgqzam3a4TBH/ShcoPgMvrGchXUncQ/XHxh9wXTFaU5e01bc8dxrtKZ66xYAaXEJL0x/3HK22v7IOm9rTdFzGpYUncY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:f27e2057-8b94-4244-b603-60c9c8ed0600,IP:0,UR
	L:25,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:a2bf554a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 0194c2da053a11f0aae1fd9735fae912-20250320
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 830583470; Thu, 20 Mar 2025 11:18:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 11:18:32 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 11:18:31 +0800
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
Subject: [PATCH 2/2] dt-bindings: dsp: mediatek: add mt8196 dsp document
Date: Thu, 20 Mar 2025 11:17:25 +0800
Message-ID: <20250320031753.13669-3-hailong.fan@mediatek.com>
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

This patch adds mt8196 dsp document. The dsp is used for Sound Open
Firmware driver node. It includes registers,  clocks, memory regions,
and mailbox for dsp.

Signed-off-by: hailong.fan <hailong.fan@mediatek.com>
---
 .../bindings/dsp/mediatek,mt8196-dsp.yaml     | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml

diff --git a/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
new file mode 100644
index 000000000000..62bcd97bd0f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dsp/mediatek,mt8196-dsp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mediatek mt8196 DSP core
+
+maintainers:
+  - Hailong Fan <hailong.fan@mediatek.com>
+
+description: |
+  Some boards from mt8196 contain a DSP core used for
+  advanced pre- and post- audio processing.
+
+properties:
+  compatible:
+    const: mediatek,mt8196-dsp
+
+  reg:
+    items:
+      - description: Address and size of the DSP Cfg registers
+      - description: Address and size of the DSP SRAM
+      - description: Address and size of the DSP secure registers
+      - description: Address and size of the DSP bus registers
+
+  reg-names:
+    items:
+      - const: cfg
+      - const: sram
+      - const: sec
+      - const: bus
+
+  clocks:
+    items:
+      - description: mux for dsp clock
+      - description: 26M clock
+      - description: ADSP PLL clock
+
+  clock-names:
+    items:
+      - const: adsp_sel
+      - const: clk26m
+      - const: adsppll
+
+  power-domains:
+    maxItems: 1
+
+  mboxes:
+    items:
+      - description: mailbox for receiving audio DSP requests.
+      - description: mailbox for transmitting requests to audio DSP.
+
+  mbox-names:
+    items:
+      - const: rx
+      - const: tx
+
+  memory-region:
+    items:
+      - description: dma buffer between host and DSP.
+      - description: DSP system memory.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - power-domains
+  - mbox-names
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/mt8196-clk.h>
+    #include <dt-bindings/power/mt8196-power.h>
+    adsp: adsp@1a000000 {
+        compatible = "mediatek,mt8196-dsp";
+        reg = <0x1a000000 0x5000>,
+              <0x1a210000 0x80000>,
+              <0x1a345000 0x300>,
+              <0x1a00f000 0x1000>;
+        reg-names = "cfg", "sram", "sec", "bus";
+        power-domains = <&scpsys MT8196_POWER_DOMAIN_ADSP_TOP_DORMANT>;
+        clocks = <&cksys_clk CLK_CK_ADSP_SEL>,
+                 <&cksys_clk CLK_CK_TCK_26M_MX9>,
+                 <&cksys_clk CLK_CK_ADSPPLL>;
+        clock-names = "adsp_sel",
+                      "clk26m",
+                      "adsppll";
+        mbox-names = "rx", "tx";
+        mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
+    };
-- 
2.45.2


