Return-Path: <linux-kernel+bounces-339396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7D898649B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0A228B44A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68FF47781;
	Wed, 25 Sep 2024 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Dr630+Wm"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B51BC2A;
	Wed, 25 Sep 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280968; cv=none; b=gvfbzkfx5S0yQI4Gn1paTZTNsQu/iuFlLPEcYAZrF9TEfxlsVS7SMj/aiZWahtryIXEPlBV/DLJOL6oC8zKzu9kGKsb9uFkW2z6zNNpt4zhMfh055v3H7mbJHCx65R7jfIqW/shOdaCH8dWZ/DXNLXzjDW6h1AyI8QWdqWtzElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280968; c=relaxed/simple;
	bh=2tXkDyMHdjna0OE+Lljguk4REKWwTtuPbQjJOifA4k4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=jXzDeMBvD3V7Dcz3bzMjoXb3SkFml4eZZOoUjgfu9OaQc5YwAeLyO2DX02sRbmWJ4utK5KSNYL0PnL7jtPuWboGshWtAsVL33E1G1e3Gf4fBAhShNm7YnLlMKDW8eotZH6gW3B6d2mlLgl+VEQJTVEYscH66StQAOT4VBEqrLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Dr630+Wm; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727280928; x=1727885728; i=markus.elfring@web.de;
	bh=GPVMv+Fro7snOOkSjwuidL1HaYFhKCBkieLGXGRlEYE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Dr630+WmB0klDSSGZpbrs28o7XI1u5mJEcjBpAXtMSHtmTjVpTDp3WEvEShQCMGy
	 HbKzLhE15mwNg4QFJO6h4koO9/U3sIuPsEfbrms3CysydJCBjMUWJ4uPLtPCm+9sm
	 kUOy1p5e8FspP/98juBDNJSH6/hUGszEUoA2fr8OTVoxg5JjbsZuhrSwsb1W5xqqU
	 L4194oa1nlTjsb3/5V9j5YYIe6XE4Nw4s8oofbpijJGU1Azk6ZSzzah9JdN181dx6
	 5E1OTlCnk0dtOfPuNToWsVGK8ukZEKaIMWiMotxqV6JmCBBbOVWAsV6aLr9nnp78I
	 2BGI1OgVzRisuJCQ2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJP4-1s5f0k31SM-00uIZY; Wed, 25
 Sep 2024 18:15:28 +0200
Message-ID: <913884b5-c2b0-412e-a271-4053cbfb9e46@web.de>
Date: Wed, 25 Sep 2024 18:15:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-usb@vger.kernel.org, Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Chris Wulff <Chris.Wulff@biamp.com>, Christian Brauner <brauner@kernel.org>,
 David Sands <david.sands@biamp.com>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>,
 Paul Cercueil <paul@crapouillou.net>, Peter Korsgaard <peter@korsgaard.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] usb: gadget: f_fs: Use common error handling code in
 ffs_build_sg_list()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hqICG156UNRmA8l23bR8Qu1RukoXSkwIibh865FWEZ3dX9rC0jR
 nQ9OGGaL3PQxLzaDF99CEUea/S8kfC/0UhcRnRomVxU7/QLLBujHDtuCy4yQ/fwD2hYWqNO
 bpr1flfnPnZdXA0OW19SGMuPTTDj52nYAVJ+aeY5Y0tVsLC6+JyiFVq3+ltSWLlglPynBfi
 y+D6GCJNMLsZuaqkOicdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NjB6L74OuFU=;K7NIHgzEH37u6IrzgTSK6OfKE5m
 LHVR3x7gH2kah8eMiqA2Kua4Vpcin8Wl5H0aSMVknCnK81t85TZu7zj/2pfHsmZ2eYqQexH9r
 sQLq2s9txpPIImey6EWeNNz2ZtC1ta1LckghGCxbBX3M/9GCBIqP5Lrhrt6tml1gYWt86axz2
 ioBaBWCPWLM76gQYrV2mJ/WfGE/SQyYq2yx+CzWi+Za6sAB9TLc+BUUdhwdQNOfhzQDf8y1jK
 +vu42v8jlvy0YZEalTIfu6mB6rRSRVcMrAr0yR5hkIuZAHJ9ase0XlxKt/eEcVnioS9HRvxA6
 GSDs9FKIDbdI6HPe+PDLmVBkNeYBvmzJOahzGe/NqGyxL52mYIDJcJctdCobGsTYaumQXDjLK
 KJwwyYNrTgc/WZCuWkusyRZ79WEcEdgLkWTsS0pYGHggK/ZwMduFyANw5cakEzWHjBBNBNaMR
 P9+pGsVwQDx7bjsjQaXYs3RC99RcM+bm3eYIgHo3ByPC6/LBhTFBZEczktSCd4CzF3wk3d7BJ
 vDiRiBZGqmoqLquvDyFi8p4EDmm7N19C2koSVjJPtFhFkAhS1uh4Sza6T5eoNeSvyx4jdBqvx
 ZhXOnabbg+HxoUleEinf/BTzRHy6BmswwZMqnFf+YdoyWHOfRBcVGvplABBiF0Pp6GZKBgv0f
 qwY10w9TLqoySvDPKBLoGuDOpgXvYe97MhO7yJiSxOpWjVHyAZHQn17wKMefkPC6hN2Rf+GFM
 MXArB72TyU8Y2iKm82gFrnEd6xWSEZe98qy1VZon5A5IG6H2SHGNmrnOWfmQU58cfUKwDD+gl
 M+Mqi/4QgxoAzk8HtGYxkiMw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 25 Sep 2024 18:03:16 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function implementation.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/usb/gadget/function/f_fs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/funct=
ion/f_fs.c
index 05b52e61a66f..318a74578c3f 100644
=2D-- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -808,23 +808,23 @@ static void *ffs_build_sg_list(struct sg_table *sgt,=
 size_t sz)

 	n_pages =3D PAGE_ALIGN(sz) >> PAGE_SHIFT;
 	pages =3D kvmalloc_array(n_pages, sizeof(struct page *), GFP_KERNEL);
-	if (!pages) {
-		vfree(vaddr);
+	if (!pages)
+		goto free_vaddr;

-		return NULL;
-	}
 	for (i =3D 0, ptr =3D vaddr; i < n_pages; ++i, ptr +=3D PAGE_SIZE)
 		pages[i] =3D vmalloc_to_page(ptr);

 	if (sg_alloc_table_from_pages(sgt, pages, n_pages, 0, sz, GFP_KERNEL)) {
 		kvfree(pages);
-		vfree(vaddr);
-
-		return NULL;
+		goto free_vaddr;
 	}
 	kvfree(pages);

 	return vaddr;
+
+free_vaddr:
+	vfree(vaddr);
+	return NULL;
 }

 static inline void *ffs_alloc_buffer(struct ffs_io_data *io_data,
=2D-
2.46.1


