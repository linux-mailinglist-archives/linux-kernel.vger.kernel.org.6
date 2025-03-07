Return-Path: <linux-kernel+bounces-551747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72BCA5703C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D057E1895E19
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274A241673;
	Fri,  7 Mar 2025 18:14:19 +0000 (UTC)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A62417D4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371259; cv=none; b=BUl1eH9VBQyu0jKU4uYmNg+OvygOI1wU+saIenjb2UP8E5Mrh0rxyssKbgsId9/2qB6IYo7bBwvW0PlJOF2WKnWZwipf2Anm1QPQw7bnIeXkfhkiqsL5PwgAfmb4MMslkqtSq7sTD5MIWICnMEG1/mNA8Jt/lx+6+zo5G/eNAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371259; c=relaxed/simple;
	bh=HrjBY9ua8sTcgtbZhsUswtgduB7G3iZ9C4EcyBcH4PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Etr1e2Hb258d0wpcyl7Pdl//yHFDrMkSdEcnp3+f02DtpJnwORoI6C0gvewDl9EGBRZEK4MvTaPHFJ1AWEuYvHgeB8jA55IyBXzBnExtJ7CJQ9l7n9vLh2JialS7o0+908VYSecRt9HsGKF+OMAj8qGCZeWIBaf5f71Kx0mn4Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-523efb24fb9so227092e0c.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:14:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741371255; x=1741976055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDYFVXstxTUKbELhxyWP6/MTBQr8aCbLE8EPSDpi1Og=;
        b=ZpFc+uOsGd/rcERhKIcTY7dUQH12CD+zG2RnNGcnmfHRGOpkBNypTsSMUkZzd2FN6/
         tSw+1j9ujRujGu5Vfsuk64kWhdj3p50FUFoSd8LaV05D3+nzjSofqhSTIEquCt0QAhzO
         F1Ssuc+prFgxqPJlIlfnlVFHfkT7zwiSIradAFOYpaDNfXWBvurC78JvqhTrsjbT8AgB
         NoTPU0nQxKYisNjiXqbr3TQ8E1LWu1lNUQDer+pF8ODCSHwH6zQtIzuSWXhv2vYT1Y/I
         BU4RinIqUnQNmWhcvLZLTTz8LCj8Y3Z35gJhsS9Ez0k/QuFOr6v8+bEfcUHbw6nT/RXR
         MyPw==
X-Gm-Message-State: AOJu0YwkEx1+hXO3jGj4/5X+tfKaImYGEM7nXnaYesEHwLmecvUoMb/e
	mpZNyt0LQcXjfA47XnB2iP5AhddnVYGlYlJBhMQjlxCQv8bb2j6leIjPJQUqZz8=
X-Gm-Gg: ASbGncvd6RQo7TWQ+CZm+hnffuFjs7npHAMBc998yxbbAkDFqpD3zGfOA8NgWAeuJ0A
	Mp4fRHbdrnyWjc1lEHC5X63EWFZwlXFLYFSsTf75Gu7lidGlsE/BoqerF/pRonYbbtBi1V+VTbY
	zuVgusGH4zByBpw3SdYigj91375ICXPIdI0xciVKEKSTXgSNw5xMqvl8pP00A90w+kc2z+wiEHn
	o7dvlvVeW1xknOQ6YpNq41Y3sl8u98U5fqj2z7GldD+cCzQKfeWD477lafQpU3wHhRwsf3LAa7m
	tto9kSv7v8pfIIRqVOgDfZrU851MWpZEuZrPtyYkUDINA1cF8aTEHy+Z6wJ8P2X1MGCh+i+mhfW
	ODO4XUNI=
X-Google-Smtp-Source: AGHT+IFdXfwRAvo5xF2CepQ8Cv6qrVJg960Df47nwY7Hu1LiV6c5WpXHroZBraHbEQR2wZgF+6YiAg==
X-Received: by 2002:a05:6122:3c8e:b0:523:6c0c:e991 with SMTP id 71dfb90a1353d-523e41614aamr3984968e0c.3.1741371254832;
        Fri, 07 Mar 2025 10:14:14 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-523d8afc188sm600647e0c.28.2025.03.07.10.14.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 10:14:14 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86d42f08135so340463241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 10:14:14 -0800 (PST)
X-Received: by 2002:a05:6102:3c9f:b0:4c1:86a7:74e9 with SMTP id
 ada2fe7eead31-4c30a5abef0mr3645977137.10.1741371254354; Fri, 07 Mar 2025
 10:14:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224173010.219024-1-andriy.shevchenko@linux.intel.com>
 <20250224173010.219024-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdWBGb5AXv8Ch3XhPPHc0CVYHf31tx1Feh87OU5MDUCdPQ@mail.gmail.com> <Z8slexKyo7VFkSKW@smile.fi.intel.com>
In-Reply-To: <Z8slexKyo7VFkSKW@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Mar 2025 19:14:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpHvGR6aYM6puuJExp_ZNFY1YSWe-qu8CJZazhN9GFufScQKBZWm2C63FM
Message-ID: <CAMuHMdVmg=kuPWCN6rRTxP1LSZFtK=gagd0x092kxzif8Tav2Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] auxdisplay: charlcd: Partially revert "Move hwidth
 and bwidth to struct hd44780_common"
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <willy@haproxy.com>, 
	Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Fri, 7 Mar 2025 at 17:57, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Fri, Mar 07, 2025 at 10:03:31AM +0100, Geert Uytterhoeven wrote:
> > On Mon, 24 Feb 2025 at 18:30, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > The commit 2545c1c948a6 ("auxdisplay: Move hwidth and bwidth to struct
> >
> > s/The commit/Commit/
>
> Why? We know that we are talking about the very specific commit.

You can have a noun with or without an article:
  - "a commit": an unspecified commit,
  - "the commit": a specific commit, specified by context.
  - "commit 1234abcd": a specific commit, specified by what follows.

> My English is not native I would appreciate a link to a material to study
> the case you pointed out.

Neither is mine, but the use of articles is similar in English and Dutch.
(I am aware your mother tongue does not have articles ;-)

I found plenty of articles explaining cases 1 and 2.
Case 3 can be considered equivalent to "Mount Everest" in
https://learnenglish.britishcouncil.org/grammar/a1-a2-grammar/articles-the-or-no-article

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

