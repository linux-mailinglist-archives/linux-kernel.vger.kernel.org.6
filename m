Return-Path: <linux-kernel+bounces-251890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5CF930B29
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2491C208E5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431DC13C8E3;
	Sun, 14 Jul 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vPPm29IL"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCADF2E3E4;
	Sun, 14 Jul 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720980418; cv=none; b=gUBoVPZ4cLuuPD6RdQLLuSRNvqDOGvZO+t00WDD0TWMV6xyHIewI4gyEW2qOWUIrLnGOgtfyAJBkMOAM/JgdQT5iQBwCJOtOsY00c3aCS3r0Pn/JhfQce0avGLY1rnQnC8EceIBl3oypcLipZ/ojSaTQ4Nbgg/TfCTYrnqfCsx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720980418; c=relaxed/simple;
	bh=BaIHPdkkfgTH6AbFnNVZncHWlNIRtXr0x9itVWG5GBM=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Zyu29MaWse2hzFj+5vI6QZaYhzBLfhSQh5eRKRu8m6K4wIIv3BRWCUzeA2f49XsU4id9DqCfIYk3MbUi/a8cvbjKrLaTSgNy3zVuR6ZdC19f11xnZRs3JBvgGXsLJEKBHNnWqhe45YoKBpCkMKfZaZ1q+a74+ZpBM14F9ZGGVHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vPPm29IL; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720980383; x=1721585183; i=markus.elfring@web.de;
	bh=IdpJg9NKmezJIapsYz2o+5Fvqpz9qETaAmE4wLDqsiA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vPPm29ILUPuLxEqBV5qC+6pjXBkH02YFzPaFPb17ox5SruYU4GAuZQh2nTn2rTzH
	 T4XJfhj68TufQFbt7I+VXHzhR/Jcf63vRxW4oTvLJ6p2sObh+j7ZDh81w7JktoFzy
	 4YKZO8ZwoiwLSwXZCJSx8+vhsoBLKrzd/kv6CD/urnc8Y1VX91ATKN7lbR3aVWg1D
	 GaM51qHHeuAKeM7QcwJsYI96LB9tLmLu5FR+SCuatIKf/uxuQtoIIwhaWm2TQtegg
	 raco9ioV4dD+P1lGVxJA+rYeA1Z78MOKc0WGr7Bsfwo13V/Hx//ofAkePpJJsyQj7
	 1wKgpiRrEM+CNoolRw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mv3US-1sBfFn3ENE-00sEqx; Sun, 14
 Jul 2024 20:06:23 +0200
Message-ID: <13c34802-c4f5-4e21-b675-4422680a7a66@web.de>
Date: Sun, 14 Jul 2024 20:06:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Pekka Enberg <penberg@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mm/slub: Use seq_putc() in slab_debugfs_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rqcv4mAWZlITSl40Y4+8GTzosv7+akT6BsQ4hgg7M44twu4+W7z
 ztPo8Sw1KHw8QjsS0z1TrEFaS+oQ9UQa3Knt9m7bOxe4lwR97nslQlXF/rsgGATj8yt0I5D
 XxK/fmgJw4Kp2r/OrHmTHVRr8HC6pc96EXrXy7UVm6oc1FaEdGjIIvuIxhJS/y+zJhq+rSn
 ZOvM75SIfJm6k8pn+8urw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/n8ZbvbyyN4=;r8emOt9AUcTNJeXBsRhd/FjVZ3l
 Fg226Z/bBR3YRHaABAFmTcTUMRgh6g/AQYTKyaYNdMbsOPcAdZ+Zst0jVi5CDPcGzJrPYgpSa
 N8VyWSwYgCmApRq8COISQJFOdqy9axJo/vUgxBRwsUApp7MC4MIxtBln1rph7jBFQWrhKWe7F
 a4yR3UInOl6hCEGcUm1mmhrCqmmz8yteBv8Wja3mJGSjuYL3lshcnH7AioZ5QremFkrKmgRbH
 qGSvnXlSxD4U27zSUltY5lQYOEkgHv+WXNTKsJ6s/gtJ0RfolS+BIsTxC7JzKLdiNWx5Z+rhB
 LZxsCJQNPirXNy43KGK42dSLsCnLiA/Z8tggqMEOzS27ijseb+gsS7zlfW9H/fqA1lIZ2aF33
 /di1geNfampkkPubniNmyN8jlVWwsrwN5zP/l8wdauVIH6Ow/gd6Lj/aIFXmKPYFJYpy3Y2kW
 hmI+ldtOqDP8DXhKV1RBZ2jYlRiwqHQnh9MrAj3CI/1IC/f+oC5XBJAP5TYYMIMeZsZdPlQSJ
 yqACCmkI+TcgaKblmE7PmwtgkMxFP7cPAiF6IE7MQ9apqD5B2KG944n549QMpslHFrAXjZkja
 Wxb/miRe2MhLJaDJbQi5tpQAnS6jXa1jaT/q+GrmE4eVFbgPc705wj/pvtmjZrsBMag3DP04Z
 vZ32HGug2nZx5b2K5tUciqQsR9lSb6V4CQD3PgAdF5B7RQLfvlFVtbPvE6AxsnCF6PDRfzQvO
 RETmIjibUuXWEDzC0VAPtMWfoxvFxVAi0jsB8i6kZ6LDGqRWjC90e8NctPpb6aSHHLTmfBoqp
 f15QQQtUzshTIPSrK64pcd8w==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 19:55:59 +0200

Single line breaks should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 mm/slub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 3520acaf9afa..49f567968f81 100644
=2D-- a/mm/slub.c
+++ b/mm/slub.c
@@ -7112,13 +7112,13 @@ static int slab_debugfs_show(struct seq_file *seq,=
 void *v)
 			handle =3D READ_ONCE(l->handle);
 			if (handle) {
 				nr_entries =3D stack_depot_fetch(handle, &entries);
-				seq_puts(seq, "\n");
+				seq_putc(seq, '\n');
 				for (j =3D 0; j < nr_entries; j++)
 					seq_printf(seq, "        %pS\n", (void *)entries[j]);
 			}
 		}
 #endif
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 	}

 	if (!idx && !t->count)
=2D-
2.45.2


