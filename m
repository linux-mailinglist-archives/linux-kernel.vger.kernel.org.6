Return-Path: <linux-kernel+bounces-516115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4497A36D14
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D54518949BF
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67BCE1A0739;
	Sat, 15 Feb 2025 09:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u2Qxo6sZ"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00B41373;
	Sat, 15 Feb 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612660; cv=none; b=WOD3eadJnTziWFhmcWulT5i3c0qTqKA6pvEwZnox4FaN0OGYOSv+wMNRRjcwvpAeGiL9KPD8zBLhpfzVvjx/lldBiAndKy2fBFALACCSKmCz5ekxhU0kv1qZOky051T/7vm4GMvrxIoYi7wFhmMnnssvp6+TlDpf2f3yho0gjJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612660; c=relaxed/simple;
	bh=klFDNl5ibN2LYZV7rawVc8ArBz1pzd0G5zUp9fD4Jis=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PzCjrlztqLK87K8lm1pLRcI5q4COpHMGK/bwEkBnQCGuVARquYEJyrW/P7862CnE8LWCvZlckiygAQGFLZ44bfbGSl/BghZMdpB67ePoygbd+GrtIhbN5CmFjGiZ1vuEcFjkQ3LqIbmSRwkFmPCL/kdSmsmaHq8tAMFWYAZnoUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=u2Qxo6sZ; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 6a6f6dc8eb8111efb8f9918b5fc74e19-20250215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=lylOz1zkmHmL7bwHexXM/NNT7naRcFl+fFhZuU5zA5I=;
	b=u2Qxo6sZW0Z/9ifk8xQwNUQX+XtjAWN9uTMiABNzPeGFy/PL2SQZa7Rkj8biNZNx/V+pub/61f5Nc4ybEiqlMbXX7BLG5M/RdrUQ85F6HFW0j7X4nXv8AeLhJcanl0oN5rEu2RyEJiTQA4+z0uUsSoVASAn8dM1S0nOT+S2C5QQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:d1ddf522-b0b4-458f-98ea-7cd411546f66,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:b6f9cb24-96bd-4ac5-8f2e-15aa1ef9defa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 6a6f6dc8eb8111efb8f9918b5fc74e19-20250215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 115243661; Sat, 15 Feb 2025 17:44:14 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 15 Feb 2025 17:44:12 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 15 Feb 2025 17:44:12 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: phy: mediatek,xsphy: add property to set disconnect threshold
Date: Sat, 15 Feb 2025 17:44:09 +0800
Message-ID: <20250215094410.547-1-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Add a property to tune usb2 phy's disconnect threshold.
And add a compatible for mt8196.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: add Reviewed by Angelo
---
 Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
index a9e3139fd421..2e012d5e1da1 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,xsphy.yaml
@@ -49,6 +49,7 @@ properties:
       - enum:
           - mediatek,mt3611-xsphy
           - mediatek,mt3612-xsphy
+          - mediatek,mt8196-xsphy
       - const: mediatek,xsphy
 
   reg:
@@ -129,6 +130,13 @@ patternProperties:
         minimum: 1
         maximum: 7
 
+      mediatek,discth:
+        description:
+          The selection of disconnect threshold (U2 phy)
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 1
+        maximum: 15
+
       mediatek,efuse-intr:
         description:
           The selection of Internal Resistor (U2/U3 phy)
-- 
2.46.0


