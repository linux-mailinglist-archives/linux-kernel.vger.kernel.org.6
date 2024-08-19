Return-Path: <linux-kernel+bounces-292644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0961695723F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B21CF1F21240
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB985187FF0;
	Mon, 19 Aug 2024 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PG5FuSJ7"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B9217ADEE;
	Mon, 19 Aug 2024 17:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724088928; cv=none; b=ZTPPxT9qczOw7wpcBzxVOCxB27WWLcYfMegL39YslqxNmYp7LXWg7+i6jsvs4Bil0gbGXXrUnPqpLifqYmX2g48bolP9FwsQg21w/nOGib1bcEBoELePXbWyQLyU3DvYR2nJaoo7l7W15upPMaJVmIK4cIxzyxJ5pK7Td/ngrTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724088928; c=relaxed/simple;
	bh=2PdBGLtwCa3jYeVsJZbMo93/zrUBXFAwrkgXdu/FrwE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=KqJCIYayAq/xZax6BUOOSbfri8SzifCmvtnToO9bPtz9wmJ0e/oXsZyZwNrF1LA+/N3ModAAAjLEC2y9Ua65RosGHxG81Uk8kaqdbsogPa4uveigQ26FgCCisU1CqWCcOgCC2Th56rTxwNXWBhy3V8E1pE0zBAs7nej/gPVhidI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PG5FuSJ7; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1724088916; x=1724348116;
	bh=zzVfF/nKMcwYxNAxS07HhEl/H9iRzZ8G72MmyK3xaUo=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=PG5FuSJ7+Wprdk2qsIDt5IokjOCSIXbYjxDIcPaZ+kM+g3YCwAGTdynLX1OdgFZLa
	 fJe8csVD3dsd4YErByb9IanIO6w6njkdCxO0M9n1JW6Ffxtk3D4sDxqH7lc2Cz1vPt
	 O7vI3uGVXKfnfATSpgaP0XP1Z0IJXUbg46lfAt8sEDu4NCyOuFdj29Bl0BDoMn00W+
	 e4i9lTzFHvzIQnxyM07MFZPdezt3rMKtRTL8cOOkJYAPyqrb8WX/H973NWHY70+6OF
	 OnE2KO/js4wEPQXQqa4jKhxgWsfxFbaW27vHHFiqUt+TSInivWd3b1MzztpcYE1Him
	 xQKtEVq6rwfZA==
Date: Mon, 19 Aug 2024 17:35:10 +0000
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, corbet@lwn.net, dm-devel@lists.linux.dev, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From: Piotr Zalewski <pZ010001011111@proton.me>
Cc: Piotr Zalewski <pZ010001011111@proton.me>, Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH] Documentation: admin-guide/dm: Fix indentation bug
Message-ID: <20240819172401.77928-3-pZ010001011111@proton.me>
Feedback-ID: 53478694:user:proton
X-Pm-Message-ID: 6cb3490ac93be09cef6f264ccf5e6f54436be285
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The following bug was found at `admin-guide/device-mapper/dm-crypt.rst`:
```
admin-guide/device-mapper/dm-crypt.rst:167: ERROR: Unexpected indentation.
```
Fix the indentation error.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>
---
 .../admin-guide/device-mapper/dm-crypt.rst     | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-crypt.rst b/Documen=
tation/admin-guide/device-mapper/dm-crypt.rst
index e625830d335e..450c211534a9 100644
--- a/Documentation/admin-guide/device-mapper/dm-crypt.rst
+++ b/Documentation/admin-guide/device-mapper/dm-crypt.rst
@@ -160,15 +160,15 @@ iv_large_sectors
    The <iv_offset> must be multiple of <sector_size> (in 512 bytes units)
    if this flag is specified.
=20
-
-Module parameters::
-max_read_size
-max_write_size
-   Maximum size of read or write requests. When a request larger than this=
 size
-   is received, dm-crypt will split the request. The splitting improves
-   concurrency (the split requests could be encrypted in parallel by multi=
ple
-   cores), but it also causes overhead. The user should tune these paramet=
ers to
-   fit the actual workload.=20
+    Module parameters::
+
+        max_read_size
+        max_write_size
+           Maximum size of read or write requests. When a request larger t=
han this size
+           is received, dm-crypt will split the request. The splitting imp=
roves
+           concurrency (the split requests could be encrypted in parallel =
by multiple
+           cores), but it also causes overhead. The user should tune these=
 parameters to
+           fit the actual workload.
=20
=20
 Example scripts
--=20
2.46.0



