Return-Path: <linux-kernel+bounces-413403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B4B9D18B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DCF8B2228E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0611E47D4;
	Mon, 18 Nov 2024 19:11:31 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCDA1E2831
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 19:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957091; cv=none; b=F0Usownuk9LO3QvR2yluaZ+sEx9+PdW6LWQ+qyfvQXslev2+2Ugz7Tss8vXxybc3EBpf87IjEgqn89WVc7qjuvNqduh7a1E6kKE3W9jXseXTFWr27gM6HlSRsDg8qAzMzdmOtpzuTuNtzeLiqYbM5hs+H7BDrCrF2zffo/LMqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957091; c=relaxed/simple;
	bh=ogoe7DYj5fNSGRVkRRryea1vrU3CSPr21hFmypa7qq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Ob0cmaVWQXIiz7eSgdts4OiKxg4v/FprzcCDlt/RDwsh66PvQSSP7+kHPyzO02q9B0jtMDq7Vn2zoT9ypAk69FPwvP34iUh02TfP6OCOLh91O3hKLGGgpfRR76nW8YWj6GvH4VVRMF3E2OVX32izFF9BoXMOQ21GuJjdoY5jA2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-13-pwgGBRruNOqD6Np7u3lSnQ-1; Mon, 18 Nov 2024 19:11:25 +0000
X-MC-Unique: pwgGBRruNOqD6Np7u3lSnQ-1
X-Mimecast-MFC-AGG-ID: pwgGBRruNOqD6Np7u3lSnQ
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Nov
 2024 19:11:24 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Nov 2024 19:11:24 +0000
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
Subject: [PATCH next 1/7] minmax.h: Add whitespace around operators and after
 commas
Thread-Topic: [PATCH next 1/7] minmax.h: Add whitespace around operators and
 after commas
Thread-Index: Ads57aZG7lyHiUjzR+iewqg1n0YFUQ==
Date: Mon, 18 Nov 2024 19:11:24 +0000
Message-ID: <f04b2e1310244f62826267346fde0553@AcuMS.aculab.com>
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
X-Mimecast-MFC-PROC-ID: hogFSRxyNirdftBqwtva07O7y1CaMYx1s4Z29bGQGN0_1731957084
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Signed-off-by: David Laight <david.laight@aculab.com>
---
 include/linux/minmax.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/minmax.h b/include/linux/minmax.h
index 98008dd92153..51b0d988e322 100644
--- a/include/linux/minmax.h
+++ b/include/linux/minmax.h
@@ -51,10 +51,10 @@
  * only need to be careful to not cause warnings for
  * pointer use.
  */
-#define __signed_type_use(x,ux) (2+__is_nonneg(x,ux))
-#define __unsigned_type_use(x,ux) (1+2*(sizeof(ux)<4))
-#define __sign_use(x,ux) (is_signed_type(typeof(ux))? \
-=09__signed_type_use(x,ux):__unsigned_type_use(x,ux))
+#define __signed_type_use(x, ux) (2 + __is_nonneg(x, ux))
+#define __unsigned_type_use(x, ux) (1 + 2 * (sizeof(ux) < 4))
+#define __sign_use(x, ux) (is_signed_type(typeof(ux)) ? \
+=09__signed_type_use(x, ux) : __unsigned_type_use(x, ux))
=20
 /*
  * To avoid warnings about casting pointers to integers
@@ -74,15 +74,15 @@
 #ifdef CONFIG_64BIT
   #define __signed_type(ux) long
 #else
-  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux)>4,1LL,=
1L))
+  #define __signed_type(ux) typeof(__builtin_choose_expr(sizeof(ux) > 4, 1=
LL, 1L))
 #endif
-#define __is_nonneg(x,ux) statically_true((__signed_type(ux))(x)>=3D0)
+#define __is_nonneg(x, ux) statically_true((__signed_type(ux))(x) >=3D 0)
=20
-#define __types_ok(x,y,ux,uy) \
-=09(__sign_use(x,ux) & __sign_use(y,uy))
+#define __types_ok(x, y, ux, uy) \
+=09(__sign_use(x, ux) & __sign_use(y, uy))
=20
-#define __types_ok3(x,y,z,ux,uy,uz) \
-=09(__sign_use(x,ux) & __sign_use(y,uy) & __sign_use(z,uz))
+#define __types_ok3(x, y, z, ux, uy, uz) \
+=09(__sign_use(x, ux) & __sign_use(y, uy) & __sign_use(z, uz))
=20
 #define __cmp_op_min <
 #define __cmp_op_max >
@@ -97,7 +97,7 @@
=20
 #define __careful_cmp_once(op, x, y, ux, uy) ({=09=09\
 =09__auto_type ux =3D (x); __auto_type uy =3D (y);=09\
-=09BUILD_BUG_ON_MSG(!__types_ok(x,y,ux,uy),=09\
+=09BUILD_BUG_ON_MSG(!__types_ok(x, y, ux, uy),=09\
 =09=09#op"("#x", "#y") signedness error");=09\
 =09__cmp(op, ux, uy); })
=20
@@ -114,7 +114,7 @@
 =09static_assert(__builtin_choose_expr(__is_constexpr((lo) > (hi)), =09\
 =09=09=09(lo) <=3D (hi), true),=09=09=09=09=09\
 =09=09"clamp() low limit " #lo " greater than high limit " #hi);=09\
-=09BUILD_BUG_ON_MSG(!__types_ok3(val,lo,hi,uval,ulo,uhi),=09=09=09\
+=09BUILD_BUG_ON_MSG(!__types_ok3(val, lo, hi, uval, ulo, uhi),=09=09\
 =09=09"clamp("#val", "#lo", "#hi") signedness error");=09=09\
 =09__clamp(uval, ulo, uhi); })
=20
@@ -154,7 +154,7 @@
=20
 #define __careful_op3(op, x, y, z, ux, uy, uz) ({=09=09=09\
 =09__auto_type ux =3D (x); __auto_type uy =3D (y);__auto_type uz =3D (z);\
-=09BUILD_BUG_ON_MSG(!__types_ok3(x,y,z,ux,uy,uz),=09=09=09\
+=09BUILD_BUG_ON_MSG(!__types_ok3(x, y, z, ux, uy, uz),=09=09\
 =09=09#op"3("#x", "#y", "#z") signedness error");=09=09\
 =09__cmp(op, ux, __cmp(op, uy, uz)); })
=20
@@ -326,9 +326,9 @@ static inline bool in_range32(u32 val, u32 start, u32 l=
en)
  * Use these carefully: no type checking, and uses the arguments
  * multiple times. Use for obvious constants only.
  */
-#define MIN(a,b) __cmp(min,a,b)
-#define MAX(a,b) __cmp(max,a,b)
-#define MIN_T(type,a,b) __cmp(min,(type)(a),(type)(b))
-#define MAX_T(type,a,b) __cmp(max,(type)(a),(type)(b))
+#define MIN(a, b) __cmp(min, a, b)
+#define MAX(a, b) __cmp(max, a, b)
+#define MIN_T(type, a, b) __cmp(min, (type)(a), (type)(b))
+#define MAX_T(type, a, b) __cmp(max, (type)(a), (type)(b))
=20
 #endif=09/* _LINUX_MINMAX_H */
--=20
2.17.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


