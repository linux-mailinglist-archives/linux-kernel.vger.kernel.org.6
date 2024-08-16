Return-Path: <linux-kernel+bounces-289455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E502954664
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80D3C1C20D72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47CA170A21;
	Fri, 16 Aug 2024 10:00:30 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBE170A0D;
	Fri, 16 Aug 2024 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723802430; cv=none; b=kOQvIDE9/+LuC7hz2ShtK7wbUN/Dy+uqzMuwhIrr3fBAg8jITByw+WHQ7X1w9lF15jeTUviA0ItHeQT/DUXi4nxvifJbqQOTa8iyBoN8iQ6pLKNZhWuMdWRpvjANvG42qOdSIlK4yoIYWGlRAfFOZYDSzB3Pvb1IC1yQFP55/9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723802430; c=relaxed/simple;
	bh=Vv2TAaWDWmqOvqd9j5e3dS3BZOi+QjN1CMbqRNWCUk8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TSSjoE5Il6ai8Z2t07+xgJfZl2cZDRj8ejpheQ0PyGzv9lNz03NjtCuo8spJ23VVAPMnmW5zH8FZdd/ZXzBj5tTHxt3UORDJAzp8p1fOvjVEoeufcdYTyqqTzQ2bEzNNTo22TDfagl2YYo3lg85XPXMrbjDOen32Cm/Oxj0l1Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WlcrL4HbLzhXw5;
	Fri, 16 Aug 2024 17:58:26 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id BE61218006C;
	Fri, 16 Aug 2024 18:00:24 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 16 Aug
 2024 18:00:24 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <W_Armin@gmx.de>,
	<yuehaibing@huawei.com>
CC: <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] hwmon: (sch5627) Remove unused declaration sch56xx_watchdog_unregister()
Date: Fri, 16 Aug 2024 17:57:40 +0800
Message-ID: <20240816095740.877729-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 2be5f0d75325 ("hwmon: (sch56xx) Use devres functions for watchdog")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/hwmon/sch56xx-common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/sch56xx-common.h b/drivers/hwmon/sch56xx-common.h
index 7479a549a026..601987c6b4cd 100644
--- a/drivers/hwmon/sch56xx-common.h
+++ b/drivers/hwmon/sch56xx-common.h
@@ -22,4 +22,3 @@ int sch56xx_read_virtual_reg12(u16 addr, u16 msb_reg, u16 lsn_reg,
 
 void sch56xx_watchdog_register(struct device *parent, u16 addr, u32 revision,
 			       struct mutex *io_lock, int check_enabled);
-void sch56xx_watchdog_unregister(struct sch56xx_watchdog_data *data);
-- 
2.34.1


