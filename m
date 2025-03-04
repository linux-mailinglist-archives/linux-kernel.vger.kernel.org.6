Return-Path: <linux-kernel+bounces-545632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A578DA4EF6D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656D8188F852
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE322780FB;
	Tue,  4 Mar 2025 21:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aaN9W9Xf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5822780E1;
	Tue,  4 Mar 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741124164; cv=none; b=RYbquUw8ZpE4FnCpDU5jy3VLFtjKw16LL0pk75HfCOtDd1X+rDXRaOd7bh+5urufmqwAbJd/Qv0zKw5m8F9M+vX1vE3YXifKnAXKXeBtgx1JkzTx/NIM8oNWnQa37FXPhWeZDgdUVZQRI75pgniajfc9md71FziLBDLj1WZQMRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741124164; c=relaxed/simple;
	bh=kqLKsRWONIOEmraC+9O8yD+AcyM64UYTSdcTa/53UAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jppTYRn3aMHl7a2zjgL4+XWGX1iMuYkvDtPP7hmJo5cPuYrFQVSMdhZyVg7D4KHX5a+7Cn8bwS6KRCwvMXt5tMNmuIyGGI/g8po4EeRkHtxal42QWWL6bueILz62U7sGbHI1WeV3jOCDRQ9Tacv1jJ/czUYDlnlpraN0d4OGMjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aaN9W9Xf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741124161;
	bh=kqLKsRWONIOEmraC+9O8yD+AcyM64UYTSdcTa/53UAg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aaN9W9XfGNIt1pfsnGJgUbprevaTyBRiiNRgutPt2zycvlKQ/KPaayi8Myrs22Jn+
	 R4ror4lsY9r0Ltaz7FGHSSPXDDy5uz7zhqf0CadrMja1ty3qCaemnkaOSSJVik3WLZ
	 i//zGlFXlE7qbgbBtItvMS45O8vOPeNVGor7+H0UNySSHTOAgN0onf6opzdRuErOZ0
	 a98Gz1LqB6PGiriskhE95CiPBjIVgq7bryqEVhMW1iQpQrQe/cIiM+c8AaD7nluRrv
	 srSZJCP1t0WguFet+Y0XsskbE//Pzw/rXkBe712WEnXZrKJkOA5flJFbQoQCuP/203
	 sjVjrB37OMI2g==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A918417E0B56;
	Tue,  4 Mar 2025 22:35:56 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 04 Mar 2025 18:35:36 -0300
Subject: [PATCH v2 1/3] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 mediatek,accdet
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-mt8188-accdet-v2-1-27f496c4aede@collabora.com>
References: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
In-Reply-To: <20250304-mt8188-accdet-v2-0-27f496c4aede@collabora.com>
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


