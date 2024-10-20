Return-Path: <linux-kernel+bounces-373154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFEF9A5309
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 09:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CE2B22B80
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDC82B9DD;
	Sun, 20 Oct 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P55lH9gd"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3D32B9C6;
	Sun, 20 Oct 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729410558; cv=none; b=hxEARvg7uCe2EqzqsrWPRlapxv1RaMnxnSz+CMzDh5WdZJCYcX3fA1jKNpgWvh87xKrzMvFoewT9Gi8OsMN2ViThcvcfqIa6wex4ey/t2j8D9GKdpEAtaauw25TfJomLbzm10vvA/tGiaq1B96vx5k/iEnRR10ux4HWBK7np20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729410558; c=relaxed/simple;
	bh=2/4nBV3EbJg4VYgdxH1vnXvH/rfZWUnk7Ke5IscmR6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV/O+J3yk0pBF9TA1fUDOtr6LKPGk460SNNxmDZwDgdCLCmh5Dd4PfoMhzn8Pasmd3YL8dW9F7aXF9J6Nqsx8NCP4dZ7SIhQO/FK76uSaa+DweGpdPlhlCtvsbFS3Gd4HuwMXhp8UTJuEMJp57GVNJE6V7UTMOQu8XCbsZcTfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P55lH9gd; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=x4NTp
	GjZzFN6SUgygF3qJkYQtZICM+89+U+jSj6asRw=; b=P55lH9gdNXdjAH4BK1M/4
	Q2iLWqF/8u2ata3tfN+A2/gd3akMk8QZSjGdzaXbIZbNRNS3KCf2h6DCP4+hXBJ/
	qp+xQBVDIXb4QMBPuzic5X8E3EpkEpWdNTQJ6s1VBe62mlRyORo10DB+Zdtn2U7Y
	W9YfQGoFb9uqz9DNfJyapg=
Received: from localhost.localdomain (unknown [114.253.22.201])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDnRlvZtRRnTWTBAg--.44212S2;
	Sun, 20 Oct 2024 15:48:42 +0800 (CST)
From: Dingyan Li <18500469033@163.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] usb: storage: fix wrong comments for struct bulk_cb_wrap
Date: Sun, 20 Oct 2024 15:47:21 +0800
Message-Id: <20241020074721.26905-1-18500469033@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgDnRlvZtRRnTWTBAg--.44212S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF47Cr4UXr4UCr1UJF4xJFb_yoW3WFbE9w
	1xK348ArWrArW7Jw13tFnavF17K348JFsFg3WrtrW3Z390vws5u3s7AFnFqFW3G3W7GrZx
	u3WkWryfJrySyjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb1lk3UUUUU==
X-CM-SenderInfo: jprykiiquwmiitt6il2tof0z/1tbiNhV+y2cUnJX3NwAAss

In the flags, direction is in bit 7 instead of bit 0 based
on the specification.

Signed-off-by: Dingyan Li <18500469033@163.com>
---
 include/linux/usb/storage.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/usb/storage.h b/include/linux/usb/storage.h
index 2827ce72e502..8539956bc2be 100644
--- a/include/linux/usb/storage.h
+++ b/include/linux/usb/storage.h
@@ -53,7 +53,7 @@ struct bulk_cb_wrap {
 	__le32	Signature;		/* contains 'USBC' */
 	__u32	Tag;			/* unique per command id */
 	__le32	DataTransferLength;	/* size of data */
-	__u8	Flags;			/* direction in bit 0 */
+	__u8	Flags;			/* direction in bit 7 */
 	__u8	Lun;			/* LUN normally 0 */
 	__u8	Length;			/* length of the CDB */
 	__u8	CDB[16];		/* max command */
-- 
2.25.1


