Return-Path: <linux-kernel+bounces-196469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0EF8D5CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BB021C21EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEF314532C;
	Fri, 31 May 2024 08:28:58 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAEEEAD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 08:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144138; cv=none; b=eLIIDCIakz+YSVvmObO1rnQGm7m26kT/yvjRHrEKAsUsyM1aMzoQ1Os2rUfiW4+w5qppPc58sV5Bmt9DzRIvuYeaf/YGHzm3RUhhN3O66fWTFkulEZO6jjItGVj+OoJYU1+8BolIl7k8RXQv3xFGOWoaism0GII5QhqFPBsM4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144138; c=relaxed/simple;
	bh=Jpqmh7/b+eGbu7hQ7QAFK7eEdTyARkLOs1eOKmnXUng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPlTVtRwNiI56kRzvs/jqSLjtkb0Dlv26GRvTZq42UhZrEfZCuNTMStyIq+m6Lp+6MKcLtFhLANLPqoqa7ewbtNF8nTJ2y5C+MkumRP3GAmyBRi6kVFBvSTtsmvRqaoSdi38W9rKHVVzvpdJ2X+L9U9cqLqnAph/2tOmOe1sqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f4a52b9413so14872605ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144136; x=1717748936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEuOPWCdC6NHpmkn8KXRs2cll8t9MNYZOzQZ1qxaIi4=;
        b=jbYMOnJAfiGVG0j3oaI8CsoeiEr5Tzmm774V1uNfvlLbAD2kRxvAxr+K1sOzyXOnAl
         07VFvc9Z2ss7uglQjs4IMbTJBmmeA9FiBb7z1JDo4XlQtjyfq1TOe2zdwBZyr0iFAJqs
         gEMsFGnoBuk8F1v1zsoHCLOr2X4CmjDffim1yri+Q9QYEohGbVaUbDctyKst0Yi5vLEj
         A0aAIh5GoDgPbK7agOH1Y4TIEt7KIjN/vREG7cU6vk7D+imbp4TLgK77XkxflYEGQnG7
         rLAzFS8vmoNRFif8rLCry0zjYiMjp/pnUn6+0VfM0cS0aySKWYM0utuYA6KPnsD8s/Ng
         6+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUSZ4S5Akx+TzuJppPKlw2MfgGZn3SjiWVY+PA1NFzhwG8Z7NgE3TAnL/Wh6tjx+tVOQ5xG0Or4HQoOz7htKtxEK2/XY9i5xKrp3Tnx
X-Gm-Message-State: AOJu0Yw5NNabrxVtuE8unBA8UDRkDmVbqG+o/XAjYZg6SRJm4GpBz3nU
	7iADWSAz7PpASq4OyqY2vgEvQCgrTSms2s7iGT0s5rSujKqOUSBKonDsxx0R
X-Google-Smtp-Source: AGHT+IFPNro3YKZW/KFWfkkTmJpIYacwmnB4R09p5E7Rm/mn2vmZ4w/pG6D0n12OKbCCR2iV8sVngA==
X-Received: by 2002:a17:902:d548:b0:1f6:23ce:156b with SMTP id d9443c01a7336-1f63705c55bmr12719995ad.41.1717144135441;
        Fri, 31 May 2024 01:28:55 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e8ad6sm10718175ad.185.2024.05.31.01.28.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:28:55 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a52b9413so14872465ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:28:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVKwY6cqAjk1Tufw5aPEW9ebeBFYB7yO0nuQp5ye9h8wgU7UJwVu1Xn+vKNB8ING4ys+RkueIPlTlCe9q7Lix5R9GkOF5ZCRqPbuG0/
X-Received: by 2002:a25:c794:0:b0:df7:8f1b:3ea2 with SMTP id
 3f1490d57ef6-dfa73bd0a7cmr1195800276.5.1717143735062; Fri, 31 May 2024
 01:22:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com> <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
In-Reply-To: <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 May 2024 10:22:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com>
Message-ID: <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, andy@kernel.org, tzimmermann@suse.de, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, May 31, 2024 at 10:16=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, May 31, 2024 at 10:45=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, May 31, 2024 at 7:28=E2=80=AFAM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > > Like we do for charlcd, allow the configuration of the initial messag=
e
> > > on line-display devices.
>
> ...
>
> > > +#ifndef CONFIG_PANEL_BOOT_MESSAGE
> > >  #include <generated/utsrelease.h>
> > > +#endif
> >
> > The #ifndef/#endif is not really needed.
>
> It's needed to avoid unnecessary build of the module (in case of m).

OK.

> > As I see no real deficiencies:
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I believe you agree with leaving ifdeffery above.

Thanks, I agree to agree ;-)

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

