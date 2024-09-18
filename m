Return-Path: <linux-kernel+bounces-332462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3780397BA18
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FEC1C21D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E690F178CE8;
	Wed, 18 Sep 2024 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ZdayU9uP"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C57B176AAA;
	Wed, 18 Sep 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726651604; cv=none; b=UIKyJc271fCsp0bAo12jiNbHbIKGikaKSXZoWUq9eEZ/8nElDfr43ksMq8K5n4tkegxdX0ciKBh1dS1i6qsGKVbyC6T9CXro8L1WqeE8q1ouvIAaGHBjtkaBATMAl8Id/55bp6UwevXYxrG01ToF5kp2DeSwglNqx1di96UPeBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726651604; c=relaxed/simple;
	bh=x0h55I41PNY0qDvUesT4sPVlbRExPV+X974LHXAdHVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNR4YNUeBq3BnD4lvanBJbcMNEHQEz9nwLr9TGmTSZ6Ot/lUHM6+zcnjV/Znnw1ODUqCg5i+i1pB5/7FCEBMdboywQ7ErVtyyt41aI055OuDndjeeOq9O02NOsYCazI3bp7OtbmoEcMn4hUlUT2eJ1st9PFkNuxaA9My5t+hrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ZdayU9uP; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726651585; x=1727256385; i=markus.elfring@web.de;
	bh=oaWtkwikAuynprJNBCi62SYkTgrh5zdNvX/3WKywahg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZdayU9uPzcaIm/7F/y36INOdINnLEkDfzL5/saKtu2oFrR26GHqBETC4wE60TnVe
	 5N3z6h9pE16ZYJ/y+7bAlAzWFowobxUJ0FLA6EFr5yAQRypm1rsmTnDOSV5fD7S1+
	 kbqlhDO7UsGuNFGk2EBSGNlYCQdKgtCYCrt7WlVQ2GCxlYDMu9xnOnoJaK77kXEb8
	 AHTFPhZzwG/2vueFhkGmJet5Aa5fNUya+Gr/DQe5N0LZfvfRxcuaUi2ZoK+VNEIhH
	 BZbnxDwotJmRct+3nGIX/vtIQNa1vaYxcJJCWWKqJ4xe0CWOwPrTiIrxYTmhor7Kv
	 vjMy/vSF2gFjGjMkNw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVrft-1sRvgi1D53-00P9PJ; Wed, 18
 Sep 2024 11:26:25 +0200
Message-ID: <91d10516-4ba9-4fe0-8f63-86205cc4f88c@web.de>
Date: Wed, 18 Sep 2024 11:26:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] crypto: lib/mpi - Extend support for scope-based resource
 management
To: kernel-janitors@vger.kernel.org, Herbert Xu
 <herbert@gondor.apana.org.au>, Peter Zijlstra <peterz@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
References: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>
 <202409180725.ZV8DCvII-lkp@intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202409180725.ZV8DCvII-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w8K01psw/6Gru/Y1WqJRRjwAZyt+jNHKMO2RQjE8uDrl01kka6N
 e2IbNXddfvZS2TJof0kwVdyODU5Uzh97pxMiuwxEYcnlUkc5mtRpBFjBklx0eJ6kgTXuE5e
 QQGTL1/T0iTtEwxbWxaSOppKwJjSm7KhOJ35UzHlEYKA/ZqJATtRLM9DMzK3N+cWYcjPoIu
 h0q+3H56Kj/SHgoEU50LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PGXNLjEUkC4=;0zSB/KTqBWrmjT6XLVpJxRdD8IX
 OonJyQdOk746tt6zxAd2b+BtLihM0MJI9VZkcOWovW21gM0lc9ylZ/mtygObRlITLxjFUmlie
 1E8i+S6npk2yZgsKm0a4FzE44CH7KoZmtC5i8dARiX8zRLpiM4n7Q9astuz9vNMKtFsmYd40g
 7ZP5MO/5vIyu4JNvCUc0lTnAd0JwwMOJeolrU1qWGqxMMKCrvFVa18XxoAyF/sLKzxS5o9XiH
 WZ7phRvO53NTskY56HVAV5JZ6BHMuKPRlu/a0D78Uec//g7TVoBGuBqxzHC5UtpBZ6seIyOVJ
 KlBXttu0Isq1/P2Z08pGrc0xwkJVm5JrQ1uWu3bOQaBU3j5VH86SMdCdJEj+g0EiXPeTreZoA
 x9kHqll5pDjsGK34/d20mOKUAeR7gt2daQKdDYnlVIEZ0c7wPUnvQIfJ5iDN0vSp3RbiIaWWU
 KC7BYXgcdyX50LlTcpoBM0LdpbJyJKaZq/nTH883k1TMSzoNAenvYk+kl0lt57NnbJipghKSR
 bDKM+By8GrC3k0oNSWMcigs/tdv1CizrIsEM9MKsFkib9S3IDRUG92uay6LzgdK3GzOB8AHOY
 VgLsW4vRr/8GhKyHiuRgq77Td0kXtgZIa8t/TniNJrv7Tdk7G0KU6U5FJObLq66oEF1aBIxlj
 UBuj7KbzhhyImu3CGcNDB6blyunLcMecjVNhxY0Hy3zSeho2h6bXNE6D/iXjtrB+XeNW9JK6R
 VxaKIKJ9aFauPXtz47vUqEDWT37nHWuhY3YkluMyN6q3xAGqsgvtMHxAzteF2kFBXdcJCtzQq
 e/nBdZJM5dL5MR3ZASYIDsYw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 18 Sep 2024 11:06:35 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

Thus add a macro call so that the attribute =E2=80=9C__free(mpi_free)=E2=
=80=9D can be
applied accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

V2:
The kernel build service pointed out that the proposed identifier =E2=80=
=9CT_=E2=80=9D
was not recognised by the compiler.
Thus reserved identifiers need still be applied also at such a place inste=
ad
so far.
I became curious under which circumstances corresponding development conce=
rns
will be reconsidered any more.


 include/linux/mpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 47be46f36435..6fbcb88ce296 100644
=2D-- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -19,6 +19,8 @@

 #include <linux/types.h>
 #include <linux/scatterlist.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>

 #define BYTES_PER_MPI_LIMB	(BITS_PER_LONG / 8)
 #define BITS_PER_MPI_LIMB	BITS_PER_LONG
@@ -44,6 +46,8 @@ typedef struct gcry_mpi *MPI;
 /*-- mpiutil.c --*/
 MPI mpi_alloc(unsigned nlimbs);
 void mpi_free(MPI a);
+DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(_T)) mpi_free(_T))
+
 int mpi_resize(MPI a, unsigned nlimbs);

 MPI mpi_copy(MPI a);
=2D-
2.46.0


