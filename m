Return-Path: <linux-kernel+bounces-189560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF7C8CF1FF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 01:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5163B1C20F6D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 23:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFDE129E92;
	Sat, 25 May 2024 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BIt9lobx"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB23B297;
	Sat, 25 May 2024 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716678507; cv=none; b=ZJV5grztr8cWigzxwk4g1BzhQem/J5qKshalmG6vimnUCofQXb/j/4Y3r9PXYcRrUS/vuDG/8ISgDj/O9ZwYNhzngeatsGTjsumgfiKe9DR5GPUDR099HzU0mHfRSljSqAoZ0Ge7IfnGvc6RlqnkIeYXc9XD+ZCZoON7pCtjQL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716678507; c=relaxed/simple;
	bh=roqVaYWdQf77QaOYdnLuCaahuQfbvw7j0isXQ2rLQJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M/iJJwKCf2I7TXei2H+lo6JNP574IMD0xI5blt0/PD4rWkDJ9yObTnpDgUJ4m6ZBvxgoHzfkFtjZox+vb9J3ncg0GcE6kwC7CBEITBmWEMzizuWDggd8J5ZaNsXN24VrvKn5pLkqKcMpBAW0rLFUEkwR+Ax+kpWu2ek3moT2CMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BIt9lobx; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a8f28b641aeb11ef8c37dd7afa272265-20240526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5iqv6x/ghbzUOX83DTvSQ+4xvQ/d9I2EOAPbwfRk/TA=;
	b=BIt9lobxCDc3Yfswvfu3deKDNhuc2iKHp7pemHak/eZXeK5ITaqDmjMy1CHqXkVVxvkTn1pI8zKdTkYG4V2r9aKDvwYB2ginqRnj1NJBVGyFZraTpUzHokh/PoxkAE8ypYK4yac2HooTMxbFCrsuq0TZKdwi7zDepGoAR+S42sc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1976d482-b671-41a3-8bdb-d76c20bdc56b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:c7f1cf87-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: a8f28b641aeb11ef8c37dd7afa272265-20240526
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1822441264; Sun, 26 May 2024 07:08:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 26 May 2024 07:08:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 26 May 2024 07:08:11 +0800
From: Jason-JH.Lin <jason-jh.lin@mediatek.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>, Chun-Kuang Hu
	<chunkuang.hu@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Conor Dooley <conor+dt@kernel.org>, Jason-ch Chen
	<jason-ch.chen@mediatek.com>, "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>, Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <dri-devel@lists.freedesktop.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v6 2/8] dt-bindings: mailbox: Add property for CMDQ secure driver
Date: Sun, 26 May 2024 07:08:04 +0800
Message-ID: <20240525230810.24623-3-jason-jh.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
References: <20240525230810.24623-1-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

1. Add mboxes property to define a GCE loopping thread as a secure IRQ
handler.
The CMDQ secure driver requests a mbox channel and sends a looping
command to the GCE thread. The looping command will wait for a secure
packet done event signal from secure world and then jump back to the
first instuction. Each time it waits for an event, it notifies the
CMDQ driver to perform the same action as the IRQ handler.

2. Add gce-events property from gce-props.yaml to define a
secure packet done signal in secure world.
There are 1024 events IDs for GCE to use to execute instructions in
the specific event happened. These events could be signaled by HW or SW
and their value would be different in different SoC because of HW event
IDs distribution range from 0 to 1023.
If we set a static event ID: 855 for mt8188, it might be conflict the
event ID original set in mt8195.
So we define an event ID that will be set when GCE runs to the end of
secure cmdq packet in the secure world.

This can reduce the latency of software communication between normal
world and secure world. In addition, we can also remove the complex
logic after the secure packet done in the secure world.

Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
---
 .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
index cef9d7601398..6e5e848d61d9 100644
--- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
@@ -49,6 +49,10 @@ properties:
     items:
       - const: gce
 
+  mboxes:
+    items:
+      - description: GCE looping thread as a secure IRQ handler
+
 required:
   - compatible
   - "#mbox-cells"
@@ -57,6 +61,8 @@ required:
   - clocks
 
 allOf:
+  - $ref: /schemas/mailbox/mediatek,gce-props.yaml#
+
   - if:
       not:
         properties:
@@ -67,7 +73,7 @@ allOf:
       required:
         - clock-names
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.18.0


