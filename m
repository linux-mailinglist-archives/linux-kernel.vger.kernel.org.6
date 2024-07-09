Return-Path: <linux-kernel+bounces-245604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F992B4D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EFB41C22877
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783D155CA3;
	Tue,  9 Jul 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="vEl4nrwb"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FB2153824;
	Tue,  9 Jul 2024 10:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720519872; cv=none; b=ma/pKbnDGxG0i5BApA3GZ6JJPyWl5Kf/seK2hm1gFBThF/bU3TM3VJNiuMzvzPZ4ai7bXKuevEgboi6awCK2mPibOk/qDc/NLMXlNQkZZ2axd2xLLsIAMiWepH+zylK2zrk2YPHhk6nDkMCfjKJo7tSC1YrNMILe8fcat5EcrZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720519872; c=relaxed/simple;
	bh=aQaWMoAReptcmjsgUtmNEBXBdnlxAudJKh40BjH2eeg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u7qOjfHWlooD4CIYwA9Drw983Ag2+Hx+LUmxH7vADdVYRVNnxud+cfSDn85dvIEfYrpsue9IsalF0eJNZ1gGqxX2RewPC9VJSIeLsEDhr/Za5XNEWlDNrKALgv45z/9FtOF2A6+d8Rk2vs35KGP+uvIoBMNodBtrRbzMSrcAIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=vEl4nrwb; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8c537d203ddb11ef99dc3f8fac2c3230-20240709
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4g/n/U/gNIclUl8PDWXPkIANE160xOqth+NppkBoar4=;
	b=vEl4nrwbvO4QEubFl9uXe0mSTg+zDRJG7vv+BmDBI2xo0YKnxhSCzqIiGXX/m9+hntKzmYWbmg098inZfMvrPUWChmOPZpmYRSf9oR6uJdV6IXHzuteLjtAdcz6jIKxLYQEYJ57Wb96EiZA1mnEBqgf6g8nHH1+3rOP84kRR3tQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.40,REQID:9cfafac3-198e-4354-9777-8e9b83d948d1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:ba885a6,CLOUDID:895b1645-a117-4f46-a956-71ffeac67bfa,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8c537d203ddb11ef99dc3f8fac2c3230-20240709
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
	(envelope-from <mark-pk.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1276852856; Tue, 09 Jul 2024 18:11:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Jul 2024 18:10:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Jul 2024 18:10:59 +0800
From: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To: Jonathan Corbet <corbet@lwn.net>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, Mark-PK Tsai <mark-pk.tsai@mediatek.com>, "Will
 Deacon" <will@kernel.org>
CC: Vegard Nossum <vegard.nossum@oracle.com>, Randy Dunlap
	<rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>, Leo Yan
	<leo.yan@linux.dev>, Daniel Stone <daniels@collabora.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] docs: iommu: Drop the stale entry in documentation TOC
Date: Tue, 9 Jul 2024 18:10:30 +0800
Message-ID: <20240709101055.27178-1-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10-0.495500-8.000000
X-TMASE-MatchedRID: q3DD6paP25SxpgqXoiq0QRIRh9wkXSlF+KgiyLtJrSBh2fnHe1cil5go
	A6tCR5r5tb9lbjrD8CQi/q1BDW1QNbBAQLqGlKivsK+WWVTsOXUFoWM8D8/dJpsoi2XrUn/J8m+
	hzBStansUGm4zriL0oQtuKBGekqUpUfEQFBqv0mf+fcB583Y+85VPwxBjG5R/rDloKsUzYHV1ir
	HCFqK+evR4gTBSYcescfVBOXUPkQV0qcKXT3+uyBGzJje0pkt3TocK8dAVBXBJmt82E/eyBQGH0
	CAFIQWsmb5gmylW+PbGS+seVPx64iJPbCM5uaOswL6SxPpr1/I=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10-0.495500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 3A272DCB714E486716714DCA05C2AB6A0DA45688F6DAC0F139CBD8C1959BC1852000:8
X-MTK: N

The Documentation/userspace-api/iommu.rst had been removed,
so should TOC entry.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20240709190613.3fd8b7ea@canb.auug.org.au/
Fixes: d926e7c04843 ("docs: iommu: Remove outdated Documentation/userspace-api/iommu.rst") on linux-next
Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 Documentation/userspace-api/index.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 8a251d71fa6e..274cc7546efc 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -45,7 +45,6 @@ Devices and I/O
    accelerators/ocxl
    dma-buf-alloc-exchange
    gpio/index
-   iommu
    iommufd
    media/index
    dcdbas
-- 
2.18.0


