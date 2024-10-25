Return-Path: <linux-kernel+bounces-381256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586529AFC96
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D01C22A85
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1765E1D2794;
	Fri, 25 Oct 2024 08:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="d7+KrT+Y"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E41C878E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845121; cv=none; b=T9CHVfwxMh6PBS260YuKVwO2d3SqIYT6rcgtFRKbEE6Wihd4YKmbAVup5WHdE7beg7Sm/u2XQie/CLgQVQHjfMaSWvZcf9PO0UMCtsRUEFFD7/Wi2LVml3bkqLZ+Agr8uFGzCCu7VZDp5g5jykSMfeNLMeks7ZM5z9ml6pVEO58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845121; c=relaxed/simple;
	bh=FyRcjH3MyU/qU7vAX8oRUCU3GcUlaWf6qQDiUkU/bDI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcJvOZAaJx4ZCJj4jqZXgIFb/fF9rCmSfX5U7Qzvo5ZqEcSdbFU5pJpzjwb3YmaObVZ6qU+Zh9PyJSNi9O3NVIbxwHZBJng1AhSJoipdlBP9Ao6BBSAWXqsfVsCD5hcEj9Ypfe+Xau0WA/t0er6ngcEGGWw5B2Ef+CWQSE0uGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=d7+KrT+Y; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9225885492ab11efb88477ffae1fc7a5-20241025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=BT/Ng943C81aesy7n0Su3FETLClPbDgwCaBp/DvtzrA=;
	b=d7+KrT+YQLkZHKtWDIIjKRc/Wl3dZ6/Q8HhhYnmaDvKuKuAoFvopb0i6UPLdjVJDIIcQ7cFXiCfoAJvqfh2Kk/E3eADWzCTS6FeZdRL3+cnVRLR0kN3EumINBstlFGXBvtEkHIOw/ASrvakkRpiTDzvaV3RRHMQZAgtiwYUKsHQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:791cb5ab-5518-4750-af5f-445bb12aedbd,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:d4d7d241-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9225885492ab11efb88477ffae1fc7a5-20241025
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 730057307; Fri, 25 Oct 2024 16:31:46 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 25 Oct 2024 16:31:44 +0800
Received: from mszsdclx1211.gcn.mediatek.inc (10.16.7.31) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 25 Oct 2024 16:31:43 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
	<dmitry.osipenko@collabora.com>, <msp@baylibre.com>,
	<rex-bc.chen@mediatek.com>, <granquet@baylibre.com>, <peng.liu@mediatek.com>,
	<jitao.shi@mediatek.com>, <mac.shen@mediatek.com>,
	<liankun.yang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/3] Adjust YCbCr422/bandwidth/training for DP
Date: Fri, 25 Oct 2024 16:28:26 +0800
Message-ID: <20241025083036.8829-1-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--5.394300-8.000000
X-TMASE-MatchedRID: gUuz9Ogq75WqO+wHLkIcO7E3FpMbg63SWDdWpJMntKiPaLJ/Ca3STzku
	TGiiLo1Yx91bb4/YjfE5bsAcOzEG6DK42JVSvu3ARAvohSJUpI++1Vx7rDn4r7v408/GP5HqqcN
	xd5hReGHi8zVgXoAltoAy6p60ZV62JW+71yEen6Zq8/xv2Um1avoLR4+zsDTtgUicvJ4MChkqZu
	nyleO9cPKITgppfSr0LQnK66f9ldiohItm7Yy7y/cqHKzCJIUv
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--5.394300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	F32734434536A121CD0B2F2009F6141F52AC7822B31BBEF4922DAF5077C969E42000:8
X-MTK: N

The change in mode filtering bandwidth calculation method must rely on
DP training at the beginning, and get the current train info to calculate
the bandwidth.

Color format support capability must also rely on DP training time to
get the most reliable link capability and choose which color format to use.

Fixed YCbCr422 problem and bandwidth calculation from color format are
both in the color format category, so they are bound.

In summary, YCbCr 422 and mode valid must rely on DP training timing,
so they are strongly bound.

Liankun Yang (3):
  drm/mediatek: Fix YCbCr422 color format issue for DP
  drm/mediatek: Fix mode valid issue for dp
  drm/mediatek: Adjust bandwidth limit for DP

 drivers/gpu/drm/mediatek/mtk_dp.c | 78 ++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 33 deletions(-)

-- 
2.45.2


