Return-Path: <linux-kernel+bounces-234171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E7291C31F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 18:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2217E1C22BF7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9471C8FBD;
	Fri, 28 Jun 2024 16:04:59 +0000 (UTC)
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCB1C688C;
	Fri, 28 Jun 2024 16:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719590699; cv=none; b=NtvVcQThn3RgyvBnotNNpB/KMCuyUnCCR5UpFNPCM+Dfi5fvi2IDKTJi9X+osMMQtz/zlrs9E035kuULM43vNBsbPQ5dfDM32INzhPHjXO95nAl6KcL3lAYENr2QGiOkCGQNeJGitRiUZ1M2S4L7QTwmlbyn7nFWEBrAaG89rlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719590699; c=relaxed/simple;
	bh=QLstFpjHxHGYOSl572DYPanLUWr4F8cpkP6emzx8uRM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=CM+MdLequIAFgTpYnJxRWChQWKKzaEJZ1lf5WOolCgI24m5Sey+wzzrBJ97AAnlIZ67ctlps34IH6KyAX1totgHZZ4aGlGN6YBVnfXVo6pnPHXFyNf0rbL6kYJxSZH76BiCuQTablEiG5oU02Ar3EsCcoJ5kWzFJlD9DrXU0L2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id B85AE542F;
	Fri, 28 Jun 2024 18:04:53 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Jun 2024 18:04:52 +0200
Message-Id: <D2BS0YMA48BG.1PEPFC3KMFV8N@kernel.org>
Cc: <linux-mtd@lists.infradead.org>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "Pratyush Yadav" <pratyush@kernel.org>,
 <linux-kernel@vger.kernel.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "Richard Weinberger" <richard@nod.at>,
 "Vignesh Raghavendra" <vigneshr@ti.com>, <devicetree@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Erez Geva" <ErezGeva2@gmail.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Conor Dooley" <conor@kernel.org>, "Erez Geva" <erezgeva@nwtime.org>
Subject: Re: [PATCH 3/4] dt-bindings: mtd: macronix,mx25l12833f: add SPI-NOR
 chip
X-Mailer: aerc 0.16.0
References: <20240628140328.279792-1-erezgeva@nwtime.org>
 <20240628140328.279792-4-erezgeva@nwtime.org>
 <20240628-refuse-actress-b76985aa020c@spud>
In-Reply-To: <20240628-refuse-actress-b76985aa020c@spud>

Hi,

On Fri Jun 28, 2024 at 5:57 PM CEST, Conor Dooley wrote:
> On Fri, Jun 28, 2024 at 04:03:27PM +0200, Erez Geva wrote:
> > From: Erez Geva <ErezGeva2@gmail.com>
> >=20
> > Add Macronix SPI-NOR mx25l12833f.
> >=20
> > Signed-off-by: Erez Geva <ErezGeva2@gmail.com>
>
> Should the email in here and in the From: field be your nwtime one?
> Otherwise
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Actually, you're not supposed to add any compatibles to this list.

From the binding:
    description:
      SPI NOR flashes compatible with the JEDEC SFDP standard or which may =
be
      identified with the READ ID opcode (0x9F) do not deserve a specific
      compatible. They should instead only be matched against the generic
      "jedec,spi-nor" compatible.

I presume the Macronix flash does support the read id opcode.

-michael

