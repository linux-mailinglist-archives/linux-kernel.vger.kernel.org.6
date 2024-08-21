Return-Path: <linux-kernel+bounces-294928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC65E95945E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDFF1F24257
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2E16BE16;
	Wed, 21 Aug 2024 06:06:57 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F38166305
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724220417; cv=none; b=ELKOdDi/AHtgpLb2kgBod9LzWSjP/14MS93XiUkNpy7QMDrAfE7B4Pj0zVsa16YFTDlLdTws7D6nPlydirxzvL9eL2e4HUdsi50771ofv7suY+nzgfKTiFAv1t2uEZDfXvfbgTuISS+qTzLmrUYaGDrfVbAJslmExLes9kjHtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724220417; c=relaxed/simple;
	bh=HGSNb0LKppQRtPUDUk01BKEa0Hxhd7eMveXAcC7KveI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lmaLjxrvTonaEZ71nB5oI1hrnYi7qmWEZmAl3GW6ql5Bpr/7lOeVtip92J8aE0IskMWsiQCzoiecEd3wh3IryPZzrFMoQTX3B5A97mPBYDDSa3+HMQScd+L+NsjCw6YOARQPnW7ZNFlBu/Xech3y2DNLVrfnPl3tPZ2O78Ge/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WpbQf0wYWz1xvWl;
	Wed, 21 Aug 2024 14:04:58 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 909A71401E9;
	Wed, 21 Aug 2024 14:06:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 Aug
 2024 14:06:52 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <bodonnel@redhat.com>
CC: <jlayton@kernel.org>, <chuck.lever@oracle.com>, <amir73il@gmail.com>,
	<lihongbo22@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] efs: rename the fs context operations
Date: Wed, 21 Aug 2024 14:14:22 +0800
Message-ID: <20240821061422.2273380-1-lihongbo22@huawei.com>
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
 dggpeml500022.china.huawei.com (7.185.36.66)

Just rename efs_context_opts to efs_context_ops for better
understanding.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/efs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/efs/super.c b/fs/efs/super.c
index e4421c10caeb..57c373bbc190 100644
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -359,7 +359,7 @@ struct efs_context {
 	unsigned long s_mount_opts;
 };
 
-static const struct fs_context_operations efs_context_opts = {
+static const struct fs_context_operations efs_context_ops = {
 	.parse_param	= efs_parse_param,
 	.get_tree	= efs_get_tree,
 	.reconfigure	= efs_reconfigure,
@@ -377,7 +377,7 @@ static int efs_init_fs_context(struct fs_context *fc)
 	if (!ctx)
 		return -ENOMEM;
 	fc->fs_private = ctx;
-	fc->ops = &efs_context_opts;
+	fc->ops = &efs_context_ops;
 
 	return 0;
 }
-- 
2.34.1


