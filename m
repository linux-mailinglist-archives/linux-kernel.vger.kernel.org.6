Return-Path: <linux-kernel+bounces-332899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07097C065
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58581F2230F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A241CBEB4;
	Wed, 18 Sep 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OETp15rv"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0411CB31C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687307; cv=none; b=dwPJytf6upoJBLSSziXllXgVItDY6khyl6oxBFCfky+vnREfR+7UT6mY435/KnWf+Ny5cVwsx5/oKWw4Lsp8YUh2E7Af2CErBTODOj6Eyv7tktGtryWjRVXn+DFw06rBU18norY4bdimgZTXsGSRHCtrAGpfOEVpVoNUekep8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687307; c=relaxed/simple;
	bh=/dImOGan3ZkKVRH8rDVlWttV/k205lKet7c6uyWYv40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gv+cczJqCtEFlRmepH8ZNyHL/7wMP+KSqwh7zbAk6HZ6blz0h7MtBlgoSA3ZlIh3LL/I9tu+oXa7oD9kRjloIzYEF1UJZBpGBBwZ8F3cxw6lX7EsXWx6a49FZ3VP8FRQcEvakalVQS4HhWLSGu8Nku6Ug0x2AZYR3znDecPAWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OETp15rv; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687304; x=1726946504;
	bh=/dImOGan3ZkKVRH8rDVlWttV/k205lKet7c6uyWYv40=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OETp15rv2DHf1qu++VcMkwVew8e3t8eg3EIACcqf9NOa3sHtbQXpLGsdVktn0GI4Z
	 wYrZUyfOxctn6KPAseveCcdCUHvJlvdX66NLMeBJrKDhYyqnneMMty9WkDvUciA8Rz
	 RAmPczYCPTBXmkhEvTsIl/6HtyZTDi5QPqd00S5b5oJGJ4l3KgVyN5pcgX5/OeH/w2
	 WNJW4YD+3k2YbV3eAnRkRtqyEAs7yCW1kzRkg963Wkmm7Lp/XM0v250Eq0qYbjOMzj
	 zgIP00/L7BUH97TsQFigJwvJRAjCZndShTNDTn7J5s7d/cTmRtJSl1i6PJdp1eDQZI
	 ck4wpo6gEIPPQ==
Date: Wed, 18 Sep 2024 19:21:38 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 10/14] staging: vt6655: s_uGetDataDuration: Rename byFBOption parameter
Message-ID: <20240918191959.51539-11-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 13e8f8f72d716206a32143f633ae48bf64a380da
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames byFBOption to fb_option in s_uGetDataDuration
function in order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index ca92dd72cb72..58446eba82cc 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -238,7 +238,7 @@ s_uGetDataDuration(
 =09unsigned int frag_idx,
 =09unsigned int last_fragment_size,
 =09unsigned int mac_frag_num,
-=09unsigned char byFBOption
+=09unsigned char fb_option
 )
 {
 =09bool bLastFrag =3D false;
@@ -309,7 +309,7 @@ s_uGetDataDuration(
=20
 =09=09=09rate -=3D RATE_18M;
=20
-=09=09=09if (byFBOption =3D=3D AUTO_FB_0)
+=09=09=09if (fb_option =3D=3D AUTO_FB_0)
 =09=09=09=09rate =3D fb_opt0[FB_RATE0][rate];
 =09=09=09else
 =09=09=09=09rate =3D fb_opt1[FB_RATE0][rate];
--=20
2.34.1



