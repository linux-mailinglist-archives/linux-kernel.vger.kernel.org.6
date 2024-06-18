Return-Path: <linux-kernel+bounces-218783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FB390C5FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DD891F228FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61C13D8AE;
	Tue, 18 Jun 2024 07:36:27 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03C812D1E7;
	Tue, 18 Jun 2024 07:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696186; cv=none; b=azdl5rJM91JtXkP6T1DolnXnbQEbvTG1OG17UA1yUliTaWZXnmBxv9r8PUbIVJK9R2a3mhsK5VcJ+7loCbK8TCmWHHYviJQydlr5A8wK8lTwdtcChdTerWlbzQKm0je3aJrD/olUR2KBIWsE/wXnIN7oJxWtbg9B0VSMW5ap0I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696186; c=relaxed/simple;
	bh=l4qwCNd0eHbNyQN6OXtnKQBtjHNXZNH/GE/oi7U5ry0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buOdFfQjP8gyxAYJahlOjPSJ5loDSgy2hNygYnssasdNwXg1qzCdmtXJetkzNCDQryh7Hfi1jcvEJ7wyFRr97KPGA7gZxe6QPEYLET3bPJ59cIII2vRLknuwc8oEpLp1RDeFtsDLgiFcfJ0fYT2CcsNfWMBf+6kPlQpuVldAF1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-62ffc495935so54202127b3.1;
        Tue, 18 Jun 2024 00:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696183; x=1719300983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXevbHTVVB5W4AkAG0SpByLTlEWY1oXg3P8wa0a9S0A=;
        b=r0IfGcPhfZYyQWXairOgAgwizEQJe5RDIO6zrw19717ZOWUvYnmqtjM7B4oa9cLvCB
         WCfJLTWVOr+Xr+rHWGki/pdYeeAGHYOnKAUoOxwqfmFYRbbFw1daaTm6IgsOw5GU9Smm
         mV/OsfEw5WcsXauiQ9gGqWJW/O9HLeBHzWJ6ZxKJ8ZIxDO3InOvlfpefSuWsEqHoKO/Z
         Uda326XqpMY1u6ncFlZtMsngRCulC7bWoDDpXV8yphp1qxz6Q/mBLkBWD96yFjHh2MEz
         8ot8UcrFZYgSQdsQtrZRQXOnUh41octR+xADEJAt87oTeZAvfAsCYz49/1+hZq2WvCPR
         zTng==
X-Forwarded-Encrypted: i=1; AJvYcCUOukw2EwThVa7nL0uLHaPTzWMDlDfpzMq6veMYjtAXBKpaTUAy2mph6kcnm/pia1GS+oM69FoH1hWTpdua/f5C7xm2OlfcMq/1BYFBgBmcYPxJbmkONlOqK9v2LsbnxeXTa7kM2I5pAEHp+Kls
X-Gm-Message-State: AOJu0Yw0emlEM/xjRFTbOicfLxPk/ABN5eG99DmfBIaR7R/LdC54fZjC
	3CuUweAhzIxbn/sn0enno1eW3CSCqAdiVDeXFk+4H5tLUtE4pfRFk3d1W6tt
X-Google-Smtp-Source: AGHT+IFHM7mhk6Fuf00JLZYzz+PxhP5osyYqbgo/fDNP4um2W196bHwxHFYnGRtXfjCOh/LW37DKOw==
X-Received: by 2002:a05:690c:fd0:b0:632:d12d:9378 with SMTP id 00721157ae682-632d12d96c4mr110481527b3.11.1718696183275;
        Tue, 18 Jun 2024 00:36:23 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6311a92c147sm16986257b3.111.2024.06.18.00.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:36:23 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e02a6d4bdbeso264296276.2;
        Tue, 18 Jun 2024 00:36:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU6kngJvNXkTbtBZSYmHdg+mGD3+/El+XP7kR/Zyqekiet9VGVInvQsb0du8twR8N0gLTlyDRdSuxcpbpWBkmahsII9y8MPkKz4D6XgYN8xSnKTnf50Ifj0XwG34QGG82sNPUF7rKTKpCDSw2Fq
X-Received: by 2002:a25:8689:0:b0:e02:721b:756a with SMTP id
 3f1490d57ef6-e02721b80f5mr1035835276.47.1718696182911; Tue, 18 Jun 2024
 00:36:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-arch-m68k-v1-1-57d38beaeb13@quicinc.com>
In-Reply-To: <20240617-md-m68k-arch-m68k-v1-1-57d38beaeb13@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:36:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWD0Je3HZ+RJyfdxKxKcBp7nt6ooP_YUpiju77Zf1QzVw@mail.gmail.com>
Message-ID: <CAMuHMdWD0Je3HZ+RJyfdxKxKcBp7nt6ooP_YUpiju77Zf1QzVw@mail.gmail.com>
Subject: Re: [PATCH] m68k: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Jun 18, 2024 at 1:47=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfblock.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfcon.o
>
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Thanks for your patch!

> --- a/arch/m68k/emu/nfblock.c
> +++ b/arch/m68k/emu/nfblock.c
> @@ -193,4 +193,5 @@ static void __exit nfhd_exit(void)
>  module_init(nfhd_init);
>  module_exit(nfhd_exit);
>
> +MODULE_DESCRIPTION("ARAnyM block device driver");

I think that should be s/ARAnyM/Atari NatFeat/, as I believe NatFeat
is also available on other Atari emulators. See also nfeth.c

>  MODULE_LICENSE("GPL");
> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
> index 17b2987c2bf5..0ab2e4d08871 100644
> --- a/arch/m68k/emu/nfcon.c
> +++ b/arch/m68k/emu/nfcon.c
> @@ -173,4 +173,5 @@ static void __exit nfcon_exit(void)
>  module_init(nfcon_init);
>  module_exit(nfcon_exit);
>
> +MODULE_DESCRIPTION("ARAnyM console driver");

Likewise.

>  MODULE_LICENSE("GPL");

If you agree, I can make these changes while queuing in the m68k tree
for v6.11.

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

