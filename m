Return-Path: <linux-kernel+bounces-341613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D579098826F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12B8F1C22A57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 10:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4A1885A2;
	Fri, 27 Sep 2024 10:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HnBMVLhb"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38761CD31;
	Fri, 27 Sep 2024 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727433053; cv=none; b=iyv55fvjWm+1RIlh/USfgvMOfBdiiJVTkBcgG4RtlRYVlw9LWoNPfvxcC07LUPhlDcb5RgxM/hbXQA931CYWgOf6l9aePbcdgoaSXmzE7mWDHh9ylmwFsWkD0zfLSSVvY7LHz83ASeHTHUuJHpGipgsHj0W6O6L2cCL7pQjf11I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727433053; c=relaxed/simple;
	bh=gGlVStBekd6tn5scRrWK5ZAhxic3Z9UU5MfQzxxUMJ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpOxp56y2ZlvcuDhnOMks72t6GdwTlt1GNJQJRWMQoa3qIL4bPWQzxez21aJgb54lQU6UlcE9/diSsQJ91UaFcbrI5xydy814KY964f7GDBCkEYwiEEH4XtzTOiuu2xaUGSIGbfnWEtdq06V4PtrjamcvolLSGc92LXxuQ9UQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=HnBMVLhb; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8d713dd67cbb11efb66947d174671e26-20240927
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=m46+FnCMQHOmqn0PoIzre0+LrIPiIFVNgGTSNn1G4lU=;
	b=HnBMVLhbPhUcs3t0NSgzyZJgxtovAZPaNcI0ORLMOmq+G36QMcdIAjAAhdYVH3V/+ZxenL18+OiKYELWCxfab731z2/zRfpjNNsxd4OVwR+ziTHYVnLAdHkNTIXxpweK/I9niv4vRy+NqDJuvqYwzKezUORbctVkCEi6oBMkQ+8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:5a2343ec-6235-44f3-8d97-821c9dd2ee93,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:c231ded0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8d713dd67cbb11efb66947d174671e26-20240927
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <pablo.sun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 288267427; Fri, 27 Sep 2024 18:30:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 27 Sep 2024 18:30:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 27 Sep 2024 18:30:41 +0800
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
Subject: [PATCH v2 0/6] Enable Mali GPU on MediaTek Genio 700 EVK
Date: Fri, 27 Sep 2024 18:29:59 +0800
Message-ID: <20240927103005.17605-1-pablo.sun@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--0.806400-8.000000
X-TMASE-MatchedRID: 9hizXfD21dsmTNBjrl+CAW3NvezwBrVmojQrbrPpzzqGisL/BZ/9PdW+
	IybvzGvgNj6y7Vt/6GWC5iz+AfW7iGUlOh2o2oTOXP5rFAucBUGUi9wB9gmcSg6QlBHhBZuwdO+
	/9tNlGWiVMlcqqHWd7aBVvEjzNBpCHxPMjOKY7A8LbigRnpKlKZx+7GyJjhAUhkdrz87uCrRgoB
	lboHSVM/+AFuk/l+IJhhE+xzpC0Amtj3NsCFywmxooWenQjZ+C/qp3hdj9VidpK/dq5WMpuQtpr
	0rlZmVdSZrfNhP3sgUBh9AgBSEFrJm+YJspVvj2xkvrHlT8euI+kK598Yf3Mg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--0.806400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D0C318A38EBB130AA739C695458581D634A5D984CB05CC042F6AC14E61DE43042000:8
X-MTK: N

This series is based on linux-next, tag: next-20240927

Enables the GPU on mt8390-genio-700-evk.dts. 
The panfrost driver probed with dmesg:

panfrost 13000000.gpu: clock rate = 390000000
panfrost 13000000.gpu: mali-g57 id 0x9093 major 0x0 minor 0x0 status 0x0
panfrost 13000000.gpu: features: 00000000,000019f7, 
  issues: 00000003,80000400
panfrost 13000000.gpu: Features: L2:0x08130206 Shader:0x00000000
  Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
panfrost 13000000.gpu: shader_present=0x10005 l2_present=0x1
[drm] Initialized panfrost 1.2.0 for 13000000.gpu on minor 0

Changes in v2:
- Fixes the "Fixes" tag in patch ("arm64: dts: mediatek: mt8188: 
  Fix wrong clock provider in MFG1 power domain")
- Reuse mtk_mt8186_efuse_pdata
- Remove comma at the end of mainpll_d5_d2
- Add patch ("soc: mediatek: mediatek-regulator-coupler: Support mt8188")
- Couple GPU SRAM voltage to GPU voltage instead of fixed value

Pablo Sun (6):
  arm64: dts: mediatek: mt8188: Fix wrong clock provider in MFG1 power
    domain
  clk: mediatek: clk-mt8188-topckgen: Remove univpll from parents of
    mfg_core_tmp
  nvmem: mtk-efuse: Enable postprocess for mt8188 GPU speed binning
  arm64: dts: mediatek: mt8188: Add efuse for GPU speed binning
  soc: mediatek: mediatek-regulator-coupler: Support mt8188
  arm64: dts: mediatek: mt8390-genio-700-evk: Enable Mali GPU

 arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 11 +++++--
 .../dts/mediatek/mt8390-genio-700-evk.dts     | 31 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8188-topckgen.c    |  9 ++++--
 drivers/nvmem/mtk-efuse.c                     |  1 +
 drivers/soc/mediatek/mtk-regulator-coupler.c  |  1 +
 5 files changed, 48 insertions(+), 5 deletions(-)

-- 
2.45.2


