Return-Path: <linux-kernel+bounces-252338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFDE9311CC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58BCAB229AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96BA18733D;
	Mon, 15 Jul 2024 09:57:27 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B9E1862AB;
	Mon, 15 Jul 2024 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037447; cv=none; b=J+7twE0JTUeRSa15Kbwy8tVkaNtQBxtHl2cxZevGKDLJyrLe/pp5RKMYr/p2E3p6t/LKR0gKlW1KOqFUAYwW6oX9yJCBs7FFMv1A4y89F/0qKP2rnrUOifmpO+jyM0xsgwPj2s8DKuO/aQvwfYbck04RJXmU2zIvZutgblPfEI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037447; c=relaxed/simple;
	bh=wj+1a6WKtsaJE7FJoENh/Oxzux7Kwyys96yvSwp5vX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DiOukfp6+QSSPtdEka+tBa33UXEum3KQpi8qKg5vAvo7weHME5I0/V6TSH7UMChy/VdI0XoLoLyAyexv/5BR8LmO5MGMr7ElrA46ZQgmRCgOe2YSS60K2e4L5+Sv7NAuA3RoebnD6pTPuMTMaDr1MZZTJh64F2Wrq7Y2fGGIKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-65f9e25fffaso16696427b3.3;
        Mon, 15 Jul 2024 02:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721037443; x=1721642243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Qqy5cIX9PhtoM3TjYnJhIKyX/+ffYHuIFVo0LyE7OQ=;
        b=dM9XppUuSrs44lJC7pBxDun442v6VHwbN+lIKW+ciJFIzdBKzEKQ0xqWC/mqi1oqq0
         /PnuyWiCiU3kpL/OeOcUxDkTigBoGpH0xRe7UhthynGszXHAQLkVXNZltxb595VHUVb8
         jQ/KYDtwFeqkjNDzrS8FdxpVQ9rnyCsbedyJr8oL5mOiBkJWJ9r0vAjjEapbk9vKRCST
         rlDTpYcdFNnloMJdNFzvo0eqw6NO7ZjaboOiGTFOi/tmxv/kLOcZtXa7H23mqwavdTX4
         2h+2vLDqsthXNrZPMBp+CdWzOFAxcmlxfLin73M+MHAfK1aik4c2CrfxHxAFoiDs4VCB
         5Aeg==
X-Forwarded-Encrypted: i=1; AJvYcCUf/PnCCCTsURdcyD16jWkEVsQKSrJZTvUW4PB+HtJ+Huw2A2kVdTHrsQHhOMuC6zzIshbOH7LwK1jGflbpbdTyvj6TqKR7JhWqUzb1aeYc1KE9FdXzq9M1/TQmu7M2Q2hYncI60O2u3w==
X-Gm-Message-State: AOJu0Yymk8fCZbUtQk0+xPWydWZrS0sw36DeQgpJepAdaRoht17MvNn+
	i+yLDenLGW9OLI19hCUfwOWV7ok/Oc3hRCigI+6YuS+Xl4BDKfmUA1w5y5bI
X-Google-Smtp-Source: AGHT+IGXo8OChVetEwglrdPuKmDdFj3wiSDQvoUAfUrkctEwJkUPY9SlOimXp2x4N9Fr51LTgDmmdg==
X-Received: by 2002:a05:690c:3385:b0:62f:2553:d3b3 with SMTP id 00721157ae682-658ef3414eemr252515777b3.29.1721037443194;
        Mon, 15 Jul 2024 02:57:23 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc29fa091sm7351877b3.54.2024.07.15.02.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 02:57:23 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-66108213e88so9154847b3.1;
        Mon, 15 Jul 2024 02:57:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU38JNtt845rBTRaDetr/dEx/zYvmI7HbhGZcA3hrGFlI5q39QUUGJ4hTJTzsAJ16pJRf19L0pYDFroFEc1gE9vdCaE3xH/DtKMeVFiVLUBfgt7DNXKMDCNIJ7d44OnhIa4/PAwEkMPoQ==
X-Received: by 2002:a0d:f0c6:0:b0:65f:77c3:63a0 with SMTP id
 00721157ae682-65f77c36408mr73368237b3.7.1721037442731; Mon, 15 Jul 2024
 02:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711085930.26252-1-krzysztof.kozlowski@linaro.org>
 <CAL_Jsq+WdctoTMNoakiY5kh4nDoNx5h522s76LoHyD_yKYvvSg@mail.gmail.com> <73038a80-ce58-4967-a258-d6befe23c777@linaro.org>
In-Reply-To: <73038a80-ce58-4967-a258-d6befe23c777@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Jul 2024 11:57:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWkGD1gcwrLhd_fSdJLV2SzCVJ=yo+ekhOAfjUp=5Hh3A@mail.gmail.com>
Message-ID: <CAMuHMdWkGD1gcwrLhd_fSdJLV2SzCVJ=yo+ekhOAfjUp=5Hh3A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: incomplete-devices: document devices
 without bindings
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>, 
	Jonathan Cameron <jic23@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Sorry for being late to the party, as v2 was sent, and applied ;-)

On Fri, Jul 12, 2024 at 11:41=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> On 11/07/2024 15:01, Rob Herring wrote:
> >> +      - description: Incorrect compatibles used on other PowerPC devi=
ces
> >> +        enum:
> >> +          - 1682m-rng
> >> +          - IBM,lhca
> >> +          - IBM,lhea
> >> +          - IBM,lhea-ethernet
> >
> >> +          - mpc5200b-fec-phy
> >> +          - mpc5200-serial
> >> +          - mpc5200-sram
> >
> > Tell Grant he needs to document these. ;) JK
> >
> >> +          - ohci-bigendian
> >> +          - ohci-le
> >> +          - ohci-littledian
> >
> > Given the typo, I think we can just drop this one from the driver.
>
> Sure, I'll send a patch. It could affect some ancient user, though...
> Although I really wonder if any of these PowerPC boxes are still alive.

Looks like you forgot various "chrp,*" and "pnpPNP,*" ;-)

You can scavenge a few from my old LongTrail DTS
http://g33rt.be/migrated/Linux/PPC/DeviceTree.html
Note that my actual machine died 20 years ago...

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

