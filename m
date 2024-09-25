Return-Path: <linux-kernel+bounces-339147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DE98628A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E373B23BBC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E21B1427;
	Wed, 25 Sep 2024 13:25:35 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80571B1412
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 13:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270734; cv=none; b=NfzuLQjZCYPHhJx8t0ouTgpnDH+C7bGCJv5b+AMwgl9AK2xh/ZQICMl2gSW2UFUVd1WpcduqGpoelm8O3JmF73LsccsW5I4cVqluTtWO2BA1uFi12D9BHFsLvoFdF9jnnj0rM77brtvrnRH8Ya8P6l86zCn/xDNMOVE3wSinJIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270734; c=relaxed/simple;
	bh=ujYzwysx8BVaV/txjzevN6TgeIeQEwkBY9v+gQRY6tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDSa8FlK4Xf6IPLGXwtrz1Asrb9bjVihgZfokeg6iQ0LsgBqFwamNN+vRhUzD27JNPwDBslc4rVXhD13MA5QX3CVseWOhhVNuT0nqq+foz+0Uzf7BnG52Lo1Edq0UbDw3ck0XxlZJwUwu2r3spB272OgAyDT4S/BW0Cq2XChXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48PDPKph032238;
	Wed, 25 Sep 2024 21:25:20 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XDHMg1QHxz2QHjcP;
	Wed, 25 Sep 2024 21:17:35 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 21:25:17 +0800
From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tkjos@google.com>,
        Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>
Subject: [PATCH V2 2/2] Documentation: admin-guide: kernel-parameters: Add parameter description for slub_leak_panic function
Date: Wed, 25 Sep 2024 21:25:05 +0800
Message-ID: <20240925132505.21278-3-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240925132505.21278-1-fangzheng.zhang@unisoc.com>
References: <20240925132505.21278-1-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48PDPKph032238

Introduce the details of the slub_leak_panic parameters in
kernel-parameters.txt, so that users can understand how to use
the parameters more quickly.

Signed-off-by: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb48ae24ae69..8a672766f05f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6130,6 +6130,21 @@
 			For more information see Documentation/mm/slub.rst.
 			(slub_nomerge legacy name also accepted for now)
 
+	slub.leak_panic= [MM, SLUB]
+			Enabling slub.leak_panic can monitor the slub usage
+			in real time on the slub allocation path. When the
+			slub occupancy is abnormal, the alarm or panic will
+			be triggered.
+			Default: N
+
+	slub.leak_panic_threshold= [MM, SLUB]
+			Upper limit value of the slub usage, expressed as
+			a percentage of memtotal. When the usage exceeds
+			the set value (threshold * memtotal / 100), the
+			slub_leak_panic function will be trigger. The
+			value setting range is [0, 100].
+			Default: 0
+
 	slram=		[HW,MTD]
 
 	smart2=		[HW]
-- 
2.17.1


