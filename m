Return-Path: <linux-kernel+bounces-390051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9449B74F7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 513091F2500B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F416C6A7;
	Thu, 31 Oct 2024 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b="GSHrLcIQ"
Received: from thales.epochal.quest (thales.epochal.quest [51.222.15.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCE149005;
	Thu, 31 Oct 2024 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.222.15.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730358213; cv=none; b=I9GCQqSdAolnVWL+QwQd2vgCaR9NdR1Z9FFPcpALh5uNfuRtr+r1VrcLi+M8nE4/KrCB7KgQyEaFw+66aBxFw+YrDL19heW3jrPhUqw2gjqxzO2T3U9ZrMr+rKooiJbLTdQhtF5IJTKUpb3b1LDMgXN9lXoiDcgEv619YY0XzCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730358213; c=relaxed/simple;
	bh=0LhzF1eZO0izMe91R4cLDD2hqekd2yJ78S0js9TCEkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTkACAwvKirejqkX+xolQEYMT5D8Oab1WCIPFEqc2Nia4TdUXA0/VAWEK0m1GOtDK09wMpsv9kjFSCkvJWJa/CzW/pk1itfg0YS7+AOISeo4fB9G5eiAWX0yxk3iPkOwWo7rfRxXE+kFNQi6B8g7i6LbkFqm3l2WVxeRub/52s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest; spf=pass smtp.mailfrom=epochal.quest; dkim=pass (2048-bit key) header.d=epochal.quest header.i=@epochal.quest header.b=GSHrLcIQ; arc=none smtp.client-ip=51.222.15.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=epochal.quest
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epochal.quest
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epochal.quest;
	s=default; t=1730358203;
	bh=0LhzF1eZO0izMe91R4cLDD2hqekd2yJ78S0js9TCEkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSHrLcIQavfOu5jndVUyp3moeN2WNYQqwpv6lKrnz0BCVLQCf1F7FCCatCJEZ3RRW
	 qSeAFYcOuccXSwLFJYWeB7B6RzKPf0L1bbAULmlx1rTHpemWzpmF1dtz86hmpKua0h
	 ZOacpnND60l/ExC0WrTkeoTrrBuuBn1q8db0/4qqGI9C5/0I0tBu0vnXvGvbEUHWe3
	 RXpbCgrbniolgdQD09krx3sSfMLEsbohaswtDK4mqOjDSjDFCeqgvGCJ8aXrEPTuf3
	 yI28ILLij8e4jrBbjfQuy5nD92jwtpJ+Hn0Q+vat2z1cbtGgJ8YRCjXB70vjyKpeRl
	 Doh8eG5HYQBzg==
X-Virus-Scanned: by epochal.quest
From: Cody Eksal <masterr3c0rd@epochal.quest>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Nishanth Menon <nm@ti.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Parthiban <parthiban@linumiz.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Cody Eksal <masterr3c0rd@epochal.quest>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] dt-bindings: usb: sunxi-musb: Add A100 compatible string
Date: Thu, 31 Oct 2024 04:02:18 -0300
Message-ID: <20241031070232.1793078-6-masterr3c0rd@epochal.quest>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The A100 MUSB peripheral has 10 endpoints, and thus is compatible with
the A33 version.

Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
---
Changes in V2:
 - Fix ordering of compatibles

 .../devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
index f972ce976e86..bb5010dcefe1 100644
--- a/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
+++ b/Documentation/devicetree/bindings/usb/allwinner,sun4i-a10-musb.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - allwinner,sun8i-a83t-musb
               - allwinner,sun20i-d1-musb
+              - allwinner,sun50i-a100-musb
               - allwinner,sun50i-h6-musb
           - const: allwinner,sun8i-a33-musb
       - items:
-- 
2.47.0


