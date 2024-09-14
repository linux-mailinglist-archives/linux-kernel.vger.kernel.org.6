Return-Path: <linux-kernel+bounces-329407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A76C19790F5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3767D1F22CA7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0851CF7CB;
	Sat, 14 Sep 2024 13:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="fReJZjJT"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD161CF5C1;
	Sat, 14 Sep 2024 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726320529; cv=none; b=DH2mO4tQPkvu9Pilenq/5D7nonWWXUn8EF+XDbAlX39oSb3esRzNQDlYp2//PAPcRVp+qOZk1ha47B5O8nrCDhfJO9zb83eNAgJ2SX9FIToclxdSoYyrXg6dmae5GsG2hzeXpg3RBXop2JCKPtyndPBWnpVyDPXOL6x2LppbIjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726320529; c=relaxed/simple;
	bh=KuEXBzCQyjKrVK/ji8x8jvInIC08pi7xzZUUvGZuNi8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bx9ngPpvU9SRg0szDm4TAkrCRf5zakCoJYZsb9jKhiDow+FW4tr5nyn5toT/hEEmCAktaK6AXXeJnVTFn3eNfcX6lmsq8B5eFdd8w6XrlFZOIZiZT2d83b9ZRR7Uuqef+2pGaRIl/M4jPpV+JGXRhhtDU3MULlLQOdJghqP/CBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=fReJZjJT; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 420fb7d2729d11efb66947d174671e26-20240914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8EsMFvgM/rHkn2Bp+x+Mwx0rwto+KF83Fupv23yrInc=;
	b=fReJZjJTXPBvzqatlPOzIK0caAp4/X6AWPiioMRsQJ7+iLzxVmC/OKDKcP/w7FnofFhuTnrWwWMGlAfj+q6Wl1UkgZzuVE/2vGie4qMwInIusvVzNG8Jb2McEL/lQxXcNr2vLPW7wWxgfIrAhmbl3kDutEM0PtkHomEfW6Vis48=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:507e5ebd-9ea4-4c01-ae31-6c4237b9451c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:4a8e35d0-7921-4900-88a1-3aef019a55ce,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 420fb7d2729d11efb66947d174671e26-20240914
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1656340153; Sat, 14 Sep 2024 21:28:41 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 14 Sep 2024 21:28:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 14 Sep 2024 21:28:38 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sen Chu
	<sen.chu@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	Alexandre Mergnat <amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul@gmail.com>, Chris-qj chen <chris-qj.chen@mediatek.com>,
	MediaTek Chromebook Upstream
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, Chen-Yu Tsai
	<wenst@chromium.org>
Subject: [PATCH v4 3/3] regulator: dt-bindings: mt6397: move examples to parent PMIC mt6397
Date: Sat, 14 Sep 2024 21:28:32 +0800
Message-ID: <20240914132833.9882-1-macpaul.lin@mediatek.com>
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
X-TM-AS-Result: No-10--2.065400-8.000000
X-TMASE-MatchedRID: /CPACGWdrN6PrjM/ltMU+Y+emiGnyeDRVF5mUd6sIMbfUZT83lbkECE5
	3BqiJpQi43HhQBEsO8h9XhRtuAtoH/gN61BAK04F6/xAZojbl7f/lBG+uXYJkJTORr84pjK1lwW
	f7/4SyDskpovHHUzQSoAy6p60ZV62fJ5/bZ6npdiujVRFkkVsm3qpy/q3UrSbQgzqXfVysehaXC
	yaHa+gjhtM7833T4Bas/bGLTLiKYCFIX7naGk/9ThtUOaCAGYK8sDC3ONNDOgFQGaq9Rtht21Rj
	oup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnoxXsgQSqx49gY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.065400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	97AB92A8EB883A43A7B9CB36186487B5BB92EC0F3CEBD8122EBE41CF1925732B2000:8
X-MTK: N

Since the DT schema of multiple function PMIC mt6397 has been converted,
move the examples in "mediatek,mt6397-regulator.yaml" to the parent schema
"mediatek,mt6397.yaml".

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 .../regulator/mediatek,mt6397-regulator.yaml  | 173 ------------------
 1 file changed, 173 deletions(-)

Changes for v1 and v2:
 - This is the first version of converting rtc-mt6397.txt.
   This is because converting rtc-mt6397 together
   with mfd/mediatek,mt6397.yaml, so we've create a patch set
   instead of submitting single patch for each subdevice.
 - This patch has been made base on linux-next/master git repo.

Changes for v3:
 - Re-order this patch since other patches for removing text DT bindings
   in v2 qill be squash into MFD patch.

Changes for v4:
 - No change.

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
index 50db678..337ac58 100644
--- a/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6397-regulator.yaml
@@ -63,176 +63,3 @@ required:
 
 additionalProperties: false
 
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-
-    mt6397_regulators: regulators {
-        compatible = "mediatek,mt6397-regulator";
-
-        mt6397_vpca15_reg: buck_vpca15 {
-            regulator-name = "vpca15";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <200>;
-        };
-
-        mt6397_vpca7_reg: buck_vpca7 {
-            regulator-name = "vpca7";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vsramca15_reg: buck_vsramca15 {
-            regulator-name = "vsramca15";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vsramca7_reg: buck_vsramca7 {
-            regulator-name = "vsramca7";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vcore_reg: buck_vcore {
-            regulator-name = "vcore";
-            regulator-min-microvolt = < 850000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vgpu_reg: buck_vgpu {
-            regulator-name = "vgpu";
-            regulator-min-microvolt = < 700000>;
-            regulator-max-microvolt = <1350000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <115>;
-        };
-
-        mt6397_vdrm_reg: buck_vdrm {
-            regulator-name = "vdrm";
-            regulator-min-microvolt = < 800000>;
-            regulator-max-microvolt = <1400000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <500>;
-        };
-
-        mt6397_vio18_reg: buck_vio18 {
-            regulator-name = "vio18";
-            regulator-min-microvolt = <1500000>;
-            regulator-max-microvolt = <2120000>;
-            regulator-ramp-delay = <12500>;
-            regulator-enable-ramp-delay = <500>;
-        };
-
-        mt6397_vtcxo_reg: ldo_vtcxo {
-            regulator-name = "vtcxo";
-            regulator-min-microvolt = <2800000>;
-            regulator-max-microvolt = <2800000>;
-            regulator-enable-ramp-delay = <90>;
-        };
-
-        mt6397_va28_reg: ldo_va28 {
-            regulator-name = "va28";
-            /* fixed output 2.8 V */
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vcama_reg: ldo_vcama {
-            regulator-name = "vcama";
-            regulator-min-microvolt = <1500000>;
-            regulator-max-microvolt = <2800000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vio28_reg: ldo_vio28 {
-            regulator-name = "vio28";
-            /* fixed output 2.8 V */
-            regulator-enable-ramp-delay = <240>;
-        };
-
-        mt6397_usb_reg: ldo_vusb {
-            regulator-name = "vusb";
-            /* fixed output 3.3 V */
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vmc_reg: ldo_vmc {
-            regulator-name = "vmc";
-            regulator-min-microvolt = <1800000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vmch_reg: ldo_vmch {
-            regulator-name = "vmch";
-            regulator-min-microvolt = <3000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vemc_3v3_reg: ldo_vemc3v3 {
-            regulator-name = "vemc_3v3";
-            regulator-min-microvolt = <3000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp1_reg: ldo_vgp1 {
-            regulator-name = "vcamd";
-            regulator-min-microvolt = <1220000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <240>;
-        };
-
-        mt6397_vgp2_reg: ldo_vgp2 {
-            regulator-name = "vcamio";
-            regulator-min-microvolt = <1000000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp3_reg: ldo_vgp3 {
-            regulator-name = "vcamaf";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp4_reg: ldo_vgp4 {
-            regulator-name = "vgp4";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp5_reg: ldo_vgp5 {
-            regulator-name = "vgp5";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3000000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vgp6_reg: ldo_vgp6 {
-            regulator-name = "vgp6";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-
-        mt6397_vibr_reg: ldo_vibr {
-            regulator-name = "vibr";
-            regulator-min-microvolt = <1200000>;
-            regulator-max-microvolt = <3300000>;
-            regulator-enable-ramp-delay = <218>;
-        };
-    };
-- 
2.45.2


