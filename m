Return-Path: <linux-kernel+bounces-362238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D54499B281
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 11:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D014D282F6E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD33171CD;
	Sat, 12 Oct 2024 09:24:15 +0000 (UTC)
Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AD0BA49
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 09:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728725055; cv=none; b=pvw3nxDgk/my2z6JX4IKXdWWPSSENTcpPrfQFpJjROvlPnTKCtC/mfh4A4gvrr/sdSVgBgZvBt+Pyyx3paUf/hCukueIgw/07+rweRflpmQaRb+pxXBmS6/+guxxCqHWlXg9lfdU4m+ufiExmbp1jk/gIqXJMDYqVVMmALVV8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728725055; c=relaxed/simple;
	bh=c3UW46j7srOuLPB2o7ltrrFFzLcsYFoXY3usatCpp4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Alh2vIANZT/+zYAghQYs1ai+iK8FZaMWP16YAgJiiVC7QulCiUInMOg52D4Vbq4pIPSEWJhqQsy9mmUPqR/KGSGl9NL5Qzdo6uLZzFUUT7hoitbnsH+vbxE522vRW3zcfdm1ksAmZnnsT2UFL3gWRJ7cWR1xEi1untlgAQntIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee4670a402bfae-db8af;
	Sat, 12 Oct 2024 17:24:02 +0800 (CST)
X-RM-TRANSID:2ee4670a402bfae-db8af
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5670a40237a1-0594c;
	Sat, 12 Oct 2024 17:24:02 +0800 (CST)
X-RM-TRANSID:2ee5670a40237a1-0594c
From: Ba Jing <bajing@cmss.chinamobile.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] perf: arm-ccn: remove unused macros
Date: Sat, 12 Oct 2024 17:16:29 +0800
Message-Id: <20241012091629.2369-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found these marcos are never
referenced in the code. Just remove them.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/perf/arm-ccn.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
index 5c66b9278862..ea878b025d32 100644
--- a/drivers/perf/arm-ccn.c
+++ b/drivers/perf/arm-ccn.c
@@ -28,12 +28,7 @@
 
 #define CCN_MN_ERRINT_STATUS		0x0008
 #define CCN_MN_ERRINT_STATUS__INTREQ__DESSERT		0x11
-#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__ENABLE	0x02
-#define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLED	0x20
 #define CCN_MN_ERRINT_STATUS__ALL_ERRORS__DISABLE	0x22
-#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_ENABLE	0x04
-#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLED	0x40
-#define CCN_MN_ERRINT_STATUS__CORRECTED_ERRORS_DISABLE	0x44
 #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__ENABLE	0x08
 #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLED	0x80
 #define CCN_MN_ERRINT_STATUS__PMU_EVENTS__DISABLE	0x88
-- 
2.33.0




