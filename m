Return-Path: <linux-kernel+bounces-234315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E9991C521
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C6E31F24422
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0831C0DF0;
	Fri, 28 Jun 2024 17:46:01 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADF153561;
	Fri, 28 Jun 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596761; cv=none; b=FBpWIx4eS26MMeLl3mMWsYUGz6nL23kuvn0rV4wtVYQFu1fcjkKL5JynB0iRy4Ymt1AoerRak28i7t314OrcY7c/Q/hYtc1ZGUs1UKf453vHRplSxLB9FCk9jmZHvNFJZuq3CC70ylauEO0M+s9FCqWP8NDWrKL/B2IOKWrymsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596761; c=relaxed/simple;
	bh=dS4es04tRYOZvf4zDFdFl25ye6JoEREx0hlNLrRlOP4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=a3/kKdXOeMSHteHgb6mkVFbg4qcsnVBDLKNawk66BgZyJOx6W2MOykcCB7uwzNyvzPFMxzVtx0SEpWEnAHww66BHDYUU3czaMxy8O9jZGZyvpcnCFlYrpKMNabd9XpCcRF88CN4QVsMY30NHVKvPoltTb8KotU46iqrbyAVHO/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 7147F5444;
	Fri, 28 Jun 2024 19:45:50 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jun 2024 19:45:50 +0200
Message-Id: <D2BU69BDUOL0.63A7T034CORP@kernel.org>
Cc: "Conor Dooley" <conor@kernel.org>, "Erez Geva" <erezgeva@nwtime.org>,
 <linux-mtd@lists.infradead.org>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Erez" <erezgeva2@gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR
 chip
X-Mailer: aerc 0.16.0
References: <20240628140328.279792-1-erezgeva@nwtime.org>
 <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud>
 <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
 <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>
 <D2BT0DT9UQ66.2L497FSY7GMAL@kernel.org>
 <CANeKEMO9hBhBs91nZkZRht9J29iRC2Tgf6ucWq=nbO7XAqzzng@mail.gmail.com>
In-Reply-To: <CANeKEMO9hBhBs91nZkZRht9J29iRC2Tgf6ucWq=nbO7XAqzzng@mail.gmail.com>

> What is the kernel policy regarding obsolete flash chips?
> Macronix annonce on end of life of mx25l12805d in 2010.

Which doesn't mean there are no boards using it. But EOL in 2010
might be a strong argument to remove it. But I don't see the need
for it, yet.

> > Also please have a look at
> > https://docs.kernel.org/driver-api/mtd/spi-nor.html
>
> The new mx25l12833f supports SFDP, the obsolete mx25l12805d does not.
> I did manage to read the SFDP, though I do not have a copy of it (I do
> not have the hardware any more).

So how would you test newer versions of this series?

> To my best knowledge SFDP table do not contain information on OTP,

That's true, but we need it to detect flashes during runtime in the
future. Imagine sometime later, there's a third flash with this
exact ID, then we need to have the SFDP to figure out if there are
any differences between yours and the new one.

-michael

