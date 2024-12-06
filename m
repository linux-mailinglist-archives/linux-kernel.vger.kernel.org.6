Return-Path: <linux-kernel+bounces-435075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415AB9E6F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4979C16251B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC9B20765B;
	Fri,  6 Dec 2024 13:24:59 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7B1FCD11
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 13:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733491499; cv=none; b=nGSZIWkXlwgN2FoisjuCVTpbr27XjYBufFCvPyUDaWGj6Nu4fPdp9Vqm8XbuZmmzy1PqlSdk0g0u4eRLFD6XMKfBLViA4o/A+G7yCnU/fqFc8f0ai1xODjeawJmTjKLCOYtU/2oMWslEVTJp/awczCiWPkrPz/AMgH5ONWI7fn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733491499; c=relaxed/simple;
	bh=mrp7r4AkFKtw74uF7gQtHscRnzFlm1VOf+r28ozKMCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Lez2kzZ6SniXOuqz2VMntaZh5BRC5kqHEssnFkRPhUSa5NMGxF4ResUVPX4a1POeNKSGaDQ7DoNlLfmzaz9NvSP7oLpDUxLJrvF+92GFHZfZFBQDh+SXC468zNcgoClyV3fN4HgKdhZDqp7Cz6afZi48Nl+NVGwNTv+PXAyp8bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-95-ndEInTIePlWej-prePKPpA-1; Fri, 06 Dec 2024 13:24:55 +0000
X-MC-Unique: ndEInTIePlWej-prePKPpA-1
X-Mimecast-MFC-AGG-ID: ndEInTIePlWej-prePKPpA
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 6 Dec
 2024 13:24:09 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 6 Dec 2024 13:24:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Thread-Topic: [PATCH v1 1/4] iio: afe: rescale: Don't use ^ for booleans
Thread-Index: AQHbRezm1jhKv1T7YkOoxbKwnK16YbLZNdEg
Date: Fri, 6 Dec 2024 13:24:09 +0000
Message-ID: <88f281a31d8342c691b2a6b2666d4e91@AcuMS.aculab.com>
References: <20241204013620.862943-1-andriy.shevchenko@linux.intel.com>
 <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241204013620.862943-2-andriy.shevchenko@linux.intel.com>
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
X-Mimecast-MFC-PROC-ID: TrDPlY2OYCzLLLnVJeL1XSYitXpPC6Ab5ohjw8LVaVM_1733491494
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Andy Shevchenko
> Sent: 04 December 2024 01:33
>=20
> There are two (non-critical) issues with the code. First of all,
> the eXclusive OR is not defined for booleans, so boolean to integer
> promotion is required, Second, the u32 variable is used to keep
> boolean value, so boolean is converted implicitly to the integer.

Except there is no such thing as 'boolean' they are all integers.
And the compiler has to have some set of rules to handle the cases
where the memory that hold the 'boolean' doesn't have the value 0 or 1.

>=20
> All these are not needed when variable is defined as boolean to begin
> with and operations are replaced by simple !=3D and ||.
>=20
> Fixes: 701ee14da95d ("iio: afe: rescale: add INT_PLUS_{MICRO,NANO} suppor=
t")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/iio/afe/iio-rescale.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.=
c
> index b6a46036d5ea..470dd7d41b2a 100644
> --- a/drivers/iio/afe/iio-rescale.c
> +++ b/drivers/iio/afe/iio-rescale.c
> @@ -26,7 +26,7 @@ int rescale_process_scale(struct rescale *rescale, int =
scale_type,
>  =09int _val, _val2;
>  =09s32 rem, rem2;
>  =09u32 mult;
> -=09u32 neg;
> +=09bool neg;
>=20
>  =09switch (scale_type) {
>  =09case IIO_VAL_INT:
> @@ -95,7 +95,7 @@ int rescale_process_scale(struct rescale *rescale, int =
scale_type,
>  =09=09 * If only one of the rescaler elements or the schan scale is
>  =09=09 * negative, the combined scale is negative.
>  =09=09 */
> -=09=09if (neg ^ ((rescale->numerator < 0) ^ (rescale->denominator < 0)))=
 {
> +=09=09if (neg !=3D (rescale->numerator < 0 || rescale->denominator < 0))=
 {

That is wrong, the || would also need to be !=3D.
Which will all generate real pile of horrid code.
(I think the x86 version will stun you.)

I'm guessing that somewhere there is a:
=09neg =3D value < 0;

Provided all the values are the same size (eg int/s32), in which case:
=09neg =3D value;
...
=09if ((neg ^ rescale->numerator ^ rescale->denominator) < 0)
will be the desired test.

=09David

>  =09=09=09if (*val)
>  =09=09=09=09*val =3D -*val;
>  =09=09=09else
> --
> 2.43.0.rc1.1336.g36b5255a03ac
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


