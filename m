Return-Path: <linux-kernel+bounces-237377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3697891EFF3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDA6FB214B6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA65312EBF3;
	Tue,  2 Jul 2024 07:21:42 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34227E792
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 07:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719904902; cv=none; b=S+jzslJJ8s4KxrbhO8ZKvcnMiZUhOgumPu37wG0wzDaxy4WZWVjwD05v1hy0NdGjLominDfZRMPGiG+Ri5ALNH4j2mZuO3qAYEbo656vqNQlRgq8L7KoUPat7ohxPKeotoyIDOy4URXohhrIZQy4WBlGNi1WrZDKgrGGvbblaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719904902; c=relaxed/simple;
	bh=LRMPTlL1WL15rUYBCdg61D13+t66ahvPx2FDr+bZay0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tyLGA73BLwRfHEdMTXsuH46kdXumaVOMlBFiP5ffpWlUuNTUWB1FggTGeSyZI5/eIGiR17VHGiAKKayXxfcDFwEBlzG/XPWQSk5tPBll4VQrAQZMveJ3DpHPr5N8NYl8x2J0FAkqHzrNdfJQ6yrPVAYriGZJp9+ws8D2Qba3Wrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e02748b2402so4175461276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719904898; x=1720509698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqjWNFuPVmOWg0A90n3DdVNAL3PKchg+JYQRnRVN8eI=;
        b=UWpWujYGkJIFn0EkI5W8p0z61/w2i7NoC9LZP4aRoDMs1IF7xrFyw7Lg6UVbnIkQLG
         8PHl+m0PWeGQZe5m6o9TP7JRealncxMHWvyXDpJmIDVgDOBMFZYKSsRaaGhtjUlUfsXT
         PZ112zNyEYtvzzkTqxmADGlAhjaOlNVkPVjXsDNCzoUALZ5+3+5RXOfPRU1HYur9H+ns
         DdnoGPxAFOVsJfhRdXqXpuer0rLYE0h02RWjxgizAj2KU3jHQ+ArcZSLL0F6KOosDEcH
         L7KH6GQarsBwuUg1JsQMBZvVAPOWfR2C7ctSd8VxD1EICS5sgC9hchJYUD06NHn8OWMs
         cc1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXge46xH5BaJtmqmiqZPDleYXpZmYqrB6cnUISxruxnKlzzpRKqdrW/kwWavKrh3eMwTfP9dVNKeJH+xVkD/r2cSykXyo3aKiyOyTeI
X-Gm-Message-State: AOJu0Yz5Sk8NAMkmRQO5S3QutFnVEZtUOlhdPwd8qurxuFRcarfNUZQ9
	pdhc0VXEYdxBbOunjvaDtMj8C9bRI0FQa90lYAwk+Je3UtUBZLqE/gJBy02M
X-Google-Smtp-Source: AGHT+IFzPILYoLnnmdKCHCgK/atM0ADwF1+TbJVvVPA0dSfjk6mrMAu1uRj9TqRRghRo+7H/M6Y6Sw==
X-Received: by 2002:a25:abf2:0:b0:e03:25d5:8039 with SMTP id 3f1490d57ef6-e036ec43139mr8338849276.51.1719904898238;
        Tue, 02 Jul 2024 00:21:38 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0353d58286sm1536923276.2.2024.07.02.00.21.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 00:21:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64d408a5d01so21139657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 00:21:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV3SbGRK+4KnYa6KYIm+sDekFAN3Krkr0pNUN13GlniZJ1GF8jcy5iFmULbZg0141a0rqFGdvjcvtYFnCZvoK7RN0rNnxxiOsMeOpQo
X-Received: by 2002:a05:690c:711:b0:64a:564c:cfa4 with SMTP id
 00721157ae682-64c71804010mr80155787b3.20.1719904897835; Tue, 02 Jul 2024
 00:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702034116.140234-2-thorsten.blum@toblux.com>
In-Reply-To: <20240702034116.140234-2-thorsten.blum@toblux.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 2 Jul 2024 09:21:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVTqsqrDTKGTGoLd_3FPk9S6wX-qXYzipJ+6yW0q0L11w@mail.gmail.com>
Message-ID: <CAMuHMdVTqsqrDTKGTGoLd_3FPk9S6wX-qXYzipJ+6yW0q0L11w@mail.gmail.com>
Subject: Re: [PATCH] m68k: cmpxchg: Fix return value for default case in __arch_xchg()
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: gerg@uclinux.org, dhowells@redhat.com, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

On Tue, Jul 2, 2024 at 5:42=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux.=
com> wrote:
> The return value of __invalid_xchg_size() is assigned to tmp instead of
> the return variable x. Assign it to x instead.

Thanks for your patch!

> Fixes: 803f69144f0d ("Disintegrate asm/system.h for M68K")

That is not the right commit.  The issue was introduced before:
Fixes: 2501cf768e4009a0 ("m68k: Fix xchg/cmpxchg to fail to link if
given an inappropriate pointer")

> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

> --- a/arch/m68k/include/asm/cmpxchg.h
> +++ b/arch/m68k/include/asm/cmpxchg.h
> @@ -32,7 +32,7 @@ static inline unsigned long __arch_xchg(unsigned long x=
, volatile void * ptr, in
>                 x =3D tmp;
>                 break;
>         default:
> -               tmp =3D __invalid_xchg_size(x, ptr, size);
> +               x =3D __invalid_xchg_size(x, ptr, size);
>                 break;
>         }

Although this was not a real bug (__invalid_xchg_size() does not exist,
but is referenced to cause a deliberate link error), it is good to
clean this up.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.11.

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

