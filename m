Return-Path: <linux-kernel+bounces-379581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B11F9AE0BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0AC12851AC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B6F1B3935;
	Thu, 24 Oct 2024 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KyFx+V7z"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DC1B392A;
	Thu, 24 Oct 2024 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762018; cv=none; b=PUvQPxBI6rjMPRYOK1X7hXe67daHFcx/PysDmHs32OfkS3ktdRfehUDzWcnL8UZI4YVtwr0IQT5F7EjyQyC+HUw1UipfCp1yYlctOFcWTnPFQU3W40qL9Q9Ppz28ldPeTj4f0YmEgTtFH2UGaPl/wr1QbRNtraDGLAjFUmY4wLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762018; c=relaxed/simple;
	bh=U4+lAqQi8/KgkXdySdPpH2mQd467QA1SQF8lQ3CLhIM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVj2BXwxeySC84Vr5jmSXiR8RkuUaTblmOxum1fnOjRpJ9y+HoJle18j+pT+RhK+0Amc59UP4+Gl+tCx+qwM+VHX69ExAIztI/s7szs+0l8pR9Va4evAwyHHEDQn3q20EiAWry25tccbfw8R7I5GNQgF57pSbsclubi6RBRaykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=KyFx+V7z; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 19ef994a91ea11efbd192953cf12861f-20241024
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=lRU6xMS4dEefnhGsln0x8bEQy8mZTyh/nEdKYPEt8C4=;
	b=KyFx+V7zzoGalYgBrHT+oG6Xp12RqZLlyE5vzHprPG8rZ/ImeZn+WiiLkMqQrqcb36JQZl3AVAkQI2tocL8WX5Dfod6Y/jWNJHEHw5T2ClcMPaBFAyZv8opLvQZF8hYnrXY+dj+BlKrxi1R4RbQ1gmpQ1mvpR9VYtlNuJJma3jw=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.42,REQID:543021ee-76da-4524-a72b-8fb6f5be6939,IP:0,U
	RL:25,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
	TION:quarantine,TS:125
X-CID-META: VersionHash:b0fcdc3,CLOUDID:602dcccc-110e-4f79-849e-58237df93e70,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:801,TC:nil,Content:3,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 19ef994a91ea11efbd192953cf12861f-20241024
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <karl.li@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 780560753; Thu, 24 Oct 2024 17:26:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 24 Oct 2024 17:26:47 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 24 Oct 2024 17:26:47 +0800
From: Karl.Li <karl.li@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Karl Li <Karl.Li@mediatek.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Chungying Lu <chungying.lu@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Karl Li
	<karl.li@mediatek.com>
Subject: [PATCH 1/3] dt-bindings: mailbox: mediatek: Add apu-mailbox document
Date: Thu, 24 Oct 2024 17:25:43 +0800
Message-ID: <20241024092608.431581-2-karl.li@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024092608.431581-1-karl.li@mediatek.com>
References: <20241024092608.431581-1-karl.li@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--13.460500-8.000000
X-TMASE-MatchedRID: YXgS1C6OPWx/dZAjNXEbFgPZZctd3P4BWjWsWQUWzVoCsxyhR8y7CQaT
	alM8C773wvUxdKBGcQwRA4hwIn2MDY2WQSzu3zX3T7jCYv2QJPG7atxTbKDEIPufvd3T2+v3oAW
	Nnmn5m56Neg5tL2+jnh12U5je5b4a7bdBxC9wVFeBlNt4VSGvIV3HHpZF/7mweuOjdf174McfPl
	xxE3mQszYLbDMMWtWewKX8fpO+yjINsM5qvTUs054CIKY/Hg3AaZGo0EeYG978V77yhJRgo99pj
	zubZ2rHwrbXMGDYqV8kL2NLniq3NVDiHpFdHheQuDMYOBqTn6YXj2OqpTl9ta7mcBhy8Pft
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.460500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	DBEC2FDE3AEB68C307DBA82FD95F9BB603F9FAFD5EF28C10EC52C826E39BFB0E2000:8

From: Karl Li <karl.li@mediatek.com>

Add apu-mailbox dt-binding document.

Signed-off-by: Karl Li <karl.li@mediatek.com>
---
 .../mailbox/mediatek,apu-mailbox.yaml         | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
new file mode 100644
index 000000000000..cb4530799bef
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,apu-mailbox.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mailbox/mediatek,apu-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek APU mailbox
+
+maintainers:
+  - Karl Li <Karl.Li@mediatek.com>
+
+description:
+  The MediaTek APU-Mailbox facilitates communication with the
+  APU microcontroller. Within the MediaTek APU subsystem, a
+  message passing mechanism is built on top of the mailbox system.
+  The mailbox only has limited space for each message. The firmware
+  expects the message header from the mailbox, while the message body
+  is passed through some fixed shared memory.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8188-apu-mailbox
+      - mediatek,mt8196-apu-mailbox
+
+  "#mbox-cells":
+    const: 1
+    description:
+      The cell describe which channel the device will use.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#mbox-cells"
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    apu_mailbox: mailbox@4c200000 {
+      compatible = "mediatek,mt8196-apu-mailbox";
+      reg = <0 0x4c200000 0 0xfffff>;
+      interrupts = <GIC_SPI 638 IRQ_TYPE_LEVEL_HIGH 0>;
+      #mbox-cells = <1>;
+    };
-- 
2.18.0


