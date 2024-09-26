Return-Path: <linux-kernel+bounces-340269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 237009870B1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85272873DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54B61ACDF5;
	Thu, 26 Sep 2024 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="IPfMCxpm"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C34C1A7AD0;
	Thu, 26 Sep 2024 09:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344255; cv=none; b=cH4GIjWNg6L/bTSeFzv5vcds0SgHFGlybCCnuoo/uj4fMItsDXH2qX2zz/YhkHbIyHU2c6rmid202ez/dK6nshFXkoEnGQQREzddyjH3KOmo8j0mz8zhGiwFE1W6fBxz4nTC6OXrGsawYvYtYSud2MFvMLLkcKG7EHq/UBr4Mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344255; c=relaxed/simple;
	bh=kO4sKsdwCUugE8CbsLsofDZOg4JYmgj8cD3/KeMEuU4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bOwSECnYPqsobO0Ds213Wlz3o97ZDHgu+oABbrRW6waFgnvrP4nkH+uNWfDKSjhu/MCz9gA7Vq5S8TohOLYGh37K7vNPWc0VEhFmZVWStxyi7KBlxO76jQEbgf9e28myyCwSa2gt7C5V1s5PuL5YAQv7TBqeVVOmo7c1czBV/aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=IPfMCxpm; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727344241; x=1727949041; i=markus.elfring@web.de;
	bh=AFzcS8Ftuw+z5NkNchcdPPK9b9v88GV9gFK0HM0eF/k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IPfMCxpm4X94tQ0gZdtc0YPBwYnhDeXbbUbiOiKWLPEiZHC6EMXvw1eOvLBFNv7H
	 EGDPRKjMbwpTJ4udjUkvn3HOWyoVPia128/ZQfSa0MdzJ5smc3jchESfFMItpFkgI
	 GnlHAcJSUxREHJPrmfQuAh5Zt6f/rbLh4zkqqdFUC0BtRBqKhh2yTtTTY82gziFLI
	 JTNm8+EY4yjPaHridnyNHoXOdctVTr5t57TNQXC8mf7ZYOjy8fRuLlZ3KAjIfm6XX
	 TOrsKDE/S5/lsnpf0+kaRMKJEkxhx5uuXVAZQXtGilNUzkQZHD1bPxzgX9D5cV+lJ
	 Q9+IumrhFFvtiYVVpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhWkj-1sGahe09EB-00g2qr; Thu, 26
 Sep 2024 11:50:41 +0200
Message-ID: <fc35a4b0-9a41-4f14-9558-99fc0b7e2ad8@web.de>
Date: Thu, 26 Sep 2024 11:50:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] ubifs: Reduce kfree() calls in ubifs_purge_xattrs()
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
Content-Language: en-GB
In-Reply-To: <ff787fb9-a9fc-4798-8460-3ec310e6cd9f@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aPiOWLcSidigunR2DygPf0duUQgDMqaQvfyrTwF39tLnflvg42L
 nQ8g/c7fmGAaop0GbD6vgZNGULC28/e+ECRg6nzhxAFXNpgO0mK7WKxSxNyYKWhzdbtJr/4
 BESjDWCztPlfBHhBQ7kxlOJ4c0MFexsGNuqeNKmDvsRxbumnyD+E1wACOk+hf8K9yo6fBrG
 p/2A/cRnmcLdLZSXwLk1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KCkX6tKssj0=;8ThV0nGKi5xh+POQztudQoa7Qii
 CKNfINptDpzjfiY+/SiY0XMhtmHintSTGmZBRoDbuDsYAq1EUhWBlTdMcA/mRnAkxgVbs0tZJ
 +AmMiSWjMUNjVwDdYudGq8S3/0C7Diy4upeSoFlbSHLIgfjMmkZ5sp4eTX+ojzxb2f0J/u1Ms
 QfEUv+Zpeh6g3uGOZWYZUrxZK9WcIzcjS7lTlxzlpT3UBs0aaq/Q4AP4mcsGlcPVCq5krDeiC
 SQOHg+l8hKW+RCGRMOLpaZlN4mf8pqGBEhWVy0vdZhP3a3Xv+KWS+IW2+izVbRqI9Ujxni7tW
 o+fyrXCcQlMhepIW0HvpFJaKnLUdzRucOBeZpbyqVTgWKSuLJghsz7rr/pbmK1ffgK21QYrPa
 h8WJAa7fJSQ3gN4c/wBIAwi2NVNdTZ4wKOq1aQ5vjhxNd3V93+XKv335EwN7SI7b4tqHOX1iV
 3KT5A3J4A9sJ52+sUrnq3sajaDJH1j0m92ZEZpP07M0Av4/aoX9f3/98Lp4AYU4qVMNoOcvAe
 Jjk5SAyTke92hCLha2k/jI1aofGk0Pnmp1nH5NlEeftNu0MRJjxlKNlxTuJFnsmzibX76OPsb
 uPgGBr+bbEvJZrqCv57KZIe8hcksLa7BgDhv6l3nLEZvUW9EGnChiNyA57WYlKAwuenNavE9A
 7S6v4BB1a0vVdiGiC/vVqCfbOh+37ik7+arRznu9sVwhvt3bUio84P/Ko2e/yA3+UgaEc9qiy
 EGXIR4TUtWzAUn3VGJJ4qi+iychuHe4yugn+BhVO1KyDeA3W5mNkBmENHDanfU1VMOl3KGA+W
 SkctUyBETctUuqZKBKNxYwqQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Sep 2024 11:28:48 +0200

Move a pair of kfree() calls behind the label =E2=80=9Cout_err=E2=80=9D
so that two statements can be better reused at the end of
this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ubifs/xattr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 7757959e9f09..a514dc4dc535 100644
=2D-- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -532,8 +532,6 @@ int ubifs_purge_xattrs(struct inode *host)
 			ubifs_err(c, "dead directory entry '%s', error %d",
 				  xent->name, err);
 			ubifs_ro_mode(c, err);
-			kfree(pxent);
-			kfree(xent);
 			goto out_err;
 		}

@@ -543,8 +541,6 @@ int ubifs_purge_xattrs(struct inode *host)
 		err =3D remove_xattr(c, host, xino, &nm);
 		iput(xino);
 		if (err) {
-			kfree(pxent);
-			kfree(xent);
 			ubifs_err(c, "cannot remove xattr, error %d", err);
 			goto out_err;
 		}
@@ -564,6 +560,8 @@ int ubifs_purge_xattrs(struct inode *host)
 	return 0;

 out_err:
+	kfree(pxent);
+	kfree(xent);
 	up_write(&ubifs_inode(host)->xattr_sem);
 	return err;
 }
=2D-
2.46.1


