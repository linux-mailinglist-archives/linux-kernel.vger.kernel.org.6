Return-Path: <linux-kernel+bounces-197337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B410B8D697D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CB51F2941C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37217C7D3;
	Fri, 31 May 2024 19:12:23 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A2C80C0C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717182743; cv=none; b=dXNmByq8WD6kDB26CskZSRLalx/OSpdQCR6BEaZMPLCxVOHPM3xFS8YRfHtxIqdjXRe2sPkz0310zQCw19mhCuZ9PdNKWmYkwe5tfOdnm+QE/h6lHUP/P8jTGv5ASRg2NGTcTh2eeMMcoewjluGBNKDg0vRNGoKKwd2PQw4lNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717182743; c=relaxed/simple;
	bh=oCxyY3mhY23+s48+kN3Qlr2TEVOAhuX/RdZZCYx/OfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFd0fuNoOxXr3sV1G30eFlXRShlFAgaWnc0v8o9cpgeoCYPItPl2QumckAhpONYuWA0cND07rPDmqIoO7FNEtrf6whNPvnWtjFqaqwsIEGzlSWGGyeNYIaG7FCaOkIn0INncp8ol4pkdJZH13Us0OcxzlV56IFXtaR0klEm3+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52962423ed8so2872756e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717182737; x=1717787537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SzpvDdH9RU5jNR/5Cs02itR1wWZZV6OWrbwMI+JACg=;
        b=FhfeGyzccwaXuR+D3wBJPjp1/aH+8QMOGo9TNRFZvuGyIT3738zdPG5EYdv43fRshS
         jt6x2x4073jCNa5yn3CXXCCPvoDK5iTf5RYs3N20bsp1B1Ejtcn9Gori5rbcuALcRFL0
         4m0mKq4Gv54wIQBTVZczI73ndr4r1W+jTnojF0337fbM/fT6JY/oIhjUIp3+gfGh827K
         d3Z0Z+8eYYw7akBnhUDYOnriLQAeVSzNI1puJrnPap5oAIyRFWHEuKCPK7RnZeCZWnSC
         bP6a8lXVXTIEXyO/OaOfckDFXi6VHwiuVqE3tjJQk+RZ97RSB2Cmaf5Y0BG9oU08OLeZ
         nX7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWxeP8f2NL2dCabaqyH5BcDbZx4ylgHEJUoIyNB1XWU7wkE4u3sXty5hstAGctFn8QILh5qMu/vGd3CTVTP9mrI5tUFbh5vNgY4U7C
X-Gm-Message-State: AOJu0Yx9wYcPseCuvlnCkDct9QpKrQCXets+vfeF1g1mCp32FbIJS2zA
	kD3bKKNZsn1InVzYyeSOPFZoe9ASSgJWcwC8kQYtBzV4xdRmJ+gm+Iv9MarM2/8=
X-Google-Smtp-Source: AGHT+IGoWOM92lm2qk6Acfs0Fh+a/6FLqC/VzegGSF5yt5LYRelug/LghNzgqaINOLX5kWOrgS7Nbw==
X-Received: by 2002:a19:7403:0:b0:523:b272:c73 with SMTP id 2adb3069b0e04-52b89569542mr1811174e87.7.1717182737277;
        Fri, 31 May 2024 12:12:17 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52b84d34b2esm414871e87.3.2024.05.31.12.12.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 12:12:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52962423ed8so2872715e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:12:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX82aG4wUNcyRVWK/6UwFc3EaSg/1jSoxSqHNmweMwqKcCe7Lu37wzcTSeGvP7wtuVKazXcZBiN89lbrX3uU1UgqUHtnfM3B4kbFNAS
X-Received: by 2002:a05:6512:3282:b0:51d:9921:20f7 with SMTP id
 2adb3069b0e04-52b896b032amr1805910e87.40.1717182736778; Fri, 31 May 2024
 12:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530232054.3559043-1-chris.packham@alliedtelesis.co.nz>
 <CAMuHMdXGJxwRDRjKQT5aa6off9nQ5WqreK9K-QhJwhUXngYA=Q@mail.gmail.com>
 <CAHp75Ve3-JkNUuF_LT=E53WfEfxt5yizSvoD22a3OvHiPXSRJQ@mail.gmail.com>
 <CAMuHMdXg1GCAqYPy++4UjFN6QsCnfikZdvsz5=2G4j13E3DUjQ@mail.gmail.com> <ZlnT_imCNdts8EOd@smile.fi.intel.com>
In-Reply-To: <ZlnT_imCNdts8EOd@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 31 May 2024 21:12:01 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV6NijyDia+YocmbCN1P1A=yuSe1qfeUYxKA5KJ-KbgGQ@mail.gmail.com>
Message-ID: <CAMuHMdV6NijyDia+YocmbCN1P1A=yuSe1qfeUYxKA5KJ-KbgGQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: linedisp: Support configuring the boot message
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, tzimmermann@suse.de, 
	ojeda@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Fri, May 31, 2024 at 3:43=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> Btw, I will take a long lasting vacations (ten weeks in a row) and most l=
ikely
> won't be able to actively participate for this subsystem. Thinking about =
how
> to proceed if something critical appears... Maybe you want a push access =
to the
> same Git repo and in (rare) cases can handle fixes? We may ask Konstantin=
 to
> configure that on git.kernel.org.
>
> P.S. This change doesn't seem to me as critical and there is still a chan=
ce
> that I will have time to proceed, but the situation just motivated me to =
discuss
> the possibilities.

Thanks for the heads up!

Np, I can take over if there is something critical.
If it is temporary, I can also just create my own linux-auxdisplay.git at
kernel.org and ask Stephen and Linus to pull from that one?

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

