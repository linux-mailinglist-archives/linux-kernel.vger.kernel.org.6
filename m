Return-Path: <linux-kernel+bounces-546275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F38A4F8A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31871891681
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC321FCD17;
	Wed,  5 Mar 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="j6rN1eS+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A671F5850;
	Wed,  5 Mar 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162871; cv=none; b=mx9rZyXzbsjQMYRCsB3bmE654LIWKMrp9+Lgf3cbaQiSzBCkuzu+J7GWMqWszHuad6LiJPY5WQHQCdghlqGkYlQOYuMStbfR5qNe/vLSMML2wEVQSD0OO1ZJIQDvIrUkh1ordVwcfSVykBeQp5YFLGofKkljkpw0AMhjoV0gpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162871; c=relaxed/simple;
	bh=3ZhW+AhUyMOTb+n2Hb8xv6MnVZgS2qx20lZ82CUUZh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvLjcUIc0NdeKXG2bf4ZgGqHWwJhJT3f3rkr04HBbLUj1pHe+7NQ3OH42+PIW4BNRciPHk9xl83lwx3ZFIWqc+NmcfK+FUNS90xSJOkGN75df183dSlrUk56Cwmav/B6HYcD/LxMG/5bcmDbvt81G6oYSaAbQbAkGklmOkLIYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=j6rN1eS+; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: c384a10ef99a11efaae1fd9735fae912-20250305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KfxPaWGsAZSYsN3AQgx//cOpK/kMmXrN13zjrXyUlh4=;
	b=j6rN1eS+LLPIzBggOPVr9kpH1GMFR6hiDKzaoFWF85jwq6DaJuPikJCMTaZgDxkVwyTUshqB0Hx/bIiCkpDIXlnJLpSv4pMi3e52EA1G+FrVMJST8kSPV82XTO/buIPrURrUhxKqi85XsVw+U+OAp68i0M8GbywiXq5aYKD459g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0e9812fc-5235-47f8-8d8f-87f4c724789d,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:62caf1c5-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: c384a10ef99a11efaae1fd9735fae912-20250305
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 625336768; Wed, 05 Mar 2025 16:20:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 5 Mar 2025 16:20:55 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 5 Mar 2025 16:20:55 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk vcp-mbox document
Date: Wed, 5 Mar 2025 16:20:40 +0800
Message-ID: <20250305082047.15746-4-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250305082047.15746-1-jjian.zhou@mediatek.com>
References: <20250305082047.15746-1-jjian.zhou@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

This patch adds document for mediatek vcp mbox.

Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
---
 .../bindings/mailbox/mtk,vcp-mbox.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
new file mode 100644
index 000000000000..d5afe295af14
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk,vcp-mbox.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mtk,vcp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Video Companion Processor (VCP) mailbox
+
+maintainers:
+  - Jjian Zhou <Jjian.Zhou@mediatek.com>
+
+description: |
+  The MTK VCP mailbox enables the SoC to communicate with the VCP by passing
+  messages through 64 32-bit wide registers. It has 32 interrupt vectors in
+  either direction for signalling purposes.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8196-vcp-mbox
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  "#mbox-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    vcp_mailbox0: mailbox@31b80000 {
+        compatible = "mediatek,mt8196-vcp-mbox";
+        reg = <0x31b80000 0x1000>;
+        interrupts = <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
+        #mbox-cells = <0>;
+    };
-- 
2.45.2


