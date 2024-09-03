Return-Path: <linux-kernel+bounces-334225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7969397D42D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F96E1F2512A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570C813DDC2;
	Fri, 20 Sep 2024 10:19:35 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAF26FB6;
	Fri, 20 Sep 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827575; cv=none; b=QatcslKJyZJhYgSK+nE7vDFTF0kEZlTObfJS3Q35t0TXzoHCLJR58EqD+WHLyUZNUkbU8Eobu2VQiyhrrtRARfoTcy4J0XAJA0Y/pxxTAjwfDEMbebZ/GYA20Q7CBfyaJUPqummCjt33UW9gUwdOadCR0bp3KvdifLSH9dBX8sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827575; c=relaxed/simple;
	bh=w1xCamu39FST5jSxUGeXJyCMcUX8dSF3z+3RQJRb4Ig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qbsoZtYaGUTyEeQgt4KGCqSVXwtcmIKYdv5wjWMLHdBIgFr/0hlRgnvaoP6i37IditSrXAXi9ZzYNFF3LOS/8IehXwiwNY16nEZf+ELJuVmuBtEQ8Xo689j1Xn5H4KeSuZLGRXpKWAhFad9vANagUFHSdfQQw3uA33LlDLOK0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966ed4b71411-6c417;
	Fri, 20 Sep 2024 18:16:19 +0800 (CST)
X-RM-TRANSID:2ee966ed4b71411-6c417
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.96])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee266ed4b5fbba-d5db3;
	Fri, 20 Sep 2024 18:16:19 +0800 (CST)
X-RM-TRANSID:2ee266ed4b5fbba-d5db3
From: Ba Jing <bajing@cmss.chinamobile.com>
To: hdegoede@redhat.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ba Jing <bajing@cmss.chinamobile.com>
Subject: [PATCH] hwmon: abituguru: Remove unused ABITUGURU_TEMP_NAMES_LENGTH macro
Date: Tue,  3 Sep 2024 10:50:37 +0800
Message-Id: <20240903025037.9711-1-bajing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro ABITUGURU_TEMP_NAMES_LENGTH is never referenced in the code. Remove it.

Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
---
 drivers/hwmon/abituguru.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hwmon/abituguru.c b/drivers/hwmon/abituguru.c
index 93653ea05430..58072af4676b 100644
--- a/drivers/hwmon/abituguru.c
+++ b/drivers/hwmon/abituguru.c
@@ -95,11 +95,6 @@
  * in??_{min,max}_alarm_enable\0, in??_beep\0, in??_shutdown\0
  */
 #define ABITUGURU_IN_NAMES_LENGTH	(11 + 2 * 9 + 2 * 15 + 2 * 22 + 10 + 14)
-/*
- * sum of strlen of: temp??_input\0, temp??_max\0, temp??_crit\0,
- * temp??_alarm\0, temp??_alarm_enable\0, temp??_beep\0, temp??_shutdown\0
- */
-#define ABITUGURU_TEMP_NAMES_LENGTH	(13 + 11 + 12 + 13 + 20 + 12 + 16)
 /*
  * sum of strlen of: fan?_input\0, fan?_min\0, fan?_alarm\0,
  * fan?_alarm_enable\0, fan?_beep\0, fan?_shutdown\0
-- 
2.33.0




