Return-Path: <linux-kernel+bounces-433614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0769E5A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116E516656E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 16:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B16224AEB;
	Thu,  5 Dec 2024 16:00:24 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC10C14884D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733414424; cv=none; b=C3zEzZt9tOg5ld1AufeadQO4DmqiPTG0Mt7jLTuLa2xWMdhawgarFT0YomPsDmPD7U/ijOBecUYV1gwvWtuMwaafXb21Gzn6BVqr/C7wVsjjx2uzQGArETNEIHR6aYetQWVaKmOZQGiNeDqV1IuPhZ0sGEWeqfOsleNZlh2uCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733414424; c=relaxed/simple;
	bh=AXRLyPnlMp9NFNYGxxbppZ4FKyyl2/ZDxFwMNPYVYNI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=WI/MMOJ/KP7Ahbqpco9HrmekxiAalFjfOO034ghPF5Z++D/I1fazwI+VKDZU3cbsqkRbbiLkftNR0XBl9dJ1qWN4g7fVx1eUZdwMd2oF4swVJ4drZB1EE3UkXtp3iwhRSIEtk7++Gyl3l35qTK7HynPhM5arjZ2vSaNlsrxf7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-279-lmsYNeUrOlaLvsVDlHEuig-1; Thu, 05 Dec 2024 16:00:19 +0000
X-MC-Unique: lmsYNeUrOlaLvsVDlHEuig-1
X-Mimecast-MFC-AGG-ID: lmsYNeUrOlaLvsVDlHEuig
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 5 Dec
 2024 15:59:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 5 Dec 2024 15:59:36 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Naresh Kamboju
	<naresh.kamboju@linaro.org>
CC: open list <linux-kernel@vger.kernel.org>, "lkft-triage@lists.linaro.org"
	<lkft-triage@lists.linaro.org>, Linux Regressions
	<regressions@lists.linux.dev>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, "netfilter-devel@vger.kernel.org"
	<netfilter-devel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Anders
 Roxell" <anders.roxell@linaro.org>, Johannes Berg <johannes.berg@intel.com>,
	"toke@kernel.org" <toke@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	"kernel@jfarr.cc" <kernel@jfarr.cc>, "kees@kernel.org" <kees@kernel.org>
Subject: RE: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
Thread-Topic: arm64: include/linux/compiler_types.h:542:38: error: call to
 '__compiletime_assert_1050' declared with attribute error: clamp() low limit
 min greater than high limit max_avail
Thread-Index: AQHbRyiOROIHG94lCEKLQVwMYBVLZbLXxsYA
Date: Thu, 5 Dec 2024 15:59:36 +0000
Message-ID: <68a3ca49c2644af5b2995038ca88a51b@AcuMS.aculab.com>
References: <CA+G9fYsT34UkGFKxus63H6UVpYi5GRZkezT9MRLfAbM3f6ke0g@mail.gmail.com>
 <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
In-Reply-To: <8dde5a62-4ce6-4954-86c9-54d961aed6df@stanley.mountain>
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
X-Mimecast-MFC-PROC-ID: WgtWQ5GiYDXQTnU6lWxj0INlljMHPNs9ReLqkERBR4A_1733414417
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: 05 December 2024 15:16
>=20
> Add David to the CC list.

I've been forwarded this one before.
It is not unreasonable really.

Is all stems from order_base_2(totalram_pages()).
order_base_2(n) is 'n > 1 ? ilog2(n - 1) + 1 : 0'.
And the compiler is generating two copies of the code.
(Basically optimising for the zero case.)
And the one for totalram_pages() being zero hits the check in clamp().

Flipping to clamp(max_avail, min, max) will stop it bleating.

More interesting would be 'launder' the 0 in order_base_2().
By adding something like:
#define optimiser_hide_val(x) ({ \
=09__auto_type(_x) =3D (x); \
=09optimiser_hide_var(_x); \
=09_x; \
})
and change order_base_2() to be:
=09n > 1 ? ilog2(n - 1) + 1 : optimiser_hide_val(0);
(ISTR there is a split for constant v non-constant before then.)

=09David

>=20
> regards,
> dan carpenter
>=20
> On Thu, Dec 05, 2024 at 08:15:13PM +0530, Naresh Kamboju wrote:
> > The arm64 build started failing from Linux next-20241203 tag with gcc-8
> > due to following build warnings / errors.
> >
> > First seen on Linux next-20241203 tag
> > GOOD: Linux next-20241128 tag
> > BAD: Linux next-20241203 tag and next-20241205 tag
> >
> > * arm64, build
> >   - gcc-8-defconfig
> >   - gcc-8-defconfig-40bc7ee5
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Build log:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > net/netfilter/ipvs/ip_vs_conn.c: In function 'ip_vs_conn_init':
> > include/linux/compiler_types.h:542:38: error: call to
> > '__compiletime_assert_1050' declared with attribute error: clamp() low
> > limit min greater than high limit max_avail
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
> >                                       ^
> > include/linux/compiler_types.h:523:4: note: in definition of macro
> > '__compiletime_assert'
> >     prefix ## suffix();    \
> >     ^~~~~~
> > include/linux/compiler_types.h:542:2: note: in expansion of macro
> > '_compiletime_assert'
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER_=
_)
> >   ^~~~~~~~~~~~~~~~~~~
> > include/linux/build_bug.h:39:37: note: in expansion of macro
> > 'compiletime_assert'
> >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                      ^~~~~~~~~~~~~~~~~~
> > include/linux/minmax.h:188:2: note: in expansion of macro 'BUILD_BUG_ON=
_MSG'
> >   BUILD_BUG_ON_MSG(statically_true(ulo > uhi),    \
> >   ^~~~~~~~~~~~~~~~
> > include/linux/minmax.h:195:2: note: in expansion of macro '__clamp_once=
'
> >   __clamp_once(type, val, lo, hi, __UNIQUE_ID(v_), __UNIQUE_ID(l_),
> > __UNIQUE_ID(h_))
> >   ^~~~~~~~~~~~
> > include/linux/minmax.h:206:28: note: in expansion of macro '__careful_c=
lamp'
> >  #define clamp(val, lo, hi) __careful_clamp(__auto_type, val, lo, hi)
> >                             ^~~~~~~~~~~~~~~
> > net/netfilter/ipvs/ip_vs_conn.c:1498:8: note: in expansion of macro 'cl=
amp'
> >   max =3D clamp(max, min, max_avail);
> >         ^~~~~
> >
> > Links:
> > ---
> > - https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gR=
ywrldKTyaXQoT/
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-
> 20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/log
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-
> 20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/details/
> > - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-
> 20241203/testrun/26189105/suite/build/test/gcc-8-defconfig/history/
> >
> > Steps to reproduce:
> > ------------
> > # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> > --kconfig defconfig
> >
> > metadata:
> > ----
> >   git describe: next-20241203
> >   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-=
next.git
> >   git sha: c245a7a79602ccbee780c004c1e4abcda66aec32
> >   kernel config:
> > https://storage.tuxsuite.com/public/linaro/lkft/builds/2pjAOE9K3Dz9gRyw=
rldKTyaXQoT/config
> >   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pj=
AOE9K3Dz9gRywrldKTyaXQoT/
> >   toolchain: gcc-8
> >   config: gcc-8-defconfig
> >   arch: arm64
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


