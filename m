Return-Path: <linux-kernel+bounces-517946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD2FA387DC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5343B54C0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443D9226882;
	Mon, 17 Feb 2025 15:39:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61084224B17
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806783; cv=none; b=JdyZZq3lG2ZOdq3UqjP8X9gi/ddjT0uEeV9TjV68wtU+/d5TZ5XNMo7aQYXMbEuaLzdHT9Uym16ZDCarzD5+aC009mMtHb8i9yNM7Lp07HbcNlfVfteVY7zePUuniGhiEG1PxCLCeUIIvkMDgkcZjy8vh8STAJfj9Rq5UPp00Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806783; c=relaxed/simple;
	bh=aidoWnRBdKS/bzj9yzmy9eXwgGR2HXGsyDF1QbYB0U0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=ofLNi/8Z7qJFujzoTJhGmBuonyH8IKbBRxCqsgZ9b6TszZ6p8nQOy6dP7qbZfGtYK4brNu/sAQMFH0kmqA6KMjHsc0tyQQKEPJvIvB+NhG7SC9T7SiMOhdBqSHu1hmXjHxVq0VyY0hzuFHiuGhy/CUf4Fu93TwokXkB3vUPgL1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A6F01063;
	Mon, 17 Feb 2025 07:40:01 -0800 (PST)
Received: from e133711.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 765B53F6A8;
	Mon, 17 Feb 2025 07:39:41 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Mon, 17 Feb 2025 15:38:54 +0000
Subject: [PATCH v3 13/19] firmware: arm_ffa: Remove unnecessary declaration
 of ffa_partitions_cleanup()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-ffa_updates-v3-13-bd1d9de615e7@arm.com>
References: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
In-Reply-To: <20250217-ffa_updates-v3-0-bd1d9de615e7@arm.com>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=aidoWnRBdKS/bzj9yzmy9eXwgGR2HXGsyDF1QbYB0U0=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBns1gv6fDyFE6SRIJTmRZSK7AGzajqpMcsbZ1Mf
 is3SarX/ISJAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZ7NYLwAKCRAAQbq8MX7i
 mGnKD/9nTGkCjRYMkNvtTNTZ+ba+EFDlgHhfCUjpG1zmPMjavtH3ijDKfC9w9dt9Nu9p4L5bn+c
 vjNaZ3Zui8C5Ui6FJjDyRaUm2O77nu73bYwuaD6t/mXHDwCh2hN1shp4KHrBtzR9u3lP3RhpkvR
 8gyGvDLNZfsRn+MyR9ClEqn4gWCaMnQLdlsWOnlQsYn2ss0vYYh4f5GLzPRINldNr13B4OpVaL3
 cD4vLjg8PHUNxv/No8Hy/InZvjwKMlpoOrCPxav/psSaQmbNKS/fmyXIkdxZfpZRe0tBKSEVsH5
 ZNqjbVjvUPV/h5Z+MczXV3hFoeNXJ5+3t7GFIQ5eyPi607V+LXSk7FuMTO4iIGnTDo5LxM5almQ
 blkjh/bIhVzvudwKKaxoLW0rihZ0cX3fW2DWf2jh1BaDMatQ5Kkhf3/Q9GIAqzw7LfsiDG5z9h/
 lGOWelMNCGy8YfjqkRLLbreFvaHFDqrMotSOBr6qQn5NZhriUDI9a/smuUllOZytYj8Ssyx7dEb
 LQLQhixX5ofSIDos2BbQaMnXxxW+XiyQ4y+K0Pvot+88jcjR9BEES0MApcRJDt4Euh22Cokfp8q
 BIY7vHs01M0rnP99lBSAFAMAlAJLs43BsbS/fXsidFQpQQNe0xKOnAu6XCGs29HM+hpAquJjkRE
 sgK1MQ/qfLcMVkw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4

In order to keep the uniformity, just move the ffa_partitions_cleanup()
before it's first usage and drop the unnecessary forward declaration.

No functional change.

Tested-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index ad2f6b410e4431bb133fa0f05dd3eec802f5ee07..43e033edd6c7cd16322c204e882a84cfe45abbba 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -114,7 +114,6 @@ struct ffa_drv_info {
 };
 
 static struct ffa_drv_info *drv_info;
-static void ffa_partitions_cleanup(void);
 
 /*
  * The driver must be able to support all the versions from the earliest
@@ -1452,6 +1451,22 @@ static int ffa_xa_add_partition_info(int vm_id)
 	return ret;
 }
 
+static void ffa_partitions_cleanup(void)
+{
+	struct ffa_dev_part_info *info;
+	unsigned long idx;
+
+	/* Clean up/free all registered devices */
+	ffa_devices_unregister();
+
+	xa_for_each(&drv_info->partition_info, idx, info) {
+		xa_erase(&drv_info->partition_info, idx);
+		kfree(info);
+	}
+
+	xa_destroy(&drv_info->partition_info);
+}
+
 static int ffa_setup_partitions(void)
 {
 	int count, idx, ret;
@@ -1509,22 +1524,6 @@ static int ffa_setup_partitions(void)
 	return ret;
 }
 
-static void ffa_partitions_cleanup(void)
-{
-	struct ffa_dev_part_info *info;
-	unsigned long idx;
-
-	/* Clean up/free all registered devices */
-	ffa_devices_unregister();
-
-	xa_for_each(&drv_info->partition_info, idx, info) {
-		xa_erase(&drv_info->partition_info, idx);
-		kfree(info);
-	}
-
-	xa_destroy(&drv_info->partition_info);
-}
-
 /* FFA FEATURE IDs */
 #define FFA_FEAT_NOTIFICATION_PENDING_INT	(1)
 #define FFA_FEAT_SCHEDULE_RECEIVER_INT		(2)

-- 
2.34.1


