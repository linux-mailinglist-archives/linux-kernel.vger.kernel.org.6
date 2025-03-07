Return-Path: <linux-kernel+bounces-551748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F76A5703D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD9A188ED2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F167F24113C;
	Fri,  7 Mar 2025 18:14:58 +0000 (UTC)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAEB18DF65
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371298; cv=none; b=GeUhkrS+1Wwz8dosxe/RFRhkxhwGJEMBleF8LOEb1z6IeCRxqpgzssSzSO2IHUpWIU4mJUp8ElPwq03OZwwxZqpR8wmIoQy2lutR9HrAy9oyDt6ibqphH6RPMEvR46I5HQS8OAlDn1qTfGCY1WnXzrCViIH/Bn2L6EVznP0g+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371298; c=relaxed/simple;
	bh=uTh3975VWS7fVQXZGaK52c0h5xILpUlJG1hwSaFanO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ok6HpoxabqhmAZgVK430305qOloaN5a3D16nCa7iMz2/CiWYcCw5PKi0ZsriFrPNeVhjLG6vfHV+nTnItnew4ylYMmFGw6oYO6YBNlKTx6lM3QPXll87Ur1ry5HhuFYw7dagpj4BfN1t+LIEmQrFJzzRcwQIWtV6wLOlicIz7xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-868ddc4c6b6so886250241.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:14:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741371294; x=1741976094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3Wv7r+yq/C5DFOIJ/TiuOh0b5drsxfo11wgEdCzflY=;
        b=uNLiR/4B0LPiaRsmQPyZwxJqE3E5EbAl7HdJlNAH/IZPGCqm5RljXhaCHHxZ61mUrb
         tfRBOpznc+YBBwUhwKNu3Fdhp4f3p07Uk03kQPRpWsT0H2dKhR0VqOe3BiDqPz8J7dGr
         xFimhqcnE+pLCQcqim1yxYx1Eu08VTUmK13iMU7a6T8Bx7cJPdkfMJERiSZPyQywEiu/
         NW8NkfNDYzQRW0JW1QYVYsRjpKgCanUDSV5vdJSIMOtwmCITdwAhWm920N/Yp6n6BwhU
         xtAHC3CX9HMGmSvsbkpTy/VFkXjQffnePD8MYN7VtZKHTDLGvTU1VRYWR9+qBwufCvID
         EKug==
X-Gm-Message-State: AOJu0YxBrsFNKH1yHvdGCBXTpyxmw4p6LjD841xUXxYn/rZ3rGDqu6sr
	dyeJv1YcMcEuhBomkLgeVKxaVA3ynJzAAEAkqNl9ljcmFVJxLmqS5elA25IRCrI=
X-Gm-Gg: ASbGncuP1oWzokufOb0ovh5ysQmPMqsKoFwzNVeceQ65NNAC6GYFjEv9ooMOOOBFxhU
	df7bQ2AH/ersar0p+xDwpoPrrLR8JhAa8l6/ka+fU+JpC99x23zTOy1m/LCOX3MLbnWCUIXEeGx
	uNxkeTSyz6IbY+WFsfSXpvx67tRPixYFFW7E2ISNdLx2xyHU33RS4wZPLEFxC6H0rEpI1DzSfKr
	nYb8mWl+uyC0xvwIBbJRrv0XU2h+ATK3DNwXy2bUSXAoiFLZ9Wjp4iuoNKvGIbIivAaCTo+PY1C
	ktGx9GnlSopOaPwSS6gZ8Iyc8EAyxXCcwMSDh8b0ijkpEeE4zXFPTSGi13h5ApL28f+XfjJ85s2
	ayfkBvG6yLKw=
X-Google-Smtp-Source: AGHT+IGrDNPZzCPlG4TKX+I6A1Zf3xtKNj3UJ60WnPx/6cYETmUZR+t9+q1c7EqniOMEL0cdIzgdJQ==
X-Received: by 2002:a05:6122:da5:b0:51b:b750:8303 with SMTP id 71dfb90a1353d-523e41728abmr3897614e0c.11.1741371294492;
        Fri, 07 Mar 2025 10:14:54 -0800 (PST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8cb9374sm582808e0c.41.2025.03.07.10.14.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 10:14:54 -0800 (PST)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-523edc385caso312334e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:14:54 -0800 (PST)
X-Received: by 2002:a05:6122:1d45:b0:520:60c2:3fd with SMTP id
 71dfb90a1353d-523e402433amr3874231e0c.3.1741371293937; Fri, 07 Mar 2025
 10:14:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-6-andriy.shevchenko@linux.intel.com>
 <CAMuHMdW=hfoKZkCtByCb13XaO4vKkk5LBx83ei=ac2CUKWJPjg@mail.gmail.com> <Z8smjviZhatCV3Td@smile.fi.intel.com>
In-Reply-To: <Z8smjviZhatCV3Td@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 19:14:41 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVTCK3mZ=zVLg5Ysfp+LZ8-hP7krm=Pp7GvrH1Gu6LrYg@mail.gmail.com>
X-Gm-Features: AQ5f1Jqt0oSxC8HFBVkjFiTwZPXpkpN2CAJkERbEs0i5ScxbhSpqgsyzR3K_lQc
Message-ID: <CAMuHMdVTCK3mZ=zVLg5Ysfp+LZ8-hP7krm=Pp7GvrH1Gu6LrYg@mail.gmail.com>
Subject: Re: [PATCH v1 5/7] auxdisplay: panel: Make use of hd44780_common_free()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 7 Mar 2025 at 18:02, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 10:05:56AM +0100, Geert Uytterhoeven wrote:
> > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > Use the symmetrical API to free the common resources.
> >
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Thanks!
>
> > Perhaps fold this into [PATCH v1 3/7]?
>
> Since we are changing not only hd44780 parts, I made the split.
> But if you are insisting I may fold them.

Up to you, you are the M ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

