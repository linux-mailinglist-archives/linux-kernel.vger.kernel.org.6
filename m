Return-Path: <linux-kernel+bounces-312764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30673969AEF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ABD1C23A0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2081C62D7;
	Tue,  3 Sep 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="mK5jSS8Q"
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C01C987E
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 10:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360791; cv=none; b=hF7oO/0a0zU23kqf/M2QkGq49hfTfwgFRZO90A72a0ECHBmKYIh8maca+KXqjkwONCObu4YgNZGyCaVAvZLJa8y7Q2QBobaBVMEhUtCgekDMWcCH5bAq66wDdVRkLAEJn44VXmL3zOPz5pg8hHFbSpziNLvoPuEF39YLIzwlLKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360791; c=relaxed/simple;
	bh=IEvc5bAwiIt8oyx0it1qXA04D8itst9KAXzwOeKt7r0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=noX2mNkGgroGImaGJ3pbhVXQjbavcVNteDbCVx7YoKcvnhbZYJrDPsqNGHH5vqeAqztIOvc8zaVUcs5/N+RkNwRtlkNKO5bfoJdEjdQJV+f5uiAiNBKVU7EHf+t5O3ggvdyZLiWw1FbsWrUAAVgfiPOfOmcl90/ewdScGldlYrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=mK5jSS8Q; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
	by cmsmtp with ESMTPS
	id lMaCsfw26g2lzlR9psXbAL; Tue, 03 Sep 2024 10:53:09 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id lR9msVxuTRBkMlR9nsR8mn; Tue, 03 Sep 2024 10:53:08 +0000
X-Authority-Analysis: v=2.4 cv=CbPD56rl c=1 sm=1 tr=0 ts=66d6ea94
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=EaEq8P2WXUwA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8 a=Kb_rVgeVel1wak-Xqx8A:9
 a=rsP06fVo5MYu2ilr0aT5:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FbIDmWyU4STgLTHI4VqNt8b7SMBSfP3dJQ9o9Le9Jaw=; b=mK5jSS8Q8/Iu7NGFXTNQlKgRID
	YC+shzubhO6R0M1heUNWgZW1GE5H9ycqewmgYnBX26PT/Jm4Wj1EVnlRp1R6VNdGLHEiUeRw58r3s
	T+20ayMdsRRLOcH1LLrgHjioyv8m8HcMJbPnE6oJReBABS/dVKAgNs8BvTXVoZ3KNUFWrbci2Mv1X
	5oPfy9nsv4c8xlEMdEXtlPa8JEBBY98Sy0v9OAg4WIs/0EaP/bIpUjQr/0bWabTzQbm+uFAWpFz0o
	0FESaRvbSgB8ZFT+S+khN4MS4+cTTBsuPMt0rzuenM483jqcKYxcYEsgKH9mgTHKDUJiYrg4U+Trc
	H/RCGwhg==;
Received: from [122.165.245.213] (port=41440 helo=localhost.localdomain)
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <karthikeyan@linumiz.com>)
	id 1slR9k-000Elu-2p;
	Tue, 03 Sep 2024 16:23:04 +0530
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
Subject: [PATCH v2 5/8] dt-bindings: rtc: microcrystal,rv3028: add clock-cells property
Date: Tue,  3 Sep 2024 16:22:42 +0530
Message-Id: <20240903105245.715899-6-karthikeyan@linumiz.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240903105245.715899-1-karthikeyan@linumiz.com>
References: <20240903105245.715899-1-karthikeyan@linumiz.com>
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
X-Exim-ID: 1slR9k-000Elu-2p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (localhost.localdomain) [122.165.245.213]:41440
X-Source-Auth: karthikeyan@linumiz.com
X-Email-Count: 53
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOtKoXZM5VLZ6Xx+AV7ELWa0Tuocc77WTDKU+lYkNu6vU5m9gITX5/0yOBy1xH6eY1+0hAw14fs2DQy0DsayKpZsUGhfa1O1yyKeO3eg1fUy8tq7TMr8
 KP/TUcErSDnkTxu70JC+iizbxDJzl9X/sABpZPHanShiz9EV8J3LuD9curlcp12Anx1oc2YYxYuoCHM9a2DSkh250uZ8IQePNaVhdjvu0CsWMVF85iKh3OL9

consume clkout from rv3028 rtc which is able to provide
different clock frequency upon configuration

Signed-off-by: Karthikeyan Krishnasamy <karthikeyan@linumiz.com>
---

Notes:
    v2:
    - fix commit message subject

 Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
index 5ade5dfad048..cda8ad7c1203 100644
--- a/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
+++ b/Documentation/devicetree/bindings/rtc/microcrystal,rv3028.yaml
@@ -22,6 +22,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#clock-cells":
+    const: 0
+
   trickle-resistor-ohms:
     enum:
       - 3000
-- 
2.39.2


