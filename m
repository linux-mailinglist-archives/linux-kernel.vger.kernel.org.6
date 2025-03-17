Return-Path: <linux-kernel+bounces-563643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C1A645D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E5016A519
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A280A221720;
	Mon, 17 Mar 2025 08:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gEh1I/Kf"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DCD221560;
	Mon, 17 Mar 2025 08:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200795; cv=none; b=i/zDhNmjvavjaUizMsf+5lSQzz0DsNsffiHmKKyyQGJdBb+6V/Dkpc/K9zYjGZgpjxs2aWKNa79BnxsHw7nR1jemUIJCFscjTFAajt1InOX8bLh4AS9SFpa03Y8YQ1PkFB/eFzZc51bTe0Az9tn/Eck9zcbzLGY3iSbjAPl1XLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200795; c=relaxed/simple;
	bh=ebNv1DgdatEgzntyZ95OdFIGUMhBrxkKUEyNQS6jUSE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu8OwonhmCzyjFiJieBFq5PLiNs6yhtTwpVKrd8y8krEdxDO/NvyJyWZ32O24jgLkz6wpkVHFqXRvIy5Xwme0FRpHZAHkC4IGCnLBv+2pz/oJT5Q3s+dpe0HRHgqFzZZ7sNGEXH5KD3TF5aj1p7etvoW4c8O3Bl0262UQnrt3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gEh1I/Kf; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 61e070de030b11f08eb9c36241bbb6fb-20250317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=abBZBbHSvhhu4hHLFKPdPw4jefnWaOmy4oNAIAImzV8=;
	b=gEh1I/KfvuQwEGblrlRnEfA+ZD8xqfChFpP6u1j3Oc5KtifvIacS6EvorqUUSWGP9Xoi4w2f+rvybnKXJwsXtSrTLmfVXfmNbSmNbt4mFZnnhzjwJH+IzNajwkHhJONK7D2VKG6IeI0eFS+C1j8qLgkGsC5JpdhMahutOnxXxhw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:0ec54276-661a-4803-819b-62d99d62ddc4,IP:0,UR
	L:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:0ef645f,CLOUDID:8a756fc6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:11|83|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 61e070de030b11f08eb9c36241bbb6fb-20250317
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <jjian.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1845444860; Mon, 17 Mar 2025 16:39:47 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 17 Mar 2025 16:39:45 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 17 Mar 2025 16:39:44 +0800
From: Jjian Zhou <jjian.zhou@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>, Jjian Zhou <jjian.zhou@mediatek.com>
Subject: [PATCH RFC v2 3/3] dt-bindings: mailbox: mtk,vcp-mbox: add mtk vcp-mbox document
Date: Mon, 17 Mar 2025 16:38:09 +0800
Message-ID: <20250317083822.891-4-jjian.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250317083822.891-1-jjian.zhou@mediatek.com>
References: <20250317083822.891-1-jjian.zhou@mediatek.com>
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
 .../bindings/mailbox/mtk,mt8196-vcp-mbox.yaml | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
new file mode 100644
index 000000000000..bd1b024e22f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mtk,mt8196-vcp-mbox.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mtk,mt8196-vcp-mbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Video Companion Processor (VCP) mailbox
+
+maintainers:
+  - Jjian Zhou <Jjian.Zhou@mediatek.com>
+
+description:
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
+    mailbox@31b80000 {
+        compatible = "mediatek,mt8196-vcp-mbox";
+        reg = <0x31b80000 0x1000>;
+        interrupts = <GIC_SPI 789 IRQ_TYPE_LEVEL_HIGH 0>;
+        #mbox-cells = <0>;
+    };
-- 
2.45.2


