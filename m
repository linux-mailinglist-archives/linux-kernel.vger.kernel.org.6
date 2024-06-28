Return-Path: <linux-kernel+bounces-234238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E591C425
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA46E1C21162
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952BF1CB303;
	Fri, 28 Jun 2024 16:51:13 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89336D2E5;
	Fri, 28 Jun 2024 16:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719593473; cv=none; b=dM3yXq8O1hdP0czlQ/Kke/zrsky7Lcjrjl0VPt52lWzm8DQlgvjHXSygLZNSnJANql6YIPmbkKReakzeecm9LnqG9osYyZUdvUY+OY7UkAmiEnn5AoI8EsVawpMRy7262JGcPVN1vfn6HaqCabMCdj9F3AJKWNRDbH7007Xw7FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719593473; c=relaxed/simple;
	bh=vuiLWhFs/4dgSOcAzxk+VPRyXw33EbyQ0Ll/O8Trnk4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=kQi4v2GQqUPo0obzDovX6VM4dLMcvwpXtnUvKRH+Y3jZ0b9HvHsAIAK0S7WcGetwrb6WpT23d/hXgsPvx84lNKDlByrx8edCVG4o2Gzvc2IJgF9BOTZH/hnCWb9NcHTedGn6ZwWmSNlTLTwuubZputykF4VcRWDmmuEQkUnk8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 1B01D144A;
	Fri, 28 Jun 2024 18:51:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jun 2024 18:51:08 +0200
Message-Id: <D2BT0DT9UQ66.2L497FSY7GMAL@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR
 chip
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
X-Mailer: aerc 0.16.0
References: <20240628140328.279792-1-erezgeva@nwtime.org>
 <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud>
 <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
 <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>
In-Reply-To: <CANeKEMMrXK=mw=n=9DuTnprkTs3ct446oaC2QTJyst8Nd+D6rw@mail.gmail.com>

On Fri Jun 28, 2024 at 6:30 PM CEST, Erez wrote:
> I do not know why they decided to use the same JEDEC ID for two chips.
> Your guess is as good as mine.

That's a common pattern and we try hard to figure that out during
probe time instead of hardcoding it. E.g. by looking at the SFDP
data. Have a look at various fixups in drivers/mtd/spi-nor/.

compatibles are really the last resort to distinguish flash devices.

Next time, please mention such information in the commit message,
please.

Also please have a look at
https://docs.kernel.org/driver-api/mtd/spi-nor.html

-michael

