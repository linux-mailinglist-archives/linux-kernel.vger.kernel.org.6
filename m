Return-Path: <linux-kernel+bounces-400976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D279C1496
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB8442871E5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 03:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F236715575C;
	Fri,  8 Nov 2024 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="Vp7z8HWv"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAC5145FE8;
	Fri,  8 Nov 2024 03:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731036308; cv=none; b=nBwgoOZ4qsXZ082uzgdvZwNcPclkXvmNuayyJMiIA+TeNdp7pHAQ4/Tg0zPuhteCKU1ioRQ7jnGWMoE/kuNNdMpFkifjxSnO6VBpBxHETzaNaP3YfebdLvtnhDosm3bIbQRKgH5AkAk2Qr2WUXIdmiQusb6S/DDSeEuO1Kw1MRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731036308; c=relaxed/simple;
	bh=DTIvffQyFOLCJCeaZdMTtXTD+N2DNjRlLdtnwLjY4Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sd8N+ySTJsaWBvE0p2fO/pPicX7yYQ0T8jmCMnx+rByZ2SlsEKP7PuCV6UZP5LoMSjFtfbGUEeBjZ7z2QsqfX64joUUlT5V1NI5sJAbJPa/x+Q1BThLrWzwhV/9XZme0PRKaxGUnEvNA49M4nCgac+BexANtIHd7PztJTntBBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=Vp7z8HWv; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.160.23])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id E1E00788B1;
	Fri,  8 Nov 2024 11:19:00 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn E1E00788B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1731035942;
	bh=zalAWlbFESuTIXMiBlQXrsSWi3K93QpEzxzNNDSnYbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vp7z8HWv11IA81Sp45yTvcUtz70ceFPM/efTZlRk2+E1yEX51c2vPvA8dKYlecke5
	 f8rPlTmBjy5U4gW/qpKGH2FzRUCJd4brHEUs/A7+xW+N7/p2OwEMrBGt0XpN/1tsQp
	 sXioovVjnPaJDAg6ltGC0CG/tZIRXmJ+Eub7PIlA=
From: Junhao Xie <bigfoot@classfun.cn>
To: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Jonas Karlman <jonas@kwiboo.se>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Junhao Xie <bigfoot@classfun.cn>,
	FUKAUMI Naoki <naoki@radxa.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: vendor-prefixes: Add prefix for Ariaboard
Date: Fri,  8 Nov 2024 11:18:45 +0800
Message-ID: <20241108031847.700606-2-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108031847.700606-1-bigfoot@classfun.cn>
References: <20241108031847.700606-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for Ariaboard from Shanghai Novotech

Ariaboard represents a product line from Shanghai Novotech Co., Ltd.

Link: https://shanghainovotech.com/
Link: https://ariaboard.com/

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b320a39de7fe..ddeb4ade4080 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -145,6 +145,8 @@ patternProperties:
     description: Arctic Sand
   "^arcx,.*":
     description: arcx Inc. / Archronix Inc.
+  "^ariaboard,.*":
+    description: Shanghai Novotech Co., Ltd. (Ariaboard)
   "^aries,.*":
     description: Aries Embedded GmbH
   "^arm,.*":
-- 
2.47.0


