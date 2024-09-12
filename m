Return-Path: <linux-kernel+bounces-326611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F45976AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEACCB21EC6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F96C1B1D60;
	Thu, 12 Sep 2024 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PPTJoxPU"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731DE1A4E84;
	Thu, 12 Sep 2024 13:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726147996; cv=none; b=r9TuWU0ewqEOIHjjWO5OQM1jX0OcjPijwxKWl2zzmQYoiE30RcGOuTazUplMCDySPleCq2YxSHDIcqz59ta8+F1xhKaRP8mogoJcPlS/BT1FcPVL0B2e5OgAOYNSS+wEEKjKRZu6mMLmKBEYZPIVU+4/aM0IQ+Xfee8o+sYmjLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726147996; c=relaxed/simple;
	bh=sSx55JSXBPmJajPAqiQ992oJNfQ2IRvppQcIcT6BETs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dOO+Q9jV9wHDL9emL9jCaYWg8h3LvwJi2uUZ8S7NvcKj0bKirND47qNG1RGs5Lxm6Gs3C0WuyBYOWXDBYZriphSxIKKrs1quusaOtkbLNlI26sFKPLSVW7/4FKkWEvrgECGMw0tHmvpzbB5wnOlbTuiv7AcWIEEkS1AmeKHmpas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PPTJoxPU; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7821D415A6;
	Thu, 12 Sep 2024 15:33:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sCzmfGIyV1SI; Thu, 12 Sep 2024 15:33:09 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1726147989; bh=sSx55JSXBPmJajPAqiQ992oJNfQ2IRvppQcIcT6BETs=;
	h=From:To:Cc:Subject:Date;
	b=PPTJoxPUworTGmi4YX2ryyYOdS7aV7cYjTOsF7EI8BIWsO1hXIuqqVmUJkCiJgr+j
	 HrkbW3e4OmfZC7osP9GDwKM40kfEIRwaQEi1YsW04GD0ktQVFBJM9gAtWw5U3uAMXo
	 MwsVnE2bvqig5e6kaa7VDCymkGIlvBZAKw15HBjwGz5I0MdjpSoCo8J8uBqapSIMrz
	 gpEci9gz1jr6wtQYg+DF7+4LNJ6JzZhzJ340i0HXNzaYGx3WTGneclLQuSXLfvIKW1
	 GOBH+DiERQs0++JevyRtbv/u4rZ7lKjffNlZdzf/ZXDNRVMh/HKsTCoBxJbISVybHv
	 2zHS2UenRFMQQ==
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH] clk: rockchip: fix finding of maximum clock ID
Date: Thu, 12 Sep 2024 13:32:05 +0000
Message-ID: <20240912133204.29089-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an ID of a branch's child is greater than current maximum, we should
set new maximum to the child's ID, instead of its parent's.

Fixes: 2dc66a5ab2c6 ("clk: rockchip: rk3588: fix CLK_NR_CLKS usage")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/clk/rockchip/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
index 73d2cbdc716b..0972e9f87470 100644
--- a/drivers/clk/rockchip/clk.c
+++ b/drivers/clk/rockchip/clk.c
@@ -439,7 +439,7 @@ unsigned long rockchip_clk_find_max_clk_id(struct rockchip_clk_branch *list,
 		if (list->id > max)
 			max = list->id;
 		if (list->child && list->child->id > max)
-			max = list->id;
+			max = list->child->id;
 	}
 
 	return max;
-- 
2.46.0


