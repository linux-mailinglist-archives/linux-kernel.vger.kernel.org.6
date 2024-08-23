Return-Path: <linux-kernel+bounces-299215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27F95D19F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD811C2320F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C755718E03A;
	Fri, 23 Aug 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="TL5x0lf3"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFF318BC31
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427368; cv=none; b=TQfbV+K1Sp9cf1G31o0qOb5djyCSuXi9FtUTuXhKgF+LlrCdaxCl0IeD52P0bkMXjSX8h1wIf46RNp0WZXnDHJuDRDbX/qA8n/0dadqsB2EQOB7xmCoSwG98gXlSGOK+RbnRk/aAUSyTDSrwkRwExZC5HPCf5fFgo+EKbD1Q5tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427368; c=relaxed/simple;
	bh=KhQ906/MDvum52hDYNzfnndzU3tfH8pKxPSR56Z8uZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajUYR1AW5Qk+RUeVuCkWVxvYXGgQ3PpO/XPiVPEvO4kgvGPA9bUoeyP7G1FlxsbMkMjLpRun8h9mNQFia6qcxExKGi5Weypmv89g6Odas+43JihI72NyalvTlzk5dE93adK0/ae8pphSxwQOe04DtNB2eJ+uOsapnsTuR2aqiEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=TL5x0lf3; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
	by cmsmtp with ESMTPS
	id hHOiszQIVg2lzhWKVsOmVm; Fri, 23 Aug 2024 15:36:00 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id hWKTswjGGML7zhWKUspHGr; Fri, 23 Aug 2024 15:35:59 +0000
X-Authority-Analysis: v=2.4 cv=asm0CzZV c=1 sm=1 tr=0 ts=66c8ac5f
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=yoJbH4e0A30A:10 a=ARcrkP6DAAAA:8 a=vU9dKmh3AAAA:8 a=L4MHaItcyTsGJ2lxC4sA:9
 a=HWcd8CIpyGgXnveeQW_Z:22 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QVMH6+AQBoL0WKzlVIw6S0+n9yYlQNc8yrm7EGRR5DU=; b=TL5x0lf3UV3Md8RKG8rOeKrkSC
	HUE2BMk3vni1Yg+IeOBy7PIDAOP6cMvpTgWa37CcKfX2syyLTzGIhCf7XC8fbOwsQ4dho2os57gbN
	Y0bkR+cQM7sFIaxEZSu0TSWYGxgQSLEZZt38qBNRPPyUw0hz8m/81oEByy46xbLBgB0GqRHNPduyS
	ZVLIxwIWKZKjm73EFPpWxY/c5WvzHij/dB2LJR40Ngvt8l+/ln5NkJvSqQW1FuVJZ0MFmKQ6rOJRT
	i5IcYovxtKM5EPdQ6Pu+waKingQpS0FMiwqP/VI/tNSY440LL0Dd7tE9Sem143ZRSsodRVOO08FUp
	F/EUtKGA==;
Received: from [122.165.245.213] (port=53684 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1shWKR-000GB4-2H;
	Fri, 23 Aug 2024 21:05:55 +0530
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
Subject: [PATCH 6/8] dt-bindings: vendor-prefixes: Add Relfor labs
Date: Fri, 23 Aug 2024 21:05:26 +0530
Message-Id: <20240823153528.3863993-7-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240823153528.3863993-1-karthikeyan@linumiz.com>
References: <20240823153528.3863993-1-karthikeyan@linumiz.com>
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
X-Exim-ID: 1shWKR-000GB4-2H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:53684
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 62
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDHbyEHD85JYP7uJExkME6ydvqtGLnaCp/ApkH6poYY+TA3XiIBycEZUUHspVTKl8XfNbk4FPKTvLXNPy/shxAgs1hGGCK+wY4a1DXMTcP8UuBEpxNhe
 TtB8/kf1V+OrCHW3PBYC1nFGBv+tMmi7IbgY/wvYIT0V/WrZdn2c8MV0QEi0r1AkhDC1aIE6yzHtDIlk0xU2K4RT6537+E3P5OfNe92yMrZ1PZWk474xvWF4

Add Relfor Labs Pvt. Ltd. vendor prefixes
https://www.relfor.com/

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc0..7d10ac7d6800 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1220,6 +1220,8 @@ patternProperties:
     description: Unisoc Communications, Inc.
   "^realtek,.*":
     description: Realtek Semiconductor Corp.
+  "^relfor,.*":
+    description: Relfor Labs Pvt. Ltd.
   "^remarkable,.*":
     description: reMarkable AS
   "^renesas,.*":
-- 
2.39.2


