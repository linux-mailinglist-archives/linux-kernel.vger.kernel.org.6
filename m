Return-Path: <linux-kernel+bounces-547766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B830BA50D4C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 440E57A56AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE6020101E;
	Wed,  5 Mar 2025 21:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="iRw7kNwd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230971FECCC;
	Wed,  5 Mar 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741209933; cv=pass; b=F6C3WmLvToEw1pDUAjD+B4xhLyn4ZsdJfZ6eBpnSGkYlNy8e5Fl/vKRWaT0ENzIM7KkCEU73IZOaMmKXxaYvd2LckRA/7t5bGC3mWrF1KPl4yvAww12QGZsZUt7Q1mLolSA8gDZ0SlEsRml5XLwsD1crT3f2Q58H+B/UzmF5ThA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741209933; c=relaxed/simple;
	bh=lmP6mTX70m64S1cwVwkdCGsTUrdF91DqCtjdZQJzKro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAAV/fHrFpTDRhBuIXNMWvdqjLzzyZbAhRg3DhXAlAxyHQzI1jAQisyutcs71h6fXwn5Gca/U9KhEi/HNVbgb1LbI0nFHVxSb4V7W7Q4UOg0WswkFnQVuwCb147dTA7ogf1Ot+OAerGA5F0ZgNsq6RpYT49d/3lUDpY73/b7JzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=iRw7kNwd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741209902; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LPpRpTOTpGBW1N1KXO6lG4fjXGnEfUiE2GVgGQIVE+onZ0oz0XRV/3pYPdxqmI4AdN//bdvfIbxWXruEFW0GpX8P2CFVTmeGjeyI1Mn7TJOH1pZ8GPVIZIxlLWz6v2ZalWhEEEM7hpChHz6Z71kYoK7xpq1QyBlPJqYq2Swt7UI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741209902; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l0WQdUrdZJvKyXOHu07xCpPjCZtIyq2fPB6xG3qYqGM=; 
	b=UnXK7L/fOkC2itQLu9yR5izY2gYsVhw2vm4+yXW+H0GB96q/zcRDpe94dsfOFrAkBdFPUBC/yJgASa87J/b4+yUihim/79xDEX6hggg+RH7bGqMWPvwRT3Ahj6CmKJMpY3RDywP7V/2ygDrKwHtRzEsAnRhDNclNCq4OkvhJ8Qk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741209902;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=l0WQdUrdZJvKyXOHu07xCpPjCZtIyq2fPB6xG3qYqGM=;
	b=iRw7kNwdCDEIeYtbxWouwWu2FNaj4vprd51PoVeSVewffIOQifb9676ctXebrfAJ
	ovozdcDgcO6Spmld312QBVlUleu561VWuZCdQ5HG1ziK6PNIrK40TlG14a7llo5A3ly
	ooBwyIg3Y+S5iUxx1aroLsvsS2lBs7EANhMb60zM=
Received: by mx.zohomail.com with SMTPS id 1741209899333471.5790605921402;
	Wed, 5 Mar 2025 13:24:59 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Wed, 05 Mar 2025 22:24:21 +0100
Subject: [PATCH 1/7] dt-bindings: clock: rk3576: add IOC gated clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250305-rk3576-sai-v1-1-64e6cf863e9a@collabora.com>
References: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
In-Reply-To: <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Certain clocks on the RK3576 are additionally essentially "gated" behind
some bit toggles in the IOC GRF range. Downstream ungates these by
adding a separate clock driver that maps over the GRF range and leaks
their implementation of this into the DT.

Instead, define some new clock IDs for these, so that consumers of these
types of clocks can properly articulate which clock they're using, so
that we can then add them to the clock driver for SoCs that need them.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 include/dt-bindings/clock/rockchip,rk3576-cru.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/clock/rockchip,rk3576-cru.h b/include/dt-bindings/clock/rockchip,rk3576-cru.h
index 25aed298ac2c2e2d37e2b441c9d92ac68801be6e..9dbccd8ed4689ee85c9220c1404f971b73c7d4ea 100644
--- a/include/dt-bindings/clock/rockchip,rk3576-cru.h
+++ b/include/dt-bindings/clock/rockchip,rk3576-cru.h
@@ -589,4 +589,14 @@
 #define PCLK_EDP_S			569
 #define ACLK_KLAD			570
 
+/* IOC-controlled output clocks */
+#define CLK_SAI0_MCLKOUT_TO_IO		571
+#define CLK_SAI1_MCLKOUT_TO_IO		572
+#define CLK_SAI2_MCLKOUT_TO_IO		573
+#define CLK_SAI3_MCLKOUT_TO_IO		574
+#define CLK_SAI4_MCLKOUT_TO_IO		575
+#define CLK_SAI4_MCLKOUT_TO_IO		575
+#define CLK_FSPI0_TO_IO			576
+#define CLK_FSPI1_TO_IO			577
+
 #endif

-- 
2.48.1


