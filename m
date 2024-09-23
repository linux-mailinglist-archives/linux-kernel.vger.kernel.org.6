Return-Path: <linux-kernel+bounces-336385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3C19839E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 01:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D0B22273
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 23:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FA0126BEF;
	Mon, 23 Sep 2024 23:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b="AcBJ/r8V"
Received: from mail.rosalinux.ru (mail.rosalinux.ru [195.19.76.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6141C77;
	Mon, 23 Sep 2024 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.19.76.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727132783; cv=none; b=o8LO08KME/81yakoBNno75dkFJ8P8TKvc6D2nDG/6cXLnCCiSY4ZFtS2OVSIp2VWwHCW6jnVPQgS9kDgj6mleE8VcYRREfU5VJ8YNVa4rCvmI0P+Poepzk+bk/THDSCzNeahilyYy2pkRBbboc3sxDuT/21LE4mctf3VtzIHM2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727132783; c=relaxed/simple;
	bh=55KNQbP1Rr8QkA48jrud3shA3V2LqKRggedj0256AWc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g8d/wxnUTQ3xKqMRR4Xy9zTgqc1xnG7srWyO0ZTy248ULUVbPJhN2Hy/rb4CSk1PbA0knqG1MM7bddZCreCm8VJvaV+NOlX4Gj0HIIdWxDKLZ6vbpyaXa42TJkweoCtjzVXukEIkG/i4pMOZP4orBVIArjIyKi2nxnEhjkimv6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru; spf=pass smtp.mailfrom=rosalinux.ru; dkim=pass (2048-bit key) header.d=rosalinux.ru header.i=@rosalinux.ru header.b=AcBJ/r8V; arc=none smtp.client-ip=195.19.76.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosalinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosalinux.ru
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 671EE1E730E63;
	Tue, 24 Sep 2024 01:21:13 +0300 (MSK)
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zyPdvJT2ry0l; Tue, 24 Sep 2024 01:21:13 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
	by mail.rosalinux.ru (Postfix) with ESMTP id 275CD1E730E67;
	Tue, 24 Sep 2024 01:21:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rosalinux.ru 275CD1E730E67
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosalinux.ru;
	s=1D4BB666-A0F1-11EB-A1A2-F53579C7F503; t=1727130073;
	bh=oilA5VjWd4oT5UgP0Ts3YW2SsuTTAakZoRlv1cmYixE=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=AcBJ/r8VOgW9X0k1xEx0ib/Fql2BArHhSwVBEKiV/cwlFMilqjTOmupJatOYJ3JKu
	 iQf+p8JiGuouO54H7vFCyhcJGRDXN65wM5yUR9l1RKiAZ1h+VSBM29+jM/0CVCf2gZ
	 aZrNdSuTp5hcvXs3tu53/6SmhEdwxc3TOmuIA/gZICJpdE6CqdhvWmDCQ8HiHcz1Eq
	 z0UJ0oZdZqqqDbDQ87mMNOhVfEWYs8NYbYHuK2sqFvQC/BppMuzAsnB8h6C93tdzGq
	 1cqa1u1LGFiMPwpGDaviid9Sv6PUN6SYuJFp7etpismN+Ft+r5m3APEMcTzIllva3W
	 SJnTBA071u/ag==
X-Virus-Scanned: amavisd-new at rosalinux.ru
Received: from mail.rosalinux.ru ([127.0.0.1])
	by localhost (mail.rosalinux.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k8R5WkSJ_Y9h; Tue, 24 Sep 2024 01:21:13 +0300 (MSK)
Received: from ubuntu.localdomain (unknown [144.206.93.23])
	by mail.rosalinux.ru (Postfix) with ESMTPSA id 444701E730E63;
	Tue, 24 Sep 2024 01:21:11 +0300 (MSK)
From: Aleksandr Burakov <a.burakov@rosalinux.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Aleksandr Burakov <a.burakov@rosalinux.ru>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: android-platform: deref after free in x86_android_tablet_probe() fix
Date: Tue, 24 Sep 2024 01:20:34 +0300
Message-Id: <20240923222034.9833-1-a.burakov@rosalinux.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Pointer '&pdevs[i]' is dereferenced in x86_android_tablet_probe()
after the referenced memory was deallocated by calling function
x86_android_tablet_remove().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 62a5f689a068 ("platform/x86: x86-android-tablets: Move core code i=
nto new core.c file")
Signed-off-by: Aleksandr Burakov <a.burakov@rosalinux.ru>
---
 drivers/platform/x86/x86-android-tablets/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/pl=
atform/x86/x86-android-tablets/core.c
index 919ef4471229..dea6ba1fd839 100644
--- a/drivers/platform/x86/x86-android-tablets/core.c
+++ b/drivers/platform/x86/x86-android-tablets/core.c
@@ -390,8 +390,10 @@ static __init int x86_android_tablet_probe(struct pl=
atform_device *pdev)
 	for (i =3D 0; i < pdev_count; i++) {
 		pdevs[i] =3D platform_device_register_full(&dev_info->pdev_info[i]);
 		if (IS_ERR(pdevs[i])) {
+			int ret =3D PTR_ERR(pdevs[i]);
+
 			x86_android_tablet_remove(pdev);
-			return PTR_ERR(pdevs[i]);
+			return ret;
 		}
 	}
=20
--=20
2.25.1


