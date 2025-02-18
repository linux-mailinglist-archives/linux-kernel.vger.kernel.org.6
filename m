Return-Path: <linux-kernel+bounces-520196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B53A3A6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8AD07A4B47
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35601EB5EF;
	Tue, 18 Feb 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xnPsxEH+"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A01E5208
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 19:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905489; cv=none; b=BWwqB21DVDl309ME47DapwCiYVDK81No3ut+DFg7ctomQ/c4sDxBGTu9Z/j3jBKuuLZvQliyPr6Q8Z+qkuSlKav22cY+5EQxLtLrzSfYsiiHV9tr+Ob2Y3SdrPKOLRzhAQFFy445kTrmq2L0pr1PLhFp2oysKN96Co3a0gZM2qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905489; c=relaxed/simple;
	bh=GNdtyBbz/LV+z6jyn5+URU3RPTpf1mcxjNHdnsoCj3w=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=h2NTlTVvxTzcpsbY5sGkrP3th8QDnPdbwlYdspTpyAYWvam63HUr4y5IGMux+UjYOjadDJ8Uu4jqLYka4vd4+OOiLgjBgeLEdbEFpqJUMdaX/G4M4c1ANcdWd2xNX3+NQPc81eRCWLsMxVvEpSOzMvM++0qLKU6bD3yPYIBkOWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xnPsxEH+; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1739905485; x=1740164685;
	bh=1BW6AC+MBhVxcWnxpRWVhNXG8mF2nKclxbj5Bvymv3U=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=xnPsxEH+abgQSY8oTy1ELt8RaP66FRg2IQDrArZC6vl7b0gKVFcfGSaMHfA+wnA9F
	 KwbUI7vns/70Y2q7qH1xLvdeSMJ9BLPBtlxLs6fVoqHjuwo7Xu6T41AJ481qeTwHpq
	 MVL3qNTJm9TdjMNguuahPV6lYAL2HPbj5j/wdweextdHQyzp6C6DnI4M1UoA7AL46+
	 Ai/QJsConcmcSVAvubGmqXMbga1S18Wh5pjdxvdaXdmNXTmfyN6VwCOjtu37lcc/Ps
	 a3Q/d+u9hpz1/5wAyheGsdKYypuR/+jhOOkamSuY0LKE99wZvrkNfEdxjFWqSK9o77
	 Ou2MetmNdtFrA==
Date: Tue, 18 Feb 2025 19:04:39 +0000
To: akpm@linux-foundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH] lockref: Remove spaces before tab
Message-ID: <20250218190400.99284-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 4a1be9c662b9a9418b31697c32ea5f4af7dbf9c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove spaces before tab from one of the CMPXCHG_LOOP lines.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 lib/lockref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index 5d8e3ef3860e..4d0c7eb22e1b 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -13,7 +13,7 @@
 =09struct lockref old;=09=09=09=09=09=09=09\
 =09BUILD_BUG_ON(sizeof(old) !=3D 8);=09=09=09=09=09=09\
 =09old.lock_count =3D READ_ONCE(lockref->lock_count);=09=09=09\
-=09while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {  =
=09\
+=09while (likely(arch_spin_value_unlocked(old.lock.rlock.raw_lock))) {=09\
 =09=09struct lockref new =3D old;=09=09=09=09=09\
 =09=09CODE=09=09=09=09=09=09=09=09\
 =09=09if (likely(try_cmpxchg64_relaxed(&lockref->lock_count,=09=09\
--=20
2.34.1



