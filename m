Return-Path: <linux-kernel+bounces-566286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A565A675DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2668042466D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82FD20DD71;
	Tue, 18 Mar 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="VlsfvZpm"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7541420CCF5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306578; cv=none; b=GHzGffS7OuDgMWSt+bib39+lK6yc032pmZLs8/oysT0/1HrSjt80pQvk+D0Sg6B0k0B54QAAW2x+KtSlHsQaKZRbN/eE2r7czcbHgl8FxCyCv5eEp5cFIqM90p/4LdN5sc8uj2SWxHG12ExPDWy77gZq5WFEzkxpxGj59MgJJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306578; c=relaxed/simple;
	bh=GPVcfqT5/XrKutcqvlnWQSa7s2lb9I+6GQRBRhzs6bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgBoZZPzaF0BohfTOslSZ8rP56/De1UEACg9YbBO3yuOHnaId7hFbi9DZJiFEt7LRn0EVhn4DPAm9eEav6g0KdIYQ3kYfXcM3bO5s0nRpx+kzLAO9eXbntI4S3jDKWDk+yw1NaRBQGYnNymDNaSzZqTy2rPhb8cxq6oQwDdZU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=VlsfvZpm; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ae148c50040111f08eb9c36241bbb6fb-20250318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=9L3QuRg7qq4jIR4VvfIWIj1a6A5KXUIfQeOYZvj+5jY=;
	b=VlsfvZpmzdg7JIMW2j+qA9NAlvKdVqzdR8asSOFcONlRLDJzuXabeqENeJXfLAOGWNa9jkps76r7FE/2nCijAVN/FKMeaJmPgIW0VSNZvCB75T19noa6nWUYJDF8NqRXbT8LjG76ketNwMT5ktuvZNgJt2BLBf9fC4FS80yXuvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:180a371a-3f60-4070-a275-7aadcc0a94b3,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:b7d3878c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ae148c50040111f08eb9c36241bbb6fb-20250318
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 974564621; Tue, 18 Mar 2025 22:02:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Tue, 18 Mar 2025 22:02:49 +0800
Received: from mszsdclx1211.gcn.mediatek.inc (10.16.7.31) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Tue, 18 Mar 2025 22:02:49 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>,
	<mac.shen@mediatek.com>, <peng.liu@mediatek.com>,
	<liankun.yang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/1] *** SUBJECT HERE ***
Date: Tue, 18 Mar 2025 22:02:20 +0800
Message-ID: <20250318140236.13650-1-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

*** BLURB HERE ***

Liankun Yang (1):
  drm/mediatek: Adjust bandwidth limit for DP

Applied to mediatek-drm-fixes [1]
  drm/mediatek: Fix mode valid issue for dp.
  drm/mediatek: Fix YCbCr422 color format issue for DP.

 drivers/gpu/drm/mediatek/mtk_dp.c | 39 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

-- 
2.45.2


