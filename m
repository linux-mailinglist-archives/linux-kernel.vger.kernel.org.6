Return-Path: <linux-kernel+bounces-444512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C964E9F080D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF1E188B1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABD31B21B5;
	Fri, 13 Dec 2024 09:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="PaUn84Hx"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14A1B0F20
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734082685; cv=none; b=OxR/nE8JgOooxHbE+O4fuMqkB8ks3QDuBUyv9lmQmcaLQUYAcAGkezFIhotOA0H2tvkWh5ZcJugce0Xp7Izp1Rtxpal7WPlrcXS2UdIeZSll+okPDFlOkwLl0JvHNLdMR/9cPRraY3wfVLLmLVAiiKwVnchfdxfLcP/JBlAmnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734082685; c=relaxed/simple;
	bh=oQpzYtOejXAwIFbpnjsdqVXPeMH8rc28IecS7Aq9/50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jqg1PCplrD64STU+46R1l4w1iLPB2xCyJoigf0GR+WVx67erT9rvD0uaYnoOzQfIzUpUYDpOqZOk6LYolMXG/M6Hxxs6XquUsqiXYDMbdllK4SDNccNpvDo3zA2AGf00I2FV1ixKaebOTiaB5DiOs3yHmhNaDm2dQWrRjm2tjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=PaUn84Hx; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1734082682; x=1734341882;
	bh=oQpzYtOejXAwIFbpnjsdqVXPeMH8rc28IecS7Aq9/50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PaUn84Hxaqn47iGdI9O9vUWWLYCo3qHbJYGnyPgieIkfFAzOVaIocQjRaa+90DCnD
	 BjsWN9KIO+yUGx0PWfABY+ydOZCQLiAf5Kz6Euy0IzMbUbK0TaEHVhofPo2DdVkaEA
	 n+6SVrnSVtobLgJ1prtno3uoG+yoVjIyHf1gj20s9CG26xsoYdCJdb+B/53tMzcf8f
	 UcSMWD7IYxl3UwnPw/77DY5kGsV84ckHkbZWOcQXgsTdt8j/zg1CtTxr2dlBTTiCgV
	 5HQWfy0PX71LSSTlDd+LVq3kt9R6T04Gpg5lrAcGQDdronusNvxYg5L8kjGjnfWD2T
	 B7FXx5F26b3bA==
Date: Fri, 13 Dec 2024 09:37:55 +0000
To: Arnd Bergmann <arnd@kernel.org>
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, Nathan Chancellor <nathan@kernel.org>, "Everest K.C." <everestkc@everestkc.com.np>, linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: add module author and description fields
Message-ID: <MGy6QhNfv7Nkp5Z1jG8CBnrfIL7idxS2qFncLvVaWUaIETm6hpWlQ5le4wpmw5RtMZx7utyDvuAGg2aks7E9seY_umnTkGSdkzYL5oVBxhM=@protonmail.com>
In-Reply-To: <20241213083119.2607901-1-arnd@kernel.org>
References: <20241213083119.2607901-1-arnd@kernel.org>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 0c7a6274337e56c3497552b65fca9db309cf2ba4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, December 13th, 2024 at 09:31, Arnd Bergmann <arnd@kernel.org> wr=
ote:

>=20
>=20
> From: Arnd Bergmann arnd@arndb.de
>=20
>=20
> The FMH driver is still missing both, so take them from the comment
> at the start of the file.
>=20
> Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB dr=
iver")
> Signed-off-by: Arnd Bergmann arnd@arndb.de
>=20
> ---
> drivers/staging/gpib/fmh_gpib/fmh_gpib.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/g=
pib/fmh_gpib/fmh_gpib.c
> index 2ed286fa5d6e..0662b20a45e7 100644
> --- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
> +++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
> @@ -24,6 +24,8 @@
> #include <linux/slab.h>
>=20
>=20
> MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("GPIB Driver for fmh_gpib_core");
> +MODULE_AUTHOR("Frank Mori Hess fmh6jj@gmail.com");
>=20
>=20
> static irqreturn_t fmh_gpib_interrupt(int irq, void *arg);
> static int fmh_gpib_attach_holdoff_all(gpib_board_t *board, const gpib_bo=
ard_config_t *config);
> --
> 2.39.5

Reviewed-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@proton=
mail.com>

