Return-Path: <linux-kernel+bounces-521220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFC0A3B95B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5403517BE60
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3928B1D88AC;
	Wed, 19 Feb 2025 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hyb504uA"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599181C4A06;
	Wed, 19 Feb 2025 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956859; cv=none; b=VGbXF228fshJJ8kFl5Uo8bSRd4pPoZ+5raf4ndKCyoSp75Shfp5dy7DVHFHQaXQUJCrWXJVU6NNPjItmXo/xjOPsrLaHfR4C+pwHu9N+8QJzGJD1i7pS75PWd9DNt6UDCv0HUz326yKMALTjxpRQYkx9C47NeYCsRolG338IGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956859; c=relaxed/simple;
	bh=MWig7AiwBvaGHoK+CGFxDEtpz9ZhHiW270zgJ+QbSHY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tqrlBMXk6VFm4iGB6qEHr+NI9iTqSGFlxJfAzi/U/Km5Ikw4D4zGISC0kXIKZ14HPFGvTShzFutDkBKHLqAq9tvJ2ACJUAgHY98Jhn1komxjQi7MOrm3fhyvbCmWneboVEZd7IImWFGOvutmcYbxBDQ2D63W7E2KFZhEFoAzmDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hyb504uA; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cffaaf58eea211ef8eb9c36241bbb6fb-20250219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PFZv3z4jR0cKH8tuf5xjGltFAPzbkhIXtmr8YZRX4Ak=;
	b=hyb504uAlN3JfcVfD5+Q0fLLA9YvO6vFGOfj/nbF6AtRPXqR6A1IBOKeihaOobgf6HQ4Stll27FBXbobEHZvOl2q9LvZSHvtwTGL1NEXFL+hEE0ZqursOk19tzSljSKg5pNvvogqn0WeemGcR+dhqQcIT8W2nxirI+oMBrQliRE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:5830d5c1-32f6-41e8-bfd3-f02df4ae1d5a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:60aa074,CLOUDID:5e2f4ca4-5c06-4e72-8298-91cabc9efadf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cffaaf58eea211ef8eb9c36241bbb6fb-20250219
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <jay.liu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1005354494; Wed, 19 Feb 2025 17:20:51 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 19 Feb 2025 17:20:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.28 via Frontend Transport; Wed, 19 Feb 2025 17:20:49 +0800
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
Subject: [PATCH 0/7] porting pq compnent for MT8196
Date: Wed, 19 Feb 2025 17:20:33 +0800
Message-ID: <20250219092040.11227-1-jay.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

add ccorr/dither/gamma/tdshp support for MT8196

This patch series id base on [1]
[1] Add components to support PQ in display path for MT8196
	- https://patchwork.kernel.org/project/linux-mediatek/list/?series=932469

Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jay Liu (7):
  drm/mediatek: Add CCORR component support for MT8196
  drm/mediatek: fix CCORR mtk_ctm_s31_32_to_s1_n function issue
  drm/mediatek: Add TDSHP component support for MT8196
  dt-bindings: display: mediatek: ccorr: Add support for MT8196
  dt-bindings: display: mediatek: dither: Add support for MT8196
  dt-bindings: display: mediatek: gamma: Add support for MT8196
  dt-bindings: display: mediatek: tdshp: Add support for MT8196

 .../display/mediatek/mediatek,ccorr.yaml      |  1 +
 .../display/mediatek/mediatek,dither.yaml     |  1 +
 .../display/mediatek/mediatek,gamma.yaml      |  1 +
 .../display/mediatek/mediatek,tdshp.yaml      | 51 ++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 61 ++++++++++++++++++-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  1 +
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     | 25 ++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  2 +
 8 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,tdshp.yaml

-- 
2.18.0


