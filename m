Return-Path: <linux-kernel+bounces-305305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4F2962CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300BF1F24E28
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E41A3BB8;
	Wed, 28 Aug 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TDDUGeIl";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="jOAA5plZ"
Received: from a7-28.smtp-out.eu-west-1.amazonses.com (a7-28.smtp-out.eu-west-1.amazonses.com [54.240.7.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434141A2C2D;
	Wed, 28 Aug 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859776; cv=none; b=Phe2xmRlTPPETQsfJByoyuXG3BOUwHTcnFweGGgcUZTUhPapLgH9GRB3giJsJbHQpDAS3UDcbuI36eJnbfnXp0dCt9TLn4EJJg24RDN0/qajSSMCWjRRRhaBy27ZGBLJv4CmPWyKKQbd/Xdzd10xQZTIgEN+EOSL5ixzNI644Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859776; c=relaxed/simple;
	bh=yDCZg1ffTuRALSjRU0LbBdSAyalvvGprIpLg3SOyseI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ON+dc6MGdvz++PaD4IDcEZLb9zFYxUIHZgXue7Q2lWFAeKg9JKQH6ki9Eq05nC/MP2JCPIJGWig+pSM+BDGWpAChKg27Y/+IwnM30/jUq4JRgh5RqLhRAj+4vikcRRNc/AROIps6BEj8OmsldpEbaOOvjV/WcbLZ/eD7e/qvIAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TDDUGeIl; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=jOAA5plZ; arc=none smtp.client-ip=54.240.7.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1724859772;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yDCZg1ffTuRALSjRU0LbBdSAyalvvGprIpLg3SOyseI=;
	b=TDDUGeIlCdH6xGw4J3wukYYzXKqXmMzkN4qw+427rE9V2RhvVE4DZTV/msYXuPuT
	UzdbkzjEsiXLCimpQrEX3gHGa+KmR2M/0HGbx0hVLUqqve/H+iTRE9uuC4Zz8kfg/u7
	Sy6z+dtpCTzx71gcsoSe4OdIP9h10urYNveUeqDJFFPIrLVjJ8c3kC5CbUZ07R+4PzT
	JTmD5LoYzWVoiCUlTmEXS2FwH453e1NczSbdTDuEALAeEWmbTAu9tNNtsLNysAL6Ip/
	+3Kfk5AC/0uDDAF33szOfvt8EoA1tf/17eOFMzEjJsKN7qe/JKwG9v5lsVLhnfSRhQg
	OHQSGtlClw==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1724859772;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=yDCZg1ffTuRALSjRU0LbBdSAyalvvGprIpLg3SOyseI=;
	b=jOAA5plZfHHqXEtHa4s3CJjv/kVm0in2FzByEDhYeYvf0sVrJ0Nje/oNHWwT2mry
	QsiH5okpeWfvMtaEdhPVYyC4z3HXF5L+5EkoYEe9ZlrWtUxFDm4srRv1iGr8bbO+5Td
	kyyaYmBukXBwqMqv2V5h2i4JCJfbI6T703jncmUo=
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, 
	Elaine Zhang <zhangqing@rock-chips.com>, 
	Detlev Casanova <detlev.casanova@collabora.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, kernel@collabora.com, 
	Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH v7 2/3] clk: rockchip: Add new pll type pll_rk3588_ddr
Date: Wed, 28 Aug 2024 15:42:52 +0000
Message-ID: <0102019199a76ec4-9d5846d4-d76a-4e69-a241-c88c2983d607-000000@eu-west-1.amazonses.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828154243.57286-1-detlev.casanova@collabora.com>
References: <20240828154243.57286-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.08.28-54.240.7.28

From: Elaine Zhang <zhangqing@rock-chips.com>

That PLL type is similar to the other rk3588 pll types but the actual
rate is twice the configured rate.
Therefore, the returned calculated rate must be multiplied by two.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
(cherry picked from commit c99648df60d3763723de9e443b862da44e8872fe)
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
Acked-by: Dragan Simic <dsimic@manjaro.org>
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


