Return-Path: <linux-kernel+bounces-309894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246D967196
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 14:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F4001C215E3
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CC417E003;
	Sat, 31 Aug 2024 12:40:20 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF0193
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725108019; cv=none; b=epxF0K+VypMqAIlVL2yJ/bFWRWu7dvEhS4UTRU80PQQCotGK+zkbQSUdjS+DkI/QfT8YdLKC9dlre/HWYVmEzJYn7JPkAwRDLPyjEPFMEEqWjf0EiW+QT8tJD+5JhxWNHosFBj1uaH0XP7TAEN4Y4FtnatNuEFCY0NZ6YQHo3Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725108019; c=relaxed/simple;
	bh=2uZQwCysczlevMbIXlt6PGWT0zeQq4JUP/rOE5wCCWI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=u5KWKJzuISGxOZGw4Pj34aHFJJXUr/+yWjZWxXI+YjegUq3r6QfNRMR1eJDXI5BTX9IMw5vdCFf9ArNLRWyteyuo66Y3AtjNzkWCbNaGTelPHnymAbz/l8PrvKzYZPoFL7gP/64mrELZL5bIWVoM5Cjfj50r4hShdEKy6aFWedM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-92-VIUI8HB7OHmUb0FuB2D6sQ-1; Sat, 31 Aug 2024 13:40:12 +0100
X-MC-Unique: VIUI8HB7OHmUb0FuB2D6sQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 31 Aug
 2024 13:39:28 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 31 Aug 2024 13:39:28 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Simon Horman' <horms@kernel.org>, Yan Zhen <yanzhen@vivo.com>
CC: "marcin.s.wojtas@gmail.com" <marcin.s.wojtas@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "opensource.kernel@vivo.com"
	<opensource.kernel@vivo.com>
Subject: RE: [PATCH v1] ethernet: marvell: Use min macro
Thread-Topic: [PATCH v1] ethernet: marvell: Use min macro
Thread-Index: AQHa+KqNGETvg8muuEmp3IGPwP4GwrJBUzyA
Date: Sat, 31 Aug 2024 12:39:28 +0000
Message-ID: <7cfe24b82098487e9b1d35f964bf652f@AcuMS.aculab.com>
References: <20240827115848.3908369-1-yanzhen@vivo.com>
 <20240827175408.GR1368797@kernel.org> <20240827175745.GS1368797@kernel.org>
In-Reply-To: <20240827175745.GS1368797@kernel.org>
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

From: Simon Horman
> Sent: 27 August 2024 18:58
>=20
> On Tue, Aug 27, 2024 at 06:54:08PM +0100, Simon Horman wrote:
> > On Tue, Aug 27, 2024 at 07:58:48PM +0800, Yan Zhen wrote:
> > > Using the real macro is usually more intuitive and readable,
> > > When the original file is guaranteed to contain the minmax.h header f=
ile
> > > and compile correctly.
> > >
> > > Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> > > ---
> > >  drivers/net/ethernet/marvell/mvneta.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethe=
rnet/marvell/mvneta.c
> > > index d72b2d5f96db..415d2b9e63f9 100644
> > > --- a/drivers/net/ethernet/marvell/mvneta.c
> > > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > > @@ -4750,8 +4750,7 @@ mvneta_ethtool_set_ringparam(struct net_device =
*dev,
> > >
> > >  =09if ((ring->rx_pending =3D=3D 0) || (ring->tx_pending =3D=3D 0))
> > >  =09=09return -EINVAL;
> > > -=09pp->rx_ring_size =3D ring->rx_pending < MVNETA_MAX_RXD ?
> > > -=09=09ring->rx_pending : MVNETA_MAX_RXD;
> > > +=09pp->rx_ring_size =3D min(ring->rx_pending, MVNETA_MAX_RXD);
> >
> > Given that the type of ring->rx_pending is __32, and MVNETA_MAX_RXD is
> > a positive value.
>=20
> Sorry, I hit send to soon. What I wanted to say is:
>=20
> I think that it is appropriate to use umin() here.
> Because:
> 1) As I understand things, the type of MVNETA_MAX_RXD is signed,
>    but it always holds a positive value
> 2) ring->rx_pending is unsigned

Provided MVNETA_MAX_RXD is constant it is fine.
umin() is only needed for signed variables that can only contain
non-negative values.

You only need to use it is the compiler bleats...

umin(x, y) is safer than min_t(unsigned_type, x, y) because you can't
get the type wrong.
If will also generate better code since it never sign extends a
32bit value to 64bits (expensive on 32bit).

=09David

>=20
> > See: 80fcac55385c ("minmax: add umin(a, b) and umax(a, b)")
> >      https://git.kernel.org/torvalds/c/80fcac55385c

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


