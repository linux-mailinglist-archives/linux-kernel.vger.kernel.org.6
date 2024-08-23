Return-Path: <linux-kernel+bounces-298641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ADF95C9BD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73239B26E86
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C61186E57;
	Fri, 23 Aug 2024 09:53:31 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F71185B62
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724406811; cv=none; b=lWxGEboe+MlsGpuOPLZgvWL2I+heV4/yaWjDelRvfowiqDPMNZ6kwQfnZhaIbqClYyELKT6rEiv/ar4aEiaA+bnpK7UEgLQwHcoE1rLTG6NiAUMmtJ1KkuYXEUIeo6TXmMdX8trPd7aMbFjqZp+NAQuaElg12Puhb51NR7uQ+SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724406811; c=relaxed/simple;
	bh=mN3MFqVkmhHgM8eFq9KKFrJEjzXF93D7fDobeTcRbcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TX/lrXr0arT01iBxYVCcSaodkOu4OFIH498Wm+gY0DZcYkDY1+cRaic74YdjfFjbSB6uBl+IsB0kCpkK4xFv24xafD2YEnyoaVdiOwGct1SDvNOvq1VwAtp1iHeL6b307lqMLwbdw5q5xjazYxb5skXgv6PAN6RLI8N8NFg2bjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WqwHt1ZZBzQqQJ;
	Fri, 23 Aug 2024 17:48:42 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 76E6B1800CD;
	Fri, 23 Aug 2024 17:53:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 23 Aug
 2024 17:53:26 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <airlied@redhat.com>, <tzimmermann@suse.de>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] char/agp: Remove unused declaration compat_agp_ioctl()
Date: Fri, 23 Aug 2024 17:50:25 +0800
Message-ID: <20240823095025.3147585-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 87be41f09ac9 ("char/agp: Remove frontend code") removed the
implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/char/agp/agp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/char/agp/agp.h b/drivers/char/agp/agp.h
index 67d7be800a7c..93689bfdda34 100644
--- a/drivers/char/agp/agp.h
+++ b/drivers/char/agp/agp.h
@@ -239,8 +239,6 @@ extern const struct aper_size_info_16 agp3_generic_sizes[];
 extern int agp_off;
 extern int agp_try_unsupported_boot;
 
-long compat_agp_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-
 /* Chipset independent registers (from AGP Spec) */
 #define AGP_APBASE	0x10
 #define AGP_APERTURE_BAR	0
-- 
2.34.1


