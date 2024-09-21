Return-Path: <linux-kernel+bounces-334837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EE297DD33
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A6A1C20E20
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2745170A23;
	Sat, 21 Sep 2024 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="uRNzYsU+"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85C1714A1
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 12:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726921346; cv=none; b=DnZ5vsN6m1HqJmB6q37OjDYs/8B/r9Jpdae9a7hANNcTFKF/2ogKXxbpp/DbJkFApPa/T6H++OlzVLSV6IUObdFViQkF5gtZzNJBauaYcu/VadirR6P6X3+j7nx30etEeUPMhJt5rVgaUeX76ats0rhOUEQGDETwPTcNnstXNf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726921346; c=relaxed/simple;
	bh=tt+1ziUrp7YEZ1KW7m/nhGSU8fM0G6RypBSbDkSUwG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QagthO6LOyvcCQUhSlMGcOIGC0aU59zSym4kG4PFv0dcJMCag89ZUXDXBLi5201iYW22f0bPMeWN7t49Qed4i54RJ82qOCloUKfaTN3zGhVsmwmgVE12Qwxa30vm4F5UtBsSd5zcXAl3bWYg9VErVgvYaXb5/LFfaWANLQbF3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=uRNzYsU+; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726921342; x=1727180542;
	bh=tt+1ziUrp7YEZ1KW7m/nhGSU8fM0G6RypBSbDkSUwG8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=uRNzYsU+j/rgKI3qYVwkgz8CKDU3MK/+jApon0cqND5JXWuvRW+jig54EbnfKNaun
	 l/WXx575RqndXck5e51ZdXBlkyjfZVwD+IFuC9YoCEJ7fsZoXKuZg8Jgmj7DOkkRxT
	 fDcAoa1+vLypxCWxIulvOSUIBui4dtW1IceSvVF+G9qZX7UC3V8c0AIqnOuwEnmXpS
	 TBvE3/pyxxwuzp9q6lKdd5b2I/KdgqH2/mZMKjjS7eQTSXDR2bl/nAQh3NfCuJwk7I
	 pm22h6TQlYtKbnBWqkdvQfqWTg7OXiZQ3lDk8doVuI1vMjxlKFdQ8gse9LjeclBgAe
	 K5YRYoEyb2nCQ==
Date: Sat, 21 Sep 2024 12:22:20 +0000
To: gregkh@linuxfoundation.org, tdavies@darkphysics.net, philipp.g.hortmann@gmail.com, dan.carpenter@linaro.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 2/2] staging: rtl8192e: r8192E_dev.c: Rename btMsr variable
Message-ID: <20240921122113.30009-3-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
References: <20240921122113.30009-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 4791aeab4bf3734d7676fb36c82107f9aa347f53
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames btMsr to msr in rtl92e_set_reg function in order to
avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/stagi=
ng/rtl8192e/rtl8192e/r8192E_dev.c
index 675e0e263697..db375ba9a223 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -52,29 +52,29 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable=
, u8 *val)
 =09case HW_VAR_MEDIA_STATUS:
 =09{
 =09=09enum rt_op_mode op_mode =3D *((enum rt_op_mode *)(val));
-=09=09u8 btMsr =3D rtl92e_readb(dev, MSR);
+=09=09u8 msr =3D rtl92e_readb(dev, MSR);
=20
-=09=09btMsr &=3D ~MSR_LINK_MASK;
+=09=09msr &=3D ~MSR_LINK_MASK;
=20
 =09=09switch (op_mode) {
 =09=09case RT_OP_MODE_INFRASTRUCTURE:
-=09=09=09btMsr |=3D MSR_LINK_MANAGED;
+=09=09=09msr |=3D MSR_LINK_MANAGED;
 =09=09=09break;
=20
 =09=09case RT_OP_MODE_IBSS:
-=09=09=09btMsr |=3D MSR_LINK_ADHOC;
+=09=09=09msr |=3D MSR_LINK_ADHOC;
 =09=09=09break;
=20
 =09=09case RT_OP_MODE_AP:
-=09=09=09btMsr |=3D MSR_LINK_MASTER;
+=09=09=09msr |=3D MSR_LINK_MASTER;
 =09=09=09break;
=20
 =09=09default:
-=09=09=09btMsr |=3D MSR_LINK_NONE;
+=09=09=09msr |=3D MSR_LINK_NONE;
 =09=09=09break;
 =09=09}
=20
-=09=09rtl92e_writeb(dev, MSR, btMsr);
+=09=09rtl92e_writeb(dev, MSR, msr);
 =09}
 =09break;
=20
--=20
2.34.1



