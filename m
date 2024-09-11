Return-Path: <linux-kernel+bounces-324888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E5975227
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39CE91F21018
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807E2194080;
	Wed, 11 Sep 2024 12:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b="awEZ074G"
Received: from classfun.cn (unknown [129.204.178.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6062F176FD2;
	Wed, 11 Sep 2024 12:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.204.178.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057733; cv=none; b=GUpvPyVrgMP2t1CekqtBKPhl9XppFDsTcTtunJkueOYOw1TP6wuIX8SFv1GfAIayzUIs9VIG6XvOE44RDYOfOivAw6AWDyfSvWqv90CR9Q4wiWgdT4+uRUBLmO9M5M4ZopWbavMgjDeWU4ZhmGGaI5EpT5h/t0h6N7sJs4HyxPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057733; c=relaxed/simple;
	bh=acxLMwAeHXmKoAPWmSOUWqniiM1VGXObmL2eXZCf2iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZnKjf2ZrhJrq4jd+my+HHKIH5N3WPNddMkQQWsoZQ6PGa2gfXJNrM9xG7eWiMGg4IEvSH1QRipJS7GGIgzue4y1l7JbnsBjIxo4M2ZJCJTZt25ElswWv6bvOQXbb5Wkgn+TNz5itqKo7DpnacRjvt7P5FDQZntY05/aIw7ri94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn; spf=pass smtp.mailfrom=classfun.cn; dkim=pass (1024-bit key) header.d=classfun.cn header.i=@classfun.cn header.b=awEZ074G; arc=none smtp.client-ip=129.204.178.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=classfun.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=classfun.cn
Received: from bigfoot-server-storage.classfun.cn (unknown [124.72.163.173])
	(Authenticated sender: bigfoot)
	by classfun.cn (Postfix) with ESMTPSA id 96EE17890E;
	Wed, 11 Sep 2024 20:28:42 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 classfun.cn 96EE17890E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=classfun.cn;
	s=default; t=1726057728;
	bh=VxKX2yW3hXBVxO4kTWCelxZoamv0eXklRuRpYCKRibQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awEZ074GQjMLA+t/NHdxpVjOqaFkANSYjuad8p2VvslTenoKIckLXegm79uYDeC45
	 v/XiehzvYZSc4nJNKQho88xVcj4Gc2RoTdcosmiGePM5x0iYuii1b4+kmdGJGPYszv
	 rrPRNn7UwxO9llPN4su+ZBQ9qA/rj9jjvcI+9u7o=
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
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add prefix for Ariaboard
Date: Wed, 11 Sep 2024 20:28:08 +0800
Message-ID: <20240911122809.1789778-3-bigfoot@classfun.cn>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911122809.1789778-2-bigfoot@classfun.cn>
References: <20240911122809.1789778-2-bigfoot@classfun.cn>
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
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..849b7b0f9097 100644
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
2.46.0


