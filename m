Return-Path: <linux-kernel+bounces-402666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D799C2A44
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B275281E5C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D080813C3D6;
	Sat,  9 Nov 2024 05:06:59 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379FC8FF
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128819; cv=none; b=g5N+xSYr2p+TCM0J40ZC50nstnRWhzGqICqd66Gz2zUrtPpUsjVY9zqDE5HZ+f/iSOQofbjhD6t1Ev22Q6ZYnMPgd9Do+YYFQ+br1PKcAtAlYjsom3E8Ay9XTFWqmWpQiXCZjrl/tjrLrFlKRN2bUX5PF+eFF4NvZ0vmtIU2Oc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128819; c=relaxed/simple;
	bh=V29sDjl4wYLu9vObgViBJRI7ryVCF3qaZxWh4f2DFWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WZwjzYWKhqNSLEmNNK9//gEh4fpUAffxQXXTsYOC08FtIltWSbzp4zg89IAjBa7mrmIkrnf5/FuyFJrEY04SsA7eyc0BSlv+Qk0l1+QX+6eqZqdO03RUJYjtjzNmv7BSsMlfjcGEZUfhycvMDUXtfSCmpZ6WX14AqdBrrDrzimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8672eede6ddf-31e22;
	Sat, 09 Nov 2024 13:06:50 +0800 (CST)
X-RM-TRANSID:2ee8672eede6ddf-31e22
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5672eedddfec-b8903;
	Sat, 09 Nov 2024 13:06:50 +0800 (CST)
X-RM-TRANSID:2ee5672eedddfec-b8903
From: guanjing <guanjing@cmss.chinamobile.com>
To: rogerq@kernel.org,
	s-anna@ti.com,
	nm@ti.com,
	horms@kernel.org,
	p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v3 1/2] soc: ti: pruss: remove misplaced semicolon from pruss_cfg_xfr_enable
Date: Sat,  9 Nov 2024 13:01:49 +0800
Message-Id: <20241109050150.265374-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove misplaced colon in inline variant of pruss_cfg_xfr_enable()
which results in a syntax error when the code is compiled without
CONFIG_TI_PRUSS.

Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 include/linux/pruss_driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index c9a31c567e85..29a76a60869c 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -167,7 +167,7 @@ static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
 
 static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
 				       enum pru_type pru_type,
-				       bool enable);
+				       bool enable)
 {
 	return ERR_PTR(-EOPNOTSUPP);
 }
-- 
2.33.0




