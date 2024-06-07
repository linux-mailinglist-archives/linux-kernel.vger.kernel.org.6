Return-Path: <linux-kernel+bounces-205312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9F38FFA91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 06:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1E61C23EFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 04:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B769C155758;
	Fri,  7 Jun 2024 04:27:15 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CEE383BD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717734433; cv=none; b=JbLAwpZ20IZGB9cnS5cfx2a2bLpsC0d+vtrPbGNIV65QDlyN49mroq7c8c1i1X4oxsD8p3a/S1Lu9A+NduDnBRc2O2b40x/a/XXlbpl0M0e2B7rN+yYP5usO4Pw1i50dFqp0Ayh5rLA83WNbbP/RKWGYPNRn4xZKXmQaM3LKpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717734433; c=relaxed/simple;
	bh=4XzJN71XGGZBN8Lrinip6eeq5KHOj/1cESH+TPYjHCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwYXOGIQ6eAGbjy2Sv5a9uPE9FVv5Eh6JhtZRc0Jr3ODI/VbJaouWxYVKppJWpAIMzwO0niosWnSn6I+L+8EeY/xDdV48Z05VVkkU79hpFz8MvUId7bko86X+TVpiBK6pONA2csEvCfM+XHq0Czk/segKVDrEjE+Ud2GeVSwupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VwSjq54v1z1S9pR;
	Fri,  7 Jun 2024 12:23:11 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 72A3818007E;
	Fri,  7 Jun 2024 12:27:10 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 7 Jun
 2024 12:26:51 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <david.oberhollenzer@sigma-star.at>,
	<miquel.raynal@bootlin.com>, <yi.zhang@huawei.com>, <xiangyang3@huawei.com>,
	<huangxiaojia2@huawei.com>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH mtd-utils 033/110] ubifs-utils: Add descriptions for new lib files in common/README
Date: Fri, 7 Jun 2024 12:24:58 +0800
Message-ID: <20240607042615.2069840-34-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240607042615.2069840-1-chengzhihao1@huawei.com>
References: <20240607042615.2069840-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)

There are serveral new libs(eg. atomic, kmem, bitops. etc.) have
been imported into ubifs-utils, add descriptions for these libs
in README.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 ubifs-utils/common/README | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/ubifs-utils/common/README b/ubifs-utils/common/README
index 8c10fd4b..32d04e3a 100644
--- a/ubifs-utils/common/README
+++ b/ubifs-utils/common/README
@@ -7,3 +7,11 @@ Common Library
 * defs.h is a bunch of definitions to smooth things over.
 * lpt.c is a selection of functions copied from fs/ubifs/lpt.c from the linux kernel, and amended.
 * hashtable/* was downloaded from http://www.cl.cam.ac.uk/~cwc22/hashtable/
+* atomic.h was downloaded from https://the-linux-channel.the-toffee-project.org/index.php?page=6-tutorials-linux-user-space-atomic-operations
+* bitops.h and bitops.c were copied from the linux kernel.
+* compiler_attributes.h was copied from the linux kernel.
+* linux_types.h was copied from the linux kernel.
+* linux_err.h was copied from the linux kernel.
+* hexdump.c was copied from the linux kernel.
+* kmem.h and kmem.c were partial copied from xfsprogs-dev (https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git/)
+* sort.h and sort.c were copied from the linux kernel.
-- 
2.13.6


