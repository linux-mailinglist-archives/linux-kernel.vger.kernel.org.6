Return-Path: <linux-kernel+bounces-540190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14707A4AF36
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 05:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9143B4AE7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 04:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE21187554;
	Sun,  2 Mar 2025 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ZRqsLXIo"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6837F2AE74;
	Sun,  2 Mar 2025 04:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740888584; cv=none; b=eQumugZqqGrIfqxvtH2NxOFoJRcpZ4rtENIUrh2vmKvFaAQ1M6hJkJYEqB+AC/fj/golp/HJ7INB7LthS21THzcA69E6zWn5o39NUjfgpa/QJ6NBEoO2dchWVjU8actIzBsUyXxaec+2rlyR60n7atGXf8TBt5a6iuhYj+Ijj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740888584; c=relaxed/simple;
	bh=rUYI6KbrqNMFcVdgzh0uXQDar/zw7KHU+wXGfZAj9mM=;
	h=Message-ID:From:To:Cc:Subject:Date; b=ULDKU5b4opCfbqoqiT8DpFRT7GXVd/RJ8nHkuwXbKtTcGRIga0mDYj8vr3+CvjBhb63QRboqhNEzL217KWpYbb6Ici/1Wx2l7qVUMRrDgtW8VfLEGjzqI+gj0THQFSi1gNUjegtwVacx5Qsfid7NV5pYSkkXQ9hznTLgK9tUuAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ZRqsLXIo; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1740888569;
	bh=/oNzA+rBYGRKTr9cqHP8TnoIYKLYQLPKVdnjgQ3dPGk=;
	h=From:To:Cc:Subject:Date;
	b=ZRqsLXIoJdo9VZvcZD2WO6KROWiBwcoSW0G6Hwl3ZVAOrtNA6iLqkjGWiz3Hlo1NE
	 6rxBdo2LtCTCuAAqsI8r0o0T2QV1XPCtD8qDTvVt5SG9zrjsjXQEqQoK37JARMAF8h
	 W/I0c2DNSTbesSW9CvZ6nodnQtT5eSSzliOJxhtQ=
Received: from localhost.localdomain ([223.74.103.43])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id AF389E6A; Sun, 02 Mar 2025 11:43:51 +0800
X-QQ-mid: xmsmtpt1740887031tewsm34x2
Message-ID: <tencent_370DBB5BD8EF699EC030ACA74BCB440FFA0A@qq.com>
X-QQ-XMAILINFO: Nte9/BsRzcszFGXiHFU7artbynl1ZqkwsV/bllGV/PxA5wYl9JeHhHD6rUydvW
	 MHJZJoiwrOpWzFqLSbrxr7O7RqW2zD/Oo6VoopAAQdeAm8ciXebcRkidioBnyrTeVIxL+d+tTEHH
	 Xy++PpPVkFnuQVzhvq80oWu01Fuz1Yo9LB2kVBQWr+RPsuLq1fmFXdGPc/nHnx//+UQqg4p3goOI
	 nbx09QlJ7oa8QXAnOqDWlZ7g5AN/KdErg6C6lX4abxhsD9UbXlN6zRYkyLcEKmswpovs3t+/xBor
	 yK9sajG0qLDpzhQN74xyzmrbwFWJqdzgjx5HRFRmWaf0Tt/Bl3qBHNsT7o8ymrsCcolaOFSTcURS
	 5uzux2OiPscFcxmJvW0mi2ExI+qDbItNs37zUkeX4uxibsYaMeYz0rirEHeJE8eOZ6bplLWuvtxU
	 ZUB2lr93sVzifIveYeb60/jbYMpq7LQ3GHICHwpldlRRM9WMzjinL7Bi2f1XdtZA22vHsvkLL5Ef
	 6fN4gCBuRg5uDDpHVy7cQ42YdfyvjhTIX8i2R7TJcD7UZ8G5LWwqyZRoT5qCb7DpSVR/gnqFzl3K
	 h30zsWj4Hnmu0bsfcn98X0hq4O7HleMxHtWWK3cb/34Rr/DeWBOPq+VQsPOUx/C6jMzCU/OFGKcp
	 KhrcDBPtwk72LTE+uaxXWI2f/XXsZYNoRznWnlHk9ifMjFvemHrMsVS43ky4QbuFLQ1jj4xvPT54
	 JxXe1MQq0Vz8eK2tBWyBb3EIqOhTdUej/WRVPlzmdWr9Hkow1ybUApKtM4/9h/vNRgIvu3zhHxlq
	 77MfpBjwJdLsdkAdzcbZQtxkqMt+XDA18WMJAdjAzHY/tHlMmUOEp7Rovelqne0x6sJl616fX0ak
	 I20H8UTAvtJV1WfL07wZrBAful948b7pFQOpWLX6qAsvBrj/cW65zxozx0NpPAINeRPlbnsDtH2J
	 5288X2klnJG9obwnMf3eWXDKqYyr/KPu+H+ti7cdOcxWtZrFDohv5DocsHuGwErxC1rxhgtIYNkU
	 DGTdY0VSJZa+K0aQpy7GpxClmwBGOZeCQMIeyLhgpEaDDlGWDR
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: xinghuo.chen@foxmail.com
To: jdelvare@suse.com
Cc: linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jingfelix@hust.edu.cn,
	Xinghuo Chen <xinghuo.chen@foxmail.com>
Subject: [PATCH] hwmon: fix a NULL vs IS_ERR() check in xgene_hwmon_probe()
Date: Sat,  1 Mar 2025 22:43:39 -0500
X-OQ-MSGID: <20250302034339.49430-1-xinghuo.chen@foxmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Xinghuo Chen <xinghuo.chen@foxmail.com>

The devm_memremap() function returns error pointers on error,
it doesn't return NULL.

Signed-off-by: Xinghuo Chen <xinghuo.chen@foxmail.com>
---
 drivers/hwmon/xgene-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/xgene-hwmon.c b/drivers/hwmon/xgene-hwmon.c
index 1e3bd129a922..4fe30198bae8 100644
--- a/drivers/hwmon/xgene-hwmon.c
+++ b/drivers/hwmon/xgene-hwmon.c
@@ -706,7 +706,7 @@ static int xgene_hwmon_probe(struct platform_device *pdev)
 			goto out;
 		}
 
-		if (!ctx->pcc_comm_addr) {
+		if (IS_ERR(ctx->pcc_comm_addr)) {
 			dev_err(&pdev->dev,
 				"Failed to ioremap PCC comm region\n");
 			rc = -ENOMEM;
-- 
2.17.1


