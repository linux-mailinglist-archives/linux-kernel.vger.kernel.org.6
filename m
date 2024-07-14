Return-Path: <linux-kernel+bounces-251765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C7A93097E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 12:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457F5B21138
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 10:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B4449640;
	Sun, 14 Jul 2024 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sVtQNKE9"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D24BD53E;
	Sun, 14 Jul 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720951235; cv=none; b=l0Tt01IYlEzWA7cmySFxy/E1w07ahWU5aiCO1XLchTxrnXcTHyV29DM5y9mw0vmn1Eh4A0kHTEePSLdVe84/H+LWezXBTmi47If8dzQ8obrmT17V2iKPK8YtVkUPG26TIw3QHhG+Mj8rQMOv7yk1eFscFfAiXlGLK+Sv3szsQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720951235; c=relaxed/simple;
	bh=70JMor/oZb4mHjzra3jt9sMl0xtaN4eX84HTPMEELtE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=idy/ChheqOqXZL6brlPM0UvROGs1Lq9khYy6Wlq+5bjsKYbLqNiSL2MBPrbrOOXsik3DCjZVUfSsbLvOpwQrfB6reNd6gTChikfWYOY9Vgy9DxFGS7UU+QrFp2uAyIPH+o4wG/XBV0m66EFbpsFpiietJSteU1vTUXT3N5m4pGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sVtQNKE9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720951224; x=1721556024; i=markus.elfring@web.de;
	bh=f/V8aOL09Ui/qzegtZpYK/nVfAQmMHIQe/+tR3O9ibc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sVtQNKE9hx9xL23lnbGNeZJvt6D1tOsU/6FvSHFtImxixuJOTm2lvDRKo7uL2mTb
	 N5dcuBpwXKQgzIOywJALCKktpTgH5rIfvSHLvJm99cIAkHyC3V/dGe6jY6bTiBVCE
	 Zs7M6MhhF5g+BJrkfxWiqzUiltkX9NGpZD9qPeHLFkEOHFcy1okq6zlJ7wx9xKgo6
	 +ABqstgXJwWHT0Xj/iuwk7RUhoSpHxHPFa1pT1jdVqDFK53PTgKKkYg6YQNJOptq8
	 ZnrUthhCRoySYXxxu+j6mgzg2afQTrNHt3CbgxXU+OkVKB7NHh0G0vSaCLPcLXx2T
	 m0nVtf7d1jraNwd5jA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MJnvp-1smXFB0sxd-00LnlJ; Sun, 14
 Jul 2024 12:00:24 +0200
Message-ID: <19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>
Date: Sun, 14 Jul 2024 12:00:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] latencytop: Use seq_putc() in lstats_show()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TqZBUhXhqpHGxa1gc58W399KpIZNGZb2ii1m5+vpW0ibQqib+4F
 T5IcP5A4z6e7q837phyVqb5BJMW8GG3LZ2ls+qVU4zjQeml2kJQagcjHPhDNfwP+8hNd3Ab
 4n1NMSTONgrnNKZg7TQtdkNr6/LDDll236r5ZvFD+7K2BveQ0rcycWMnVGZIhY+xhK+tLP7
 IZG4ffWYmVAQAwKa0lxnQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:v9Ct82VaZo4=;+I/evG/a54EpAnd5MSr5p9YQ/zI
 5PQ2vikeXo2fL3UpHKmIIndsQFRivrLAkwDSvmKU7937p1vgmtevUe5BbllayRCz1t086fHeT
 W1xmRKys9J6KATljXUQXyefEuuDT7kGMPdA6kKuFaXyR4/kXdEEaPoc9wMrv1IU0X2jxTHJhc
 +3dVY7PctPIhWxPSJF3O7sRH4icw60bRPJw0gotIb4e6WgqDi297ma+sMpZKzsk/Kzd2ckpcw
 onFpCvJMhOoUrO8MxWsRuS1BUbl/tNEhqsxDsElVTRBOGqvtivCA+HGemfmITnn8ARTBCuMko
 OLmwtRZSRGcmbF+7AKCd7t4BIlqPAzFFX9EEJDX1UP6CtUeGpZj4zp1tMj/UAuPhTl6BCzUDm
 0AAN/7ULILAXYSZ3gZGLfQhjlvnX5byRKqI5OjJLUf4CHmRkIoNQFx2Yo8fxVn5Z9XCeKVtEF
 DjLGgVSvHAEGz5xJiR4BJ5hFEvKXvHQCnYt0m0WbTh4y2uN4RcYTBkvepB8gGna5JYJJtWEOQ
 ia3UIHLo+ybvwcFmbLmk7s+8Jt+c6Vl6NcNeWV81TaJto96p6PgYDxAtl1Ac3rBozEp2mS8qC
 DgS9LR/MPUmE0FCUJ4A6mDWLJ876rJqO4u/E+mxd7hC9soj+24zaMi6VClnPT9px+x1S91XXz
 X21TPTeWmTqqzemnIEBYzsExfX2dPbHF64BszaPxeXo9xAohjbJEVwu4fheMzkSmjZx4Luv9q
 LvdhClCfEgGNIdsK00aFGZgwLgiz8YdtP73S+WZfnw4kdifZ+vtq7zqT85BdgDsYXIoEClghq
 7B1Ev2mNZ0f8DdcymhK8oUeA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 14 Jul 2024 11:52:13 +0200

A single line break should be put into a sequence.
Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.

This issue was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 kernel/latencytop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 84c53285f499..09e5231598ae 100644
=2D-- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -260,7 +260,7 @@ static int lstats_show(struct seq_file *m, void *v)

 				seq_printf(m, " %ps", (void *)bt);
 			}
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 	return 0;
=2D-
2.45.2


