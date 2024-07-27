Return-Path: <linux-kernel+bounces-264011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8731693DDDA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1734F1F22189
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447E242AA9;
	Sat, 27 Jul 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Uv/cFNi2"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF06381BE
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722070245; cv=none; b=TEqauSWIQbQg82bgU7mGm26/af9dvzQFQcjkD1W4UA7+fhO0+ajiHpikPfZO8uJdnkG1jWWpNHrdt9UzFVpht9U8zroCX1nOD+/IodBVxuaLxlUk84hvD9Sq+1b5BXJDTZjwPTZ4ZmLZAw4+5cOBL0d2PeRwKKmbPgAASqu3c8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722070245; c=relaxed/simple;
	bh=Xsqk0n6ScgrN4MlGX7T/sHpD+Oj95pPo2bugXfZvZvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+HpU9q9mskNPUjvLPQtjcVqNrKveGZ3CIzHP8Lln1plio2xzxIPBUlygQyT3eKJtuzfJNcPpDVoYww0NXml2a5KA8EsqX2t7c0d5MOaHXl8rvp/gaMTjZeRGyTuyjhZ9yib+XrS/YrownTL1GGR9dCYLxzAFKgqhG7TdiELKvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Uv/cFNi2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722070231;
	bh=Xsqk0n6ScgrN4MlGX7T/sHpD+Oj95pPo2bugXfZvZvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uv/cFNi2kF7Ml+mO9b7wTtIwK61pZHx03tiDHpo6EwGzU+bL2ky+Akpk5Gexe1AoG
	 4vltQ3mumSR8lxZ3HHXMuL6lo+hG7Gr8V+XaYQMNS4PF+1fznwA9NHC0SyQBPk+arm
	 mUbLrU2GrPW3vYEQbHczaLrsMhfzOnuvq6tn7PSU=
Date: Sat, 27 Jul 2024 10:50:30 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: add stdbool.h header
Message-ID: <4bdae1cf-ad18-4d16-b6cb-8f4e8adab867@t-8ch.de>
References: <20240725-nolibc-stdbool-v1-1-a6ee2c80bcde@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240725-nolibc-stdbool-v1-1-a6ee2c80bcde@weissschuh.net>

On 2024-07-25 19:10:44+0000, Thomas Weißschuh wrote:
> stdbool.h is very simple.
> Provide an implementation for the user convenience.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  tools/include/nolibc/Makefile  |  1 +
>  tools/include/nolibc/nolibc.h  |  3 ++-
>  tools/include/nolibc/stdbool.h | 16 ++++++++++++++++
>  3 files changed, 19 insertions(+), 1 deletion(-)

<snip>

> diff --git a/tools/include/nolibc/stdbool.h b/tools/include/nolibc/stdbool.h
> new file mode 100644
> index 000000000000..709abed93425
> --- /dev/null
> +++ b/tools/include/nolibc/stdbool.h
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
> +/*
> + * Boolean types support for NOLIBC
> + * Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
> + */
> +
> +#ifndef _NOLIBC_STDBOOL_H
> +#define _NOLIBC_STDBOOL_H
> +
> +#define _Bool bool

For the record:

The claim "stdbool.h is very simple" didn't hold up very well.
I managed to switch up this #define.
I'll fix it up when applying.

> +#define true 1
> +#define false 0
> +
> +#define __bool_true_false_are_defined 1
> +
> +#endif /* _NOLIBC_STDBOOL_H */

