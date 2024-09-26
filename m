Return-Path: <linux-kernel+bounces-340266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE259870A9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B45FB294FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FDD1ABED0;
	Thu, 26 Sep 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="FGZIcpoX"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDA0189509;
	Thu, 26 Sep 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344192; cv=none; b=A59tmrbJ99552l4ZdNlVprUAn4EGnaKtML22z+5NvOeC7/b9MppYQCNqSL7wI8yNbxMzVh6ffY4q3KNMEUanvvh6zOnzp0BE07y+k1CeTaA8cu5xPkCsvFNffyA+OMFx9/R9/pylsLB8NHiCDT3yKkrgE+jX9YXIraJDuNUW3Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344192; c=relaxed/simple;
	bh=ZXk2C/znJ57eFHaI30r3/vprd1gjSx/o8+kq+MZi0a4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dd4OHRbFRgX/JZp45XXb3L+LF7t5PxzzinCiNvdh95iAZCJGkvGJjVR/F5RvVPr9EOCtHnkPPi+Xe15GfPm1PgLMfusUX32QtDm7MZGUbvAOhIwBqyQDcCoj/AASmGVaUlGjON4StErrAsl1DMJgM2P2rlAcyZA+NPMSWVsPn7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=FGZIcpoX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727344167; x=1727948967; i=markus.elfring@web.de;
	bh=hOHEk4EFX3thBPSJCG19L99hsawAOI1Zr0gYqbm9Nic=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FGZIcpoXoUGEtfGzoOtlaYHO7fZUwVlz/pLNnKQ7weLPEztJMWHJ8OI54pSz7J5l
	 YrF2La1+2ZfH4esWu98SkIQ4v573j1IZXrLY0Oqy6UzU2vkY9NsGItab5Ojxhnl0Q
	 1zdvI7ehFBhqf7HP8YD0dA98DzzhXIbhrf1x3ZETos2iDWaIdLkLvIRKykKTVAxX1
	 CIeJuwGMrfD/RT8jtUXgSFCGm+/KooVayCKnGUSd10Z+gr0SDQ/ehy2QfL34jG/zB
	 mHCnuxB8nH/cwIW83ru0stcFd33qkQOUqimY5zhoF+TJaj/acfHli+N3IpW0W4ml1
	 G5SYFVW0fSnd0E0gCQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZB07-1sOjsF3o37-00XYKK; Thu, 26
 Sep 2024 11:49:26 +0200
Message-ID: <c5bd9bb7-2636-4c48-9623-4c93ded3469c@web.de>
Date: Thu, 26 Sep 2024 11:49:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] ubifs: Call iput(xino) only once in ubifs_purge_xattrs()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
Content-Language: en-GB
In-Reply-To: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vpgE/5iekYk8NTAf200bwBBju3y0tsqloprET8oIqGfXy4pqgUL
 bJ0+s97WyUsUZ3nqZigCX/KhxuvygeHpwP7LZjgJfP/4LSxzb9o4eLQ1iGyjEEtVl46f4ip
 p0YbjfKRQ2jKcUK1+hZ40UrwbVMtBfu40hey0OG0S09S3jCer6RlH0olF2k3W2qruN0Ka+M
 TviNhZ8ird73w+DmJtOzw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nCr9OlfvGMk=;9o41UjHyQrjeEH0YURHJa9Mz5B5
 dsoXKaw5azo1TlXWdX428deCnw4hRn+xuOYo5eOsnVu27j0nw3ZpJs3jNb2irDm+avn7IaXxA
 mffaKO+ZbZVQc3I2rw+9J7SjIUhtd/aPOKOKipKjLEcd9m38n3bKIqYtnYcKEzqNBw9cMzo98
 qmNMV5JczdXht2+XG2KShmngs9I/r/GWbxWXf7eU+2xWdw373bYvsliwpIBW4FmEZWsZc6gyK
 DcgJNInxupKcmwWCaC4lk1V9bEMIFvBF+GhzGdOVxo3CjgZP1iSO19iP3IRAUOVomUb+WNhnw
 z+qlLQRoqwXLttI6x550eVTZcj24u2GzRBJPdEn7bT1o98D32Z8YpgtTkjpc8JOt19vmK4krT
 S3MsyGJd2jOpVMPQu+LJSZTUegE5HwRoGv4bsqm4rVIIWgD98gwXEQdr5GArY1FGMPZzhCLYY
 D33cxvFyWTBx0mkRMvfJl2NHCRZe7TZhhKX7l3QTWgnK8iQqPRtrQADLyu4ssBGzLngaq4rBU
 YA/2bNCght74+R0Sl9MlrgH8UIuUq6p2aHctdHSb2owBzouYF1TldSmIMMBn+t6nPzYGYPFYm
 fIwNa+P31mksksBOQu57SoaNlEwnDA2AGQUHj/NzvWZP11aQzIWzLvkEFjoCvvVvqEO1jb3Ci
 Cid1BW7mda8DCALepzZ9hI0BSnH7MTQsZZgAS/I8SV0l4L3Bv2UG7pHGYpbcfNZMGBS3ZBZFj
 SE9ZISG8Pu2uZPSCSPgiTBMwJPsfb577i4CAOQg1s0+EDqfqE3IHBRliv+OquAVrQ+OguI4gC
 SuVK8bwpQWZPgdUbF3tuNJYQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 11:05:29 +0200

An iput(xino) call was immediately used after a return value check
for a remove_xattr() call in this function implementation.
Thus call such a function only once instead directly before the check.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ubifs/xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index f734588b224a..7757959e9f09 100644
=2D-- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -541,16 +541,14 @@ int ubifs_purge_xattrs(struct inode *host)

 		clear_nlink(xino);
 		err =3D remove_xattr(c, host, xino, &nm);
+		iput(xino);
 		if (err) {
 			kfree(pxent);
 			kfree(xent);
-			iput(xino);
 			ubifs_err(c, "cannot remove xattr, error %d", err);
 			goto out_err;
 		}

-		iput(xino);
-
 		kfree(pxent);
 		pxent =3D xent;
 		key_read(c, &xent->key, &key);
=2D-
2.46.1


