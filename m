Return-Path: <linux-kernel+bounces-200523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700838FB13D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2850A283A64
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AF61459FE;
	Tue,  4 Jun 2024 11:38:40 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C038B;
	Tue,  4 Jun 2024 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501120; cv=none; b=HckJyS93O5iYLFvdEr7pJtNv01lpjCL30wjbznGw53sn2XEXR/JYdDfJiRXVp62HXWrvEwDFg/aq2vQlB6HAav1IAS2RnpYCqGq+PaLuWeQG1G2T3uZkLQFwsL/utdQa2RQ1Y3/6NC+gZsPHTZxUPU7zQOm7UwWR3o5sfPNQf1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501120; c=relaxed/simple;
	bh=c2u5i1+HLFteihmzabNvpFUFBefE6Pzw1A+fPM1m1HI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UxtGjI0DUUlDk4Yo1MtFK2EqmNr5wh8rfT8mcjq5Wo9QDiRwoZGPa79lCPl8eWYxtRaD7GUVQMd7i/vGZ0rGH6WD4ekf8EaTeUxvkga9kbtU1snK8VVNr+UsFba1NdMhZSB4QHL70qBkGl8DHNDJV/sy7FvNF4wpMrdtUvd+JRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VtpR41vW2zwR4Q;
	Tue,  4 Jun 2024 19:34:40 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ABDC140FD3;
	Tue,  4 Jun 2024 19:38:35 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 19:38:34 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <corbet@lwn.net>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
	<aou@eecs.berkeley.edu>, <paulmck@kernel.org>, <jpoimboe@kernel.org>,
	<tglx@linutronix.de>, <rdunlap@infradead.org>, <xiongwei.song@windriver.com>,
	<wangkefeng.wang@huawei.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] Documentation: kernel-parameters: Add RISCV for nohlt
Date: Tue, 4 Jun 2024 19:40:05 +0800
Message-ID: <20240604114005.875609-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Since commit bcf11b5e99b2 ("riscv: Enable idle generic idle loop") enable
idle generic idle loop for RISCV, but the document is not updated
synchronously, so update RISCV support for nohlt.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Fixes: bcf11b5e99b2 ("riscv: Enable idle generic idle loop")
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..821dafffa119 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3936,7 +3936,7 @@
 
 	nohibernate	[HIBERNATION] Disable hibernation and resume.
 
-	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,PPC,SH] Forces the kernel to
+	nohlt		[ARM,ARM64,MICROBLAZE,MIPS,PPC,RISCV,SH] Forces the kernel to
 			busy wait in do_idle() and not use the arch_cpu_idle()
 			implementation; requires CONFIG_GENERIC_IDLE_POLL_SETUP
 			to be effective. This is useful on platforms where the
-- 
2.34.1


