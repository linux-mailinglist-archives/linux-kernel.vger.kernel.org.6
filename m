Return-Path: <linux-kernel+bounces-512792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F558A33DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 559597A437D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85B122155B;
	Thu, 13 Feb 2025 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hrue+E5J"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030E21D3CC;
	Thu, 13 Feb 2025 11:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445652; cv=none; b=EBjMe/rF0Zf3bS0Fs6fMsDG6a2ellnZVKNWOe1cMH96gUFznhj9QRXfqJa4HE0LWs7CHnDviC1EcNQWZyieUi5/2zaa/sP/veonfAsCxeclzmmVX7db/INXBt2vEuxFmKa9xON6drPnO5S2ZYwgl2+Pu+KoXaoyiC2DYBT9mv70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445652; c=relaxed/simple;
	bh=E2XNV4WJzLYKlsC0jrTYob1TsNvbS4I9eUsDpDlD9hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrN810FqcQSuHRhOFSkzh6Gx3pXyEqcPiDH4BUba3Z6tPVMW6AwJBlBWQ1Cr+GEadY3LlJSDngexrBl6Umz70j1DP18luHYfGNYoNMMfglxSEd/AgQGFPHnDyZG/yutHLGpcLZ3SfihCGedbbrmkjhgfQIXvqL+UDs7/VhrL8dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Hrue+E5J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739445648;
	bh=E2XNV4WJzLYKlsC0jrTYob1TsNvbS4I9eUsDpDlD9hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hrue+E5JAAlkh3h58w7Dv25y3vOaS+suQ4LGN1AfmBJR9YKITpfCS915G5Me44tb/
	 vy2MibWdjwLCnjwIsJVw68TZ5QzgwSuGe7zJelA4YMRZLFphlc01GgBPaJRom57kZd
	 uhcKbb7u/WlcbshjBn7Jw0x79h1KP2tgz5zqT3Ws46OLSCpffksyc3dNYsCPex7eXa
	 iggeV8hOSE9lgRBm32h3Eg9aDDWSSh8/rpEtRlFuQa1NjgcbfTARYja9WAmpLsniUu
	 PcfJIltLs1UNQymaq7O4CZCUZ6Mz2fY9Y+POGaJF3QbuVGdvWogjntmVOEKhyiq946
	 X+Z+KnaBFrYAw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D684617E0E93;
	Thu, 13 Feb 2025 12:20:47 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	angelogioacchino.delregno@collabora.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	pablo.sun@mediatek.com
Subject: [PATCH v1 1/3] arm64: dts: mediatek: mt8195: Add base display controller graph
Date: Thu, 13 Feb 2025 12:20:06 +0100
Message-ID: <20250213112008.56394-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
References: <20250213112008.56394-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The display related IPs in MT8195 are flexible and support being
interconnected with different instances of DDP IPs and/or with
different DDP IPs, forming a full Display Data Path that ends
with an actual display output, which is board specific.

Add a common graph in the main mt8195.dtsi devicetree, which is
shared between all of the currently supported boards.
All boards featuring any display functionality will extend this
common graph to hook the display controller of the SoC to their
specific output port(s).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 129 +++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index f013dbad9dc4..4f2dc0a75566 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -3142,6 +3142,23 @@ ovl0: ovl@1c000000 {
 			clocks = <&vdosys0 CLK_VDO0_DISP_OVL0>;
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_OVL0_RDMA0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x0000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ovl0_in: endpoint { };
+				};
+
+				port@1 {
+					reg = <1>;
+					ovl0_out: endpoint {
+						remote-endpoint = <&rdma0_in>;
+					};
+				};
+			};
 		};
 
 		rdma0: rdma@1c002000 {
@@ -3152,6 +3169,25 @@ rdma0: rdma@1c002000 {
 			clocks = <&vdosys0 CLK_VDO0_DISP_RDMA0>;
 			iommus = <&iommu_vdo M4U_PORT_L0_DISP_RDMA0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x2000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					rdma0_in: endpoint {
+						remote-endpoint = <&ovl0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					rdma0_out: endpoint {
+						remote-endpoint = <&color0_in>;
+					};
+				};
+			};
 		};
 
 		color0: color@1c003000 {
@@ -3161,6 +3197,25 @@ color0: color@1c003000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_COLOR0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x3000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					color0_in: endpoint {
+						remote-endpoint = <&rdma0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					color0_out: endpoint {
+						remote-endpoint = <&ccorr0_in>;
+					};
+				};
+			};
 		};
 
 		ccorr0: ccorr@1c004000 {
@@ -3170,6 +3225,25 @@ ccorr0: ccorr@1c004000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_CCORR0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x4000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					ccorr0_in: endpoint {
+						remote-endpoint = <&color0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					ccorr0_out: endpoint {
+						remote-endpoint = <&aal0_in>;
+					};
+				};
+			};
 		};
 
 		aal0: aal@1c005000 {
@@ -3179,6 +3253,25 @@ aal0: aal@1c005000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_AAL0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x5000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					aal0_in: endpoint {
+						remote-endpoint = <&ccorr0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					aal0_out: endpoint {
+						remote-endpoint = <&gamma0_in>;
+					};
+				};
+			};
 		};
 
 		gamma0: gamma@1c006000 {
@@ -3188,6 +3281,25 @@ gamma0: gamma@1c006000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_GAMMA0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x6000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					gamma0_in: endpoint {
+						remote-endpoint = <&aal0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					gamma0_out: endpoint {
+						remote-endpoint = <&dither0_in>;
+					};
+				};
+			};
 		};
 
 		dither0: dither@1c007000 {
@@ -3197,6 +3309,23 @@ dither0: dither@1c007000 {
 			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS0>;
 			clocks = <&vdosys0 CLK_VDO0_DISP_DITHER0>;
 			mediatek,gce-client-reg = <&gce0 SUBSYS_1c00XXXX 0x7000 0x1000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					dither0_in: endpoint {
+						remote-endpoint = <&gamma0_out>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					dither0_out: endpoint { };
+				};
+			};
 		};
 
 		dsi0: dsi@1c008000 {
-- 
2.48.1


