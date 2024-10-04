Return-Path: <linux-kernel+bounces-349971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A5198FE10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC8282933
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1587813A868;
	Fri,  4 Oct 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m5YIBeqy"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328922EF0;
	Fri,  4 Oct 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728028206; cv=none; b=ZPYEjhKnYGi/8KO0dl3SmvNz7TXUOO40ulWcsaIXggwn0qmGNIa/OBAtAc3+bNY2xHBMy/PHYngkmNMS7Qiep4zQFaKuZ97SAeE/0E1WO4cMBsW98uAs2vXtApHsrnE62LayWUDv1/2CkQvbtlTFRyDC1nCfxVAjFgIzKVDQglE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728028206; c=relaxed/simple;
	bh=2YNZy+PdWFS2aPMYJOfFJ0eWPZwXlsQQWuiD/KarH60=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fsM2/bhJKMiXfFQCNDPLm1NURzsCi6iIA9JZU7xPQ+NuhubYvi/zo7+FVTADztBvfOe6hjkgCZ0s16OhASh4112g58orvl2lPJW6NM7mTelMajOpRUQIwIZQIVgui4qieKjZaVB+Y+ztay8My2rfWf+xxp2O1kHUPuB96QeJOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=m5YIBeqy; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 40547134822511efb66947d174671e26-20241004
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gnqkDbmzWlsqBGGV2jWV2TwelPd0ktIYHv7wQSsrf5o=;
	b=m5YIBeqydpsRUjIiZdDg9P5sDn7dj3xNhts3QI6msg6lQXzzduYmOrLVryNPKR4AhgtHdxU5+bDv5+GkWzleTaQPMmSro0WC20nlTFWCqQYaW2kuEcPH0+kw/bNTiB3iYsoFOa/lUqccPwa/Mh+Bj3v0hRuN6lbeZZa3fAdFmDI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:9dc669df-9892-444f-9cf7-d1264891ce95,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:6dc6a47,CLOUDID:5884be40-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 40547134822511efb66947d174671e26-20241004
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 680921914; Fri, 04 Oct 2024 15:49:57 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 4 Oct 2024 15:49:55 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 4 Oct 2024 15:49:55 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>, "Sen
 Chu" <sen.chu@mediatek.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH] dt-bindings: power: mediatek: Refine multiple level power domain nodes
Date: Fri, 4 Oct 2024 15:49:38 +0800
Message-ID: <20241004074938.6571-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.217600-8.000000
X-TMASE-MatchedRID: 56eCqOszUJp+YhdyenZTz5dc7I2df+msLJXjpJzQSNPfc2Xd6VJ+ymja
	/2LEydj5j6kCfX0Edc5Si65s7OsML1xxDx5qbkR9FEUknJ/kEl7dB/CxWTRRu4as+d5/8j56JJg
	JbsOusyW/vimt0hT5DclJq5M3pM6Ryj1crLYUwy1Zny+h5/IYMg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.217600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E97C1C3C5E2E3C760AEEF27B5F22FDC67E88EE9BC45F9462AFD2C36985979F932000:8
X-MTK: N

Extract duplicated properties and support more levels of power
domain nodes.

This change fix following error when do dtbs_check,
  mt8390-genio-700-evk.dtb:
    power-controller: power-domain@15:power-domain@16:power-domain@29:power-domain@30:
    Unevaluated properties are not allowed ('power-domain@31', 'power-domain@32'
    were unexpected)

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../devicetree/bindings/power/mediatek,power-controller.yaml  | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
index 8985e2df8a56..a7df4041b745 100644
--- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
+++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
@@ -54,6 +54,10 @@ patternProperties:
             patternProperties:
               "^power-domain@[0-9a-f]+$":
                 $ref: "#/$defs/power-domain-node"
+                patternProperties:
+                  "^power-domain@[0-9a-f]+$":
+                    $ref: "#/$defs/power-domain-node"
+                    unevaluatedProperties: false
                 unevaluatedProperties: false
             unevaluatedProperties: false
         unevaluatedProperties: false
-- 
2.45.2


