Return-Path: <linux-kernel+bounces-350561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C8B9906D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204F01C220F9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E11C879F;
	Fri,  4 Oct 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mcMrYBGj"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A91AA7A1;
	Fri,  4 Oct 2024 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053258; cv=none; b=YExXaq/2sMQVOXQemQpBj0FLG6yiegLbMsB3mIBMMSMwAxJA8cwABzgCpsAM/ReYNeHva1AKdR+U4LLhBDHcAtZOZeGaf72A52cu49rSIHpPkKBhUTEBH+13GYFWWShFzg2nxlzuTgPX/zXl2L6kD1Mag6/DEZAJ/66qQQdcgJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053258; c=relaxed/simple;
	bh=u++hyLoQ/i3dNqBZq/LmKb+AfeZrtTSxIHJd/ivLDYg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=fmid/jfS33ioqSCVe7nJiwF97VIe1Ngigl9sG2eKtqCLqk89oxBVQlRDdtTF6ygLRyKNTZoCo46Xuc4HmuYGnjf9AUVjB6tWFDVF+pZ2SDkwnyIrHIDB709G68HJCPpXBAIfZ4QMK3ywqrQa4GuTI/5K056fkcutKOiub0uOUh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mcMrYBGj; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728053227; x=1728658027; i=markus.elfring@web.de;
	bh=A+dNUIVHyB/x/Bc3YYhMlKwmGkB5MZJLY2b4rGCcbMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mcMrYBGjC1JW9gGVVlzcs9en17zQRE1GeHjgVb1ez42IX4uRdm6mR3WKtTtOocxC
	 NAl2tjIos7jrn/A8ilCCuNdL9g62uYLZbk+VK8/l8lmzMOsY/VECZ03OKyy9g/EML
	 UIyQwAmzbqsMYFK+BBd4T717vps89iHugmfOjphE3aEUMSa9AwczOGzTNF7jNJO0w
	 aLB0MxXZ1x+7a/4wYU28dtVXGcxRqVIFNOrXZtVfCzoqGY5JhkaK77r00nNmvcEA5
	 26/6cE9r86UbQRoqi39u0ZWw9FpcPW8EZelcDReC1aCTxoEXRBRllx0vcwVBtgYkp
	 9Yt6DNJBXiPQM82whA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpTxm-1s6ppW3uCC-00n7Tq; Fri, 04
 Oct 2024 16:47:06 +0200
Message-ID: <95773471-a94d-4c10-b678-2b5b702f3bed@web.de>
Date: Fri, 4 Oct 2024 16:47:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mtd@lists.infradead.org, Miaoqian Lin <linmq006@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mtd: parsers: ofpart: Use common of_node_put() code in
 bcm4908_partitions_fw_offset()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZJrZ7bEjaQWkla2jPU6YmskI8FAKk84owvqvM1zNu3EahBADPmf
 zTI+iIwKmZiEqJ7ILxO6eHqIGXPWilGF8TedOvMfXVB8c2+CrnD4TSZzA+jlRKe8Rd6h6Lh
 JTqn3Xa/RZ4zIKAYi+k1Dmm97Q3IjaSH20bAis/Q7MJ+jHqusR75cJR7SKfw7i969evC/QM
 MN3gXEOs4/3XW4QK2V8Ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rjK11Ig61CU=;MkiouDE4DQx5/nv4efR61E1S2jp
 h3OJurh9lHmuyWciEzL+phrJ1tO2EmEIvRDuA8lOgMNhOzWlH3VdVsP5trjfPfR/9mghlFwjg
 NABrkFvif99kcXhZMxS66XtRygcKny/l4Zrd+gUE33Lb100hzE9ZER3rU7VWqz9DOeYxLL9J4
 EevLcy880+cRNvr56WmldJmhPMS/C2iAwToHOs4tE96NLr+r9xWYLfLIRZp2doWa6YrUbLaoq
 MFW60QW7gWf15IG2nZOICwHIkazn2EhhzVheA1xXXxPu7OxLZH8nsbYEHV0A9atryEX2IV26s
 wJO4uL9M+xcl5P/jar6n8WlCiLYMpxQl4/+t2Uy4ZbeDaEh/tlW8/HwYztjMMcX/lD9u+gRM5
 vw1WGcbZ/+whMBbSJgp+gt0xeA+qGDnmy/OjVJ2gMTqbBjiiNSCvdPNh05RJbJei4MxaQkocX
 FNJvl/Am8FNvX0JiGyOHtEajv1+I8lCzzZXZHQiBupxboir6pmufqh+EGxLQQMx0SawXaDBF9
 P7UPKfVpmNhNPVD/Oxdxvme9j0fF0PbJ7YPlTbaIbeh8o7zVBxJax+7RQ8YVGaAh/Mhep1sgw
 +fHfzyrNLVsrqtQwm9Q1t/Ky2KkjzrBdyMbSu9av93MkK8OGZTD3XFh6vcTcl4340t2W4wg12
 uC29sfKfzbL2ZTi3wmK4zxKXjbhhjtc9HKJnzAonhqJ+N18wkTj0leR2M/SsnaMY1ccU6EtDH
 QIj3Ix1YjgFESaMn88Zsjb2xiXvHGECaGFjBtXt8etgojli/LDD2p885zbYvbDzJvNaaCbP+X
 jjlezHFmXLGpJ/bejoB5Jcgw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 4 Oct 2024 16:30:52 +0200

Enlarge the scope for the local variable =E2=80=9Cerr=E2=80=9D and add a l=
abel
so that a bit of exception handling can be better reused at the end of
this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/parsers/ofpart_bcm4908.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/parsers/ofpart_bcm4908.c b/drivers/mtd/parsers/of=
part_bcm4908.c
index bb072a0940e4..f9caf4a44b4c 100644
=2D-- a/drivers/mtd/parsers/ofpart_bcm4908.c
+++ b/drivers/mtd/parsers/ofpart_bcm4908.c
@@ -19,6 +19,7 @@ static long long bcm4908_partitions_fw_offset(void)
 	struct device_node *root;
 	struct property *prop;
 	const char *s;
+	int err;

 	root =3D of_find_node_by_path("/");
 	if (!root)
@@ -27,7 +28,6 @@ static long long bcm4908_partitions_fw_offset(void)
 	of_property_for_each_string(root, "brcm_blparms", prop, s) {
 		size_t len =3D strlen(BLPARAMS_FW_OFFSET);
 		unsigned long offset;
-		int err;

 		if (strncmp(s, BLPARAMS_FW_OFFSET, len) || s[len] !=3D '=3D')
 			continue;
@@ -35,16 +35,17 @@ static long long bcm4908_partitions_fw_offset(void)
 		err =3D kstrtoul(s + len + 1, 0, &offset);
 		if (err) {
 			pr_err("failed to parse %s\n", s + len + 1);
-			of_node_put(root);
-			return err;
+			goto put_node;
 		}

 		of_node_put(root);
 		return offset << 10;
 	}

+	err =3D -ENOENT;
+put_node:
 	of_node_put(root);
-	return -ENOENT;
+	return err;
 }

 int bcm4908_partitions_post_parse(struct mtd_info *mtd, struct mtd_partit=
ion *parts, int nr_parts)
=2D-
2.46.1


