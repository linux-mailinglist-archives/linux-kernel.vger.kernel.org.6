Return-Path: <linux-kernel+bounces-218775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DC990C5EA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83FB3B2186F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D813C697;
	Tue, 18 Jun 2024 07:31:47 +0000 (UTC)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD1E7D07E;
	Tue, 18 Jun 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695907; cv=none; b=F5EvOEh7G2gZWUrnYKtWdKcUAc7S7iUmXCbrUhhdIMLoPABl8pxJWhdubgdXiF6GdDb6YL0ZD5bqyOWxTU0jKrnWwifEpkUZ1k+yU7z3GesrVM23Ko3QzDUOyQoiSkasjBJ110ehUhvAd1Q89nHb2xA6ERJp8U7rvBgvcb2w/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695907; c=relaxed/simple;
	bh=7ybhaAMpgARhjdDo1pnTKZPpKF4QH6VLKZUn/uTHOcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=km6IeyBnKr2vyW5kJueBGlhFglBHzFIuaat+tInvckZn6bx1/TPw/9Wk8KRyOeoiiP4j90g8oTq7xlgPaXYlKH0ehKYgVvecUapQZFH+lo4dZSlMB9VgjIg3310dbw2KM62JtFEywoyI83Ju7Rcz7/ljLOY7b0lp7iuMcD/Nn5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfdff9771f8so5253360276.1;
        Tue, 18 Jun 2024 00:31:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695904; x=1719300704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S03qLG8W+d8ZBCNGeV/REOufI8+NbpzlzNVodwGHfz0=;
        b=wvy5SemQ7AmADvMkkefbEoUGC6XJ08uRz3Y+7oYLkyTeGsNyxMRTEX0Q/P4SbIuwby
         FAbFmH1owlhKVUszKDLT8MIy9d76o2f+jAB8Z8WbpDkAtX+X/YgmTQAe5vzw32SiSCQZ
         GzLGbTxwMOf3P4lZgBx989XOT5bwGNI1QRxywElbbPCP9OHXYKNiknCr0i5EgBPQctDM
         tb0kH5JLSLYdTJF7QxKTK6Zk2HB/59NUhVFRKVeCuOHbmjXUvBjPAdf1q2Plru9OV3oN
         P70wL8q9wFH7Fw0io7T9YsfkyJTxT99GmVqz8S78RRHtlR8ww4+/6ym3AjRDI1nhSWcr
         JfkA==
X-Forwarded-Encrypted: i=1; AJvYcCX8JCjY9hv5RUIMix2YBPw2AwedVHxiY2LUYXpdSbWyL+/aDKSFAcI0rKUe0h1JL82BgvaK+iNHq5TZ9960+4zUFJwKhhsUJeEwwtVwI/6fAnZ0WWA7tmRvlhtwUi6FAOMERmzr5XjM1atPGMtH
X-Gm-Message-State: AOJu0YzK9f8gPVufnrmXYAX/mcsmb85VcKIBJwYzhnl2Hr6GsYRnaIoK
	o1DBvADCjLcM/3PkbakcxY9iZaDJbtxTJthoarn96/NdfXfzVAy7hoYNGvhz
X-Google-Smtp-Source: AGHT+IFiMEE8vcBRLHjDWs3YHIlu2ehHo8qXk7IaGq5mKloU3XMoSSKxE6GHGml6aJxzSLp0uwNi5w==
X-Received: by 2002:a25:6950:0:b0:dfd:b921:1c9c with SMTP id 3f1490d57ef6-dff1543fff0mr10448609276.43.1718695903591;
        Tue, 18 Jun 2024 00:31:43 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff444fa0e0sm1050296276.64.2024.06.18.00.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:31:43 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6316253dc52so39186597b3.0;
        Tue, 18 Jun 2024 00:31:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVU4++/DKUjJFz9jj/P2ChVi6gpIPdgjOFQxASH+n2A9FWCk6n5bKw6H6Xes9prdhwvHX1zW31JlJ4p6vSbF9kPNyRER8Nzpsha/iCvjns+axGA3QCW/1gk9lsJ5i4ZX5tO5aC5ot4+6Vizo0f+
X-Received: by 2002:a05:690c:84e:b0:62f:c163:a05e with SMTP id
 00721157ae682-6340b2e5048mr60025167b3.30.1718695902875; Tue, 18 Jun 2024
 00:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-char-dsp56k-v1-1-56e435ffa664@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-char-dsp56k-v1-1-56e435ffa664@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:31:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVr53vcFYf8WZz2b6Bi2=2BbxYkSHnT2Cjo_5YmhjuAhw@mail.gmail.com>
Message-ID: <CAMuHMdVr53vcFYf8WZz2b6Bi2=2BbxYkSHnT2Cjo_5YmhjuAhw@mail.gmail.com>
Subject: Re: [PATCH] dsp56k: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 7:03=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/char/dsp56k.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

