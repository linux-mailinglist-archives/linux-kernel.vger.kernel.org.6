Return-Path: <linux-kernel+bounces-254874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFD9338C0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 10:16:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D7C1F23E42
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 08:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648CF225AF;
	Wed, 17 Jul 2024 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bUKZEbJf"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30356566A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204176; cv=none; b=XtTWZHxESYNkiOgcJK4xJFIAG/293zFsaQlGAn7dxBq2mhtzn0XmKmiLbRA4ujMW73m+q6VaUKFiGv+FxP8u89NqObbxkpgQ2xi/DolscIJG3O+Hoe5kcW/dxzlzC9aXg49xXUxyG6JuiN2NzalwqJdMATNGIXZrZUf8sFNEBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204176; c=relaxed/simple;
	bh=SKQ3eeI8Hz/8/EGMxUsxspaDogLJCgTQ52AxtRBP6m8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOj4iKZkVSAkbb6jDs11YtZWoPwXhllFt5KIsv3htrltZHaiQHE4bS5PyGi2EfGra5Mkgfq1TLYQRsrwmWc8dtUZ/Qu9slXqszLwoAHwu7hPY2wCYt53d/A9AxpbVUwHguUntjh1hSiRXidyk/Izo/LwJQE2CetbZ3VFgkvYXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bUKZEbJf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B3E3420008;
	Wed, 17 Jul 2024 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721204172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BO7Fy/QrnT1QJQqKob04tOemjYG1MLIYQ2dRjjYvVOo=;
	b=bUKZEbJfsOkFLzCmb2K0Sawv+n7Y7r+WhN5p1ayfFODIWZJmJ1jSWvJVDHy3m267aHUOp4
	7M6D6l20IOZdZBdN4LqqI0nIsy6UDzjr3WlnNkng8gPdYw0XQtrhZ5jWtwyMgI0BqGUYjn
	MWeIrUxL7kxolNnvuxm/wttQQsMT7y4CWblHi7kUTOF2p5eSz/2CH+nKIPcXz5UZz/cFeM
	MumZwBEBZQtl2mrEdtgnoIOGJXf98PKEqHIiOjqrFIPwNIS9hfxxeNEEItcLgqKly+8S8c
	yuVoiVEBI9zz7lHc5/xkdIv2xA+V0GZQJZ3Se+RcvW69pOnXxq7GYwdVvztBFA==
Date: Wed, 17 Jul 2024 10:16:10 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Cheng Ming Lin <linchengming884@gmail.com>
Cc: vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, richard@nod.at, alvinzhou@mxic.com.tw,
 leoyu@mxic.com.tw, Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: Re: [PATCH 0/3] Add fixups for two-plane serial NAND flash
Message-ID: <20240717101610.792a4a11@xps-13>
In-Reply-To: <20240710011541.342682-1-linchengming884@gmail.com>
References: <20240710011541.342682-1-linchengming884@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Cheng,

linchengming884@gmail.com wrote on Wed, 10 Jul 2024 09:15:38 +0800:

> From: Cheng Ming Lin <chengminglin@mxic.com.tw>
>=20
> Macronix serial NAND flash with a two-plane structure
> requires insertion of Plane Select bit into the column
> address during the write_to_cache operation.
>=20
> Additionally, for MX35{U,F}2G14AC, insertion of Plane
> Select bit into the column address is required during
> the read_from_cache operation.
>=20
> In spinand.h, add struct spi_nand_fixups as SPI NAND
> fixup hooks.
>=20
> In macronix.c, add fixup functions and update ID table.
>=20
> In core.c, add an if statement to determine whether to
> insert the Plane Select bit for the column address.
>=20
> These flashes have been validated on Xilinx zynq-picozed
> board which included Macronix SPI Host.
>=20
> Cheng Ming Lin (3):
>   include/linux/mtd/spinand.h: Add fixups for spinand
>   mtd: spinand: macronix: Fixups for PLANE_SELECT_BIT
>   mtd: spinand: Insert Plane Select bit for the column address

I believe patches 1 and 3 should be squashed and come before patch 2.

In general in your code, please avoid camelCase.

Finally, I am not convinced yet by this implementation, I don't know
what to propose yet, but I am not particularly in favor of adding such
hooks. Can you point to a datasheet (url and page) where I could get
more information?

>=20
>  drivers/mtd/nand/spi/core.c     |  7 +++++
>  drivers/mtd/nand/spi/macronix.c | 51 +++++++++++++++++++++++++++++----
>  include/linux/mtd/spinand.h     | 17 +++++++++++
>  3 files changed, 69 insertions(+), 6 deletions(-)
>=20


Thanks,
Miqu=C3=A8l

