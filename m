Return-Path: <linux-kernel+bounces-326711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DFC976C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7802E2860FD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AEA1BC9EC;
	Thu, 12 Sep 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="iNrPafFI"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313CA1BBBD1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151186; cv=none; b=AyIXbBOyki/L8yNh5oVAW54LhlWoBotztacY0IEIqGuTayY3OvbfjNJm/cFZSm3GqT75ii3nMrYal2yTcnc1hrs2IuzhCD50w35XE9Qn1qeIufiCiGcWddKG+U17e0nHUYbaWsTPdyBYHVM/1nsOidZVJc4XoosSUg23GLUnqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151186; c=relaxed/simple;
	bh=I4W3+7s6dJnx7xXMW4sHD8e0zh2O1/GmeX4hIefSRvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQ9Kp7IdqrG+vIRRHvmjLa7NdAQDsXKOBUMlr0HbwJpQowNhrgZvMcFUUzW/pAzQaohc4Vzrfq6KTVzy8XKIdNU+bRd5ocUlH3W/KPKgHAAy4xCu6h2VbVVFimyY1l9te2MqQ9Yvdvjm+M0u/Ei8FNtxtuSRDmC8mKy30AeIxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=iNrPafFI; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id okLxsfyBynNFGokm8sgV86; Thu, 12 Sep 2024 14:26:24 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id okm5shg9Dn3BMokm6sDRRO; Thu, 12 Sep 2024 14:26:23 +0000
X-Authority-Analysis: v=2.4 cv=DY8RqOtW c=1 sm=1 tr=0 ts=66e2fa0f
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8 a=vU9dKmh3AAAA:8
 a=7OYjvGxe6aps89qF7tkA:9 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q3nSf+jGddQX3+uTVKIG1Xgr4itWK8uPrGRSisvTDwU=; b=iNrPafFIoD65zmFiipdpwCkAx0
	lirSOPNcyCcAP8W4t4IrFzwFTCLI+mzx0Dq+4zJ9kFNBzAJ4/VycyKvazzEuPqEo1pRjtNHrbKp0o
	RWbp3UwvVzszBP09uB+8YaALFDPb82dYXCJTIaTBAB9BytRAgaNx9YdWjQVrH8/M7LOotkJgNu86D
	jr2r4zmBBcoz0xqCwHUzfUg8hzV6fh5RTxIfXrKAB+uCqYb3WvwnFm5ZoW7L4tqZ/eq5N1xiAbWyv
	A8MMAW512hBYd3KPDOOMDwgU0nQL9aemdTXkxpc1oiURd/rGTSVZt2r1w9SMQIEFvBZLEOn5tCzg2
	VgaTjbjQ==;
Received: from [122.165.245.213] (port=41006 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1sokm3-003n4z-1r;
	Thu, 12 Sep 2024 19:56:19 +0530
From: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
Subject: [PATCH v3 5/6] dt-bindings: arm: rockchip: Add Relfor Saib
Date: Thu, 12 Sep 2024 19:54:50 +0530
Message-Id: <20240912142451.2952633-6-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240912142451.2952633-1-karthikeyan@linumiz.com>
References: <20240912142451.2952633-1-karthikeyan@linumiz.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1sokm3-003n4z-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:41006
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 57
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMUP9jcAy2/3oQmWdxm2HADDjuQ2n+7ahgykhDe/2Uip9Q47RUZ5gEQC4gLYIzu5+t3X27NC2j1cVhlhqqqSVJrgBDYKJJNkiNm2h6Wsua5K++bspXUq
 aRDbjTHN00d6pAgOrKUM3dTcGRtzGQMcotJvF/kt9qQYJg0SLAmchnNcVm7zNZjug/+FcmQm9RSf6fVn6diFrZ0v2Y0I7FvGohs4kka+SBw8zDbwgbSoB/y4

Add devicetree binding for the Relfor saib board which
is based on Rockchip RV1109

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---

Notes:
    v3:
    - no change
    
    v2:
    - fix wrong usage of SoC enum

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 1ef09fbfdfaf..ae5e0104612e 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -848,6 +848,11 @@ properties:
               - radxa,zero-3w
           - const: rockchip,rk3566
 
+      - description: Relfor SAIB board
+        items:
+          - const: relfor,saib
+          - const: rockchip,rv1109
+
       - description: Rikomagic MK808 v1
         items:
           - const: rikomagic,mk808
-- 
2.39.2


