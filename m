Return-Path: <linux-kernel+bounces-214446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A499084B5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA2B1C222E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C447214885E;
	Fri, 14 Jun 2024 07:27:10 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B3A1474BC
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718350030; cv=none; b=QWCxLMqL6rAjN75+JHT5UKqDnu0VxFyRA4Am9isOOkSK8yg6bWTTJ3WgmVTDnl/OM30tS8vzLXkbuDdRNLhecC/zdvsi8iRh68WdXXGobAA5sUFwX3R4zG2jchdtJn8M5BJq8EZy4QnIIRE08XSdqKTqQPBUMw8dssL0wCSdvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718350030; c=relaxed/simple;
	bh=Cqj4d0kwFRq1hg1FkKe8Prs7jh1IqdC7dNUqMr0VaLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtUEiJi63UOmqZgVvdl3TJieLfb35WH5Vz2ZOIuUSLZE/ud3MP4ttlpOlyOyYkDOtYHKdBZqepOJvxFl+MJVJSdk1qotNE8T0jSznozOZAA+z4x0Wx0csS3/c2NrntlilLb7C9n1+jo5oLSJvvd5kJdbtGQs909A1mEbvlnI+IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso2031577276.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718350027; x=1718954827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bOhhydEb/pokB6Vjqx+FIu1ujuk/gkIge04R2bCG1hQ=;
        b=Ka9MEZ9rcsGfW//TkZsIsWX439wNWhouWC50VBjXOZqJu5Jw4dBTQhA1NLb8vS/137
         di507a5L6PpPmjby5Ef1LxBmmPIT4OK7v/bc7Ta9GlwTXgV+lTxXoEk5dyT1c/NmKP4o
         W2C/gryW0X85WQPuam7o9ZZgM52tbr/1ovW3Psb9rTtRf6k5Oidd4PLbryr9s/SOVoIW
         Y1UbB+NGmlPaPWGYWtvftbmDNhf6pQgUFn2tZj0OuzphUmGiqac4nFqMfttGF7zDAvCo
         ZTK7BNWb5fuJHA5Op67ahu7p1HqE/LQ1blXaHFgAF5Qu+8+DUhExazPBlptD/5o+vLRo
         qB3w==
X-Forwarded-Encrypted: i=1; AJvYcCUx5Hrzcfo2UyzC/NHJjPFgp5bwySYJhMW3FmhdPuKLW3KdWqbAuyGWXYFAbCXVF4XxvfEVStimynEBPjXZ87yfctlJ8tRmMF3aKekO
X-Gm-Message-State: AOJu0YzUqkQh7D86yiegZaqiuF7UGHmOlXr4YUw/Ml4n6p5PvkrUw3ho
	1XbXrZjI0YHC/8Hic0m9YGdxvUGcWtJKmRFZGoIR7JpbIGHEHYVKRRMqF/Ny
X-Google-Smtp-Source: AGHT+IFYcblDFxmHlCv8//2I5OuZGfAROknRuWJOfoV4sT8W46seALEEINBfzijys9B021SdLCKfqw==
X-Received: by 2002:a25:800d:0:b0:de8:c277:1e72 with SMTP id 3f1490d57ef6-dff153462c2mr1719111276.1.1718350026674;
        Fri, 14 Jun 2024 00:27:06 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff046690dcsm445042276.11.2024.06.14.00.27.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 00:27:06 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-62a2424ed00so23902667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:27:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVL0sIl5+9+yAW7wLq1378ILjy3OItbZe3w21GRvf+KLfahdO4sbje8dwZMkn+hQKaxDj+9TyvGE5MVSXZaxH0WjTstzk/vd+EMhNP4
X-Received: by 2002:a25:8284:0:b0:dfa:85e4:c8bc with SMTP id
 3f1490d57ef6-dff1534634emr1778123276.6.1718350025611; Fri, 14 Jun 2024
 00:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718311756.git.u.kleine-koenig@baylibre.com> <85a3d444f2943ebe9d64e722b1717a5f7d06ed48.1718311756.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <85a3d444f2943ebe9d64e722b1717a5f7d06ed48.1718311756.git.u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Jun 2024 09:26:52 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUHi0Yu2Giccp7pHqpjLWG2CjkGFWehLV0iWBHB_V4oGw@mail.gmail.com>
Message-ID: <CAMuHMdUHi0Yu2Giccp7pHqpjLWG2CjkGFWehLV0iWBHB_V4oGw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/2] driver core: Don't allow passing a -ENOMEM to dev_err_probe()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Xiubo Li <xiubli@redhat.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Thu, Jun 13, 2024 at 11:24=E2=80=AFPM Uwe Kleine-K=C3=B6nig <ukleinek@ke=
rnel.org> wrote:
> From: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> If a function returns the error code -ENOMEM, there should be no error
> output, because a failing allocation is already quite talkative and
> adding another indication only makes it harder to determine the actual
> problem.
>
> So the construct:
>
>         ret =3D some_function(...);
>         if (ret)
>                 return dev_err_probe(dev, ret, ...);
>
> is questionable if some_function() can only succeed or return -ENODEV.
>
> Catch some of these failures during compile time.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Thanks for your patch!

> I have some concerns about this patch, I only implemented it because in
> reply to the first submission of patch #1 Andy wrote that he thinks this
> should be done, too. So the idea of this patch is only to keep the
> discussion about handling a constant -ENOMEM to dev_err_probe() away
> from patch 1, in the hope to make application of patch 1 more likely :-)
>
> So, I think this patch 2/2 is a bad idea, because:
>
>  - Let's assume there are functions, that return either success or
>    -ENOMEM. (I'm not aware of such a function, but I didn't search for
>    one and probably something like that exists.) Probably the compiler
>    won't be able to know that, and so doesn't catch that "problem".

You can find several in public header files:

    git grep -W "return\s*-ENOMEM\>" -- include/

I expect there are more in static code all over the place.

>  - Using dev_err_probe() to handle the return code of some_function() is
>    convenient. First to make error handling in the calling function
>    uniform, and second, to not create a patch opportunity for all
>    callers when some_function() might return another error code in the
>    future. So dev_err_probe() can just be used without caring for the
>    details of the handled error.

IMHO this is the only drawback.
And things may change: a static (inline) function that can only return
zero or -ENOMEM now, can return other error codes tomorrow.
Also, some dummies (e.g. dma_mapping_error()) return -ENOMEM, so it
depends on kernel configuration too.

>  - In the presence of patch #1, there is no real problem with calling
>    dev_err_probe(dev, -ENOMEM, ...), because this is an error path and
>    so not performance critical, and no error message is emitted.

There's still the issue of increased kernel size, mainly due to the
presence of the error message string.

> Given these, the more complicated implementation for dev_err_probe()
> isn't really justified IMHO.

My initial reaction was quite positive, until I discovered the dummies...

> --- a/include/linux/dev_printk.h
> +++ b/include/linux/dev_printk.h
> @@ -275,6 +275,12 @@ do {                                                =
                       \
>         WARN_ONCE(condition, "%s %s: " format, \
>                         dev_driver_string(dev), dev_name(dev), ## arg)
>
> -__printf(3, 4) int dev_err_probe(const struct device *dev, int err, cons=
t char *fmt, ...);
> +__printf(3, 4) int __dev_err_probe(const struct device *dev, int err, co=
nst char *fmt, ...);
> +#define dev_err_probe(dev, err, ...)                                    =
       \
> +       ({                                                               =
       \
> +               int __err =3D (err);                                     =
         \
> +               BUILD_BUG_ON(__builtin_constant_p(__err) && __err =3D=3D =
-ENOMEM);  \
> +               __dev_err_probe((dev), __err, __VA_ARGS__);              =
       \
> +        })
>
>  #endif /* _DEVICE_PRINTK_H_ */

Looks like dev_err_probe() does not have a dummy for the !CONFIG_PRINTK
case yet, while it could definitely use one.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

