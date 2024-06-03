Return-Path: <linux-kernel+bounces-199533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CF58D8836
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 19:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C6E81C21555
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424B1137C27;
	Mon,  3 Jun 2024 17:53:15 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF53D25622
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 17:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437194; cv=none; b=kc7+mFDpl5gb9I5jV4B07A0Xa0tL+yxx3KOyZHMxAbr0f0qssMEqzL5FIhL5mZu14OcF0pK9a0fPsUaZLrN1OLw547SEHf/1DIfGF2Swof8umj+GND4p7TI+iZh9pxd3KZapbC4CbrYv1BOB+iaOcY+pKxRFIgUNGgAJCsgvR3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437194; c=relaxed/simple;
	bh=YpgbT06HnmbOY8XJm1ZUnbkzw/0Bn/aggm9hg3G2Bo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+SSTAOTz1etn889MJR60RPW6siWBa2wz4lgLHQBiFbuECq2rGLNGxJfCXvMuntNiYJ5uUGLqknNIjdQgn7Q4ertvY+WyzWEnOLkLk0se5UKUn6uLU3v352j++RzNCJE+QpjOl/ccOuYDIqZBrvFqhv5dfCytGC546donRUYWsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso4196190276.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717437191; x=1718041991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6vS6zekAlRMKF/uDnH73JIrPcwRqDuCP/QsgxUQhhk=;
        b=IXKnoBr0IeXcxQzl0NvrY3z+BhZxCjMEMIgqRBvJmIk1ZAEbgWE69QANaULcQiKHra
         f3ktLSSpMwYXv9JRnj3y2tKXNwGjvURi/uZNQIThGAuOEKFr5eQguFx2zxTeM6ud3t9K
         o/0VWInHhiZ00MAwDksuMhUhl9G6voPEpGbeT7PK7Ws9YbnLEkT6S0x9Ky1APfFgc2bV
         +cvL/kzryPP5GCx5c2SkBuwA4IcwWQkxZf1Ytl+M2zrTDYrtzMBjde9/iTaBjPemJhyZ
         lquX6Hoh4RLkV2F42iEFGdlSL/vWYOXNxipkFfh/e0KXV7iCmLkAjwdRRdvJH7lGE2g0
         U2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVzlrFIZt79/JOjUATxW7nIjbEhhelwgEAmCbpcczvSlTg9OQg+yakRerFjT/f2iSCzgfAwPlelfYXMww6Y6sKVs0aR3tBLFArpRi/2
X-Gm-Message-State: AOJu0Yz7lBvd9Kr8tuKvYcj+0uqvKdtsk6r4tDQDBTB8HPEKpS1zr0HB
	jukfGyjwLsCaQf4riRzArnLS8fzPywMhBb3W7ZcF8AlMQV+LO7aFAVUrf8yC
X-Google-Smtp-Source: AGHT+IEQ8BUjbcA/esrb0EXkAnI1qof/LWOAM6o+/5bGJFv7oqzHB7u1ib7NWYRr/IgqWs9QRIQoLA==
X-Received: by 2002:a25:8a82:0:b0:dfa:7e08:3ec4 with SMTP id 3f1490d57ef6-dfa7e0841a5mr8751780276.8.1717437190656;
        Mon, 03 Jun 2024 10:53:10 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dfa8027ffeasm1384284276.37.2024.06.03.10.53.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jun 2024 10:53:10 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfa48f505dfso4698780276.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 10:53:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWSr7nArsYXAsGC4S+7l5chmFuDghymDTKrqIHWpeIm2wYfXgGa2QiCTJphHOHqPooG1/9+wEuJckM+Km5BCEzIXNPOh180UN/B+G+s
X-Received: by 2002:a25:ce42:0:b0:df7:94d3:5555 with SMTP id
 3f1490d57ef6-dfa73d9e5damr9557597276.41.1717437189819; Mon, 03 Jun 2024
 10:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e00498fccf6dcbcf63bd24a137bfc7abd1b98345.1716967720.git.geert+renesas@glider.be>
 <Zlb_txl4CqCfxWZz@pluto> <CAMuHMdUyW_RxfUaxnyWVzPsdXQWqCQbgZ+avHskinXkrSFqhtw@mail.gmail.com>
 <Zl3HiBX8ih6Sret6@bogus>
In-Reply-To: <Zl3HiBX8ih6Sret6@bogus>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Jun 2024 19:52:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVkeKbUa45okF8qGOVVLRcOOtq=54yett+4dbyktCHxeg@mail.gmail.com>
Message-ID: <CAMuHMdVkeKbUa45okF8qGOVVLRcOOtq=54yett+4dbyktCHxeg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: ARM_MHU_V3 should depend on ARM64
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>, Jassi Brar <jassisinghbrar@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sudeep,

On Mon, Jun 3, 2024 at 3:39=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
> On Wed, May 29, 2024 at 01:36:42PM +0200, Geert Uytterhoeven wrote:
> > On Wed, May 29, 2024 at 12:13=E2=80=AFPM Cristian Marussi
> > <cristian.marussi@arm.com> wrote:
> > > On Wed, May 29, 2024 at 09:30:45AM +0200, Geert Uytterhoeven wrote:
> > > > The ARM MHUv3 controller is only present on ARM64 SoCs.  Hence add =
a
> > > > dependency on ARM64, to prevent asking the user about this driver w=
hen
> > > > configuring a kernel for a different architecture than ARM64.
> > >
> > > the ARM64 dependency was dropped on purpose after a few iterations of
> > > this series since, despite this being an ARM IP, it has really no tec=
hnical
> > > dependency on ARM arch, not even the usual one on ARM AMBA bus, being=
 this a
> > > platform driver, so it seemed an uneeded artificial restriction to im=
pose...
> > > ...having said that, surely my live testing were performed only on ar=
m64 models
> > > as of now.
> >
> > For that, we have COMPILE_TEST=3Dy.
> >
> > > So, I am not saying that I am against this proposed fix but what is t=
he
> > > issue that is trying to solve, have you seen any compilation error ? =
or
> > > is it just to avoid the user-prompting ?
> >
> > I did not see a compile error (I didn't enable it on any non-ARM
> > platform).
> >
> > But it is rather futile to ask the user about (thousands of) drivers
> > for hardware that cannot possibly be present on the system he is
> > configuring a kernel for.
>
> I am fine with this fix but I have seen quite opposite argument. That is
> not to add dependency if it is not strictly required.

Can you please point me to that reference?

> Also since you state that the fix is to avoid users of other archs being
> posed with the question that they may get annoyed or can't answer, I
> wonder if the right approach is to make this driver default "n" instead.

The driver already defaults to "n" (which is the default default ;-)

Thanks!

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

