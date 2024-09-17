Return-Path: <linux-kernel+bounces-331531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C761397AE07
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 11:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A321C224FB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 09:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA85160887;
	Tue, 17 Sep 2024 09:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BeoH2Iy6"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E201315DBD5;
	Tue, 17 Sep 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565623; cv=none; b=jkJl2i+54mBbPS7ZonTwvtSSeSybtIN/ID75WGiOBaTToE23o00GnAB/o6h2j5Wh1Q07E7F8kkSFUgY86PIFi/WG6e+3ogP9ML8E+/2nUA87inpsaISCzsrkKOa9Yg39gr4cRE9h7l6DLb6uxWn/UDdhi9UfiwSZedQvCpV44Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565623; c=relaxed/simple;
	bh=hac2hUFaa/gebLVtfJwTY0SuulzszxQKQH0AilZ+XKk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TyDLaifcpA6Y1knhCBVyLll8PLeif/IPmzSAgz72kIfAkBTUeW7rJOnAXjzVRMP/JfNnti7cvovSXYgHmfPH5XClOh4QSDzPoplT8HnPIe1m4O3lGsO3wNI2njqmRLB9tN95DYpe7StuGPnnIzlaI1HDfvTWUbW6aQkwZ0sDNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BeoH2Iy6; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726565606; x=1727170406; i=markus.elfring@web.de;
	bh=BQCXTN8kKkd1kkGO9NF/p4jvWGCDLj4NS40vm1F4hUo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BeoH2Iy6DdIU4GndjNZnbkIeq2YNj+TbY72vkBctTYkViWyETfm032YkQg4aDjm/
	 dnHEB91Vdg7GgM0aXN8k+BRJCmbj5a82Y8mGIrFcUTCCAuyY/9EavMWuXPqUyzB1Z
	 VRFy4o/bQaqKlG224rPYsAm+oZoqV6f8cOzpwp2X/azvLAyweYX74sXkWinE+9isF
	 vj1T1c/Rkx8a5j2FtJcaRUHlqdBx8K8boeFkHucGEmdAQOa3WQ+aBna4wVJwA+cCM
	 KaDXKfOpDdK/aEEVf46RtVBTaZD3asU51rYbyc5r2w6X8hGlNDrIxg3PpcXZxqhFa
	 gFibUQDQN2Kp8A/f+A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLzin-1sYYC72tIP-00XdyW; Tue, 17
 Sep 2024 11:33:26 +0200
Message-ID: <bc5ce9ad-acbd-4f3b-91d6-10cf62bf5afc@web.de>
Date: Tue, 17 Sep 2024 11:33:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: kernel-janitors@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] crypto: lib/mpi - Extend support for scope-based resource
 management
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nL+dVkroubRqlrEYG8b1wBZgrLvmUOOGbIjc8yycZpxoJGL7txJ
 yJLhnXrJOfhNzXjkjDx0dOMp9rCMBlSW+UyLuseJhCHYJtOROYuX05EpirMYRhVpQBpuONv
 yiqNw9Xqay4zM+1t0x23t3HAMkWkqpHpe7O+kMv7h9/xbfDMIcXsB2US/vCYC0gmTUXj53u
 im/6olLOPOVb/VSqJa+rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kry6FD/SrT0=;M8vir+4w+5TsOFOlWwr5t5mOHsE
 xYwAJEZBe+83b20qSxUCsq1VdlMDdcNKVeJN1+tPmBvjqAq37VOSfPbn+ncF808CBFqaNbB99
 7v/D5sdb6zU7bw4ZH7pfIBK3+k/U5PlN7aCYXngiRHGZwCP6AHWKX4diP9DItMJ685b4K9LXa
 /QmURvgfEIUJJt8oKf7f1aT5/9wVTndD7qa3f4dYdVvGUn8IrOIDP6LDsBH2vNpnrVq81uB1P
 VvSy61A8B/L7gkyuHkKAAr60Giuk/QF9+IM2ZvjHcYJoqKniVp5FgbbRcNOF1TI8TwiMhuEqP
 pbCbN2p1brdGmutyHsbmSMwfEytJnekaNPIr2Z0FeIm+0G1P5XOafD9QuldXADVYz/ZAUgmAR
 43ykwMUljolsPUaX7fr4+9CkgrXwNHgu43FLvNV1GAeRx+j0p+0UjjvqvkdUi7v1TBld7NBnR
 DjJu5BDq3dH+4bqmvvr5vcC8dVoMq+WPBXsZEbFmqc1WQliUC29mZL4qX1uxWckBUog0rzuUE
 2jtjbR3BhnQGb9pT+4R+ka3obPBmcSHT9rgwt/mKxTq5hdxxUW7Qs4cSMOlwmZLyNbgXmQdxJ
 Y6S3M2kZg6c4jZ5ud1BsLC6Jej0U8TkDUs0wH6d24+uqLO3tj3IvcSbHTTdA+etyfNsUsmVI3
 ljsZ6KMSF9LkPSxUCgSO2Oz73J0AROskgn7vvA6KMdluwSxivi5kZFJOGM0ghRwX9M89CnELP
 j1bWDw1ppr7O70TWGx5Dyt/Z84mfWk93VBaQ9Rpa49cmfNFJBfdZJSkPSXG3wCtPBqtbsmpQE
 xCdY1bnSLOvV7/Lcam9gU/NA==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 17 Sep 2024 11:20:29 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

Thus add a macro call so that the attribute =E2=80=9C__free(mpi_free)=E2=
=80=9D can be
applied accordingly.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 include/linux/mpi.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 47be46f36435..47db8fa5fcc8 100644
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
+DEFINE_FREE(mpi_free, MPI, if (!IS_ERR_OR_NULL(T_)) mpi_free(T_))
+
 int mpi_resize(MPI a, unsigned nlimbs);

 MPI mpi_copy(MPI a);
=2D-
2.46.0


