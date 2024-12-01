Return-Path: <linux-kernel+bounces-426577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 385769DF52B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93676B210D0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025183CD3;
	Sun,  1 Dec 2024 10:29:57 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8787AD5A
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733048997; cv=none; b=Uem3yR+YIu96YTlhfiqGdWX8bGzuSYfrpbFE4G/cEU471g0u5Fd0sQ54FtvqW5xb2zLoXBymL7MHPFfIGL7a/vurYrpyc9Drw3FIkDrY/RIWoXqaemHh8HLiKxionaur8f4pjonTWM92eUboRN0K7mr1dcUP2zSCsWm52v4ciNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733048997; c=relaxed/simple;
	bh=uLeJs9a4ziqCM+rM63lJMeasPcx2dm1ZTNIySsONDB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=on8P/vhMLlQlHVaoT7+TxHngUe4pma8PTphhXMRa4AHUWd60LDvNq0TlrWS/HXOhunUTWrcf1eSjTwyqqrAHWc44OdYDaFKydC/DIbv65F1WAG5FSdFg2zBgAIdhUEXKj8TIR49PnCFGQsngxVo7XR0FCBXz1pjPjGt2Z72q6Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4aef1e4c3e7so820753137.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 02:29:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733048993; x=1733653793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcIOSYzjNwsQGO1A+69Z/y5g0kNFHzkKGIV0FYE+buU=;
        b=Q7iNo5q6sgrGNYMc41fb1aNXR9rTuOi3/Uw0yfCWoN6tmxCaElQO22gTux5IQtbS3B
         zqh53Rkfpn7lAV5qdfK9nQ3+UyUteceAYAiMi1uArMBmTOkEkqu2E/utVzbV5YQ6Kn5F
         P3cDSWsyKt0taCh5fOcqVa1+RIrBmIHA6adzaFvUjMwR/aapMdGCsj37TGlcBA/48Ak+
         9mE6qR2z5T1nBOdIcENQkD9x1yCnGgxiad56p7A8wSnO5EqDNSmeMh+x4DH4ZVeaidic
         e39A0NRrbhpQbWiuZsq7bltRM66BoxYP7OSE6euH34YzDNfGwgcqhg7s0zBc7E1LFovg
         6KHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX00G2i6p1kyeZBLnvIPBPainNqr2xVseFbFvBI6bScGYpLP8oEYcYbJfmdWQnfwwGHDUWXgU4cS3vSaU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RMm6JJvsqV+fbrXEGPoGFC53wnFSnUPQhTftst2iYSLjT+mj
	P7JPksKrMlR7nSApyyPMATRQ1Ox4KfQdC+oatkZ6FzJkork5E+pXQyfpoFIk
X-Gm-Gg: ASbGncsmG1Z6xMmbdiXMk9izN9d6BcJgUD+fmMgxWJ1D3Crzt9Jxrpd9DJw5sF6QsIO
	7d9UNThffgm+h4NFroLayKLNcrMQpo3zjMfPkDsCh2XXGQwrrNUIF5gCQzu4nOdRl16XizqRFvo
	fIfncsZ6YyhdZ1qxsDyLem81T6W/U4N4VrfnoBxRkbytCb62WwbjPsmec568KG1RNAB/tnsw+dP
	ZBM46IXcl4Id/j+iTWqlyO01FIz3j/w4TQx2TLEApHUyhtfNKLuwdgow9JqF2zAVtGajGK1Sjqt
	eJq/iqBXwDJ5aQjf
X-Google-Smtp-Source: AGHT+IGesYkdAcvzaFzoFv/OMWOk9o45c88IkRhGlXvVSUO7VOld1b8azSgrSSi2TuNAAqRqaq+3zA==
X-Received: by 2002:a05:6102:f86:b0:4af:48a6:79d4 with SMTP id ada2fe7eead31-4af48a67c43mr21056427137.6.1733048993403;
        Sun, 01 Dec 2024 02:29:53 -0800 (PST)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85b82a0d3f1sm1372807241.5.2024.12.01.02.29.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 02:29:52 -0800 (PST)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-514fab8ac5aso733628e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 02:29:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIOWHap0E6o5T5gcuOGQyRROOO0SzCLces6riZoIk0e4OrXdkyMWXlG3ab/1cjAmAyQJ9ACZ8mgtz/9io=@vger.kernel.org
X-Received: by 2002:a05:6102:38c6:b0:4af:58f7:15ec with SMTP id
 ada2fe7eead31-4af58f71c0bmr11615268137.4.1733048992532; Sun, 01 Dec 2024
 02:29:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20241130145727.900020-2-u.kleine-koenig@baylibre.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 1 Dec 2024 11:29:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVm5D9bqpmdLe=_FPchttUqy80H7qdOUuXzm-af5gGSjw@mail.gmail.com>
Message-ID: <CAMuHMdVm5D9bqpmdLe=_FPchttUqy80H7qdOUuXzm-af5gGSjw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Switch back to struct platform_driver::remove()
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Andy Shevchenko <andy@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Paul Burton <paulburton@kernel.org>, Erick Archer <erick.archer@outlook.com>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 30, 2024 at 3:57=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/auxdisplay to use .remove(),
> with the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
>
> While touching these drivers, make the alignment of the touched
> initializers consistent.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

