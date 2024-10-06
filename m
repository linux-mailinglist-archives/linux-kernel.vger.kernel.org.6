Return-Path: <linux-kernel+bounces-352560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF339920BB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93CE31F20F01
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D988418A6B5;
	Sun,  6 Oct 2024 19:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="Jif4izth"
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B7B154C08
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.28.40.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243307; cv=none; b=NGxoorrQp/3l2kUMXP7+rixDA356I8pB+Siee19F+Gg1GMMVlbktSQQPT1VcMVHJH9UJwBkAcTKyOQUCT+KOe51dgxN0uQyf5UhWxZLkLQbArJN2yQphqpTb44l/IX0xK6lh5pkqZTrPn28lyyhQz61hA/3zf/ohdXO65ELnN5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243307; c=relaxed/simple;
	bh=nnFAo6T0JNlV4KN03OabrJNkB2+4Y1gcqfUEdQScEKs=;
	h=Date:From:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hfO4zbQAmC4lzwIJzqiwb4ab76NMlrI8bv6wkW3FMs/FBARUjXlje347Umocqq0ettOWu5ZBy4HefEmsN1EFvUO5VK5h2fEXZlSi1V3yLJsNQe0g1B/2W6q8aYSKjKg4/TriVsWFhmZeVBwT4rfi0PYBDLARuyq0DAZtvYvlnWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz; spf=pass smtp.mailfrom=nabijaczleweli.xyz; dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b=Jif4izth; arc=none smtp.client-ip=139.28.40.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202405; t=1728242975;
	bh=nnFAo6T0JNlV4KN03OabrJNkB2+4Y1gcqfUEdQScEKs=;
	h=Date:From:Cc:Subject:From;
	b=Jif4izthrTZYOWgXcQW+7yZE9i1TtMlJectnqqWk9Q4+ZgR/0KacYKYiOPODEWB8y
	 45Yvhz7mD87PekFy8uZUQhGgq1QyokIQAfIL9JuC3F0xwHkGcbhJFQTvhxlxhaRIg+
	 FLRCXdW5zVCc2YG7bLpCR3awakofDjNy+AsXzgFqv+E76MD3iv5wmSQTsMHawLUcAX
	 jCJMsZK/QAhRmb2wjD84omTkco478Yi3XVPiH2verpLc9oorFRLGTipdMWrqROm7il
	 XVBhn9q3snRN2C+X0uQK5JO32h0cbrwxQ5wBvxEsd63R6bzYuu/dJYaFUK6VQhspm9
	 uDaCjd7zyQNnQ==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id CC9AD2FA0;
	Sun,  6 Oct 2024 21:29:35 +0200 (CEST)
Date: Sun, 6 Oct 2024 21:29:35 +0200
From: 
	Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] Fonts: acorn: fix =?utf-8?B?4oyQ?=
Message-ID: <7foasfscbzfj2rqshro2u2rd36mmvgih3b27q7jystfou3jsyk@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rpllbcn7wegsfoe"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--5rpllbcn7wegsfoe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Characters A9/AA in the kernel codeset are =E2=8C=90/=C2=AC
(this is consistent with and documented inline in most other fonts).

However:
  $ cat Acorn8x8.x/a9-=E2=8C=90.x
   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88
       =E2=96=88=E2=96=88
  $ cat Acorn8x8.x/aa-=C2=AC.x
   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88
       =E2=96=88=E2=96=88

0x7e 01111110 -> 01111110 0x7e
0x06 00000110 -> 01100000 0x60

Thus:
  $ cat Acorn8x8.x/a9-=E2=8C=90.x
   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88
   =E2=96=88=E2=96=88
  $ cat Acorn8x8.x/aa-=C2=AC.x
   =E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88
       =E2=96=88=E2=96=88

Fixes: "[ARM PATCH] 1717/1: Add German umlauts to Acorn console font"
 (first in Linux 2.6.2)
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xyz>
---
There doesn't seem to be a maintainer listed for lib/fonts/,
so Cc: Andrew per spec and Simona since she's the committer
for the latest few commits on this file? Hope that's right.

 lib/fonts/font_acorn_8x8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 18755c33d249..2e7b6c73a231 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -176,7 +176,7 @@ static const struct font_data acorndata_8x8 =3D {
 /* A6 */  0x1c, 0x06, 0x1e, 0x36, 0x1e, 0x00, 0x3e, 0x00,
 /* A7 */  0x1c, 0x36, 0x36, 0x36, 0x1c, 0x00, 0x3e, 0x00,
 /* A8 */  0x18, 0x00, 0x18, 0x18, 0x30, 0x66, 0x3c, 0x00,
-/* A9 */  0x7e, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+/* A9 */  0x7e, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 /* AA */  0x7e, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 /* AB */  0x40, 0xc0, 0x40, 0x4f, 0x41, 0x0f, 0x08, 0x0f,
 /* AC */  0x40, 0xc0, 0x40, 0x48, 0x48, 0x0a, 0x0f, 0x02,
--=20
2.39.2

--5rpllbcn7wegsfoe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmcC5R0ACgkQvP0LAY0m
WPHbRA/+KdihciX925cMOsUnq9bY1JGivIA48tIJpNAtmNdAilrZbWL4k5+7aK2D
9+3dxEFmooIEa3VmQUwmXEHQg0W9YBOevTK+LBWMcF0a09gmpCm5XvtxWiWGrtTK
aGUIBm6ZMlFZihalspOXewlrV8eU1OmxTWr1OwlmB9eFsfGxZ4QMCk6mCUTqoTay
MhVOTJ4X6+xlx+vwFR33LMLHVmp3vH4r9CS/K3fTEPhQoL17930Q96kKk63P+zRV
Mhde0D1pnJFDPGzezyNH0xrHV4Kd/KjNPdE+zyc7Uq50hRX/Z339G8zJ9tX8rRsk
on/2yL2yCgxbgVHM3WdCBn5NqVIBHb9PeWIAfn18va9dKDEteN1e+xd++D2w3zoa
9IEtaNaOn2rbYCvaUEaU7pj2OLs7wMN+7QTBmUQyF6wq33+CcaGVLrP37xXIFHOp
oKNldwkHBgiCafQGKUZs0KrPjE3leESTmMSbgA7Gl3sdGd6C8C6g2m+cupaQ+voc
8tXp8TWt4OpArMF+LgDXEd09DrD59eTcEynConrgxkRW6Nxfs0hQj84/9Ehm5asU
S7oOuP7zPOJN6ZBRiqW0pwMZK+Zr3eTXUkayXUBVW3meRNRKyGdAGM0wxhLZ0CIp
VWA0K+ttdxKdROg4pCY378eXiUddkboM3QyJ3t3HabyQIzHED+U=
=DOSE
-----END PGP SIGNATURE-----

--5rpllbcn7wegsfoe--

