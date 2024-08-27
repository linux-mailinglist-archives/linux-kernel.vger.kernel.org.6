Return-Path: <linux-kernel+bounces-304044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F132961914
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CAB4284D9A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060F1D4142;
	Tue, 27 Aug 2024 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="uMMhWIDd"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2505186E3E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 21:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724793534; cv=none; b=PYF7AzCwPvzIjOrISnq5c/aXpLg7WUVsoCXnjuydjbTVeoXtHJHWSQc41BBC91oLoicZDzhwAX/Q008fQRri3xxJgmb+WpEo6XGEXCgILTluk6cmiVKSMSSwS7ds1UmqTzdSBnxfMBt/wdnGiVTz6tiumEj4JKIgjV5BE1HmQkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724793534; c=relaxed/simple;
	bh=RDbJv82lk0D3tTscnWEaHOg0GYw75s+ZiPka2RboCQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWpLxhi08Gj4wdYvd80c29m/cUpYc3F/ZDuZ/IfigUb1d9s00QAYfpRGQ+ZcGeP7c/BxwpnjOGlPJtaZQdNSRW6J8mcSZoJGtXp00kx7DtnDH+W7h4Usy6jLPEcla1j0VvRzxIe0zuyY54yy2wzVZRikqy6rjscLAzouOmu/pTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=uMMhWIDd; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1724793523; bh=N+m6VozoSQEDl4c9f4ixFCDyQnruh/fyJbGweefwo+Q=;
 b=uMMhWIDdIxguXtaWryD9G2OORZyT+lQ4M98ZD4ih2UfqxMOCv74lz+qV12qsgE4uh+ukuH3jG
 oAEdxMOOPsek30DqdARyNTQdk5DBob59WZjhjV+mdLuls7MozHx0twb5KrmQPmI+Wv9/mJd4Ski
 oaJ5nowZZt+s5wyB9s9J3skfw91fOzo3gqQaKKGxaovvjA399W3EaeQOqVDzJ4AiZvZONVq01wK
 aEVS8fyfC0+UpRrIJbI0SSbo7Wlq6/voOb0KmFVovJVaYeSsxMcrif8QV5+iSbNY7zhFHhvjX1G
 dWdmuSL5MPqNqSrJiOr0RYetN3dJ2m56LKjAGKf8N7IA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
Date: Tue, 27 Aug 2024 21:18:17 +0000
Message-ID: <20240827211825.1419820-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827211825.1419820-1-jonas@kwiboo.se>
References: <20240827211825.1419820-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ce42b2ec205819dc6f17b5

The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.

Add devicetree binding documentation for the Hardkernel ODROID-M1S board.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2:
- Remove the redundant rk3566- soc prefix
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 207358b2faf0..1f137a8dc572 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -598,6 +598,11 @@ properties:
           - const: hardkernel,odroid-m1
           - const: rockchip,rk3568
 
+      - description: Hardkernel Odroid M1S
+        items:
+          - const: hardkernel,odroid-m1s
+          - const: rockchip,rk3566
+
       - description: Hugsun X99 TV Box
         items:
           - const: hugsun,x99
-- 
2.46.0


