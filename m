Return-Path: <linux-kernel+bounces-570988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997A1A6B79C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 10:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BFF3B465C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CA2206BB;
	Fri, 21 Mar 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pJYSvMk+"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D41F17E5;
	Fri, 21 Mar 2025 09:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742549706; cv=none; b=uF3oa2b3vKMDKUNGKw+aj7xS3Bq1CNAgFuAlgWigpeUBZCPijkpc23Yc5bGILGEXK+pRcLud1nNKnL7AhTdT3MqqBZTop2maYapTGVRU+rSKJbkZohburLe2sBJ66o7VT1OyDsFRLRRauiuslCfe75I5zBQG62eQks8P8OAaSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742549706; c=relaxed/simple;
	bh=8Lrt5ED8u/rQAJQ7OVXPJbaftuiKlagAIxz9Y2LQr70=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TZ11l65selLTIZ/fR6OKhUad9m6epmixJIzaCWtRnCFuk57Vd+IQkD+PVrx5NioS0gV3q34SBc4FKXp9TAAqWhhaMNck9i+3vyeEpoifLDrar2iEEXMdhojFMjcJ9GZjCtipnkYKbw5NUjyWfOZV8DDdq7QlpCGYIuwQHLIvHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pJYSvMk+; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: be78862c063711f0aae1fd9735fae912-20250321
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XyPNRArIQHbZFMHDFDMsDCGvKqnXw9QJroLE3H0ZOeU=;
	b=pJYSvMk+hFxURwYD6ONfnLVnnneXRI2HNDD1QfSPzKFjSYXiFVZDGmR4GVOX9Uar9REfZNLmMq7uipKPYEKMU3qPCR58JYCC3vEGswtO++cUgBDJI8boy5CTs0PqFg2lrjcUuZAtE3YQfMyg3lwFfSTuE4Xff+UthGLVZNamF+A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:ceffd49d-ce86-438c-a27b-8a82d40deb1c,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:1879a1c6-16da-468a-87f7-8ca8d6b3b9f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be78862c063711f0aae1fd9735fae912-20250321
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <paul-pl.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1805131538; Fri, 21 Mar 2025 17:34:53 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 21 Mar 2025 17:34:52 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 21 Mar 2025 17:34:52 +0800
From: paul-pl.chen <paul-pl.chen@mediatek.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<chunkuang.hu@kernel.org>, <angelogioacchino.delregno@collabora.com>
CC: <matthias.bgg@gmail.com>, <p.zabel@pengutronix.de>,
	<jason-jh.lin@mediatek.com>, <nancy.lin@mediatek.com>,
	<singo.chang@mediatek.com>, <xiandong.wang@mediatek.com>,
	<sirius.wang@mediatek.com>, <paul-pl.chen@mediatek.com>,
	<sunny.shen@mediatek.com>, <fshao@chromium.org>, <treapking@chromium.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v2 00/15] Add MediaTek SoC DRM support for MT8196
Date: Fri, 21 Mar 2025 17:33:29 +0800
Message-ID: <20250321093435.94835-1-paul-pl.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Paul-pl Chen <paul-pl.chen@mediatek.com>

This patch series adds support for the MediaTek MT8196 SoC's display
subsystem in the DRM driver.

Changes in v2:
- add support for MT8196's new hardware components (EXDMA, BLENDER, 
  OUTPROC) following the previous MTK OVL software architecture.
- reuse mtk_ovl drivers in MediaTek DRM display to support the new 
  MT8196 SoC.
- implement support for multiple mmsys instances within a single 
  mediatek-drm driver, improving flexibility and scalability.
- refactor existing components (mutex, OVL) to accommodate the new 
  architecture and improve code reusability.
- update component matching, binding logic, and data structures to 
  support the new multi-mmsys design.

Nancy Lin (10):
  soc: mediatek: add mmsys support for MT8196
  soc: mediatek: mutex: refactor SOF settings for output components
  soc: mediatek: mutex: add mutex support for MT8196
  drm/mediatek: Refine OVL format convert API and export to public
  drm/mediatek: add EXDMA support for MT8196
  drm/mediatek: add BLENDER support for MT8196
  drm/mediatek: add OUTPROC support for MT8196
  drm/mediatek: add ovlsys_adaptor support for MT8196
  drm/mediatek: Add support for multiple mmsys in the one mediatek-drm
    driver
  drm/mediatek: Add support for MT8196 multiple mmsys

Paul-pl Chen (5):
  dt-bindings: arm: mediatek: mmsys: add compatible for MT8196
  dt-bindings: soc: mediatek: add mutex yaml for MT8196
  dt-bindings: display: mediatek: add EXDMA yaml for MT8196
  dt-bindings: display: mediatek: add BLENDER yaml for MT8196
  dt-bindings: display: mediatek: add OUTPROC yaml for MT8196

 .../bindings/arm/mediatek/mediatek,mmsys.yaml |   5 +
 .../display/mediatek/mediatek,blender.yaml    |  48 ++
 .../display/mediatek/mediatek,outproc.yaml    |  54 ++
 .../bindings/dma/mediatek,exdma.yaml          |  70 ++
 .../bindings/soc/mediatek/mediatek,mutex.yaml |   2 +
 drivers/gpu/drm/mediatek/Makefile             |   4 +
 drivers/gpu/drm/mediatek/mtk_crtc.c           | 342 ++++++--
 drivers/gpu/drm/mediatek/mtk_crtc.h           |   6 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 133 +--
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |   6 +
 drivers/gpu/drm/mediatek/mtk_disp_blender.c   | 276 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_blender.h   |  18 +
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  67 ++
 drivers/gpu/drm/mediatek/mtk_disp_exdma.c     | 372 ++++++++
 drivers/gpu/drm/mediatek/mtk_disp_outproc.c   | 242 ++++++
 drivers/gpu/drm/mediatek/mtk_disp_outproc.h   |  22 +
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 158 ++--
 drivers/gpu/drm/mediatek/mtk_disp_ovl.h       |  16 +
 .../drm/mediatek/mtk_disp_ovlsys_adaptor.c    | 797 ++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 281 +++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.h        |  28 +-
 drivers/soc/mediatek/mt8196-mmsys.h           | 451 ++++++++++
 drivers/soc/mediatek/mtk-mmsys.c              | 203 ++++-
 drivers/soc/mediatek/mtk-mmsys.h              |  18 +
 drivers/soc/mediatek/mtk-mutex.c              | 257 +++++-
 include/linux/soc/mediatek/mtk-mmsys.h        |  60 ++
 include/linux/soc/mediatek/mtk-mutex.h        |   4 +
 27 files changed, 3675 insertions(+), 265 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,blender.yaml
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,outproc.yaml
 create mode 100644 Documentation/devicetree/bindings/dma/mediatek,exdma.yaml
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_blender.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_blender.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_exdma.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_outproc.c
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_outproc.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ovl.h
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_ovlsys_adaptor.c
 create mode 100644 drivers/soc/mediatek/mt8196-mmsys.h

-- 
2.45.2


