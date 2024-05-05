Return-Path: <linux-kernel+bounces-169164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8148BC410
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 23:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECB1B21501
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 21:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C33136E04;
	Sun,  5 May 2024 21:50:31 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2C6EB7E
	for <linux-kernel@vger.kernel.org>; Sun,  5 May 2024 21:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714945831; cv=none; b=iH5VKBRk07LfGnxUo3EnETzYRxn8HzPQd7sQtpv/kg+3/PBrIc3fYwUGbKyIjW+CWb84MsNOW92aHYYLgHYJybHEQFS/wWatILwLctR5au7ET9/NGgLSwSfq6rMtACHWM+vp4k/dZEn86a+2v5q8iPivYtmVqw54yBSbzd8/03Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714945831; c=relaxed/simple;
	bh=4x09+TgtkiavXWB8WSF924E+mUO2753WTTrEYG/x2cc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K6AAfbpQGB1PQkTX5X9Y1Nt5SoMDIdMWf5vY4NNTTJOF4TLAAQDGcSHNUypMnKP7g3UAMWp0rMFE9jbwEAiPrGQq4iML5M+wpoF9+oU+G9KqmyNMWEEA6LHDt2tDpQTBbA8gvlS/4cOUlQRnFQ2eXk6nhZ/DZi0YCoJQfyfyaC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-156-34HP07sTNbyigNAagLM0zQ-1; Sun, 05 May 2024 22:50:20 +0100
X-MC-Unique: 34HP07sTNbyigNAagLM0zQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 May
 2024 22:49:44 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 May 2024 22:49:44 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yury Norov' <yury.norov@gmail.com>, Kuan-Wei Chiu <visitorckw@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
	"n26122115@gs.ncku.edu.tw" <n26122115@gs.ncku.edu.tw>,
	"jserv@ccns.ncku.edu.tw" <jserv@ccns.ncku.edu.tw>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Thread-Topic: [PATCH v4 1/2] lib/test_bitops: Add benchmark test for fns()
Thread-Index: AQHam+S8XBnnR43Z8kaIhRcpvR0+crGIoopwgAB+UQOAABDgEA==
Date: Sun, 5 May 2024 21:49:44 +0000
Message-ID: <9108af3e10234c49b6452df245ad3250@AcuMS.aculab.com>
References: <20240501132047.14536-1-visitorckw@gmail.com>
 <20240501132047.14536-2-visitorckw@gmail.com>
 <ZjJt9w2mvdm2P+dM@yury-ThinkPad>
 <62fdb348791949c08e53936e3bc442b5@AcuMS.aculab.com>
 <ZjfUbqyYTrVR8E6p@visitorckw-System-Product-Name>
 <ZjfumT3gv9rzFBxw@yury-ThinkPad>
In-Reply-To: <ZjfumT3gv9rzFBxw@yury-ThinkPad>
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

..
> He also chose to use random numbers to feed the fns(), and that's a
> reasonable choice. I see nothing wrong in his approach with the array,
> as well as what you proposed. But the test is done, and it works. If
> you think it's worth testing the function with your approach, feel
> free to submit your test, I'll take it just as well, and we'll have
> even better coverage.

Accessing a very large array is going to be affected by cache line
and TLB misses.
It wont really be entirely affected by implementation of the
function itself.
This is especially relevant for something that does really apply
to large memory blocks.

OTOH you don't want to repeatedly call the version that used
a binary chop with constant data - the branch predictor
will learn the pattern instead of getting if wrong 50% of the time.

A compromise would be to repeatedly process a short random
buffer enough times to get something measurable.
Although it is perfectly possible to use a cycle counter
(but not the x86 TSC) to time single function calls and
get repeatable answers that can actually be compared to
calculated values.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


