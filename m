Return-Path: <linux-kernel+bounces-304149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09105961B0E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 02:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032EA1C20995
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4525511CA0;
	Wed, 28 Aug 2024 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrO+nI86"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8583F17C7C;
	Wed, 28 Aug 2024 00:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724804462; cv=none; b=dVBImi/uP4aJpcnhyuDWQJkFIn2vLDCWQ8aLbTGjoUBFeLD+28EdkYD5eLOmYWTxLGWLDawX5s7pCQeNJ+gD+LMwO0B/xyZIG//lUxWNd4wUdAI0OKcif/70jume/cvsRTm/kyxH+kXCckTXLUK4AIweWdvpJQHXRvSo6fAyh1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724804462; c=relaxed/simple;
	bh=+JyIfjGGfDW08CZFv38NnHyCIwmkiulk74kjYBuxnJ8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FUbS9UO23va53/nw4QOesxxieausdniDMJEfJK72MnitfrdRwNpfE4KRwBPRZVcT6x7YSHlXvrXRek8ktIuyHsarmjxCvldN79cPsfUK9n7S8nJLt00Ek+VuSEaMQR/5FoTrAAyiBTizghMSqGcpG4Qw3I10l3S7A3h9K9B2rLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrO+nI86; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09599C4E695;
	Wed, 28 Aug 2024 00:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724804462;
	bh=+JyIfjGGfDW08CZFv38NnHyCIwmkiulk74kjYBuxnJ8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=VrO+nI86oF3O8hu6jd7ApoDjDaMDwom23SKOd/DArDxvTWRKCz2OHApWqwCJ1ap/T
	 G4EkzM7XHPRqVjz7jjIGwxfiUhKvcaSQSiLC1flipsnkH5QX1r+aBCf2HlnB1CU6QS
	 LAIIc/EHsz/BOg+QAjroBJajmF9avYkatTuV39pkRHfhaYOUM3oo6kf2YqC84RiX/I
	 gEI41jpGdU3tprDrK2/awnOqLKR1aC8DMpaXt4SMoGYzjUND/ZLJ7z/XHt5QoXCPpg
	 xAdAsdlcntLHHiMc+R7PREJjsYmi4gKqLf1nQSvjxX5CXDFc9zR1wooYKJOlqKcoph
	 zT8J9kGITWOmw==
Message-ID: <3e782ac88cc28fb5fa7ed71e7573e60f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240822161452.1780149-2-andriy.shevchenko@linux.intel.com>
References: <20240822161452.1780149-1-andriy.shevchenko@linux.intel.com> <20240822161452.1780149-2-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/2] clk: x86: lpss-atom: Use predefined constants from units.h
From: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 27 Aug 2024 17:21:00 -0700
User-Agent: alot/0.10

Quoting Andy Shevchenko (2024-08-22 09:14:07)
> diff --git a/drivers/clk/x86/clk-lpss-atom.c b/drivers/clk/x86/clk-lpss-a=
tom.c
> index aa9d0bb98f8b..c70088be72d1 100644
> --- a/drivers/clk/x86/clk-lpss-atom.c
> +++ b/drivers/clk/x86/clk-lpss-atom.c
> @@ -12,20 +12,24 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/x86/clk-lpss.h>
>  #include <linux/platform_device.h>
> +#include <linux/units.h>
> =20
>  static int lpss_atom_clk_probe(struct platform_device *pdev)
>  {
>         struct lpss_clk_data *drvdata;
>         struct clk *clk;
> +       u32 rate;

Do we need a local variable?

> =20
>         drvdata =3D devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL=
);
>         if (!drvdata)
>                 return -ENOMEM;
> =20
> +       /* Default frequency is 100MHz */
> +       rate =3D 100 * HZ_PER_MHZ;
> +
>         /* LPSS free running clock */
>         drvdata->name =3D "lpss_clk";
> -       clk =3D clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL,
> -                                     0, 100000000);
> +       clk =3D clk_register_fixed_rate(&pdev->dev, drvdata->name, NULL, =
0, rate);

This should be a one line patch.

>         if (IS_ERR(clk))
>                 return PTR_ERR(clk);
>

