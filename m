Return-Path: <linux-kernel+bounces-332896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6797C062
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C22B22004
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D731CBE99;
	Wed, 18 Sep 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OUE+zpnc"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3EA1CB30E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687287; cv=none; b=FJHirrgkrpUuxP+NZIU2CnYf7HaohAcnWolLfW9tdTLd11sXKDVcgEf5KIEd0bjXok4mNk48HE6ZRxgPsIkolvb2gnXMLpq2N90AqCPL6MPgj0ig/tdeSUWYMTQKUUPHv8f5IfBSsTLL5GoIVu2gRORRJrCiRXfAXWTWH+yFHLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687287; c=relaxed/simple;
	bh=tmxJZ1iDzC5bj4dGB4TSqrMB1l5mCGut4F+5SZsXvuM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LURK6d/X+DRfg6v97K+001O8BqvAtG8nJQkQeuJ5/MoFay7U9XyCruNro0Ku9DFWAhjN7ovRZLpWbs+3jJC7/ZKbURvag/Iv7cAxqgAnjDz22txIQ9d5xz9NIQpH4BNQ5QGkjCZqx33iq0fnTzOiiF8GTOKP1enrNjSNexXx3Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OUE+zpnc; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1726687283; x=1726946483;
	bh=tmxJZ1iDzC5bj4dGB4TSqrMB1l5mCGut4F+5SZsXvuM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OUE+zpncVs2reNBa14Kj+E7fhw/ed9JCRYG5G3EfgBk9QkmEa/+/Nj7wcPuxdVZ6r
	 Gos56PFKXiLp5zrDSHunWJaK1vT6YodnStBHLhnHK9XFkc5xvLwqVpZf4+8Wc1BHC/
	 i43KA0QDLzbBH+znD8Kn0NU0Qbp4uqRJhk8pFIovZt+RUlP6Ddscncok6SfXn8CZPL
	 mZ5cUhKwTBWQfGJxnyZRwhRUOWeF1QO+SQglrWtkUDvcAGOIvMuCeV979sYPNNfGsh
	 oRiUh7jbQ+wZU7uLQUtZsZO6dynQ95Knr4mL2M/suY3rQKCh/wteEBk+oq5bxi4SG4
	 SH2GtG6qqevrQ==
Date: Wed, 18 Sep 2024 19:21:20 +0000
To: philipp.g.hortmann@gmail.com, gregkh@linuxfoundation.org
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 07/14] staging: vt6655: s_uGetDataDuration: Rename uFragIdx parameter
Message-ID: <20240918191959.51539-8-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
References: <20240918191959.51539-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: fe23c06e11d02b388475037091821da9bf092843
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch renames uFragIdx to frag_idx in s_uGetDataDuration function in
order to avoid using camel case.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/vt6655/rxtx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 72837898ea29..3d7bdcba83a9 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -235,7 +235,7 @@ s_uGetDataDuration(
 =09unsigned char pkt_type,
 =09unsigned short rate,
 =09bool need_ack,
-=09unsigned int uFragIdx,
+=09unsigned int frag_idx,
 =09unsigned int cbLastFragmentSize,
 =09unsigned int uMACfragNum,
 =09unsigned char byFBOption
@@ -244,10 +244,10 @@ s_uGetDataDuration(
 =09bool bLastFrag =3D false;
 =09unsigned int uAckTime =3D 0, uNextPktTime =3D 0, len;
=20
-=09if (uFragIdx =3D=3D (uMACfragNum - 1))
+=09if (frag_idx =3D=3D (uMACfragNum - 1))
 =09=09bLastFrag =3D true;
=20
-=09if (uFragIdx =3D=3D (uMACfragNum - 2))
+=09if (frag_idx =3D=3D (uMACfragNum - 2))
 =09=09len =3D cbLastFragmentSize;
 =09else
 =09=09len =3D frame_length;
--=20
2.34.1



