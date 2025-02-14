Return-Path: <linux-kernel+bounces-515171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45FFA36138
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A1D16BBB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 15:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068C226738A;
	Fri, 14 Feb 2025 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="e6S0uCEi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D78266EED;
	Fri, 14 Feb 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546115; cv=none; b=rcZr5U54m6lPBvTgMaxKnoa75W3+vH8GgzpOlvA1Cp/zK8i/5W1l2HcyZP9yzOrdfQAqbv6mc2V0YFTC+y3msfzVPksY1GUfeHaLj0wZ928O/l0IQ0Ab8qvyD4eM3L50cNVpwbPFPaRbktMz2DXYGk++Ss3/EGfnHtHdjRFWft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546115; c=relaxed/simple;
	bh=JlKd02FMr5+yn8vnMu4CtaugEG5YPJLOEvhxTZp5wBQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abBwMN/qtE2C0fVy2TB03IFQDaEPygguEURKaGPnobIhNV6CPJYO6yCzkPEVWGRFrXuoaDxyCxc2D7RewXjmEfUA83Ds7qvCCzZO6e292EYYVXYy+SsaspLPrieMuKkvXACszrQrU7azcfBdPRFrTNsiw75kTok0omrbC2Iovl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=e6S0uCEi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739546106;
	bh=JlKd02FMr5+yn8vnMu4CtaugEG5YPJLOEvhxTZp5wBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e6S0uCEimvGI6HgMA73JSU5MOVMGZa/3wpyIYb1lmvNeTMQ2a+8bTZZSAWU1RNN9W
	 lDiuBMZ4nGKLQ413R1OUJ3YrftqHerYyQJkX0poh3WW9FVnN2U5TwU/4mNsi+jzKF6
	 MoemyRcF03xqTkGPQC80Oe9mHTBZhNvUABNpmoRLwQ7CR7r9HBd9gJSjM7J88qtRaA
	 9grK+3Vlx2G5Hlt8Dm8OsdMLqrULtwW69o6mIanHi6qRie22gmGJI8ujDdrX7S2X2M
	 a/RJOAq7hVXz/4cNIuA9sYX/JFJ+IaNXVmKffYAWhVS+7/kuZwDz+w5MCtiZ+vlkDi
	 v5OfdBF/t/MYg==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1003])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1CCF917E0FBA;
	Fri, 14 Feb 2025 16:15:01 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 14 Feb 2025 12:14:29 -0300
Subject: [PATCH 1/3] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,accdet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250214-mt8188-accdet-v1-1-6bbd5483855b@collabora.com>
References: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
In-Reply-To: <20250214-mt8188-accdet-v1-0-6bbd5483855b@collabora.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Trevor Wu <trevor.wu@mediatek.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: kernel@collabora.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add a mediatek,accdet phandle property to allow getting a reference to
the MT6359 ACCDET block, which is responsible for detecting jack
insertion/removal.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 362e729b51b43ec16716aee70ad736420def81f3..41d303e28e4dabd152140531ec0bf7375741b659 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -40,6 +40,12 @@ properties:
       hardware that provides additional audio functionalities if present.
       The AFE will link to ADSP when the phandle is provided.
 
+  mediatek,accdet:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to the MT6359 accessory detection block, which detects audio
+      jack insertion and removal.
+
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object

-- 
2.48.1


