Return-Path: <linux-kernel+bounces-334369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C15E97D65C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5A661F22DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4341517ADE8;
	Fri, 20 Sep 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cLrYyQSr"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2017A589;
	Fri, 20 Sep 2024 13:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839742; cv=none; b=HGELSR1Qw2phvqICV3gzfUEg738Zui09HnMZpO6jEFtrLy2lXCPBElIrOTmrGq22xgALuxVgnMr4ocXNr0yJRVj9Szthh6l28pYf4IhmztvV81CM9CjNnAvKO0FjxtbEYG9a0+gBHNVqiL+98psI6Dy0f0YyWNw/6cpy6RfWDwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839742; c=relaxed/simple;
	bh=IH1eK1Q/V1ah8TGPJ6j95/WVqEb3Xyc0mGclcgPqgFQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JKHQ69Cj5+CuNH6vk/6Q8Ym0jnBKAILYgt2nshmwHG5IDRuFhbuygJPYFaXtaXJPz1+OK6QUfkGKMVHYQoUbSGYkkfXGgKnAChDRV0rHQTuG3Q0A1je2QFeeEU8zfXojxJToz+wruiTGqz1VTLktjXqbccc/L3MvKz0KilSRr7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cLrYyQSr; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 243eb79a775611ef8b96093e013ec31c-20240920
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jdGS2Redugm+6yZAwL+vZjmNIVgfyGtJQLHlHzdoyr8=;
	b=cLrYyQSrvVQ0Cw7c8sRJzWPRIwo/KrBm8gIeyXnOpHhic8hlmxYGO4sZr1a9d08efdROnHi0Nfpf1VQxfX/dLrmqWQvN+gG6JiQxIAA6ADugYW8h5pekiofPZb5KHvmPr51uvEMo+vvAMruQJGNzDNpFOWhtia8x3aIyc2FEcSQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:0fe5b65a-a41b-44bd-b2b6-5825297f6e5a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:66b94e9e-8e9a-4ac1-b510-390a86b53c0a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 243eb79a775611ef8b96093e013ec31c-20240920
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 268247819; Fri, 20 Sep 2024 21:42:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 20 Sep 2024 21:42:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 20 Sep 2024 21:42:10 +0800
From: Pablo Sun <pablo.sun@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, "Srinivas
 Kandagatla" <srinivas.kandagatla@linaro.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, Pablo Sun <pablo.sun@mediatek.com>
Subject: [PATCH 0/5] Enable Mali GPU on MediaTek Genio 700 EVK
Date: Fri, 20 Sep 2024 21:41:06 +0800
Message-ID: <20240920134111.19744-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.191900-8.000000
X-TMASE-MatchedRID: 9hizXfD21ds77EsBOi8++odlc1JaOB1TnhD9A3Sa7pa48McbajxWsC/k
	D8Mn5brMtJRCaLO6y7uf4k2rUca3tGGBe5Zc3tN2kPoFsM336M4xXH/dlhvLv1wpnAAvAwazdO+
	/9tNlGWiVMlcqqHWd7aBVvEjzNBpCHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUYlEZe7KrQtZx+J
	e1fezGIAwOQ5ymuQBGw4C83QCL2crUqZcgNHQfiSeTaJ1EC2jFSb5MQ3rtK9UN2krgd0tMduYLh
	V1S6S8pSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvrHlT8euI+kK598Yf3Mg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.191900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 6C40CAEC85C00BB6034421F075345033D6F50A9AE679C36B035BBA50599BD0782000:8
X-MTK: N

This series is based on linux-next, tag: next-20240920

Update efuse and clock settings for mt8188, and enable the GPU
on mt8390-genio-700-evk.dts. The panfrost driver probed with dmesg:

panfrost 13000000.gpu: clock rate = 390000000
panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x0 status 0x0
panfrost 13000000.gpu: features: 00000000,000019f7,
	 issues: 00000003,80000400
panfrost 13000000.gpu: Features: L2:0x08130206 Shader:0x00000000
         Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
panfrost 13000000.gpu: shader_present=0x10005 l2_present=0x1
[drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0

Pablo Sun (5):
  arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power
    domain
  clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of
    mfg_core_tmp
  nvmem: mtk-efuse: Enable postprocess for mt8188 GPU speed binning
  arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning
  arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU

 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 11 +++++++--
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 24 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-topckgen.c    |  7 ++++--
 drivers/nvmem/mtk-efuse.c                     |  5 ++++
 4 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.45.2


