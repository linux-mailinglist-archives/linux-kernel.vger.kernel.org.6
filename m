Return-Path: <linux-kernel+bounces-297921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F095BF24
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11FB8B20F4F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C91D0DF1;
	Thu, 22 Aug 2024 19:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b="CwB841z/"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5C91D0498;
	Thu, 22 Aug 2024 19:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356264; cv=pass; b=ql8KWsb5ZlHN4+8f/+tIQ7/iqpT/68tQDEkcVziOGMKn3lSEe2B1PC7jQWz1pdPIQkrSxnZWol85vmVqPRGdKm7BsFC6OLNwwmxBjFpSN3tsneD5jRjJPMHQNjPCcfMi7RT1VwXIsNEsH8o8TfwZl7P10Y9UCeYVaGY5iSnKXuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356264; c=relaxed/simple;
	bh=B33qPXmDAhp73Zj6zm+LZ2G9dUgp7OsD1hIowgEL+1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iX4bRHQRNEuaTRzHHzC/ILOA3cieV5OFGs5/h/Qe4tcEjUsp42vR1N/L8RFwnggr85CdnqDMJ660D9vXDbWYmuibnmZFcJV0+wW8Vu+PcszxUsGYoxUcHQ9fodVs9aX7fwi2aQNX2rfqRLDNtcoZAaQ1zHDN0YzEa/9+NmxoVGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=detlev.casanova@collabora.com header.b=CwB841z/; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: detlev.casanova@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724356242; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Smzzu57kwtKi3+i+iipKpGHDxPrw7B2rkSbgYLIZfMT2r3RegOb2fTQsVZMdqBgicLbZOzv0jtBy1L3NjYj6Vf+QBvV6DPriVr0uzsMtYPkINYj+kxy2AkyrHoRb+YOOlIilDCEiF0MSBlAejW6VUDUOTYVJ4lThiwOamK87aXI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724356242; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1nAinSTq7n3Km4Nm+1m1jCkVbcD+GZU2DovoVzRzBTM=; 
	b=C5QYwUs0iwARPln3VKNqIbdziFxEiKtMXA5MyCnGzTP18qiZdRZOUdSuNyyNb3MAtVOucVFGPgfF45HzAZ2vUR3PrU42RJErSpU9ocRG0FW29AI+TBv3XqmywcvLSTkaiXghu/tR48EoWyLRSBfQadf2myOghN51ZEjrGNw78jc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=detlev.casanova@collabora.com;
	dmarc=pass header.from=<detlev.casanova@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724356242;
	s=zohomail; d=collabora.com; i=detlev.casanova@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1nAinSTq7n3Km4Nm+1m1jCkVbcD+GZU2DovoVzRzBTM=;
	b=CwB841z/RtRKBaoVD1A9dANIRTv7FWlDvSFMVX4o/0nttPFSm83EIn5UkZYT0oW1
	Hua/BAlKvxB2UD7m/EmEJy6fbHxZneInLlEnhaMFBp59vgrPGIKurjcm/yww00EltgV
	rgSru74wOegCrkeJ2n6D9HzyLpD7Emn//ELqUoF0=
Received: by mx.zohomail.com with SMTPS id 1724356240193829.9990063974029;
	Thu, 22 Aug 2024 12:50:40 -0700 (PDT)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v6 2/3] clk: rockchip: Add new pll type pll_rk3588_ddr
Date: Thu, 22 Aug 2024 15:49:33 -0400
Message-ID: <20240822194956.918527-3-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822194956.918527-1-detlev.casanova@collabora.com>
References: <20240822194956.918527-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Elaine Zhang <zhangqing@rock-chips.com>

That PLL type is similar to the other rk3588 pll types but the actual
rate is twice the configured rate.
Therefore, the returned calculated rate must be multiplied by two.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
(cherry picked from commit c99648df60d3763723de9e443b862da44e8872fe)
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/clk/rockchip/clk-pll.c | 6 +++++-
 drivers/clk/rockchip/clk.h     | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index 606ce5458f54..fe76756e592e 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -914,7 +914,10 @@ static unsigned long rockchip_rk3588_pll_recalc_rate(struct clk_hw *hw, unsigned
 	}
 	rate64 = rate64 >> cur.s;
 
-	return (unsigned long)rate64;
+	if (pll->type == pll_rk3588_ddr)
+		return (unsigned long)rate64 * 2;
+	else
+		return (unsigned long)rate64;
 }
 
 static int rockchip_rk3588_pll_set_params(struct rockchip_clk_pll *pll,
@@ -1167,6 +1170,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 		break;
 	case pll_rk3588:
 	case pll_rk3588_core:
+	case pll_rk3588_ddr:
 		if (!pll->rate_table)
 			init.ops = &rockchip_rk3588_pll_clk_norate_ops;
 		else
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index fd3b476dedda..40fc0e4703c1 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -287,6 +287,7 @@ enum rockchip_pll_type {
 	pll_rk3399,
 	pll_rk3588,
 	pll_rk3588_core,
+	pll_rk3588_ddr,
 };
 
 #define RK3036_PLL_RATE(_rate, _refdiv, _fbdiv, _postdiv1,	\
-- 
2.46.0


