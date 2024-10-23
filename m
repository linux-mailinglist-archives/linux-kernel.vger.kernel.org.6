Return-Path: <linux-kernel+bounces-378084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5309ACB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50613283943
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD641ADFF7;
	Wed, 23 Oct 2024 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OudN8owg"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE801DFEF
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729690105; cv=none; b=U7B7exSSkF0kUdHvuzTieyrPm+pdO/AX6ULZTgefWD0pWjPy7pdo5JOB59OC5IKp8MoKOF30jwhZXF3wfmwEIfDhsKA1j78Yl90LittBRjSqjpH7uIE6sNi+YPc/Hp6qHDe4Lc01Tteg1bONLBW2hELM1bH32HKV+Kq+wGAlgik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729690105; c=relaxed/simple;
	bh=YilXwYTF1EZ40CJXwCjjAwjt43uCB+NGMsmhAdeDftw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Mr9YDtkkSr/loUIxQg1BobI44X46W95l+CdsnRvUalny5Ww4aX6CHf+2eFkFqDJOhfa5cDnWpkkvaRx3z8Cw2NXEGrWYx5WMt0WVb36rZ67WQbq8Pcs9UiIfj7jQEocUppxbAYHgoReCedWbkDMTpEnwEaPnVS1XFZ/ATUJIwGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OudN8owg; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1729690100; x=1729949300;
	bh=3pOFyS/YAsAOctiWACFlhkUIICzQBNJM1BMSEUZeUOA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=OudN8owgJVWeKHm8COuwi1v8OpShzpJPsGjx78ycBiQgEx01rEDAHc7yy6HSvUcN+
	 2iCwBnNHjBVK/6e/+daWsFoQVz8e46QBJioyTFDzlG1pQ/E4FQ7ILXDB3Rsw2d6R7S
	 Al+BiZaqsLcgmsQ3CgsJfmhL+1AvKIAKsDnFGiEdpLUnQtLy6nx0+C/wT4hcO9I4Fe
	 P8JRul+mTCW0FaKV0QYIObEV0Eu83+VB4gQOjAkxuEeB0CDdywRhMX8Ccg7xkv2Lm2
	 eWDN8hIhPEP0rLZG4omGyR6WZRiaI1aYP73r6zKgsel+zHC8JGbGtN+T9L/n145fsG
	 +2t1j/5egxa+Q==
Date: Wed, 23 Oct 2024 13:28:17 +0000
To: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com, dvyukov@google.com, vincenzo.frascino@arm.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] kasan: Fix typo in kasan_poison_new_object documentation
Message-ID: <20241023132734.62385-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: c0891f609ba3f3fc7d04bab32535c6be1f0bb978
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fix presumed copy-paste typo of kasan_poison_new_object documentation
referring to kasan_unpoison_new_object.

No functional changes.

Fixes: 1ce9a0523938 ("kasan: rename and document kasan_(un)poison_object_da=
ta")
Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 include/linux/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 6bbfc8aa42e8..56465af31044 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -153,7 +153,7 @@ static __always_inline void kasan_unpoison_new_object(s=
truct kmem_cache *cache,
=20
 void __kasan_poison_new_object(struct kmem_cache *cache, void *object);
 /**
- * kasan_unpoison_new_object - Repoison a new slab object.
+ * kasan_poison_new_object - Repoison a new slab object.
  * @cache: Cache the object belong to.
  * @object: Pointer to the object.
  *
--=20
2.34.1



