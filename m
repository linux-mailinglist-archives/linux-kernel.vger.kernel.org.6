Return-Path: <linux-kernel+bounces-200391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D6C8FAF5A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3689B1C218A5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148321448D7;
	Tue,  4 Jun 2024 09:58:00 +0000 (UTC)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5BB14372F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495079; cv=none; b=lnRrR5TJgQnLgHqCXwin1rbxi5RqhHH4amNWTbVZkBeOWAMGWPfZ2sIYb7aEZeYZfHRgHHzTIdjQQ11Ua7Z5yIC4nBBDlMPlskMfgddhgdtplwkK/VpRBcesaASK0kNOzuPUrNEoMuvp2JSwWs5v/GfbR5MKsJ+u0x9AZzGk9jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495079; c=relaxed/simple;
	bh=1c8thpbnJn/2l/x22dvU3Yv0tOZFxguoKyAcUSYd0Ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sphX4oZv3N2YrcIWKVEGHiXh10C2Gnzx6d64I1p2Io5Bkq5qnWYVqCGwAltl5EMoc8vzFDvssT+fdxlmzZcTYYPNtxcU9ZCU5PTDv4Nb0196+p2J460E7ubmmh1hwuhTYvaYHn73TcSvsi1Z67qZqnexFlWeEQqAOflbmGDEmIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-62a08092c4dso51965057b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717495076; x=1718099876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kXaK6OgKo/9uKgUwfGucXPROnKA27c2dMDYH7qaPkS4=;
        b=tsqn5Y2juPNHmzbD77aJ/0zgWRipLDmhyjM0jxOxqf+Hs9Tt6yp8pV6Jc0b6PHsWhv
         MQlIOElCouv6bTLGgSuf1PekJUgrBNvUMPesfok9dXnQICdz1SYtKjq3Pivbu+0gn0gG
         nOeEI9FlMNNwv6B7oiTK6N4//NHHKiveqIy7cWdk0CXyaQDjjWmadIDIH7exlhV0eWhy
         uB0KQ8Qg2ivaeJMOn2tuLTzVlkvaD/RVt0c6gyrEWaZPJa3FGLRlM6Iu8FG9lDtKmN2T
         xuMNGOj5IBOPqohyH3su18ks9PQ7qRNn+1GZw5Zvt40IWd0aXDHI1GtbNgSvWQzR31vA
         mhFA==
X-Forwarded-Encrypted: i=1; AJvYcCVO9te+54/Dk5XM5QY9LE7KzkeDfA4ROXgdjrgfCUk889GZMi7HtifBPQwuLVfVVsvwBYFI5P6In/P1PNv0MixsHlVIQ2P2pwT8RbO+
X-Gm-Message-State: AOJu0YxznApg30HTGO6vYw5eedFwzaUCM+DLnP3ZyrL/a4VDcrl+eZNa
	rMJCa0/U080+nLfybsklGfKtqu9ivl2eN8GA/YQ1rHXhEGTo+iD+rfxv25YQ
X-Google-Smtp-Source: AGHT+IGv9p08DE77XuQumuxOvi+yCTi+88pDRpFRzIJRju0zFXN/vhulkDc6nDS16/E+2cp8vvvovA==
X-Received: by 2002:a81:e445:0:b0:627:cfe1:1c21 with SMTP id 00721157ae682-62c798274bcmr108016187b3.47.1717495076305;
        Tue, 04 Jun 2024 02:57:56 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62c765b9218sm17684447b3.26.2024.06.04.02.57.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 02:57:56 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so4812925276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 02:57:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQqw5OLvnIqzDhLX9RYuSQGK4IU+Ueg2qEjesJQV4abfuNWDQY7PbGk3Few+kB5wprGMwwjZWJvhZcE9N8jbcXzbaY83EPf4Jg6dqG
X-Received: by 2002:a25:ad26:0:b0:de5:5693:4e96 with SMTP id
 3f1490d57ef6-dfa73c43eb4mr11645139276.27.1717495075612; Tue, 04 Jun 2024
 02:57:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
 <Zlb_txl4CqCfxWZz@pluto> <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
 <Zl3HiBX8ih6Sret6@bogus> <CAMuHMdVkeKbUa45okF8qGOVVLRcOOtq=54yett+4dbyktCHxeg@mail.gmail.com>
 <20240604070718.ypymfv6j2smvxldr@bogus> <Zl7ia0t2O2xS8PXU@pluto>
In-Reply-To: <Zl7ia0t2O2xS8PXU@pluto>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 4 Jun 2024 11:57:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW8d6_=5Xe8QtmqTzD1dbeE8g8MU183X8uXYp-_hnwDPg@mail.gmail.com>
Message-ID: <CAMuHMdW8d6_=5Xe8QtmqTzD1dbeE8g8MU183X8uXYp-_hnwDPg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cristian,

On Tue, Jun 4, 2024 at 11:46=E2=80=AFAM Cristian Marussi
<cristian.marussi@arm.com> wrote:
> On Tue, Jun 04, 2024 at 08:07:18AM +0100, Sudeep Holla wrote:
> > On Mon, Jun 03, 2024 at 07:52:56PM +0200, Geert Uytterhoeven wrote:
> > > On Mon, Jun 3, 2024 at 3:39=E2=80=AFPM Sudeep Holla <sudeep.holla@arm=
.com> wrote:
> > > > On Wed, May 29, 2024 at 01:36:42PM +0200, Geert Uytterhoeven wrote:
> > > > > On Wed, May 29, 2024 at 12:13=E2=80=AFPM Cristian Marussi
> > > > > <cristian.marussi@arm.com> wrote:
> > > > > > On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wr=
ote:
> > > > > > > The ARM MHUv3 controller is only present on ARM64 SoCs.  Henc=
e add a
> > > > > > > dependency on ARM64, to prevent asking the user about this dr=
iver when
> > > > > > > configuring a kernel for a different architecture than ARM64.
> > > > > >
> > > > > > the ARM64 dependency was dropped on purpose after a few iterati=
ons of
> > > > > > this series since, despite this being an ARM IP, it has really =
no technical
> > > > > > dependency on ARM arch, not even the usual one on ARM AMBA bus,=
 being this a
> > > > > > platform driver, so it seemed an uneeded artificial restriction=
 to impose...
> > > > > > ...having said that, surely my live testing were performed only=
 on arm64 models
> > > > > > as of now.
> > > > >
> > > > > For that, we have COMPILE_TEST=3Dy.
> > > > >
> > > > > > So, I am not saying that I am against this proposed fix but wha=
t is the
> > > > > > issue that is trying to solve, have you seen any compilation er=
ror ? or
> > > > > > is it just to avoid the user-prompting ?
> > > > >
> > > > > I did not see a compile error (I didn't enable it on any non-ARM
> > > > > platform).
> > > > >
> > > > > But it is rather futile to ask the user about (thousands of) driv=
ers
> > > > > for hardware that cannot possibly be present on the system he is
> > > > > configuring a kernel for.
> > > >
> > > > I am fine with this fix but I have seen quite opposite argument. Th=
at is
> > > > not to add dependency if it is not strictly required.
> > >
> > > Can you please point me to that reference?
> >
> > I don't have one handy, I need to dig but I have been asked to remove
> > in the past.

I guess Linus Torvalds has missed the "ARM MHUv3 Mailbox" question
when configuring his kernel.... Or he has disabled CONFIG_MAILBOX
(it is not enabled in any but a few arm defconfigs).
Oh wait, he runs ARM64 now, so the question was valid ;-)

> > > > Also since you state that the fix is to avoid users of other archs =
being
> > > > posed with the question that they may get annoyed or can't answer, =
I
> > > > wonder if the right approach is to make this driver default "n" ins=
tead.
> > >
> > > The driver already defaults to "n" (which is the default default ;-)
> >
> > Ah Cristian mentioned the same in private. I may have misunderstood
> > then, for some reason I thought explicit default "n" would avoid gettin=
g
> > the prompt.
>
> I just tried this trick, it does not seem to work: an explict default-n w=
ill
> anyway trigger a prompt.

The default value does not control the visibility.
Visibility can only be controlled through "{bool,tristate} ... if <conditio=
n>",
or through "depends on <condition>".

> > As I said I am fine with the proposed change, just took this discussion
> > as a way to learn little more about Kconfig.
>
> Can this be at least
>
>         depends on ARM || ARM64 || COMPILE_TEST

Only if the MHUv3 can also be present on ARM ("aarch32") SoCs.
Or do people really run 32-bit kernels on ARM64?

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

