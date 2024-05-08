Return-Path: <linux-kernel+bounces-173474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4080D8C00D0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D563FB25362
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A26126F05;
	Wed,  8 May 2024 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="P4xkoawb"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885E986AF4
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 15:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181623; cv=none; b=UMMl+1yhDtiHYkyTegoqMqSQj780HIAnsar0GCgtGnfO+UA5gmdrLpfgVN1V7uOYTygHKSgn5SxyNecT5jxXcXdeUKVTsZMEB0rdWmT2ElKFeMwMGcQL6qZKYyXKH9p0f6ejjMIPUDV9K0Ql0ODBIW3FrUxEOUkGnps3jU8olNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181623; c=relaxed/simple;
	bh=pVWuYbzUs7Jev4RY7RmHJPW4092hATCc5SdzY5qRSLw=;
	h=Message-ID:From:To:Subject:Date:MIME-Version; b=ZrM20EIWOKilFC9Eqn2KghFTK0O8nBKtQufnpnhQtb4uq7Md4WCmJjHHh4xuQLE4261aMDFwBeUnKs6MIWZ+opKAhGYRAl5CxA7XSr0pVPVyAamrpz8Fb0BVaD8vTgSYhRfoncNyBLr6J27IQ/tlxCXazQHxe+OBVLyLyuVV2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=P4xkoawb; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1715181609; bh=elRxz6OWhugfzFAIlmwlLj9gRAiGJCPhF4W6JN9Xyhg=;
	h=From:To:Subject:Date;
	b=P4xkoawbUSX2SA01TpRaQrvpxoNZ2ctBO2HwRubIMdTeVA9VhWhCs7dNTVSjgm7lQ
	 v9T+ueQvpK1J60/BkgvlYVZHKNJ+LTBsejdan+veu1ciHMK7QiBeWrhrQE0+iDtO0Z
	 0sIEWHd7aqw9cXOJ9/UpmwIsUHJT1Kct/VCz0fY0=
Received: from pipishuo-OMEN-by-HP-Laptop-16-b0xxx.. ([123.115.148.131])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 375AB210; Wed, 08 May 2024 23:13:53 +0800
X-QQ-mid: xmsmtpt1715181233tkjqblovg
Message-ID: <tencent_1992979C468AF087A1909000C6D0D5E61207@qq.com>
X-QQ-XMAILINFO: MUl6Z5IrFzo7Rxpr5BMoTbyvm829X+fUJdpiyFAfklHaNPjsUL+MRRa88iq6np
	 3dCgOCRp+f1wzZtEYcNcXa6FM6+LOwGTASB1HPAU0OnaQ/YTIAkrP9/I7LPEKwb7KeVwKg44OmYf
	 r61J/cAI+dDoBOx7ilN+jxbQZ1tDWQ8e+Y0g/gZK3s+QcBrxjFjGamqOnddAcKpwgc6fBOwh38mz
	 5uzMJAJmfMHoWD5ROP8p8jgZpCF1oQxjTXNXPY1rXOft+/uPxGLk6HwvEAijQhMHjHlhLxQOmyjf
	 095s3a31xa+OqJPx0a9xJX6OfbBHXgVG66ZPHKx3JlWGCDXfrrRdQljO5TZDDjhFUJywSrg7RK4u
	 6F6MGGcFcirD4eXvzvT2XSRJcSxdXWdRlAK80zgUa4Z/GXi6fjyZQJkiexd2vfYrr9Oj0XO91uF7
	 WBxJEWDszBDeF5GGPWkwAdzhJCBPzhgbx5roJywTUY47CyfCHlKH3C5s0yEx1PAAI8GPCqofqTrr
	 qXecxlbWm0kB7WocpxS4S3Ah1a5IPsr6fiR5FehXWe3vz/PC4oftteA03AikEqsznXwWJgg6CktF
	 DdK4mBrGzobzKhNjkGgzZfLyHY3aTNA7L3+3UFprG9nPkgqfWyoZxQDj5MWjNfEnmea7g9UjZAdM
	 68VJZWjuw4cujoSMppGqKGEBu1NXklINrk88Aqp7KdHKDfkXB3fDh59eq/J7Azha4/o2iYb3+Jx4
	 qZ8iV+GucNO0rMx7sWtxB817jWB+52QD+R6OTiWyCa29yOqMULjUzFvZX1/vQ7jG/Es+ePpDu5En
	 Q5VGh4KNNtDag+IVgDs74I5YKKGsnc1x1bu8g7KQxQ6Q8xuVi2DBLHdJyOjSlRTwbXg3CxSr5+9O
	 FJyT5qtY68xbOargjIpdou8k9H37z/fX5Sp6uDhvXztEGiiDLytJQn+B6Ul7D4AJvAf3qznt01DI
	 pNqKBzaSf3MaybwXggIUHj93jGvziYl/TuCyx7efXP4X/fuY10ZQjHSLfzw3u0PtJlKJeuDZ+fvz
	 P06Gp/Aje/IQruYAn0U6qBRfjhgfzCsb1JibiV0gfMVoGVnp6+8B/KtwQvqcURTnk0zn+7+Bdr8F
	 DF5lNdpfhZXpM4VJvJw7jbvAuKk9rP8bWc5hpGUTkgZnCT7c0WMvu/uyIcg92NEYmo5mYyIrRS9U
	 ciOkc/2yAsioev2Q==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Chen shuo <1289151713@qq.com>
To: 1289151713@qq.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192e: remove the r8192E_dev.c's unnecessary brace
Date: Wed,  8 May 2024 23:13:52 +0800
X-OQ-MSGID: <20240508151352.6831-1-1289151713@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a unnecessary brace in r8192E_dev.c.Remove it to shorten
code and improve readability.

Signed-off-by: Chen shuo <1289151713@qq.com>
---
v2:Make "Subject" line more unique.
   Add space after : and driver name in the subject.

 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index e3ed709a7674..1862a9899966 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1640,9 +1640,8 @@ bool rtl92e_get_rx_stats(struct net_device *dev, struct rtllib_rx_stats *stats,
 	if (stats->Length < 24)
 		stats->bHwError |= 1;
 
-	if (stats->bHwError) {
+	if (stats->bHwError)
 		return false;
-	}
 
 	stats->RxDrvInfoSize = pdesc->RxDrvInfoSize;
 	stats->RxBufShift = (pdesc->Shift) & 0x03;
-- 
2.34.1


