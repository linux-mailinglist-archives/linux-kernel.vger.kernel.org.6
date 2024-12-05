Return-Path: <linux-kernel+bounces-433210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC999E552B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D2F1881A84
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C9A218846;
	Thu,  5 Dec 2024 12:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q81DvHXi"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D68D2185B9;
	Thu,  5 Dec 2024 12:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400919; cv=none; b=tCbdoI4QQRwT6Z5pGObwIvW/rCczdHtThZiGKsqGd33KnDSONBuLvCjxEZVeVwB/MBj4TnZbkrkaJhBmTjnMiBE9IIadXA1rxG/vJ3czrzIGqrRtOwhSgzeCSPSIRAxbU9NkKq5g/URxLVdH3HNLNaqb/aHM2iaGAOFnLclkR9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400919; c=relaxed/simple;
	bh=otE4SGQQQOEOXe8kbkzhKoyw2kCK8dxjt0QPi5mvR/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hH2qazFE95tgqZNM/q/lNFLbQsmDataR+0L/ja7GDK1lOmyAoVMzmPdoWNf3irrHVgpfijHhAUiKZ8sr/QghWg3rnIGAP/hQrIMm6+RmjE3RSeeV8ffLeb9OC9rGu2xBFkZFJzh3XMKQREyrbnZe1Xu2P2Y5OwXQOhLvp9JX9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q81DvHXi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733400915;
	bh=otE4SGQQQOEOXe8kbkzhKoyw2kCK8dxjt0QPi5mvR/U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q81DvHXiqTu1FnIbPP+8I337ekkRISKqEsY66bf1+JvhgXb+imi4pVg7R2Ztx4G0h
	 9q/EBdXeGbvGEEB7cmLCO3Z0ahtSIfqoZU6OZL12E1O8qq/jA5hstoqiDjfXx+lpwY
	 mEBvcv9AiK+FfOHT3Wt5cG/LyL5330XB7r58jmJHks5j/7VvHXmANC0miB8NbJn6ZO
	 9fcXyWtsyP9u9gW1YQUCCTMJTk4lWOWztClmd6EhpjQvhSkneISVvJvyFiwPv3vF5t
	 b2pi9SEEjCKLFFJV7spV50ZlsncjGg5XYDKEg0CfktIhfm9lVVYzXwbOP7VTVMydhv
	 J41QN4ClCEExQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3E58417E366D;
	Thu,  5 Dec 2024 13:15:12 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 05 Dec 2024 09:13:55 -0300
Subject: [PATCH 2/5] ASoC: dt-bindings: mediatek,mt8188-mt6359: Add
 compatible for mt8390 evk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-genio700-audio-output-v1-2-0e955c78c29e@collabora.com>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
In-Reply-To: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.2

Add a compatible for the MT8390 EVK. It is compatible with
mediatek,mt8188-mt6359-evb so make that the fallback compatible.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml  | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
index f94ad0715e3239653c74553e27231f1395babefa..ffe9347b543f5c687433862a21ad534b8aace27e 100644
--- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
+++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
@@ -14,11 +14,15 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt8188-es8326
-      - mediatek,mt8188-mt6359-evb
-      - mediatek,mt8188-nau8825
-      - mediatek,mt8188-rt5682s
+    oneOf:
+      - enum:
+          - mediatek,mt8188-es8326
+          - mediatek,mt8188-mt6359-evb
+          - mediatek,mt8188-nau8825
+          - mediatek,mt8188-rt5682s
+      - items:
+          - const: mediatek,mt8390-mt6359-evk
+          - const: mediatek,mt8188-mt6359-evb
 
   audio-routing:
     description:

-- 
2.47.0


