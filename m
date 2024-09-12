Return-Path: <linux-kernel+bounces-326446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F107976875
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29727B20B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742B9190079;
	Thu, 12 Sep 2024 12:00:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87419EEA1
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 12:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142408; cv=none; b=YNaCD+W4BFr1xUFL+ogOFxPxvN0p0RyF61bpLcQ2jECKamVCp+60jcAno8IrGgDZeIv28Gc5mguD1qWmHf9NQrKBZW7ynD4gsid2pORfXs3CjkxRZVTQDyMvUlKNzWYF9lSNdvzGdQnkvVTxB9WU5MdO8o8G9uiaeevEwmN/W2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142408; c=relaxed/simple;
	bh=yxJBWRglkHbaNEq55y6z2HHjCNr7NB7VIGOEqAO5EvE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsjpmWFGefNpitrFdbPOxvDA4QUEmG7d3JjWhuFJWE7Aj40J0QBSb/lBG5RXhOexXu7kVdocO7aQRapBCLBVT0BTRUCzhqovPlxnaHBlPecCXndiUvnuBPtnfLPCa1mjg7PfDDR+79NSgqj4rICbJpC88wilXk6m0jnP9fKQRBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4X4GCg62BMzfc45;
	Thu, 12 Sep 2024 19:57:51 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id DF76D1800FF;
	Thu, 12 Sep 2024 20:00:02 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Sep
 2024 20:00:02 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <apw@canonical.com>, <joe@perches.com>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>,
	<linux-kernel@vger.kernel.org>, <dwaipayanray1@gmail.com>,
	<lukas.bulwahn@gmail.com>
Subject: [PATCH 1/2] checkpatch: remove RCU APIs in deprecated_apis map
Date: Thu, 12 Sep 2024 19:56:14 +0800
Message-ID: <20240912115615.1029452-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240912115615.1029452-1-liaoyu15@huawei.com>
References: <20240912115615.1029452-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500003.china.huawei.com (7.185.36.200)

After commit 6ba7d681aca2 ("rcu: Remove wrapper definitions for
obsolete RCU update functions"), the definitions for these RCU APIs
have been removed, so there is no longer any need to retain them in the
deprecated_apis map.

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 scripts/checkpatch.pl | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 4427572b2477..ca60a2db223a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -834,16 +834,6 @@ foreach my $entry (@mode_permission_funcs) {
 $mode_perms_search = "(?:${mode_perms_search})";
 
 our %deprecated_apis = (
-	"synchronize_rcu_bh"			=> "synchronize_rcu",
-	"synchronize_rcu_bh_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_bh"				=> "call_rcu",
-	"rcu_barrier_bh"			=> "rcu_barrier",
-	"synchronize_sched"			=> "synchronize_rcu",
-	"synchronize_sched_expedited"		=> "synchronize_rcu_expedited",
-	"call_rcu_sched"			=> "call_rcu",
-	"rcu_barrier_sched"			=> "rcu_barrier",
-	"get_state_synchronize_sched"		=> "get_state_synchronize_rcu",
-	"cond_synchronize_sched"		=> "cond_synchronize_rcu",
 	"kmap"					=> "kmap_local_page",
 	"kunmap"				=> "kunmap_local",
 	"kmap_atomic"				=> "kmap_local_page",
-- 
2.33.0


