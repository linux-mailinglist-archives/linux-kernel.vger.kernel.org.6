Return-Path: <linux-kernel+bounces-300739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EC895E7BF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1391F21556
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 04:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8EC7641E;
	Mon, 26 Aug 2024 04:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="IpZERUNS"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84A2E419;
	Mon, 26 Aug 2024 04:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724647788; cv=none; b=ujnh11WM4SY9zrlOiIRhzNUKScV7Hn39Dc6zeltSYR/5NWM+iZ6Sdafs1meCkGQbDvuYoAOmCRxdJ/6idOHqC/7gwenDyqFGzAxkK9Zw/BfBGEs5XqBedcHQMEKwxSrgBZJgMsVZwHFjaSK06PYb8DGuZTPbZlmiQbrvFVxoOZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724647788; c=relaxed/simple;
	bh=3c0/iExWxHfA1R4X4g4Jj92Pno9I69MHrCQ014gopdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjRaDHvcB43AdX7BpYvOezdBvkeI8GLxwab1k/op0q3d1H9G5u8ywYSeDblD9KEywFrMFTu7BnPeTYCvxG5afv/ICgPQO2WPRvULgB1TCGyO5iSQoiwstE99jr95s3TSt7Sz+KlXQbYh+6UaZz4GkemDZYM93/vjcZ+y24y+nXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=IpZERUNS; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-arm-node1.classfun.cn (unknown [124.72.161.4])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 152E378921;
	Mon, 26 Aug 2024 12:46:00 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 152E378921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1724647560;
	bh=xy3BVZ51BxjGwxtVBSSEMAXgINYYbn7h0bC1DIDUHk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpZERUNSKzCW8tuMIZO8grTY68X9AXA5/707euG9hp/rnSW2Twg2WwrOjWki25YOe
	 W5OTNqCKwHpQfK6IeAri0U3saSmj1Z5jWQMQXEVIwxh08ZAzJTtrzQdoYgy7bZvb4k
	 TeEnDiMaaSTnVjAF1mxDc8mFBcPovmhupnm/DyMg=
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Shenzhen JLC Technology Group LCKFB
Date: Mon, 26 Aug 2024 12:44:11 +0800
Message-ID: <20240826044530.726458-2-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240826044530.726458-1-bigfoot@classfun.cn>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for Shenzhen JLC Technology LCKFB (https://lckfb.com/)

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..e5d64fc4fe31 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -804,6 +804,8 @@ patternProperties:
     description: Lantiq Semiconductor
   "^lattice,.*":
     description: Lattice Semiconductor
+  "^lckfb,.*":
+    description: Shenzhen JLC Technology Group Co., Ltd.
   "^lctech,.*":
     description: Shenzen LC Technology Co., Ltd.
   "^leadtek,.*":
-- 
2.45.2


