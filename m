Return-Path: <linux-kernel+bounces-413404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE7F9D18B4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E22FB21ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFF71E2831;
	Mon, 18 Nov 2024 19:12:14 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE65A14D2A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957133; cv=none; b=hymGlCG/rIHYqA7FSZPddvLPXRIZPaMbf0y18/cmB1MUS2TswDmMNsiaiLRoSA/DR6rtK3F83YUFhSF1zHD03ygT+b/YJeDoI0725MXi8kigQPPn/TwoMt4pPrLlxfh10cwBoLZCq3voiOtogK3Cf8MTSXeSduauAM2dmbD5iOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957133; c=relaxed/simple;
	bh=2XAQkemA71iYPVIEwuwPyJsh+LIonqmhcOgHRBp9Mk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=c3ODAxRVQBzXvQRUw9s5aqKs01T9/YoLwLzG9hB60WQykoE3QHBPrRjG18jB4e+mj8ZcE/6+dra4SPRm0yoWuKlNsBjJQC5HSwVN1eYrxKFpmaimNOPA4xlFB2+POjakWQHpoDt3m7K2zybMuP0s/fMG1sEFy8ny93sCCxjAqmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-131-lyN8MeafO_qKA23yXAR8qw-1; Mon, 18 Nov 2024 19:12:08 +0000
X-MC-Unique: lyN8MeafO_qKA23yXAR8qw-1
X-Mimecast-MFC-AGG-ID: lyN8MeafO_qKA23yXAR8qw
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:12:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:12:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: 'Arnd Bergmann' <arnd@kernel.org>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, 'Jens Axboe' <axboe@kernel.dk>, "'Matthew
 Wilcox'" <willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>,
	'Andrew Morton' <akpm@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Dan Carpenter'
	<dan.carpenter@linaro.org>, "'Jason A . Donenfeld'" <Jason@zx2c4.com>,
	"'pedro.falcato@gmail.com'" <pedro.falcato@gmail.com>, 'Mateusz Guzik'
	<mjguzik@gmail.com>, "'linux-mm@kvack.org'" <linux-mm@kvack.org>, "'Lorenzo
 Stoakes'" <lorenzo.stoakes@oracle.com>
Subject: [PATCH next 2/7] minmax.h: Update some comments
Thread-Topic: [PATCH next 2/7] minmax.h: Update some comments
Thread-Index: Ads57cA01trJ5zhURpGnEK/DpxxPAQ==
Date: Mon, 18 Nov 2024 19:12:07 +0000
Message-ID: <85b050c81c1d4076aeb91a6cded45fee@AcuMS.aculab.com>
References: <c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com>
In-Reply-To: <c50365d214e04f9ba256d417c8bebbc0@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rjOIXIQG3GVyKdpDElSeL0WpX-2k-kZ6xSo0W4dXmfc_1731957127
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

- Change three to several.
- Remove the comment about retaining constant expressions, no longer true.
- Realign to nearer 80 columns and break on major punctiation.
- Add a leading comment to the block before __signed_type() and __is_nonneg=
()
  Otherwise the block explaining the cast is a bit 'floating'.
  Reword the rest of that comment to improve readability.

Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 53 +++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 51b0d988e322..24e4b372649a 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -8,13 +8,10 @@
 #include <linux/types.h>
=20
 /*
- * min()/max()/clamp() macros must accomplish three things:
+ * min()/max()/clamp() macros must accomplish several things:
  *
  * - Avoid multiple evaluations of the arguments (so side-effects like
  *   "x++" happen only once) when non-constant.
- * - Retain result as a constant expressions when called with only
- *   constant expressions (to avoid tripping VLA warnings in stack
- *   allocation usage).
  * - Perform signed v unsigned type-checking (to generate compile
  *   errors instead of nasty runtime surprises).
  * - Unsigned char/short are always promoted to signed int and can be
@@ -31,25 +28,23 @@
  *   bit #0 set if ok for unsigned comparisons
  *   bit #1 set if ok for signed comparisons
  *
- * In particular, statically non-negative signed integer
- * expressions are ok for both.
+ * In particular, statically non-negative signed integer expressions
+ * are ok for both.
  *
- * NOTE! Unsigned types smaller than 'int' are implicitly
- * converted to 'int' in expressions, and are accepted for
- * signed conversions for now. This is debatable.
+ * NOTE! Unsigned types smaller than 'int' are implicitly converted to 'in=
t'
+ * in expressions, and are accepted for signed conversions for now.
+ * This is debatable.
  *
- * Note that 'x' is the original expression, and 'ux' is
- * the unique variable that contains the value.
+ * Note that 'x' is the original expression, and 'ux' is the unique variab=
le
+ * that contains the value.
  *
- * We use 'ux' for pure type checking, and 'x' for when
- * we need to look at the value (but without evaluating
- * it for side effects! Careful to only ever evaluate it
- * with sizeof() or __builtin_constant_p() etc).
+ * We use 'ux' for pure type checking, and 'x' for when we need to look at=
 the
+ * value (but without evaluating it for side effects!
+ * Careful to only ever evaluate it with sizeof() or __builtin_constant_p(=
) etc).
  *
- * Pointers end up being checked by the normal C type
- * rules at the actual comparison, and these expressions
- * only need to be careful to not cause warnings for
- * pointer use.
+ * Pointers end up being checked by the normal C type rules at the actual
+ * comparison, and these expressions only need to be careful to not cause
+ * warnings for pointer use.
  */
 #define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
 #define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
@@ -57,19 +52,19 @@
 =09__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
=20
 /*
- * To avoid warnings about casting pointers to integers
- * of different sizes, we need that special sign type.
+ * Check whether a signed value is always non-negative.
  *
- * On 64-bit we can just always use 'long', since any
- * integer or pointer type can just be cast to that.
+ * A cast is needed to avoid any warnings from values that aren't signed
+ * integer types (in which case the result doesn't matter).
  *
- * This does not work for 128-bit signed integers since
- * the cast would truncate them, but we do not use s128
- * types in the kernel (we do use 'u128', but they will
- * be handled by the !is_signed_type() case).
+ * On 64-bit any integer or pointer type can safely be cast to 'long'.
+ * But on 32-bit we need to avoid warnings about casting pointers to integ=
ers
+ * of different sizes without truncating 64-bit values so 'long' or 'long =
long'
+ * must be used depending on the size of the value.
  *
- * NOTE! The cast is there only to avoid any warnings
- * from when values that aren't signed integer types.
+ * This does not work for 128-bit signed integers since the cast would tru=
ncate
+ * them, but we do not use s128 types in the kernel (we do use 'u128',
+ * but they are handled by the !is_signed_type() case).
  */
 #ifdef CONFIG_64BIT
   #define __signed_type(ux) long
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


