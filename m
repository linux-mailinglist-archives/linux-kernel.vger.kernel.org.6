Return-Path: <linux-kernel+bounces-521226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1998A3B992
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277823BD032
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6101E131B;
	Wed, 19 Feb 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YHrxDM5D"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354E1E2853;
	Wed, 19 Feb 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956879; cv=none; b=mg8op4E3fCK3rdlm5k6N2eSqPCvW4mJ827RDlyT6N/NkWppnkA21ElYh7GdBTdfTBJ2jaifDEueCH+CV6B7uN7wcFf8OTUeS78cAOjiNWYKkDEI1vJGd0r55a3Qz018pyMQ+8QlW9N+k5fDiwiNDtoc98qiek01I7wJZoHD2X6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956879; c=relaxed/simple;
	bh=XVMKXuhbJt/G/OVCs7SX3u5Lhwl9MMTRPHx3ZHjonZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBPYRbx57MsqAiqRY0awM+TdTfBieBY6/eoJgBgAOcL5UO/2hgrcUGKCgZD0ViuDVbV5W9/p7Ll3qMkB/19nACYMDAnF/54gQcXJG25RgiHMI/nZKHfkS8nlGrSU8rvVXNPu2dUr1IJVEEZYadQVdrtZS/9tfdKITgGREK0U2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YHrxDM5D; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dab8dd8eeea211ef8eb9c36241bbb6fb-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=uM3a/hh8+kNs9gIHDDILrZB8EPPcnXIjNDj3pFqq6K4=;
	b=YHrxDM5DZ1m5+MX9IUxE8+4tI/Rb1XDvNs8++BX3ug86xhsQgy515c8XKKk26NlxK/oxsPceHZmXUIORQhsDxd6LvR8Vuf2ocWURZMXtCHHy5zxWUImzN/n7vLabcZcQLOqp1InF57VcdjHHLwr4vGlkHuYYYirvhGfOF3DjawU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:76bf51d3-fda4-4970-a720-1f6b4e9b59b1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:5e304ca4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dab8dd8eeea211ef8eb9c36241bbb6fb-20250219
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1162297104; Wed, 19 Feb 2025 17:21:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 17:21:08 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 17:21:07 +0800
From: Jay Liu <jay.liu@mediatek.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Yongqiang Niu
	<yongqiang.niu@mediatek.com>, CK Hu <ck.hu@mediatek.com>, Hsin-Yi Wang
	<hsinyi@chromium.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Jay Liu
	<jay.liu@mediatek.com>
Subject: [PATCH 5/7] dt-bindings: display: mediatek: dither: Add support for MT8196
Date: Wed, 19 Feb 2025 17:20:38 +0800
Message-ID: <20250219092040.11227-6-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20250219092040.11227-1-jay.liu@mediatek.com>
References: <20250219092040.11227-1-jay.liu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Add a compatible string for MediaTek MT8196 SoC

Signed-off-by: Jay Liu <jay.liu@mediatek.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,dither.yaml    | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index abaf27916d13..1f1719228b5d 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -31,6 +31,7 @@ properties:
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
               - mediatek,mt8365-disp-dither
+              - mediatek,mt8196-disp-dither
           - const: mediatek,mt8183-disp-dither
 
   reg:
-- 
2.18.0


