Return-Path: <linux-kernel+bounces-549774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A73A55725
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13B0C3AC5B1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C225C275601;
	Thu,  6 Mar 2025 19:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iA3r5LYz"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A36272931;
	Thu,  6 Mar 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290789; cv=none; b=HcqotZQm7ZsAhbAsFehdYU3iqqV9cl4Z550NhmevBhA0vqyROboP2EfZ+dqLxor6aCnmVHdeNxjTy+WIaAc3c2KiHlJ0Tf0skupP1CfAmVNrNbBYNHIn5kKSOz/kPMA5/VNYltwXiA82aRHxV+XykxOz4JLUzLkRA3XLQgZHPJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290789; c=relaxed/simple;
	bh=kqLKsRWONIOEmraC+9O8yD+AcyM64UYTSdcTa/53UAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GloD3kBv7pl9F2zqaDOvfBnP9HguBH/zhsDNedvjGCBRUOT3jjIqgeUP0Rin90mKy0q5IluWHze91mHU1i/aMRQaXXojSFj94Y3acu1err6S10MFDyd4TCsD/W+TJpE6rWS8Gw3oSF5m6EaJWzKoNlrnWz5Y5uGEjakHPvSoo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iA3r5LYz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741290785;
	bh=kqLKsRWONIOEmraC+9O8yD+AcyM64UYTSdcTa/53UAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iA3r5LYzxaP2yAgv5oief1N6BEqqJ6EhZdjo+YkSNPe8zEdNs4BifC1bdt8N1EH6a
	 EAWJtBTQxcYO1oe2NBxwhelfx46ySm4NKbkKTdS2/Jd/YnikmypxOHLjmUd7bPOak/
	 cGm3bbkur6xk2JLEP5d5qEacWGx9xgcKlHE0/+9TgLlfxx8G3D7hVCZQ43J7QmNTun
	 AvN1TEkV6bBoxWwzMkx3M2Z7w3b8+LrOdkJU4sISdx46kFkm8l2N5PcEI0kBmS7tmh
	 UrpmxxDk1QL9bADW6sat5du3zi3A64BsT+LBnMidl8VvDp3KvLhLWbVuObjMT0xLw7
	 PDeWY+L4PyDVw==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1002])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AAEDC17E0607;
	Thu,  6 Mar 2025 20:53:01 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 06 Mar 2025 16:52:15 -0300
Subject: [PATCH v3 1/4] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,accdet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250306-mt8188-accdet-v3-1-7828e835ff4b@collabora.com>
References: <20250306-mt8188-accdet-v3-0-7828e835ff4b@collabora.com>
In-Reply-To: <20250306-mt8188-accdet-v3-0-7828e835ff4b@collabora.com>
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

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml         | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index 8c77e7f68ad7b6f5b88b53cedccb291139a2eeea..76d5a437dc8f4ad1f31c21f84304bad326b0facd 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -40,6 +40,14 @@ properties:
       hardware that provides additional audio functionalities if present.
       The AFE will link to ADSP when the phandle is provided.
 
+  mediatek,accdet:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      The phandle to the MT6359 accessory detection block, which detects audio
+      jack insertion and removal. This property should only be present if the
+      accdet block is actually wired to the audio jack pins and to be used for
+      jack detection.
+
 patternProperties:
   "^dai-link-[0-9]+$":
     type: object

-- 
2.48.1


