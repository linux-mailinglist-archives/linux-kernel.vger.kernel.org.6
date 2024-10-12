Return-Path: <linux-kernel+bounces-362241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAE599B292
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929EF1F25D02
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D6F149C53;
	Sat, 12 Oct 2024 09:31:21 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4A8132120
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725481; cv=none; b=QgWwUCCT6FtSSO2wMLDPZEyPD+IT6+dkCuORvh9zDu10dcmqU60AxL7lS9EYSj2kI8BC2h1vGaZ9TfwF7Jickm8sWdogU9XLke3k5IF5BPw/im4X1goAyx0FyXpcDtThD7vrTQVzTjl3SZxeBcweHC1nit9dNdETQc3O8unCs7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725481; c=relaxed/simple;
	bh=6C42ZX+ZeYpODhCe0mC08pEJsAQOqxFcjRad6lk7yws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuWHJbzWpvJVWbGVASzJRnTKtP5qge3qTeC1nJYE0GLLi/tcfxqQaAOrxlNFNmf0FY8Gs5yTFn63sXO0a/ni6/QGF/0d4c1hfR4UrAcgiV1aqr87amwC/Kp9WxXjjhHIyuTwVPgVbzB9WvUqLxxoGDs4OMxKQRmdbpxp18Zp8lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee5670a41dca46-0aa55;
	Sat, 12 Oct 2024 17:31:10 +0800 (CST)
X-RM-TRANSID:2ee5670a41dca46-0aa55
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2670a41cdd49-0d8c8;
	Sat, 12 Oct 2024 17:31:10 +0800 (CST)
X-RM-TRANSID:2ee2670a41cdd49-0d8c8
From: Ba Jing <bajing@cmss.chinamobile.com>
To: robin.murphy@arm.com
Cc: will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] perf: arm-cmn: remove unused macro
Date: Sat, 12 Oct 2024 17:24:11 +0800
Message-Id: <20241012092411.2497-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the marco CMN_HNP_PMU_EVENT_SEL
is never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/perf/arm-cmn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index 397a46410f7c..37b62d0dcc06 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -79,7 +79,6 @@
 
 /* Some types are designed to coexist with another device in the same node */
 #define CMN_CCLA_PMU_EVENT_SEL		0x008
-#define CMN_HNP_PMU_EVENT_SEL		0x008
 
 /* DTMs live in the PMU space of XP registers */
 #define CMN_DTM_WPn(n)			(0x1A0 + (n) * 0x18)
-- 
2.33.0




