Return-Path: <linux-kernel+bounces-401182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE39C1701
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DB81C2215A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AD91D1506;
	Fri,  8 Nov 2024 07:27:13 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6A61F5FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731050833; cv=none; b=fPDWvBh+LtwtLTIZQEjrCZkEYJ2xyGxXwIXhvsVrx9rPWgY2Hz3O83AI8JJo2uuPPDSckqJ+MUwDQ3WV2x13MBQ5oqvKfcOJBskjnmgOK+XSSDTFbt2QgxsMRkLty8q/t9SuaKD1RVloYuPJTCbdhmScUhrwpI/pczpGLUtxGgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731050833; c=relaxed/simple;
	bh=ckBZSmx994GtJ6h4NVak1m2GJNFoiBbCY0PNPByXa/0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FW1JsoMNCkYYuHwQ0biR4DjHKZLRo1leoljy6EREnca+FrfSl4p1CL2klPX32ICAgFyWMCPHvRO3vSviUlP60GPJG80mjcLoGR48YuBsAKIbKUD8tn7aCqHRp4rf24aBcAGHCnQskuLnbC0aHtO7q3U+ALXDq11VPtFs3NuHrm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee6672dbd435bf-bee8b;
	Fri, 08 Nov 2024 15:27:01 +0800 (CST)
X-RM-TRANSID:2ee6672dbd435bf-bee8b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee9672dbd1fbf3-8d45f;
	Fri, 08 Nov 2024 15:27:01 +0800 (CST)
X-RM-TRANSID:2ee9672dbd1fbf3-8d45f
From: guanjing <guanjing@cmss.chinamobile.com>
To: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH] fixup for "firewall: introduce stm32_firewall framework"
Date: Fri,  8 Nov 2024 13:37:08 +0800
Message-Id: <20241108053708.171916-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 include/linux/bus/stm32_firewall_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
index 18e0a2fc3816..5178b72bc920 100644
--- a/include/linux/bus/stm32_firewall_device.h
+++ b/include/linux/bus/stm32_firewall_device.h
@@ -115,7 +115,7 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
 #else /* CONFIG_STM32_FIREWALL */
 
 int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
-				unsigned int nb_firewall);
+				unsigned int nb_firewall)
 {
 	return -ENODEV;
 }
-- 
2.33.0




