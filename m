Return-Path: <linux-kernel+bounces-545440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD75A4ED58
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587C9880ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C6625D522;
	Tue,  4 Mar 2025 19:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KBZjIhKS"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767D259C89;
	Tue,  4 Mar 2025 19:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741116139; cv=none; b=FvZAEigR8/poxoRCp3eZ9FJo5gKFJr+YzSmX/plkpW1uz+PcxiarHMp2XhFafVCbkf325qMyOR/I5bKcZnmxpEE7BJRSgyXbnyV0S8/0BTMNR7BBs2ln7IXm/OKGfq/03Fo7cVJgV1Roi8AHsYv6NzWKJp0ort3v8untyFgGqYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741116139; c=relaxed/simple;
	bh=EDKLCV+MzmNMG+l3wuT8ODK2RlmwFc2eJ1sfRzaIp7U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EuZpUWdv04cqulHhz5Pl3m7cSM0m+IgYaV1DRPa4E0MRKLOOdlvosKf60Ftixo3tlQLWabDf4WCMDbHdxXerqEaWb1pDovkG0NKL7bleuk9RkfL/U3CDQ9u+VpIx6/NocaxHH7Ye3hpNO+IgqdCjuHs58YoD0qs2AHmqBupotBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KBZjIhKS; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741116117; x=1741720917; i=markus.elfring@web.de;
	bh=7bItaIpL50iONjJ6ezepTySgEuIy1conWnocyy7c1HI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KBZjIhKSGu+H7K0E+EmJW7txizonPwtF66pEUvS9fagnc5l+pb/HAzddRr0fZCu8
	 PHvrGleKfwz7NzUpkhSAz7ojIfz623sJAYVysL5zi8T6FQwuuSmwEQhx0XTjQu5F6
	 7k4yw7oQB2QPMVS6Pb+Bjwz5at56x9RfJX6+qTZiwBi7bSSDpmUP67ZGAF04lrgVD
	 +yzDbRQXcVoYn8OhHOSdnTX9EnFXc4jUEJ5wfG2kNY5815IqMilwXFnq1wWmaysjG
	 R0KQE6kQmLAbyACKj+dcKdL9PPLzAuJSpjWKP0cM7+hRbOFqM0HTuRSd4iNjdDrTc
	 sWSTHq6uie7WC9Qv/w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.64]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1tMFUk24Et-00nQUv; Tue, 04
 Mar 2025 20:21:57 +0100
Message-ID: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
Date: Tue, 4 Mar 2025 20:21:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception handling in
 cfi_intelext_setup()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-mtd@lists.infradead.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
Content-Language: en-GB
In-Reply-To: <3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qKFVHeZFM8z5ZXsxO57qi6A5GLqriqNvol5/pp2fC4KpApqiHG1
 JjUKwLrZAmwzXRM5ufs7amW+9qBBkD9yaLqmHKD8kkpwnPbN3gkC4y4NhG4sgBQSKVOSecT
 4PQYkNBXjfG+6QnCVZwruHG9o6ZwvJhk5dwQql7N6A+YbNOar8t2XaQhNzJOkpi9VWhjW4i
 3SkCydtmLEmhP4fG/46zg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7XhKd8N636g=;17LWSq/5A434rFvDzWDT7dvIXld
 67ohFCtij2fYZibsznLRTKx3adqcpAeJos1pj2NqbmitXewkIUxZrE84wL7fQkp2HqQgFULKG
 ED4aqqTgQyTICT3Un2pIbMx4+r403h16ErubFPZ7bAJgdrmWJKUzEw6ypD9KxZuk8LhwGhJz4
 g9MFzPBSCuQUACLvaFGSIJrNE1BEZrZxROkkluMV+YwAmmYABU5Vk41mI7ZzOAK+E9owC6hj3
 a1HLMuTImfMKcsiZOA8C8pnIhzyy68kmJomSP6zgGn5SAOTrwdHwYuHb0F0RXnEKjp6WwXIzT
 v2lJN7Q9xyEgjrwgpU8iqjLOaVsxWbsmj6iVT24JLytlb5iCPzEeI7g4psektbejP9wkVtN90
 h66aMzIVqLFgj3SxnbEDKAm6CkTa7+3bvj6UDcUdqgvQzInIPURcy0KBd9uXUbmaMTu789f+t
 RRG17WIP+3K+Dhb/CW7PsYF4M1zMdu3/xLWFfn/6R/5giK6pXD0TiM5LzEn64WTETY2nmVShF
 5tU76uLwnNehzLOPg9iuYWzAkimO4jRITTxuNnQkWH4Rhwpjsz8v6hXBRDk/xmHANgAUv5REY
 TgEvBXxIqKi0N2eeP3F1zmdMfK14qFvQMSpVpgzSZUGTtNs17j/MOKlx00bzIu7cWvRNJRJm8
 YYz3cfrzZXxCTTCG+KfdFbXIJRsk4Lz14McTi3X7FlLvDyJQBQcQHf4xEfTQiv5v8OyufYXtw
 nwl51afKB3/+0zjoiwqJ5Cx7x3g05XE/08zuEcJ4Apmi4g0wIENjXaZmk+nvnTWO7pWZcjGug
 RPJT5oWwKzPB6OK7at/sceNmtAxwF5vCLJ06gFAJq1gQTGqccHZ2Cew0arYbRfF6I6kobIt9m
 6BdcT9RC6upuAd7/4sv8lmIn24yEWyUqH4UecKfgTC84vJeG6gdt65tWTZomdDaXyMFg6etQb
 As2CCP08OzyrtfFlfGyKTw3Y9Vfuu7Hb0FVf5+PJAi8IydpmySTAVULT0q8p546JX0IqEndo+
 1Bgk0+0Fr1oWFFNFwxUrSxz0xemK3dT4nuw01F0krrhLXnhNUD0LSzi+TRUorxJXGXzEkmuGi
 t3IF0yWJnOR4fF+SaxhOfHmZ07vxON95iA94gguhdmqUlHeoclxgoOFO6fNV+nHSjS6GT4fkP
 mOnXHJNe6+htnbJvB9RvPIh6W4RuxEsL4gdhF4934ohzyQyl6F/Li0z4mY6Fe/idzLVYeY5nY
 6PpdQP1Aa/nxp9KJxQ/we6A2pAUSav6cbtc+1ngAf8Ty9RftHZ+eynvFm3iEuq6VTHOXsxrdr
 qFvi3N481CAQyQ+dxFFC/f/Fh4y88y9bh/Y4MJpqOfnN7cNjuqDx0gON0XyK62NLQZiR2oNC4
 BF98kTmJ4xPEGfyXGM2//Gmtj3GvAUuNh2CTdZJWaZ5X27uyvHgy9tax3GhmfzruX8TYnVrQP
 Gk/GHoqXkje3IjrImP6HOOtpU3Xw=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 21 Mar 2023 20:13:51 +0100

The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another pointer =
check despite of
the detail in the implementation of the function =E2=80=9Ccfi_intelext_set=
up=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed memory allocation.

* Thus use more appropriate labels instead.

* Delete a redundant check.


This issue was detected by using the Coccinelle software.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/chips/cfi_cmdset_0001.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_c=
mdset_0001.c
index 54f92d09d9cf..a06318cd5ea4 100644
=2D-- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -614,7 +614,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 				    sizeof(struct mtd_erase_region_info),
 				    GFP_KERNEL);
 	if (!mtd->eraseregions)
-		goto setup_err;
+		goto free_mtd;

 	for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++) {
 		unsigned long ernum, ersize;
@@ -630,7 +630,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 			mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].numblocks =3D ernu=
m;
 			mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap =3D kmallo=
c(ernum / 8 + 1, GFP_KERNEL);
 			if (!mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap)
-				goto setup_err;
+				goto release_loop;
 		}
 		offset +=3D (ersize * ernum);
 	}
@@ -638,7 +638,7 @@ static struct mtd_info *cfi_intelext_setup(struct mtd_=
info *mtd)
 	if (offset !=3D devsize) {
 		/* Argh */
 		printk(KERN_WARNING "Sum of regions (%lx) !=3D total size of set of int=
erleaved chips (%lx)\n", offset, devsize);
-		goto setup_err;
+		goto release_loop;
 	}

 	for (i=3D0; i<mtd->numeraseregions;i++){
@@ -660,18 +660,18 @@ static struct mtd_info *cfi_intelext_setup(struct mt=
d_info *mtd)
 	/* This function has the potential to distort the reality
 	   a bit and therefore should be called last. */
 	if (cfi_intelext_partition_fixup(mtd, &cfi) !=3D 0)
-		goto setup_err;
+		goto release_loop;

 	__module_get(THIS_MODULE);
 	register_reboot_notifier(&mtd->reboot_notifier);
 	return mtd;

- setup_err:
-	if (mtd->eraseregions)
-		for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++)
-			for (j=3D0; j<cfi->numchips; j++)
-				kfree(mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap);
+release_loop:
+	for (i=3D0; i<cfi->cfiq->NumEraseRegions; i++)
+		for (j=3D0; j<cfi->numchips; j++)
+			kfree(mtd->eraseregions[(j*cfi->cfiq->NumEraseRegions)+i].lockmap);
 	kfree(mtd->eraseregions);
+free_mtd:
 	kfree(mtd);
 	kfree(cfi->cmdset_priv);
 	return NULL;
=2D-
2.40.0


