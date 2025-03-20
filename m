Return-Path: <linux-kernel+bounces-569112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A32A69EA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6DE1896D36
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35F21E832E;
	Thu, 20 Mar 2025 03:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RtTO/oh6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA4149DFF;
	Thu, 20 Mar 2025 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440709; cv=none; b=FLOy0s8PZTrH2GmOIInWOdGgz1NxKGOI+R6alHGIwvq5DEwsa1BPbJ0iG6m2D+iN+89pOy7B0TSskCPmloGzaEMW8xKROVwgCqSLrIsz1XyJwV8gi+nET4yxo4KdLRFXZ4ROjl8l9EyNPBXMjep+3hhJV6tD7acAZjfZkQtEkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440709; c=relaxed/simple;
	bh=N1aQ455jOoMMMKJD3/nKom6h2GL4ZfWqiWk0RxY2onU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FxDjBaCiRuysHiYz3ePPusG/7wy5sa0Um8v652ZYjoeyCrOZVJITtyk1SggkKeJ6UFQMRre5aqZwQUQXXYtkGYWLLl5eXDCAhFK1+RaJS2+nwu+kruk2PotunhK2O6gRmZevGp2fqmGOXTSu/9adKadFUz4eypNqxs4HzlrxCFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RtTO/oh6; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f93fe42a053911f08eb9c36241bbb6fb-20250320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=O8wO0y0Uf9L6XQSvVRb4n8ULZarLdb4tWNcXs+FmIgs=;
	b=RtTO/oh6oU+QhyXnTgE4Q6fpVfEbJgYebv9FwbCNorTSq44EQApBAohsd5IZeVnTb7ZUYk8cJJbGjEmKBlqsl/S7WXuqvqSpAglIEnObS6Aq9kbuhtWB7FVXdL/c4sr8XrqT8dASA3/K0puRc2zbD3ikQZ5EJOPA2vAj4nKvuJc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:d06b13c8-048f-4bb7-b266-edbf0a18a2a0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:97c2998c-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: f93fe42a053911f08eb9c36241bbb6fb-20250320
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <hailong.fan@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 134413315; Thu, 20 Mar 2025 11:18:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 20 Mar 2025 11:18:18 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 20 Mar 2025 11:18:17 +0800
From: hailong.fan <hailong.fan@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, "Bard
 Liao" <yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<sound-open-firmware@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<Jjian.Zhou@mediatek.com>, <Xiangzhi.Tang@mediatek.com>, hailong.fan
	<hailong.fan@mediatek.com>
Subject: [PATCH 0/2] ASoC: mediatek: Add support of SOF on Mediatek mt8196 SoC.
Date: Thu, 20 Mar 2025 11:17:23 +0800
Message-ID: <20250320031753.13669-1-hailong.fan@mediatek.com>
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

Add support of MediaTek mt8196 SoC DSP to SOF.
This series is based on linux-next, tag: next-20250319.

---
This series patches dependent on:
[1]
https://lore.kernel.org/all/20250307032942.10447-1-guangjie.song@mediatek.com/
[2]
https://lore.kernel.org/all/20250307034454.12243-1-guangjie.song@mediatek.com/

hailong.fan (2):
  ASoC: SOF: MediaTek: Add mt8196 hardware support
  dt-bindings: dsp: mediatek: add mt8196 dsp document

 .../bindings/dsp/mediatek,mt8196-dsp.yaml     |  96 +++
 sound/soc/sof/mediatek/Kconfig                |   9 +
 sound/soc/sof/mediatek/Makefile               |   1 +
 sound/soc/sof/mediatek/mt8196/Makefile        |   4 +
 sound/soc/sof/mediatek/mt8196/mt8196-clk.c    | 100 +++
 sound/soc/sof/mediatek/mt8196/mt8196-clk.h    |  23 +
 sound/soc/sof/mediatek/mt8196/mt8196-loader.c |  61 ++
 sound/soc/sof/mediatek/mt8196/mt8196.c        | 650 ++++++++++++++++++
 sound/soc/sof/mediatek/mt8196/mt8196.h        | 109 +++
 9 files changed, 1053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dsp/mediatek,mt8196-dsp.yaml
 create mode 100644 sound/soc/sof/mediatek/mt8196/Makefile
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.h
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-loader.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.c
 create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.h

-- 
2.45.2


