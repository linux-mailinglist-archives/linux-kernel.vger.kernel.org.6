Return-Path: <linux-kernel+bounces-314858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1506B96BA0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70592871AA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B1A91D54DC;
	Wed,  4 Sep 2024 11:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="RhYU/o6v"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29291CC887;
	Wed,  4 Sep 2024 11:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448535; cv=none; b=FOpNg5/dhLQ7HOUFGSPOmIdLZxijymXiHlwnUnwtmTQc3b27uGgoZ2CR3kEcPxH6+jWlFPNRmbjhdw+MTWyVs/dXZ5p4abEk2tMdJWQ5y+OgErwJAwBIiVcezQ35KgFij5Nho1uzjzzHPdzzai1JGPJvy5fU9+GZvdtLwnqqMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448535; c=relaxed/simple;
	bh=V3mwBlviZGgfZioSkwsxLN72XvWdwXWJOEh2KcFkql0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ewJXkIj1CCBvL0Lw7ttWc5q7xGLzfdIQs4AtBmy6BF6D/Sfe1rY4GglHxLVfOLVaWioZ8rLmF29HLBZdy32qgsACW/Yet1jRna1E3XMtXnha6t+eeDS1aUylArX67ZFz3Ad/dhwg2KaAIdAGWZlp5m8/ZTQGukQf9yB/5U0FaWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=RhYU/o6v; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.162.211])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 2612878915;
	Wed,  4 Sep 2024 19:15:26 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 2612878915
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1725448531;
	bh=LgCWXjXm5LLz+unYkSuaYOG4MmVw9SSS9uowZ20puHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhYU/o6v870//WMiDbPFHKvMZHDnD6MIpHYwDgux+3q+4f+rPDP2s2WrC6PljJlv+
	 ge31YGFA4qmVXEpnw+/9wegWyKU1mWHmKsT+8Rlb1GAGverSDPrvUzfZwGUFZmLY3l
	 GKwsR4iGrO+6HYFyu7VC+bItpHnyeovuMgenxfmU=
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
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Shanghai Novotech Ariaboard
Date: Wed,  4 Sep 2024 19:14:54 +0800
Message-ID: <20240904111456.87089-2-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904111456.87089-1-bigfoot@classfun.cn>
References: <20240904111456.87089-1-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for Shanghai Novotech Ariaboard (https://ariaboard.com/)

Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..58d1a2e8b212 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -145,6 +145,8 @@ patternProperties:
     description: Arctic Sand
   "^arcx,.*":
     description: arcx Inc. / Archronix Inc.
+  "^ariaboard,.*":
+    description: Shanghai Novotech Co., Ltd.
   "^aries,.*":
     description: Aries Embedded GmbH
   "^arm,.*":
-- 
2.46.0


