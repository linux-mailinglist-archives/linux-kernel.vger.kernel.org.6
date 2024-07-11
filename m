Return-Path: <linux-kernel+bounces-249801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0724492F005
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F6D81F21533
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5377519E82B;
	Thu, 11 Jul 2024 19:57:24 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1979B450FA;
	Thu, 11 Jul 2024 19:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720727843; cv=none; b=SVCcL/2YMlc4vQrFba5iXlib38LN90gP28MCCilsIFfWyRs/f8Plbzz9+kHmUGbkI6oSmC5onl0IpWLh1IgY5M+pV9IGBKGZo3m1hV8CKtyOzhqbbXVYXg3aMWGCp0yaLI1xD/VSnq4w6ksZymNX+og1ig7lrt/nbj7KU8K9Jos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720727843; c=relaxed/simple;
	bh=jKLIKzkKA3Yux1VKw/7LF7+AkuB0/6yE9JFIkqxZHvs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=VIqQyjvGCtI52ecySFHVGlEI9FgYS7kTxr+Y0wpwmRr/bfNCO5hW0SxsVGgb7y0/gtAc6SQSNWCBUM3htj7DKQ24Tz+pZuOqbQvvt53r4A5JOIvIwFQOMm6h7R1BdDk4VcxE36K/+owCarU1S7H3S/Hnon6wd302bhYnEX5PbNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id D28A739F8;
	Thu, 11 Jul 2024 21:57:18 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 21:57:18 +0200
Message-Id: <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
Cc: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Jaime Liao"
 <jaimeliao@mxic.com.tw>, <leoyu@mxic.com.tw>, "Alvin Zhou"
 <alvinzhou@mxic.com.tw>, "Julien Su" <juliensu@mxic.com.tw>, "Erez Geva"
 <erezgeva@nwtime.org>, <linux-mtd@lists.infradead.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <linux-kernel@vger.kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Erez" <erezgeva2@gmail.com>, "Esben Haabendal" <esben@geanix.com>
X-Mailer: aerc 0.16.0
References: <20240629103914.161530-1-erezgeva@nwtime.org>
 <20240629103914.161530-4-erezgeva@nwtime.org>
 <1c457520-07b7-4bde-b040-e8bca959a4f5@linaro.org>
 <CANeKEMOODBNZA6efh0E0Ga_KaVs5Y3WLcUftRhNwYHhnXO=GNw@mail.gmail.com>
 <CANeKEMO42rJt5Ob4_HDcZ3eEMvuMOPvRaFaLwL8SA65NtxSV7A@mail.gmail.com>
 <1d56c3b2-7adf-45b9-a509-956340f3f17b@linaro.org>
 <CANeKEMMe-Onpn7xWQHgWz1Ps_uQPEMa7HrKA00HpoKjG+DCJNQ@mail.gmail.com>
 <3bafcbea-6aa5-43ca-9d12-3916be3fe03d@linaro.org>
 <CANeKEMM02-Jvb8Pd0fZJFnRg-hsAW+hckYWm11tZZXNMPSPJ=w@mail.gmail.com>
 <9b45cc73-2251-4085-af95-7ccd00dd6d3b@linaro.org>
 <CANeKEMP+mRefYZNb+TuBmOD7dC6=7Rg7D1EcfnjJoiaeaV28SQ@mail.gmail.com>
 <875xtd48ps.fsf@geanix.com>
 <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>
In-Reply-To: <CANeKEMNJ3_ET5pQo2wg7_GSLX+vE+dqW-CV=v2DnG10xcgSdzQ@mail.gmail.com>

Hi Erez,

No top posting please, see also
https://subspace.kernel.org/etiquette.html

On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
> Yes, I think we should.
>
> Reading the specification provided publicly by Macronix.
> For all the JEDEC IDs with the no SFDP flag in drivers/mtd/spi-nor/macron=
ix.c
> All of them have a new version or a new chip with the same JEDEC ID
> that supports SFDP.
> There are 2 chips that Macronix does not provide spec. in public.
> I can ask Macronix technical support on these 2 chips.

We don't add flashes we cannot test.

-michael

