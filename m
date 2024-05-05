Return-Path: <linux-kernel+bounces-168977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344638BC07C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 663CE1C20292
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 13:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1B31C695;
	Sun,  5 May 2024 13:12:33 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09F18C36
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714914753; cv=none; b=Ox3Z0j2vT+qwwjgxAotyLOVxyHK8CEWRSL/KQlvj9CHLKgVZtPymGWKDHs2snXG9lKSk/eipyItemToxID/U+Mk/u1hqiM1ZSnmG8js1R0zoKTEJNZ+L+q/c9uz0HtNuf1R4PGJ1wXbNnHukhP04BotMnkY0ysn4ByMsi2eVOHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714914753; c=relaxed/simple;
	bh=mqI7Lkx9BEEGcIaH2vP7P85Be4RYE/5c4rJo24kmo3o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=HRKOntTcIoKvYDQqGKyrBso2k7JaIMoH2rqqjbkP7O41Sbcrp+7sk6qqcfBBUNw9wDLy4nky6en8U6VZZiqfqNPCK1akDlpe23EDs5fEX9A9g0hY7Qo5JK7R3xJ8Uq+Ga/Yu+hV7s7mwpjouX72RmZTJNK/4EAIvjTHTnW4C0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92--hnA0pcqNy2537LVwsUSTA-1; Sun, 05 May 2024 14:12:28 +0100
X-MC-Unique: -hnA0pcqNy2537LVwsUSTA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 May
 2024 14:11:53 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 May 2024 14:11:53 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yury Norov' <yury.norov@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Thread-Topic: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Thread-Index: AQHam+S8XBnnR43Z8kaIhRcpvR0+crGIoopw
Date: Sun, 5 May 2024 13:11:53 +0000
Message-ID: <62fdb348791949c08e53936e3bc442b5@AcuMS.aculab.com>
References: <20240501132047.14536-1-visitorckw@gmail.com>
 <20240501132047.14536-2-visitorckw@gmail.com>
 <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
In-Reply-To: <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
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
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Yury Norov
> Sent: 01 May 2024 17:30
>=20
> On Wed, May 01, 2024 at 09:20:46PM +0800, Kuan-Wei Chiu wrote:
> > Introduce a benchmark test for the fns(). It measures the total time
> > taken by fns() to process 1,000,000 test data generated using
> > get_random_bytes() for each n in the range [0, BITS_PER_LONG).
> >
> > example:
> > test_bitops: fns:          5876762553 ns, 64000000 iterations
>=20
> So... 5 seconds for a test sounds too much. I see the following patch
> improves it dramatically, but in general let's stay in a range of
> milliseconds. On other machines it may run much slower and trigger
> a stall watchdog.
>=20
> > Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
>=20
> > ---
> >
> > Changes in v4:
> > - Correct get_random_long() -> get_random_bytes() in the commit
> >   message.
> >
> >  lib/test_bitops.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> >
> > diff --git a/lib/test_bitops.c b/lib/test_bitops.c
> > index 3b7bcbee84db..ed939f124417 100644
> > --- a/lib/test_bitops.c
> > +++ b/lib/test_bitops.c
> > @@ -50,6 +50,26 @@ static unsigned long order_comb_long[][2] =3D {
> >  };
> >  #endif
> >
> > +static unsigned long buf[1000000];
>=20
> Can you make it __init, or allocate with kmalloc_array(), so that 64M
> of memory will not last forever in the kernel?
>=20
> > +static int __init test_fns(void)
> > +{
> > +=09unsigned int i, n;
> > +=09ktime_t time;
> > +
> > +=09get_random_bytes(buf, sizeof(buf));
> > +=09time =3D ktime_get();
> > +
> > +=09for (n =3D 0; n < BITS_PER_LONG; n++)
> > +=09=09for (i =3D 0; i < 1000000; i++)
> > +=09=09=09fns(buf[i], n);
>=20
> What concerns me here is that fns() is a in fact a const function, and
> the whole loop may be eliminated. Can you make sure it's not your case
> because 450x performance boost sounds a bit too much to me.
>=20
> You can declare a "static volatile __used __init" variable to assign
> the result of fns(), and ensure that the code is not eliminated

Yep, without 'c' this compiler to 'return 0'.

static inline unsigned long fns(unsigned long word, unsigned int n)
{
=09while (word && n--)
=09=09word &=3D word - 1;
=09return word ? __builtin_ffs(word) : 8 * sizeof (long);
}

unsigned long buf[1000000];

volatile int c;

int  test_fns(void)
{
=09unsigned int i, n;

=09for (n =3D 0; n < 8*sizeof (long); n++)
=09=09for (i =3D 0; i < 1000000; i++)
=09=09=09c =3D fns(buf[i], n);
=09return 0;
}

You are also hitting the random number generator.
It would be better to use a predictable sequence.
Then you could, for instance, add up all the fns() results
and check you get the expected value.

With a really trivial 'RNG' (like step a CRC one bit) you
could do it inside the loop and not nee a buffer at all.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


