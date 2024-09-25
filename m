Return-Path: <linux-kernel+bounces-337955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C5F985167
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ABBAB23443
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3105E14A614;
	Wed, 25 Sep 2024 03:23:45 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5DD14A4E2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 03:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727234624; cv=none; b=ipHn+QS7chw7ANByrf04glnJnD/oedb5xHXOxrZ8T7Ui/gqg1vVNbrlC7ScNvWykpGtmUQ9pUHNreIOGB5VKvQR705IGBCUSC6XA9oTKI8egwpRHoX7qTI7uzNPq/6TSnEd9SWJzk83r8xnEwlej40Dzr95C5kmP0dw/rMktnIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727234624; c=relaxed/simple;
	bh=ujYzwysx8BVaV/txjzevN6TgeIeQEwkBY9v+gQRY6tk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kR3nEATkqSyz9Y07zmzF+WEezgjM/kWbDaYUpgdevj6jdV1Q8EONBFLVznqmm5p3RQ33o3GJOKG43z+7401Y5ZbMjN0oyB3U++Wc8c/np1HakpnDACez4MyKjZKCqBVRRvgDJOjeIW2z/bEVZpx0AT9Dk/MRqp95qSFUROe6Vh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 48P3NE3x054301;
	Wed, 25 Sep 2024 11:23:14 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XD20y3PGQz2Mx63v;
	Wed, 25 Sep 2024 11:15:30 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 25 Sep 2024 11:23:11 +0800
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
Subject: [PATCH 2/2] Documentation: admin-guide: kernel-parameters: Add parameter description for slub_leak_panic function
Date: Wed, 25 Sep 2024 11:22:56 +0800
Message-ID: <20240925032256.1782-3-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
References: <20240925032256.1782-1-fangzheng.zhang@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 48P3NE3x054301

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


