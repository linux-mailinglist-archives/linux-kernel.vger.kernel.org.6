Return-Path: <linux-kernel+bounces-563291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4935CA63C91
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6D01671E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9993717FAC2;
	Mon, 17 Mar 2025 02:58:06 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EC41624C9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180286; cv=none; b=lf/lNI99th8jusUnNKiN02NeT150M7RxHE/HsbpQCC1befoL0QLv3J3azf/IOkIy15cna64SlgcyOzofL+BMJ9413rGeVIdg491kAAVJ/FewC7gT3KPEpvNAMBCaCqfj+4/7028agSTwOJw36OXfUWzwlIL0D87hLD/foCzquZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180286; c=relaxed/simple;
	bh=j+86JghROxkd7pYKYTLoyBbI5elkaW+ibuWKjLoQ1V8=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=msmE/Dq/8DUubQkKu7lhOvrrahIltt66URqqmtTb71DepJrOJn4JExfvYL8Y9UPej6pdskbeuH2jbIxjYyQHOtKO6SllSCnXlw+DIlTRnorUlIH4+rF0wCler8QmojTv50qexGoL3hOt8UtsxaRfS2cvuhKlRnuUsvSbEYrK7s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGKQv5KDCz8R042;
	Mon, 17 Mar 2025 10:57:59 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 52H2vif5071879;
	Mon, 17 Mar 2025 10:57:44 +0800 (+08)
	(envelope-from feng.wei8@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 10:57:45 +0800 (CST)
Date: Mon, 17 Mar 2025 10:57:45 +0800 (CST)
X-Zmail-TransId: 2afb67d78fa9634-63c34
X-Mailer: Zmail v1.0
Message-ID: <20250317105745891-NnPPMd8T0guyJikMgM6p@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <feng.wei8@zte.com.cn>
To: <alexander.deucher@amd.com>
Cc: <christian.koenig@amd.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vcmFkZW9uL3V2ZDogUmVwbGFjZSBuZXN0ZWQgbWF4KCkgd2l0aCBzaW5nbGUgbWF4Mygp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H2vif5071879
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D78FB7.000/4ZGKQv5KDCz8R042

From: FengWei <feng.wei8@zte.com.cn>

Use max3() macro instead of nesting max() to simplify the return
statement.

Signed-off-by: FengWei <feng.wei8@zte.com.cn>
---
 drivers/gpu/drm/radeon/radeon_uvd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_uvd.c b/drivers/gpu/drm/radeon/radeon_uvd.c
index 058a1c8451b2..ded5747a58d1 100644
--- a/drivers/gpu/drm/radeon/radeon_uvd.c
+++ b/drivers/gpu/drm/radeon/radeon_uvd.c
@@ -961,7 +961,7 @@ int radeon_uvd_calc_upll_dividers(struct radeon_device *rdev,
 	unsigned optimal_score = ~0;

 	/* loop through vco from low to high */
-	vco_min = max(max(vco_min, vclk), dclk);
+	vco_min = max3(vco_min, vclk, dclk);
 	for (vco_freq = vco_min; vco_freq <= vco_max; vco_freq += 100) {

 		uint64_t fb_div = (uint64_t)vco_freq * fb_factor;
-- 
2.25.1

