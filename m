Return-Path: <linux-kernel+bounces-563561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FDAA64423
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262F33A13BF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85B121ABC1;
	Mon, 17 Mar 2025 07:47:20 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F598F5C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742197640; cv=none; b=auFmK/JVH0Gkv0MPP3k/DViaPWNwdXydii/bOfmPsFcXbXTWS5FwnpgrwK7B5iixKBDdVGU9pYvpQToLUIFj/BgMz7DQ1m2EDHqZhYgLZqG9GGYMojxKNApVe/Iu190mBos0ZH/9rJWoMIZfRoKqVy4TCFOimN5lBHFyDyvBBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742197640; c=relaxed/simple;
	bh=kfcvLecLv1q9xbglTQLonj5fKbZWoIAYa1VVQ0GQZKY=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=BhjerV9zfsowTPDtNmCaWMl/13M4x1nCXgrbAdNZ+WIr4esrxrbuA+r78Ed5Yih/LGDlpA8oFOL6LJSKOpW0Nmbnhu2PiBcI/UZunaMusN27qZPsWiREOdw6dcT9IQBHn8H6xSw6aUmQq70E8cnSA92cdoZps3tgg3BsfPPrtjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZGRrf3bsSz5B1Jy;
	Mon, 17 Mar 2025 15:47:14 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 52H7ktjt063259;
	Mon, 17 Mar 2025 15:46:55 +0800 (+08)
	(envelope-from tang.dongxing@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:46:57 +0800 (CST)
Date: Mon, 17 Mar 2025 15:46:57 +0800 (CST)
X-Zmail-TransId: 2afc67d7d3710bd-1450e
X-Mailer: Zmail v1.0
Message-ID: <20250317154657278tVMfwXa9KMOtZ6c_FfHJ9@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <tang.dongxing@zte.com.cn>
To: <alexander.shishkin@linux.intel.com>
Cc: <linux-kernel@vger.kernel.org>, <yang.guang5@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBpbnRlbF90aDogbXN1OiB1c2Ugc3lzZnNfZW1pdF9hdCgpIGluc3RlYWQgb2Ygc2NucHJpbnRmKCk=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 52H7ktjt063259
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7D382.001/4ZGRrf3bsSz5B1Jy

From: TangDongxing <tang.dongxing@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: TangDongxing <tang.dongxing@zte.com.cn>
---
 drivers/hwtracing/intel_th/msu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index bf99d79a4192..eb474e9a9645 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1983,15 +1983,15 @@ nr_pages_show(struct device *dev, struct device_attribute *attr, char *buf)
 	mutex_lock(&msc->buf_mutex);

 	if (msc->mode == MSC_MODE_SINGLE)
-		count = scnprintf(buf, PAGE_SIZE, "%ld\n", msc->nr_pages);
+		count = sysfs_emit(buf, "%ld\n", msc->nr_pages);
 	else if (msc->mode == MSC_MODE_MULTI) {
 		list_for_each_entry(win, &msc->win_list, entry) {
-			count += scnprintf(buf + count, PAGE_SIZE - count,
+			count += sysfs_emit_at(buf, count,
 					   "%d%c", win->nr_blocks,
 					   msc_is_last_win(win) ? '\n' : ',');
 		}
 	} else {
-		count = scnprintf(buf, PAGE_SIZE, "unsupported\n");
+		count = sysfs_emit(buf, "unsupported\n");
 	}

 	mutex_unlock(&msc->buf_mutex);
-- 
2.25.1

