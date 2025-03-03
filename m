Return-Path: <linux-kernel+bounces-542671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B3EA4CC40
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C33E3AA9A2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC670233132;
	Mon,  3 Mar 2025 19:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ppJFF5nc"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954932343AB;
	Mon,  3 Mar 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031558; cv=none; b=JwFjRYNa1aKOVYuiVTlbEf9u0j2IWgCEt25YXRM9EG5iuAWy0HL8JY8mV3OxSrN8yBrRrVZwL2IxaAwo0KHUqdX4YKaAG1TN7xcVnXHpQVA3jGh2FIRi+nFzO6rmv8GycDoyiGat6bS0t0bqWFBG+0zjZE3njLuXXET9mT4a+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031558; c=relaxed/simple;
	bh=/5kL6lkfSoy6jZ4mv2VO4LHLoCr22zO2W5GVelcms+Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=F43WFoPk95ogE5SjvK/+n0DPZ+WOwnx5o1U+omEzD0WQIIeAh6TMHbFEoNiy1pvDd0QklJDTlL3Z02e3EYRsAOf3H2wKCRZ1YMTRBD6lL0XjjAbb41ZbDYFiri42OVKU7jSp57uPUAl6wQr+eC65cm4IsyV0N3PaMOO7NlGpRw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ppJFF5nc; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741031542; x=1741636342; i=markus.elfring@web.de;
	bh=p/1y8E3y+CaOKzyRHNzCHL74cbkCQAfumb6We0o3vWU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ppJFF5ncblNd32Rn6q0Nz7PhAQF9Y4OjPI9faI7Oe/EEIQSgv8rlWW23u6lTpbK2
	 Dh/3VibQbUt9Lap/9o2j+VQsM7nz5zfqY1JbQBZ53lJDGYCdYuIxD78zXlM0M08Ee
	 4MeXITMuSQbZ4PyjDjsMJCY9Evx3nHaukhPmj2u32jMRSBOsaOn59d7591iAhcPgH
	 riCkgnxJgGXi5vruwtTQRvS2o4HWrpNXutF8R/ieMQQoc9GOYAXPb0LJayz9wzdKK
	 LSKAuM+YUv1DHxpMnCIzIPPPO3wJx46USo0f6HeKw77KNH050goMBSW2K9duxaPkp
	 Dy8efTxGc3Y/+ObsIQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIL0C-1u1LRC1jV6-00Aj73; Mon, 03
 Mar 2025 20:52:22 +0100
Message-ID: <fb65b3c3-00b2-4c33-8ab1-8e60b4159c3f@web.de>
Date: Mon, 3 Mar 2025 20:52:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH RESEND] ufs: Fix exception handling in ufs_fill_super()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, Agathe Porte
 <agathe.porte@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@osdl.org>, Evgeniy Dushistov <dushistov@mail.ru>,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 Jesper Juhl <jesper.juhl@gmail.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Content-Language: en-GB
In-Reply-To: <9d975625-672c-ab81-2e78-c3fa48747913@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YsISSegg3lcQ3hmqRzFgdivEeAVL0GWFjbgRAsPOJh7cfonv/eR
 /ZRmIN+xHxCwxcEuyGHP+l+dYl+M3uf2p5OSoES/URxruvATvajdjtbaqd9DTP/NRX49EVN
 ic7+wrTwsrXf7WhAjOkXOLAE3f+i6+XR1dZ14C4WhLaWlf1nm3xldhro1VJ+bBntnsv3F5t
 6vps+sy62rHMU8Q0hwmAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V1/6gYigggU=;L3OHYIdZuntwDgsrHAQo83kdWle
 D5fCV9moqOaiq+5g/sIBBsbr5AwFlbQZ4d6rSpdm4QOmA5oxExd5NLbMfEdtD8AGljB69cEy1
 NlgDe12wGcW+Pg4/onP+NRvDf5gFkIpWw3AyR364O6l4uD7632YJv1Bc9w/ACiEFi39FzZLjA
 vQo8eVhThiFlRIvhofvVUo7t24IBGJsTTW1skl3AiIidH2DvqUQtfgyVTrXiIYWHNs6ecvous
 aCbGoVgC8f5sdYOvLdBVgqtAMaKSX1QdAUGNZmBdsclWzpv1KOX5cCgOaFD5j0p2GODrP8Q4+
 AWc4EfvsdtczAy85JS6ORkSzhC3RToKg5qnhmK+ge2iu52KnA4iHs1A2YnQygF8Aidsr73gOZ
 WNzErbfnw3i+/SNSbkg7RHIlVohflQ2yZRIitQ/q9WXYahuFCcV0rWf8x3AM2AtLfZsWJNV9i
 iey3ggzIm6zMAYQ3lsbC593vTzNgNcH+WXjesNIX0k5vx4/9klOmlb2AJMn8J9owgfzmzFZqg
 G2g93Olpu5XImJFN0nGytMyK+yNhaq0s2CfYYgtB44+6hTQdxM+D+eqY0+6OzPFyGuf5lqMyc
 249dTbPsM47ntMLwmiQiyNnfk0xV6zUl7f1zeo2kAlZMe7Jo0v0WVaemvEUHNE5gHsjA+vBNG
 +qlxZAx+jizgqVrHxwet6QHs/U8N/CUq7FbVQ63NYSdr1zTfoKvEGeNQi9DSxTB0h/ro9mwdu
 hh8em2EyO9IjmcJdvTe3/M0YqJGhfAujhLuL2rgOHJl5MceuxN8EfIS27fy4aLGI5CPtiwa4d
 hoJ77z25Qmy6c5synXJd5UP/HinYEghMlo5bj9n1ZFg1G351rlyJZvUjlB+TyE5d2fzpwNUKE
 uV1S0lElH7CmIfrXRBlV33srHkZyVmiJRpk+x1OA8EQjuJgfkBJZ1Mx6DWeSDRptjbjYI18+P
 H/Rh0e66D10p+7RPJfXAzPql1gGxRQvNvjTNWqWT+KBsooOH3bwBI6DQn35hDEF0LdbkyL1ci
 vacyLCSMk5IXuESOKmP0Ya+lQaq1lHt2KJ6cQxRnzKNfKg9TxKVEOyvQKWzyRfXGCeRzhuhQC
 gugoBjFMaqOpfIpqTQoe+Qkb64Pi2tAARHrrkXNHLDG0GnoWHVdzjaMPKehHYz7foXEYULVgK
 qBqhfuwvwD+OdGcou+xFoK5Q2tlvnxjBhaiqNjN75ll8mX4yLb+5qtlWuZ95R+arvfbVEicvG
 ZcnCfSnz8PMYNQAN6gLOdVb/oh8JLJeT7JNb7cZGkdhKOXbc64+WYQojQv5ysjJiVjbaHIbBP
 Gp0FrM3oBW9UlUuz0sJ0iOuzEvIP1IEUrpPaSbBPhCiv6qO81sRLJZm94zDyRfBFmECm8ZsA+
 YmN4rGapGZ5u0JA9cWKEif0p4eOPVF5kaWwmn10+KOJi+d/QkypB+nvPUmnePLtxs5C7ofb8r
 vAOJVFmNq9L/ItoMWlL3kjLEaMCc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 22 Mar 2023 21:50:45 +0100

The label =E2=80=9Cfailed=E2=80=9D was used to jump to another pointer che=
ck despite of
the detail in the implementation of the function =E2=80=9Cufs_fill_super=
=E2=80=9D
that it was determined already that a corresponding variable contained
a null pointer because of a failed call of the function =E2=80=9Ckzalloc=
=E2=80=9D
or =E2=80=9Cubh_bread_uspi=E2=80=9D.

1. Thus use two additional labels.

2. Delete a redundant check.

3. Omit extra assignments (for the variables =E2=80=9Cuspi=E2=80=9D and =
=E2=80=9Cubh=E2=80=9D)
   at the beginning which became unnecessary with this refactoring.


This issue was detected by using the Coccinelle software.

Fixes: f99d49adf527 ("[PATCH] kfree cleanup: fs")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/ufs/super.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 23377c1baed9..017653c36080 100644
=2D-- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -789,8 +789,6 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	unsigned maxsymlen;
 	int ret =3D -EINVAL;

-	uspi =3D NULL;
-	ubh =3D NULL;
 	flags =3D 0;

 	UFSD("ENTER\n");
@@ -821,7 +819,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	ufs_set_opt (sbi->s_mount_opt, ONERROR_LOCK);
 	if (!ufs_parse_options ((char *) data, &sbi->s_mount_opt)) {
 		pr_err("wrong mount options\n");
-		goto failed;
+		goto free_sbi;
 	}
 	if (!(sbi->s_mount_opt & UFS_MOUNT_UFSTYPE)) {
 		if (!silent)
@@ -836,7 +834,7 @@ static int ufs_fill_super(struct super_block *sb, void=
 *data, int silent)
 	uspi =3D kzalloc(sizeof(struct ufs_sb_private_info), GFP_KERNEL);
 	sbi->s_uspi =3D uspi;
 	if (!uspi)
-		goto failed;
+		goto free_sbi;
 	uspi->s_dirblksize =3D UFS_SECTOR_SIZE;
 	super_block_offset=3DUFS_SBLOCK;

@@ -984,13 +982,13 @@ static int ufs_fill_super(struct super_block *sb, vo=
id *data, int silent)
 	default:
 		if (!silent)
 			pr_err("unknown ufstype\n");
-		goto failed;
+		goto free_uspi;
 	}

 again:
 	if (!sb_set_blocksize(sb, block_size)) {
 		pr_err("failed to set blocksize\n");
-		goto failed;
+		goto free_uspi;
 	}

 	/*
@@ -1000,7 +998,7 @@ static int ufs_fill_super(struct super_block *sb, voi=
d *data, int silent)
 	ubh =3D ubh_bread_uspi(uspi, sb, uspi->s_sbbase + super_block_offset/blo=
ck_size, super_block_size);

 	if (!ubh)
-            goto failed;
+            goto free_uspi;

 	usb1 =3D ubh_get_usb_first(uspi);
 	usb2 =3D ubh_get_usb_second(uspi);
@@ -1291,9 +1289,10 @@ static int ufs_fill_super(struct super_block *sb, v=
oid *data, int silent)
 	return 0;

 failed:
-	if (ubh)
-		ubh_brelse_uspi (uspi);
-	kfree (uspi);
+	ubh_brelse_uspi(uspi);
+free_uspi:
+	kfree(uspi);
+free_sbi:
 	kfree(sbi);
 	sb->s_fs_info =3D NULL;
 	UFSD("EXIT (FAILED)\n");
=2D-
2.40.0


