Return-Path: <linux-kernel+bounces-553918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0938A59096
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D262188EF61
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937C62253E4;
	Mon, 10 Mar 2025 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="FEXAgxF4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CDB29A2;
	Mon, 10 Mar 2025 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600869; cv=pass; b=Ns59pSm5xSNLJ1rBiukMpzo/GlfWOTPIiJrXHtjd7ob8jmbvWkIvtd7JMiNzYFR39RVbHVK4aTgq3ZSMScGger+4TT7qnKryU0mguhLJwfSmJYS5wmwQlhcUM8Y0iF2indDgBOWT1+yrYYrCYwCyhk6qcO4m4RJU7xvVKafnbbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600869; c=relaxed/simple;
	bh=slBkkxdL5yulCJikcYC8ve+41KsUu/C+4DkmX9HRbTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QmI+FPAaOyO/ICnUULk3v8Hlv8etNHp8yDcSQi5bma3T/w7wPTM4Wy9ogVqBjdX/jtM7f0r/8Vojmo1Ooc2tBWTaRdarTH45Out8ljEPXQ1bUtF3q3gGCwX/2jUU7qyezaO+vj/AY79j7hfrAQLONUVVikHhtudedr3ek4LcAfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=FEXAgxF4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741600838; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=X5Ku3qEwrPdTwHAs8CrQxzz2J3LO50Dck05HJNsqiSXQMoKhtAqznZE+V0P6YikN9ZZ277HTM+mzbvazOm0VOmiiNkWaMXt9uwn82hGV305SLJrsGvV+z8dqAEKR87i7zKXpZZSO3QQMLZL8huG6pRnlKF53/XDtsgyXPOQy7AM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741600838; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZwrgReuxeLe3BlfVPHAP9VVYbVwRHECtchfxWVqLJ5Y=; 
	b=cnQQnbBEmSBNlT159xZEkiUBzCZF2A72tJCc0ngGWPQ5QSiQgLS05RjkssshA315YjAQxycIN6vSI6e8AVAEjQc5F8Mw2gdiVA35GmPASJ/JNHeGPocFEqeHNnHEmAotyHbNw0VfxJk4E6YnFYgLU7bFoWySIm3yzHnWBdcg4yY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741600838;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=ZwrgReuxeLe3BlfVPHAP9VVYbVwRHECtchfxWVqLJ5Y=;
	b=FEXAgxF4nC6Mz0MdzNKCqEIZv3V8zKnbJSpXnnHH9MkA5JID4lrpIXUeQr5dDrvl
	u/8yhefBhas4jgrjELJ5R9yjvjA4YtQ+k49yqWmRQ3xc6RJf6lMACwK7kI7HbkoaHzh
	oytOKInKXZSHdT5vISnl61U4WFbs+RdEqK7+N06E=
Received: by mx.zohomail.com with SMTPS id 1741600837144360.63308913443063;
	Mon, 10 Mar 2025 03:00:37 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 10 Mar 2025 10:59:56 +0100
Subject: [PATCH 1/2] dt-bindings: clock: rk3576: add SCMI clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-rk3576-scmi-clocks-v1-1-e165deb034e8@collabora.com>
References: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
In-Reply-To: <20250310-rk3576-scmi-clocks-v1-0-e165deb034e8@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Chen <cl@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Mainline Linux uses different clock IDs from both downstream and
mainline TF-A, which both got them from downstream Linux. If we want to
control clocks through SCMI, we'll need to know about these IDs.

Add the relevant ones prefixed with SCMI_ to the header.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/dt-bindings/clock/rockchip,rk3576-cru.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
index 25aed298ac2c2e2d37e2b441c9d92ac68801be6e..f576e61bec7041455e10ac18c92f3b33ec0760e3 100644
--- a/include/dt-bindings/clock/rockchip,rk3576-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -589,4 +589,9 @@
 #define PCLK_EDP_S			569
 #define ACLK_KLAD			570
 
+/* SCMI clocks, use these when changing clocks through SCMI */
+#define SCMI_ARMCLK_L			10
+#define SCMI_ARMCLK_B			11
+#define SCMI_CLK_GPU			456
+
 #endif

-- 
2.48.1


