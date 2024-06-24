Return-Path: <linux-kernel+bounces-227012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D696C914726
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 106D31C20CAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26115136994;
	Mon, 24 Jun 2024 10:12:05 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469DC5380F;
	Mon, 24 Jun 2024 10:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719223924; cv=none; b=bVR0rL6+g10TFXHh5mGO5qQx7Kt+/yg2cu5on3eAfPJh24yFQtg4Zk4VszmH8FK0559wax4q2n+QGlk5Zp5ij280yxR9cJ+Mf6dvINiTZuhgDO5JohEo2qf8sQv9TyZG0B3bYVkNlV0+f+s1qxVrMhz7UwGYMOsKlU2lmrTO+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719223924; c=relaxed/simple;
	bh=IBvZyxdbo97T0/Tgj7l4fyQGXy0qXDZWL3VU4l7Hxnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YLxBCt4VwzQatNlCqf1cf+ZCzGuJZF1i8MNh+BU83MTwreErSmm6ypbATIt0Ice8cAetGazsBk2BGLO0xj2YdJVSNLbr2HOsl6m2THTpyaYF/cnL56LfABJEWlD3WVr/xMmBGCYxuuB5rQg4uXSxs6GtOnrVuNjwyJO0wYLNP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-63bce128c70so29333967b3.0;
        Mon, 24 Jun 2024 03:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719223922; x=1719828722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElYVxUQdlVxuSMCsySI9p98sI8g3FQfvxxo+f8vrW3A=;
        b=B+uZKr0lH6JmviH8D2iolqv8ocr3WOyV0LyglkCTlJjHVd6lx8SpSdnh1yYMTmSx5m
         GJH6rC4VRgxIvpZ6be2HXbpu/NpfhR/GhahgWfsipmdrulzazrQFGSyomdcdxpKDKnwZ
         0Gvn1g26qCDtEdki4PW3LxhW1lEHH6Q7UXbUAjxwgwcMETZwQZJ6VtMC8srvOqVxCwKD
         qFwhtGGVPxPHaIYH46B8O6jud+bfltLa/RYnLZdz+ljFZ8ZVuNcm5+3xIK+uKZI9yYtW
         ODJkmZdSXrNZOodI74FKNNuPavhVlCuctD3FWorVOVCuZaSABZgE9MhXI7zVvuIpWMuw
         k/Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWQjYvO8l7+XO4kUvqcsGFkCr1LVOVHnxpx1th1R/J5l95fLrze0mKxX6S1ZKSEpF/hCMa58iADZSU5SS2lFaHtnXnUhBM8MhaDZuB6lVXAUxgExsmMZk2svlAj2PgWDR7Fi8TT/JzzXeJjhVQm
X-Gm-Message-State: AOJu0YwKgJaNQ4Li7m0cayPEho4zItDTdG0mT4vfm137I+TmCmJ7ghgz
	QQT1YiW6jJm7JNv9+bYf3MT1BtQoVNxi3hNW6DofxVItKLd5f8Zc8z8jPb0g
X-Google-Smtp-Source: AGHT+IFG6IBsf5sqYD7hE8J+CzWP4DoAu8XA6RkB3juDN/fqYtxUFtoxfvgKxna4g1eTGkepiLNdSw==
X-Received: by 2002:a81:4322:0:b0:622:c70b:ab2b with SMTP id 00721157ae682-6424821b6e8mr26768427b3.2.1719223921940;
        Mon, 24 Jun 2024 03:12:01 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f11c03cb6sm27860207b3.31.2024.06.24.03.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 03:12:01 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02b605bca2so3616553276.1;
        Mon, 24 Jun 2024 03:12:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU02JQuTOS23FKCjRMPylulJMOJToH99u/+MHGJNEiVIwlZNMfz6zEys0PYT2kQ+NtV3ueRJpe78Yafn+wIdbMVHQ1cGBq+2BfTONTap/NRQSufjWRt5QA99LRgsN6ojAiMF+BTkSODDj+BoFHw
X-Received: by 2002:a25:3607:0:b0:e02:d13b:5e19 with SMTP id
 3f1490d57ef6-e02f9f44593mr2748225276.9.1719223921597; Mon, 24 Jun 2024
 03:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-arch-m68k-v1-1-57d38beaeb13@quicinc.com>
 <CAMuHMdWD0Je3HZ+RJyfdxKxKcBp7nt6ooP_YUpiju77Zf1QzVw@mail.gmail.com> <a9a90666-5b3f-478d-8c88-002e23aee48b@quicinc.com>
In-Reply-To: <a9a90666-5b3f-478d-8c88-002e23aee48b@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Jun 2024 12:11:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX1GEuWz-SfhuRvofgryzHApNTrWkvmyJuQ4Av8TZY=1w@mail.gmail.com>
Message-ID: <CAMuHMdX1GEuWz-SfhuRvofgryzHApNTrWkvmyJuQ4Av8TZY=1w@mail.gmail.com>
Subject: Re: [PATCH] m68k: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Tue, Jun 18, 2024 at 4:46=E2=80=AFPM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> On 6/18/2024 12:36 AM, Geert Uytterhoeven wrote:
> > On Tue, Jun 18, 2024 at 1:47=E2=80=AFAM Jeff Johnson <quic_jjohnson@qui=
cinc.com> wrote:
> >> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfbloc=
k.o
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/m68k/emu/nfcon.=
o
> >>
> >> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >
> > Thanks for your patch!
> >
> >> --- a/arch/m68k/emu/nfblock.c
> >> +++ b/arch/m68k/emu/nfblock.c
> >> @@ -193,4 +193,5 @@ static void __exit nfhd_exit(void)
> >>  module_init(nfhd_init);
> >>  module_exit(nfhd_exit);
> >>
> >> +MODULE_DESCRIPTION("ARAnyM block device driver");
> >
> > I think that should be s/ARAnyM/Atari NatFeat/, as I believe NatFeat
> > is also available on other Atari emulators. See also nfeth.c
> >
> >>  MODULE_LICENSE("GPL");
> >> diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
> >> index 17b2987c2bf5..0ab2e4d08871 100644
> >> --- a/arch/m68k/emu/nfcon.c
> >> +++ b/arch/m68k/emu/nfcon.c
> >> @@ -173,4 +173,5 @@ static void __exit nfcon_exit(void)
> >>  module_init(nfcon_init);
> >>  module_exit(nfcon_exit);
> >>
> >> +MODULE_DESCRIPTION("ARAnyM console driver");
> >
> > Likewise.
> >
> >>  MODULE_LICENSE("GPL");
> >
> > If you agree, I can make these changes while queuing in the m68k tree
> > for v6.11.
>
> You are the domain expert here. I'd be very happy for you to make the cha=
nges :)

I made these changes while applying your patch. No need to resend.

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

