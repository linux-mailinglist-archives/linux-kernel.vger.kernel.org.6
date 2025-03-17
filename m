Return-Path: <linux-kernel+bounces-563513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65160A64336
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4714188337B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 07:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CD721931C;
	Mon, 17 Mar 2025 07:17:20 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147A21CFEC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.62.165.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195840; cv=none; b=BejhAE4M8lehfibKC6cZSnoXyEQNYYp2JLgsC/iV35VEZ7R6Y1ddzpWgtf21jGbTYywQDhKePjf2ZyDvMnvTX6w4IGkNl1JS9BGFx7e5YO8JNs73z4iVYlr4Iv1Kgz3m2nao/8c0C0F/hWDcnoGqHGSDqw9kubytLZB5zXS1QIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195840; c=relaxed/simple;
	bh=TbdqC6kaY8ADR7bsnfdwIHRhnhOpf1QkzLFQbDHaCOk=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=m5Kk3ZhvsFcI1LH0QiPazms0CV8aBBa9i/waWMjSZ5d5iaeEThHETiql9JUbVWzRvN/xtVOScl2ZmkGbHXkOmHYIY5LKkUKlkw7e00vLQtN/z45e+l14DHFjgjBp7byvchGf78HQDlornhF/KauqhxJUhrPacPbatVpyh86mcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=183.62.165.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4ZGR9z4DFLz501gV;
	Mon, 17 Mar 2025 15:17:11 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 52H7GjbN079096;
	Mon, 17 Mar 2025 15:16:45 +0800 (+08)
	(envelope-from tang.dongxing@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 17 Mar 2025 15:16:48 +0800 (CST)
Date: Mon, 17 Mar 2025 15:16:48 +0800 (CST)
X-Zmail-TransId: 2af967d7cc60616-56a25
X-Mailer: Zmail v1.0
Message-ID: <20250317151648132Sj7qhbVfKcPYvqCievFUf@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <tang.dongxing@zte.com.cn>
To: <jgross@suse.com>
Cc: <sstabellini@kernel.org>, <oleksandr_tyshchenko@epam.com>,
        <jiqian.chen@amd.com>, <ray.huang@amd.com>,
        <jeff.johnson@oss.qualcomm.com>, <minhuadotchen@gmail.com>,
        <tang.dongxing@zte.com.cn>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>, <ye.xingchen@zte.com.cn>,
        <yang.guang5@zte.com.cn>, <yang.yang29@zte.com.cn>,
        <xu.xin16@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSB4ZW4vcGNpYmFjazogdXNlIHN5c2ZzX2VtaXRfYXQoKSBpbnN0ZWFkIG9mIHNjbnByaW50Zigp?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 52H7GjbN079096
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67D7CC77.001/4ZGR9z4DFLz501gV

From: TangDongxing <tang.dongxing@zte.com.cn>

Follow the advice in Documentation/filesystems/sysfs.rst:
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

Signed-off-by: TangDongxing <tang.dongxing@zte.com.cn>
---
 drivers/xen/xen-pciback/pci_stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index b616b7768c3b..a0782a74ed34 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -1281,7 +1281,7 @@ static ssize_t slots_show(struct device_driver *drv, char *buf)
 		if (count >= PAGE_SIZE)
 			break;

-		count += scnprintf(buf + count, PAGE_SIZE - count,
+		count += sysfs_emit_at(buf, count,
 				   "%04x:%02x:%02x.%d\n",
 				   pci_dev_id->domain, pci_dev_id->bus,
 				   PCI_SLOT(pci_dev_id->devfn),
-- 
2.25.1

