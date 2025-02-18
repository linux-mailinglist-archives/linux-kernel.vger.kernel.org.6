Return-Path: <linux-kernel+bounces-520483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7599A3AA55
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A45B170D60
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788D81DE3AA;
	Tue, 18 Feb 2025 20:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A44rg6jA"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF191DDC0F;
	Tue, 18 Feb 2025 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739912118; cv=none; b=liriQnumTYvhDg48YNm3tDLp6ZV2mIl70zxmy7qUipBoZ2VKGJhvpuRLUNtRvPUaT+09BfrgiZM38Aeq/qdmlJL6GvW3EZCAN4ZUgE2YvCMQaD6SrKDs5WX7f58M278FNnvp0SyAN02hNP+XJHwx+ym64AanCodEKrXbYAVZpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739912118; c=relaxed/simple;
	bh=B3FIt860XOzRzSLwGAyU0H8nrJF+jVL8fCQPsnOwnsI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=md1XlhhICUTmwW/Cu1Uz+8KI24vD/W2/2X9Au3TAA4DinUlTygLnEZ89TILQ+rvSjGo6D6QfkcMQepACSxTF5wnKp5rDg4ceInYFrDvwtSqaUKGU5XW0NA+bafpxuyEmFtE8d2rEXFs9+12PV1UcwMBRrJc30hcNVAzsvh40d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A44rg6jA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739912114;
	bh=B3FIt860XOzRzSLwGAyU0H8nrJF+jVL8fCQPsnOwnsI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=A44rg6jAA9mDbtSrYZ2BdQ6DT8sWsP5ts8XMj5S2SSD7XQc6Gcl6pnrHcLpx0sevy
	 DGzA8v76GNYYMgRtiQtg/TKTDF2boxrCe4/ONmeu2yE1kYiiI6FaOQByVd/Zvy/z0T
	 YojFlA9QxEqmtGLvRKzryT55VTMRHu4Ke5HcN+MCQrswia5lVBzG4kzese83E4ztcL
	 +xf2Pxq3o8MTi44NZ1e3dWC0chFlKr21zBFvGOJdVwUBmIdHZkxJH8CcTzR2KIf2+m
	 AurK+ZzRIc0KnQN7pKL1BYwHE/CJMmrO7PX0cWy1mpEL8K3snvrOvJcmyS4q752eIB
	 ISmu+A2WC4WrA==
Received: from [192.168.0.47] (unknown [177.33.139.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D98F917E14E7;
	Tue, 18 Feb 2025 21:55:10 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 18 Feb 2025 17:52:19 -0300
Subject: [PATCH 6/6] arm64: dts: mediatek: mt8390-genio-common: Add routes
 for DMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250218-genio700-dmic-v1-6-6bc653da60f7@collabora.com>
References: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
In-Reply-To: <20250218-genio700-dmic-v1-0-6bc653da60f7@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

Add necessary routes for the onboard dual DMIC present on the Genio
700/510 EVK. The dmic is supplied by micbias0 and micbias2, and inputs
into the MT8188 DMIC DAI.

Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
index a37cf102a6e928440cc88e7e8fe0225fc28ec962..efdeca88b8c4e58f0c17825156276babf19af145 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-common.dtsi
@@ -959,7 +959,11 @@ &sound {
 	pinctrl-0 = <&audio_default_pins>;
 	audio-routing =
 		"Headphone", "Headphone L",
-		"Headphone", "Headphone R";
+		"Headphone", "Headphone R",
+		"DMIC_INPUT", "AP DMIC",
+		"AP DMIC", "AUDGLB",
+		"AP DMIC", "MIC_BIAS_0",
+		"AP DMIC", "MIC_BIAS_2";
 	mediatek,adsp = <&adsp>;
 	status = "okay";
 

-- 
2.48.1


