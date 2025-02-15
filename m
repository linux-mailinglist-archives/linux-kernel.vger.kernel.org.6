Return-Path: <linux-kernel+bounces-516124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81472A36D32
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3801892A3E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C50F1A3160;
	Sat, 15 Feb 2025 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fu77did2"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0718C2ED;
	Sat, 15 Feb 2025 10:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613988; cv=none; b=i/OI+HIhiTMtcMq2d/DTbGNDoaHgDvZdtc/76uezLMH2a8MQ0m+T0+7L3PxM9cpE6onEM68HlVspZvgSp5ne+GVNT4Nprojzn/zxxRb7hnwSWiKmhE7mygoi6qj0b+fWObsQrVddxgFRXpLsyoIuYpon8VvSLKHupT/csrXhLuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613988; c=relaxed/simple;
	bh=qN9sqzBF8Wm+6uTGSVriIgBQyemhgwmom0TimKNH/w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=texjjM1rPx7asEl6KEG0sqSpth69mLHYdm3fGsjrZJncblEISM4rb8PzpZawrZLL0SrqVUfPn3iogyZpQdrGbSXgGadR2m6q552ER91vS+7ctDGG+DllQQeuwOewfTFQ8sScJsmMxanhNTgLbffV3xj5Xuv3f48qispJaFCR/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fu77did2; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 801471c0eb8411efb8f9918b5fc74e19-20250215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=v+EJ59sKfsvOAm5WdSxUyGZEDjYp1M4xybOklYuyeHg=;
	b=fu77did2raEuzRcT3h1MYDoVDr0fj/fnKEDqsnW+GpsYZcXcw5tWVXm78He8L18KYwQ4+Nh0fr1ELyGxAwuyojKdQ0MEU0V1o19Tu7zmPFmrC0kuS5Udx4dDqNFCb+wDANgn/GT+PY9GSSHIWIg1WiAD+slUTRBQ7QXBVgngKQQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:ef713562-0b45-401e-84a9-d54f1aad8ec5,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:60aa074,CLOUDID:11316988-f9ab-4ac1-951b-e3a689bed90c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 801471c0eb8411efb8f9918b5fc74e19-20250215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2031481686; Sat, 15 Feb 2025 18:06:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 15 Feb 2025 18:06:17 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Sat, 15 Feb 2025 18:06:16 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, Mathias Nyman <mathias.nyman@intel.com>,
	<linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/4] dt-bindings: usb: mtu3: add support mt8196
Date: Sat, 15 Feb 2025 18:06:12 +0800
Message-ID: <20250215100615.808-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250215100615.808-1-chunfeng.yun@mediatek.com>
References: <20250215100615.808-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

There are three USB controllers on mt8196, each controller's wakeup
control is different, add some specific versions for them, and add
compatilbe for mt8196.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: add the ommitted third dual-role controller
    add acked by Conor
v2: new patch for dual-role controllers
---
 Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
index d4e187c78a0b..aa411568704b 100644
--- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
+++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.yaml
@@ -28,6 +28,7 @@ properties:
           - mediatek,mt8188-mtu3
           - mediatek,mt8192-mtu3
           - mediatek,mt8195-mtu3
+          - mediatek,mt8196-mtu3
           - mediatek,mt8365-mtu3
       - const: mediatek,mtu3
 
@@ -188,7 +189,10 @@ properties:
             103 - used by mt8195, IP0, specific 1.03;
             105 - used by mt8195, IP2, specific 1.05;
             106 - used by mt8195, IP3, specific 1.06;
-          enum: [1, 2, 101, 102, 103, 105, 106]
+            107 - used by mt8196, IP0, specific 1.07;
+            108 - used by mt8196, IP1, specific 1.08;
+            109 - used by mt8196, IP2, specific 1.09;
+            enum: [1, 2, 101, 102, 103, 105, 106, 107, 108, 109]
 
   mediatek,u3p-dis-msk:
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.46.0


