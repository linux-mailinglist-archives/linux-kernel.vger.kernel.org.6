Return-Path: <linux-kernel+bounces-377979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 784B09AC975
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05DBC1F22805
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F361AC444;
	Wed, 23 Oct 2024 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZNEPKqvu"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1121AB6F7;
	Wed, 23 Oct 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684391; cv=none; b=GpKZvyAaH3J5pzdmInedeGUL+dvObkCXsZnzKLOKfxTxOoxtkxgmlnL/FBSANo0JFI9KiaAA6rFFx5lZM4VOQhgUQYx5bbyqgNT23uPcXv1z2OW4jLsy3QUKsaNscOqe8SrI2MFK07lDPuSuqiEIX5hk6yp6a5esF6XWDKbzyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684391; c=relaxed/simple;
	bh=YIFtUzEb+zNMNMf/+HsO4cidzcc/g56Tm4oHW05vqio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KMOmKuN4OB45xsE3lN5y1nNuZP3BxbdPU2HvMna4XeHm756fIcohURx++Cq9N8sAj0VM0QeD27jBuxUc5B9FpniFRprYngGxTkm+F8/7nGzkYzs4qlVUYY1mL+AgedJj2tKv2QEVpRxkKxAu19xzFYeKvnSPdTOfY5Stk2HBuW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZNEPKqvu; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 90DF6E8A;
	Wed, 23 Oct 2024 13:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1729684279;
	bh=YIFtUzEb+zNMNMf/+HsO4cidzcc/g56Tm4oHW05vqio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNEPKqvudDpiEYufefsHsKGr9FMGFJmYgisd3cw6xUZstfTQW+R9gxzDsvLOHu+jd
	 DfqbqS3iXub//0qDBLAtkLFjchWZTDIUMKR0xbIuxIImUJNXJolpMn8UQzW9h5tVZK
	 M1h+/hc2KxZ6JW3Ld0xBQ3GyoaFSGPeEB/KZnvME=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 23 Oct 2024 14:52:42 +0300
Subject: [PATCH v4 2/3] arm64: dts: zynqmp: Add DMA for DP audio
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-xilinx-dp-audio-v4-2-5128881457be@ideasonboard.com>
References: <20241023-xilinx-dp-audio-v4-0-5128881457be@ideasonboard.com>
In-Reply-To: <20241023-xilinx-dp-audio-v4-0-5128881457be@ideasonboard.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Simona Vetter <simona.vetter@ffwll.ch>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1252;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=YIFtUzEb+zNMNMf/+HsO4cidzcc/g56Tm4oHW05vqio=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnGOOdp5qjGToWY37pydXUvCk+Rk5jrhcolO7kw
 ZoP9VD7HyKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZxjjnQAKCRD6PaqMvJYe
 9boPEACfd7c5aR41z8i2JKMiqweJA1/BsSsE4uhrIlFIOeyRvgSZIBivvGWplW+XAytbKMYsbxf
 KgU53RC7bKXPP6xNoEqBoOy698+QZOJ/V328PD2itzEe+XbrpOmnLdfjZXoEMYrhavZC3KGzWkS
 0ayBKbsTAFAtYcGK1belyis+P9Z3/Q7oRXoc8HoCSwgKFVw9FE5erNCWvBbcZlpdfImMnYjOmQW
 tIvh246appkQdiEgWMOZ6wXs2zuD0CBqYSYc/QSfuO1f8TqSssC6DXElunfK6MCgqOHIXDhy9LQ
 L4xk3DBuR7U/X9fpOp75bpZb+DrHKZBqKkieQi5iITPXabcu7bEBC+1b4/Sel9PsPOP2K0BLc5I
 PzpkRbh9DkrmWI2+TiVCTSCXMk8wil7bbKnGfGAvBi4W1d3Gh4WFH3NRNJNemNHbQkVs/+g7toA
 AkKYcknf3PanJog0MqVcTCE02s8qvd0I0s6jCKKhKWGfYWq06aq2PrSNXtAOt7OnTVG12+zWreQ
 hqMFWV67LT4TuU95vFapR5LnOHM9Ud0KGnBkj1MxMxFcg2gOmMhdFQs+XObrr1fwzT4XofvbU+t
 R9/idQ+AAgHLzk0xTUynB8islnExHrVLh9ISs/RYm7mhNCaypRjE327lBkrQkcJpe/KnXbCwwOh
 s5gnNDBLP/Un3zA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add the two DMA channels used for the DisplayPort audio to the
zynqmp_dpsub node.

Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index b1b31dcf6291..673ca8422e6b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -1207,11 +1207,14 @@ zynqmp_dpsub: display@fd4a0000 {
 				      "dp_vtc_pixel_clk_in";
 			power-domains = <&zynqmp_firmware PD_DP>;
 			resets = <&zynqmp_reset ZYNQMP_RESET_DP>;
-			dma-names = "vid0", "vid1", "vid2", "gfx0";
+			dma-names = "vid0", "vid1", "vid2", "gfx0",
+				    "aud0", "aud1";
 			dmas = <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO0>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO1>,
 			       <&zynqmp_dpdma ZYNQMP_DPDMA_VIDEO2>,
-			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>;
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_GRAPHICS>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO0>,
+			       <&zynqmp_dpdma ZYNQMP_DPDMA_AUDIO1>;
 
 			ports {
 				#address-cells = <1>;

-- 
2.43.0


