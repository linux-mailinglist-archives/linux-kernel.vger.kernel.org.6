Return-Path: <linux-kernel+bounces-191918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0C88D1610
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB94B211C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B08913AA32;
	Tue, 28 May 2024 08:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="10dnc6xa"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C9E17E8F9;
	Tue, 28 May 2024 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884171; cv=none; b=esgmXTNzhWRTMdTQPN2rSJBBNzGMqhIyZA/HcBhYEJGzEh/ts95mWaDrxEnzRykOAa7DE4V8FecECeFMwXwt7r/Sgldeao5zB6zRaRh8Kc99PB9P8KK0tgHGuVORIfKaU0umBOUd3ib0NgWmCDKXNPQILjo1gcMUBejBQQXgRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884171; c=relaxed/simple;
	bh=4V0unZZMxFYExMEXevIB43oB1N7X4q7IE6LTHwkEOtY=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=HpuIvNhA8PioQQgwjvh7vm+jGfkmf0wol4TzTjZuRuRurtCCfR+hOwxhD1Vddg6akWmle+wNYMeVPI2GsLRcoVeboq4PjhkcAV6a7Kk5/vQaTRRx/foQXb60QxgDt++jKztlJPfA1fv/+RJKjUUhOb0tWm+yOBULa2pT7KsoYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=10dnc6xa; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MfEWqiPiowp1nxWFVOqmObG5hSUllA+ZfcuPMLVDwsA=; b=10dnc6xahQf1TxfTvr7uj+8znz
	iy9kqoqnE0J1LuGy2fJwm8DiGSlcCZ/dKz3EyZVBxLQYZuJvL8mgYXwPV7TRpBMR8m+Rd5rHZGPZT
	YLG61wnlbrzHBWPG6LrxwSZF7sLqm6kU3NqVlb8tfY+ies3laLoLT4zfjhpKtyp6zseQfbhzGkGYw
	cavflUIu4T3bDZkxSOlJC+5aeJGGk+0Mo5O0i5fyDXySARhVvRJVTQ65MbTkyTCrSnMMqOTl/jLc6
	EwSF8Jowza/7huTK5gKR4P/37p/XQ1/4TEmyXEgyuSlD18/7ZHdGscWhObb2F1mX+MIZq7YtE+nWl
	A0JAgQWQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:44848 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1sBrzl-0004R8-10;
	Tue, 28 May 2024 09:15:45 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1sBrzn-00E8GK-Ue; Tue, 28 May 2024 09:15:47 +0100
In-Reply-To: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
References: <28114882-f8d7-21bf-4536-a186e8d7a22a@w6rz.net>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-clk@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>,
	 Ron Economos <re@w6rz.net>,
	 Samuel Holland <samuel.holland@sifive.com>,
	 Guenter Roeck <linux@roeck-us.net>,
	 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	 Dinh Nguyen <dinguyen@kernel.org>,
	 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	 Michael Turquette <mturquette@baylibre.com>,
	 Paul Walmsley <paul.walmsley@sifive.com>,
	 Rob Herring <robh@kernel.org>,
	 Yang Li <yang.lee@linux.alibaba.com>,
	 linux-kernel@vger.kernel.org,
	 linux-riscv@lists.infradead.org,
	 linux-arm-kernel@lists.infradead.org,
	 regressions@lists.linux.dev
Subject: [PATCH] clk: clkdev: don't fail clkdev_alloc() if over-sized
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1sBrzn-00E8GK-Ue@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 28 May 2024 09:15:47 +0100

Don't fail clkdev_alloc() if the strings are over-sized. In this case,
the entry will not match during lookup, so its useless. However, since
code fails if we return NULL leading to boot failure, return a dummy
entry with the connection and device IDs set to "bad".

Leave the warning so these problems can be found, and the useless
wasteful clkdev registrations removed.

Fixes: 8d532528ff6a ("clkdev: report over-sized strings when creating clkdev entries")
Closes: https://lore.kernel.org/linux-clk/7eda7621-0dde-4153-89e4-172e4c095d01@roeck-us.net.
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---

Please try this patch, which should allow the platform to boot, bit will
intentionally issue lots of warnings. There is a separate patch posted
recently that removes the useless registration with clkdev.

 drivers/clk/clkdev.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 6a77d7e201a9..2f83fb97c6fb 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -204,8 +204,15 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
 	pr_err("%pV:%s: %s ID is greater than %zu\n",
 	       &vaf, con_id, failure, max_size);
 	va_end(ap_copy);
-	kfree(cla);
-	return NULL;
+
+	/*
+	 * Don't fail in this case, but as the entry won't ever match just
+	 * fill it with something that also won't match.
+	 */
+	strscpy(cla->con_id, "bad", sizeof(cla->con_id));
+	strscpy(cla->dev_id, "bad", sizeof(cla->dev_id));
+
+	return &cla->cl;
 }
 
 static struct clk_lookup *
-- 
2.30.2


