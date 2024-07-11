Return-Path: <linux-kernel+bounces-249928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FD92F1C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 00:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E2B1F21DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BAB1A00F7;
	Thu, 11 Jul 2024 22:13:53 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0BB42AB5;
	Thu, 11 Jul 2024 22:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720736032; cv=none; b=kErs0B/dkhh8nEFMC2fIq+3F9Du/58I4obxyn7XkVTW9EBeeCXR5lwWcmzRFV+y/QG7Lhif6acNKlK0d4wGKPX1wc0Bab6yGoSahjfdnNrkYLNQv2RWLWiQPCLaSimsiYxyvPNojVxA+s+wMx4DBstfdP8YgK1IR95OePJmtV4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720736032; c=relaxed/simple;
	bh=cHna4k26ioqiXPXuUKIMzpJZE3gkKYyiH7P4BVkC3Mk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=t28gJ2kj2gvdbwPAA/P6luwtpD1plgXF11Et58P9S3rp5DA8keBxlhw/RoAm3xq1CMYWkcdwh/io2JSUhiFzxrsco9KgJ0gErEZLAUOnVkNGNJAOdzG9lunX1bgqb+fetCSP8IF0CEjxIwsnZgwUS34cTJRSsd9dcrNmNVr3zBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id CE2D83A00;
	Fri, 12 Jul 2024 00:13:47 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jul 2024 00:13:45 +0200
Message-Id: <D2N20HB4BIC4.O13SZINCMJ9P@kernel.org>
To: "Erez" <erezgeva2@gmail.com>
Subject: Re: [PATCH v2 3/4] dt-bindings: mtd: macronix,mx25l12833f: add
 SPI-NOR chip
Cc: "Esben Haabendal" <esben@geanix.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Jaime Liao" <jaimeliao@mxic.com.tw>,
 <leoyu@mxic.com.tw>, "Alvin Zhou" <alvinzhou@mxic.com.tw>, "Julien Su"
 <juliensu@mxic.com.tw>, "Erez Geva" <erezgeva@nwtime.org>,
 <linux-mtd@lists.infradead.org>, "Pratyush Yadav" <pratyush@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
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
 <D2MZ405LVTN8.3LTVN3KTUD6A3@kernel.org>
 <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>
In-Reply-To: <CANeKEMNtXb4ZV7kcLbHY+Mti6dPV9UZ2wTyUq5z0qtmtNNqSVA@mail.gmail.com>

On Fri Jul 12, 2024 at 12:09 AM CEST, Erez wrote:
> On Thu, 11 Jul 2024 at 21:57, Michael Walle <mwalle@kernel.org> wrote:
> >
> > Hi Erez,
> >
> > No top posting please, see also
> > https://subspace.kernel.org/etiquette.html
>
> It was a single question. Which I think can be answered in one reply.
> In cases where there are different parts in the mail, it makes sense
> to avoid top posting.
> I do not believe we need to be pedantic.
> The guidance is not holy, it is aimed to make communication more comprehe=
nsive.
>
> >
> > On Thu Jul 11, 2024 at 8:57 PM CEST, Erez wrote:
> > > Yes, I think we should.

Regarding top posting, what was the question here?

I don't see any context. So don't expect any reply from me.

-michael

