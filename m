Return-Path: <linux-kernel+bounces-196424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524E48D5BBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:45:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F314E28258D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FEB7441A;
	Fri, 31 May 2024 07:45:27 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E16D187575
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141527; cv=none; b=iBBzqKD0l4csZ9wWFfz9fwyFfKQl6+9QG7qpYQ4BTnomJMnQ60pRxyAiJuEqyclWeORFHxMpjVPVgI6/vnoX9H9+haUo3tghfpEVq0f7sSqXDMZDZExPTG51k1Uib3TvrESjxUrb0PdCYrKdsXd8tIhkPkyPIhVf//Vw7hCFbl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141527; c=relaxed/simple;
	bh=3hxTqPHa+3uT3qalG6S62+LU3FmNytJEHI1pZQn/Ln0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dqDwlRb4ghN2bnBE1Pf72nNB1wOMA2lCGFt/tnP90h509QxBnAHHHm7/PwwCTnvyKa/dC4duDT1lbZK+f0TaxQO23xzR+ycgJumThtcur42Vx97vrLk/2QC0SgNreoKM9aUJL4y0Z4UH57nsQpPXtvkwOBC3KhU7plWg8kuAYVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-62a145e0bb2so16704137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:45:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717141523; x=1717746323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzYlvKg62KG4Y2Kc1f8OI9fT+ZIiT1F2JGmXChS17WE=;
        b=jOJqhnacMtoGYQYkgX0S1/jrRRMF7vVgdK4mHXlr/reP+gTUnZeZSQJfdNsN1xT8X8
         q6rcKaChrscm+qslnUndrK/FV3a8FBBw6dCtVrCd8T72rsilQBg/UHWM9FRtL4WDAy4Q
         0rtTmrt9t2BCmRFOWFYeWd8BiCbLI1PF8eu1aDKMJW4SrajwawhWypvDRuwDsXBhR3ze
         aC8U+sV7xUOsk6h+sZPT3cpcVTbKb2GcBofzcOGRv0CXRnA8vdum6zC74DkC/1jMsxhw
         CSMk2kRKnjB0TxFwc4YWngpyHPPssQPuPdCm5QW+IeVMQq+SkJ7X1LaGYZtR7ZXNJkxk
         f2nA==
X-Forwarded-Encrypted: i=1; AJvYcCUEcFNpi4dR4KmwAH1bWLp/IGqWjJy5DwtirSg/RG7knk/+THdGX6ILIDtky7hG/hYm6ypXGXOBHISmuHI/PgiH1JixWd3HxEb+HxGM
X-Gm-Message-State: AOJu0YwtEeMc/Wa7kJbLRex9AhHWcjm/I0KYPekLxVyR5287yn8Msstl
	YTTKXJ0dCy0whFfLvyf+dVopYLiwxHF6xdZGq2JAWX6ptA8Xvv6ll5vW9zhx
X-Google-Smtp-Source: AGHT+IHdBapNqY1DrYfBOrpyWnN9qK3iuLsvzgqnPjScaKDPlmLW4Ox9TWpsaNKu9Rp5fCvD8wkC1g==
X-Received: by 2002:a0d:c242:0:b0:61a:e48c:38b7 with SMTP id 00721157ae682-62c797ef625mr10175487b3.41.1717141523392;
        Fri, 31 May 2024 00:45:23 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c7667dbf8sm2429737b3.77.2024.05.31.00.45.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 00:45:23 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfa5b9274feso1949137276.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 00:45:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVXvJUUzPzP7UkB69RrG40M0/au7Ht0v0RiZQLuEzYGGBOptv1ZOtIuKDSZxmkPrUjyfV3TX+JCmyyDui+CyuuBKCxNURY4gVtB2M+b
X-Received: by 2002:a25:d3ce:0:b0:de6:154b:5835 with SMTP id
 3f1490d57ef6-dfa73c43dcemr1140786276.26.1717141522447; Fri, 31 May 2024
 00:45:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 May 2024 09:45:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
Message-ID: <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: andy@kernel.org, tzimmermann@suse.de, ojeda@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, May 31, 2024 at 7:28=E2=80=AFAM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> Like we do for charlcd, allow the configuration of the initial message
> on line-display devices.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Thanks for your patch!

> --- a/drivers/auxdisplay/line-display.c
> +++ b/drivers/auxdisplay/line-display.c
> @@ -8,7 +8,9 @@
>   * Copyright (C) 2021 Glider bv
>   */
>
> +#ifndef CONFIG_PANEL_BOOT_MESSAGE
>  #include <generated/utsrelease.h>
> +#endif

The #ifndef/#endif is not really needed.

>  #include <linux/container_of.h>
>  #include <linux/device.h>
> @@ -312,6 +314,12 @@ static int linedisp_init_map(struct linedisp *linedi=
sp)
>         return 0;
>  }
>
> +#ifdef CONFIG_PANEL_BOOT_MESSAGE
> +#define LINE_DISP_INIT_TEXT CONFIG_PANEL_BOOT_MESSAGE

So the user has to add extra spaces at the end when needed.
This makes sense, as they are not always needed (e.g. when the length of
the message matches the display size, no scrolling is needed/wanted).
I have verified that Kconfig actually preserves such spaces.

Nit: this is the only definition having an underscore between "line"
and "disp".

> +#else
> +#define LINE_DISP_INIT_TEXT "Linux " UTS_RELEASE "       "
> +#endif

I'd rather move this up, next to the other definitions at the top of
the file.

> +
>  /**
>   * linedisp_register - register a character line display
>   * @linedisp: pointer to character line display structure

As I see no real deficiencies:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

