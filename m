Return-Path: <linux-kernel+bounces-362169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B73499B1C7
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 09:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE330B21050
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E6713B7BC;
	Sat, 12 Oct 2024 07:46:06 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFBBA49
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719166; cv=none; b=COCUwgT7y/pnLd6o3ABXXLzba2Tno4altSPrIph/iDVCkx6SmtUk8QPK4HMdChLO1NJ/DOWY3zYFx4x4k2QKSMBFNRlBLdJdWU6M1wz+WK7zZK/rQEJhWDSPZKr7PlbpRAyc7IZlv4M1PZTIc9Np4pdi4C3PivlD7UyDmKp322g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719166; c=relaxed/simple;
	bh=5fBhRMXitvEDkwfuBsC25pb4SB5KKPZoykP1CzO2m48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=haNlnsbqLVa7MRTLr+OJoMJK/nPNwKOXMmfAwKIFiay7+UOvtCdZbNsz1p51cIJpfpM4yYClUHNrW3zpzDWhStQ/gXjgjy8/oOxPvku6hyShI1BcaS4foogPqeoB5TxpwmvZH58Hcht/1M9f+lWe84RFRniK4ZK9Xdp/BGjXlfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7670a292f2d8-092ec;
	Sat, 12 Oct 2024 15:45:53 +0800 (CST)
X-RM-TRANSID:2ee7670a292f2d8-092ec
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9670a2920a83-01c11;
	Sat, 12 Oct 2024 15:45:52 +0800 (CST)
X-RM-TRANSID:2ee9670a2920a83-01c11
From: Ba Jing <bajing@cmss.chinamobile.com>
To: xueshuai@linux.alibaba.com
Cc: will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] perf: alibaba_uncore_drw_pmu: remove unused macro
Date: Sat, 12 Oct 2024 15:45:34 +0800
Message-Id: <20241012074534.1942-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By reading the code, I found the marco ALI_DRW_PMU_CNT_STATE is
never referenced in the code. Just remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/perf/alibaba_uncore_drw_pmu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/perf/alibaba_uncore_drw_pmu.c b/drivers/perf/alibaba_uncore_drw_pmu.c
index c6ff1bc7d336..8218daddf370 100644
--- a/drivers/perf/alibaba_uncore_drw_pmu.c
+++ b/drivers/perf/alibaba_uncore_drw_pmu.c
@@ -43,7 +43,6 @@
 #define ALI_DRW_PMU_CNT_STOP			BIT(1)
 #define ALI_DRW_PMU_CNT_START			BIT(0)
 
-#define ALI_DRW_PMU_CNT_STATE			0xC04
 #define ALI_DRW_PMU_TEST_CTRL			0xC08
 #define ALI_DRW_PMU_CNT_PRELOAD			0xC0C
 
-- 
2.33.0




