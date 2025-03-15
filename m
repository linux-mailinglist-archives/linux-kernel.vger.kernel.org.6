Return-Path: <linux-kernel+bounces-562417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ACFA626F1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 07:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45D887A5891
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 06:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294718DB17;
	Sat, 15 Mar 2025 06:07:55 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B8BF9E8
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 06:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742018875; cv=none; b=b0m++gz3VyzfratXxzpAfTobp4YjKeym0Z2zNkeOHK08WHZdCPmMIEiYwQ9F/9aYUUJ2wUD2syI+DlXAhGBFTOAMv4XbpTMiSUIVtB/NP5vGeBiZoKX8hEu3+Ymvvaw8sb4SkpK5n6OBEVc8VqOy8DjoOFjlJ5tjP/TE0E1cb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742018875; c=relaxed/simple;
	bh=sWfxxtex5eJurZ7TSJN6TWx4aqxfQQn3PzRY6ZimCgo=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=W5yXyPg3ckjHxIKsOvH7JyjGuJCMxO2UJUWNfFlU5751aITjyWW2vbN+HSkW7HRDyAkNA5NBeA2ISpjcb0+rONSbqVFjbbkPUi0ztRnebEZFsdeJ1ueP5oyR9h9ejLV1F5Y1/LsPF106o40l7H6z7NLGEEvs6fhz1Hq1KkI3vsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZF9kp2NNtz8R040;
	Sat, 15 Mar 2025 14:07:46 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 52F67fo0052400;
	Sat, 15 Mar 2025 14:07:42 +0800 (+08)
	(envelope-from xie.ludan@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 15 Mar 2025 14:07:43 +0800 (CST)
Date: Sat, 15 Mar 2025 14:07:43 +0800 (CST)
X-Zmail-TransId: 2afc67d5192f272-5d071
X-Mailer: Zmail v1.0
Message-ID: <20250315140743750cHJ6I1rOluLjS4m5GCKjr@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xie.ludan@zte.com.cn>
To: <akpm@linux-foundation.org>
Cc: <jbaron@akamai.com>, <jim.cromie@gmail.com>,
        <linux-kernel@vger.kernel.org>, <xie.ludan@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBkeW5kYmc6IHVzZSBzeXNmc19lbWl0KCkgaW5zdGVhZCBvZiBzY25wcmludGYoKQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52F67fo0052400
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D51932.001/4ZF9kp2NNtz8R040

From: XieLudan

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: XieLudan
---
lib/dynamic_debug.c | 4 ++--
1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 5a007952f7f2..83ce3f310ab9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -795,11 +795,11 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)

case DD_CLASS_TYPE_DISJOINT_NAMES:
case DD_CLASS_TYPE_DISJOINT_BITS:
- return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+ return sysfs_emit(buffer, "0x%lx\n", *dcp->bits);

case DD_CLASS_TYPE_LEVEL_NAMES:
case DD_CLASS_TYPE_LEVEL_NUM:
- return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+ return sysfs_emit(buffer, "%d\n", *dcp->lvl);
default:
return -1;
}
--
2.25.1

