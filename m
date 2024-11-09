Return-Path: <linux-kernel+bounces-402622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92E69C29BE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1521C2148C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FED013A863;
	Sat,  9 Nov 2024 03:36:04 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4539E1EEE9
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731123364; cv=none; b=IR9KwWifidhIQrzZZ8Fr/P7M13eN77q2ihtm07k5bzsBANkJ+qUZj7+Q2Fwtvh0MdlZ5CxzC04YoMNLkzWI8qqr5yr7ewwa5ymd0fIcfuGXLsyWDZxdHBy7t+v8fpSV6enoN8WgKhODrstW69BL3s2McvXe1HXc2U2o2N9AILEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731123364; c=relaxed/simple;
	bh=V29sDjl4wYLu9vObgViBJRI7ryVCF3qaZxWh4f2DFWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kwFlaKPWBBW25P/EjHkHFC4f0av5QhQG9vKlfmG8SRppuigbJeuYhvVtK8+txeuSA/2tnLZmqXDvY1aPV4e2pTI8VAiBWKDf+HhvbkwFFa7SkK0bl6yWiv6Rk7G0q3yhhTA2xdj3d59r0If+iHswdGn/ljcEg5O5UpRv9SOQ9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee8672ed89c881-318c4;
	Sat, 09 Nov 2024 11:35:56 +0800 (CST)
X-RM-TRANSID:2ee8672ed89c881-318c4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee6672ed864cf5-bee92;
	Sat, 09 Nov 2024 11:35:56 +0800 (CST)
X-RM-TRANSID:2ee6672ed864cf5-bee92
From: guanjing <guanjing@cmss.chinamobile.com>
To: rogerq@kernel.org,
	s-anna@ti.com,
	nm@ti.com,
	horms@kernel.org,
	p-mohan@ti.com
Cc: linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v2] soc: ti: pruss: remove misplaced semicolon from pruss_cfg_xfr_enable
Date: Sat,  9 Nov 2024 11:26:31 +0800
Message-Id: <20241109032631.258765-1-guanjing@cmss.chinamobile.com>
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




