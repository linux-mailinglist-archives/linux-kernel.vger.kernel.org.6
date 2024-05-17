Return-Path: <linux-kernel+bounces-182641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDA38C8DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0687428422F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535021411DA;
	Fri, 17 May 2024 21:29:58 +0000 (UTC)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874DE16415
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 21:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981397; cv=none; b=O8zAmpI6DqRfpunXm9us5kyscWot8A9Va+Dfc9IjZNL2NxTbRZ8+zPmjAoJp1OvLWmWoOAv0WhYqDzHv6IJQoVBfHy1h7hw2kBPjdenJvt4G2b/UehgPYy4dVIwpL0AttadyEd5zUOLYErlxekEJO8xFZ+Eiy2dlQogebnLoV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981397; c=relaxed/simple;
	bh=sERb3KEqtITPGFi0Do+B2YPsMMxnClT+yjJ6+Fzt3us=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ALcM2NmCtjb/C6VyGEe30hcilEUesyXtf6yoCZND1xgLGxiOKvweE7QMlrXSt7o99aOgONbhYPvdcd1Mlw4hEyEirg1D15nWR3dXRh3sbCfPDiAadyHF2ek9fRfDX2EsahyHyzGMkawM6FCvihpOhZ6biszzOqaGDpJflOjFNkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H9G9XG002296;
	Fri, 17 May 2024 14:29:34 -0700
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3y64f41wjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 14:29:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 17 May 2024 14:29:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 17 May 2024 14:29:33 -0700
Received: from Dell2s-9.sclab.marvell.com (unknown [10.110.150.250])
	by maili.marvell.com (Postfix) with ESMTP id 17CE43F7059;
	Fri, 17 May 2024 14:29:33 -0700 (PDT)
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: <nm@ti.com>, <ssantosh@kernel.org>
CC: Vasyl Gomonovych <gomonovych@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] soc: ti: Fix missing newlines in log statements
Date: Fri, 17 May 2024 14:29:10 -0700
Message-ID: <20240517212930.2019962-1-gomonovych@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pro26TlM8DEm1coA3lRphfK0gW1k1JJ0
X-Proofpoint-ORIG-GUID: pro26TlM8DEm1coA3lRphfK0gW1k1JJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_10,2024-05-17_03,2023-05-22_02

Add the missing newline characters to two pm33xx log statements
to ensure proper log formatting.

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 drivers/soc/ti/pm33xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/pm33xx.c b/drivers/soc/ti/pm33xx.c
index 8e983c3c4e03..3a56bbf3268a 100644
--- a/drivers/soc/ti/pm33xx.c
+++ b/drivers/soc/ti/pm33xx.c
@@ -450,14 +450,14 @@ static int am33xx_pm_rtc_setup(void)
 
 		rtc_base_virt = of_iomap(np, 0);
 		if (!rtc_base_virt) {
-			pr_warn("PM: could not iomap rtc");
+			pr_warn("PM: could not iomap rtc\n");
 			error = -ENODEV;
 			goto err_clk_put;
 		}
 
 		omap_rtc = rtc_class_open("rtc0");
 		if (!omap_rtc) {
-			pr_warn("PM: rtc0 not available");
+			pr_warn("PM: rtc0 not available\n");
 			error = -EPROBE_DEFER;
 			goto err_iounmap;
 		}
-- 
2.43.0


