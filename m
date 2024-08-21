Return-Path: <linux-kernel+bounces-295135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE26D959773
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BEF1C206A3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550681C4EFB;
	Wed, 21 Aug 2024 08:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="R7lBLD5F"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A975E1B2EDA;
	Wed, 21 Aug 2024 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724228957; cv=none; b=GuyQq1QsabqY9a4AJCU3WNKGVbrcGqkcTffY9k/pznoS7M91H9LUj81IH/kSLg2ywqXaHb84Wcs4l4HK0vBn0adfUpQgg+y0XJSPWRJiqVHmeJtMVzApz13z8/A1h+DAJZreSerm0Od6kLTiGWvaurPBwBGiCUfkX4PYYAb/unU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724228957; c=relaxed/simple;
	bh=monv1sfMnChfbIt/NuI7LwukHNbqPEOuUJPTaJruz6g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sViiRKZ6fpnYd7xOWI4FBXkH79Qmj4mCeCkyrp3+D6IbHeBTm464YHUMPOgtQGHolSZqR/LbPsGJYiUadf5xx3CxM1yUq5X8QsOchyO6cEXjUb7sEZI+jujPTtRNeaTX6Grdryw4ivwHRe5U2cS8Jly1GSTUDwWVsvX0qqaNsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=R7lBLD5F; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6b8792a65f9711ef8b96093e013ec31c-20240821
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9dWeFxAg2xqXsmzDG1ltKi5lpCetx2eU857d2YS9e1I=;
	b=R7lBLD5FfFIG3XsLBblwikB1qrejib1tlmHOPOfNqrbhR50HctKQUsJ4UaMi7dz1xE4WJhbQIMrxAez650CI3TbzNecazfxcKR7bmc0fSdyUwjt2j8ZYNl+wsqW5B4rR6ipUw6rUipGM/zMDDeUwW6AzQ8bIJhwQ1iyFPj3m/Z0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:6957e150-7c53-4de5-8bc2-cf23612200dc,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:79e2ca5b-248b-45cb-bde8-d789f49f4e1e,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6b8792a65f9711ef8b96093e013ec31c-20240821
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <friday.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 134779627; Wed, 21 Aug 2024 16:29:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Aug 2024 16:29:02 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Aug 2024 16:29:01 +0800
From: friday.yang <friday.yang@mediatek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Yong Wu <yong.wu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	Friday Yang <friday.yang@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 2/4] dt-bindings: memory: mediatek: Add smi-sub-common property for reset
Date: Wed, 21 Aug 2024 16:26:50 +0800
Message-ID: <20240821082845.11792-3-friday.yang@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821082845.11792-1-friday.yang@mediatek.com>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

On the MediaTek platform, some SMI LARBs are directly linked to SMI
common. While some SMI LARBs are linked to SMI sub common, then SMI
sub common is linked to SMI common. Add 'mediatek,smi-sub-comm' and
'mediatek,smi-sub-comm-in-portid' properties here. The SMI reset
driver could query which port of the SMI sub common the current LARB
is linked to through the two properties. The hardware block diagram
could be described as below.

             SMI Common(Smart Multimedia Interface Common)
                 |
         +----------------+-------
         |                |
         |                |
         |                |
         |                |
         |                |
       larb0       SMI Sub Common
                   |      |     |
                  larb1  larb2 larb3

Signed-off-by: friday.yang <friday.yang@mediatek.com>
---
 .../mediatek,smi-common.yaml                  |  2 ++
 .../memory-controllers/mediatek,smi-larb.yaml | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
index 2f36ac23604c..4392d349878c 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt8186-smi-common
           - mediatek,mt8188-smi-common-vdo
           - mediatek,mt8188-smi-common-vpp
+          - mediatek,mt8188-smi-sub-common
           - mediatek,mt8192-smi-common
           - mediatek,mt8195-smi-common-vdo
           - mediatek,mt8195-smi-common-vpp
@@ -107,6 +108,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - mediatek,mt8188-smi-sub-common
               - mediatek,mt8195-smi-sub-common
     then:
       required:
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
index 2381660b324c..5f162bb360db 100644
--- a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
@@ -69,6 +69,16 @@ properties:
     description: the hardware id of this larb. It's only required when this
       hardware id is not consecutive from its M4U point of view.
 
+  mediatek,smi-sub-comm:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: a phandle of smi_sub_common that the larb is linked to.
+
+  mediatek,smi-sub-comm-in-portid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 7
+    description: which port of smi_sub_common that the larb is linked to.
+
 required:
   - compatible
   - reg
@@ -125,6 +135,18 @@ allOf:
       required:
         - mediatek,larb-id
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - mediatek,mt8188-smi-larb
+
+    then:
+      required:
+        - mediatek,smi-sub-comm
+        - mediatek,smi-sub-comm-in-portid
+
 additionalProperties: false
 
 examples:
-- 
2.46.0


