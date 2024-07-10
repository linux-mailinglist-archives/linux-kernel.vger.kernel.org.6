Return-Path: <linux-kernel+bounces-247181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC3492CC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9876D1C22F65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 07:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B22D84D3E;
	Wed, 10 Jul 2024 07:51:47 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBE784D12
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720597906; cv=none; b=PVgxOza4luUhuttr/4idqOegH/ADA6wir9JpjowmFokTOaPO97EtF1NGvaX2vpdcFPcBA/kNcjxofqSEuHwYjTgPsB63dq80m9yJsjbcFUls07v/BVtfQOJvFFPCUSHolleXEdzgjKfo2aRgvCeg8UBPf6mbqLdCbdz8tNVa6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720597906; c=relaxed/simple;
	bh=fROySEc7Nwi1oKO0n7ctYzkZdFjrsdxsGKuMuZVUoBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwXftGQUE8FflhX8I54HHyB8EKRvImpUIq5FAOJ3mNa5GsZ3t/m2H5Cd9CggcITmnE5349/+PwuCcKG3Gt1doPeYacAqHAoAnLPSyUz2V1qbzTO1ZkqJVXd7jO5kKu4uLNql56m4RtuV48MoEML5wcj9AS2i+i0rSGAcrqb06uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-64b29539d86so54901207b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720597903; x=1721202703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xwUkC2957U6M9JtnEiR4qwk1hE+eeGWalXN7vG7quE=;
        b=asAwjdXXkXtEcNs40P7LmxaqbEqIaeYFnMM05GUIBFRuOb7r6repKlB6SHJDB/iPKJ
         WzWrldo2iXul4OLu+uJJ5OsyywhFFCh+IYK6PEOeG7MpJ1fJME6UvqSQoByizAbs3not
         OH+pcdl+DIDEZCTFZuNV/UDJHRMlQLaYN5q8VV5ogCaHWj4kYjWYza84vfQ43gITq72X
         lPAZmg+muSH3K4am2js8AB3BY0p2qqFU5mt6sUS4A6ZOkeabatpTMbn/XZE8f5Iza2HK
         XioWD80E7+wqxrow314vwvcFXNK4JQ+5t4MyCfVgBE4xAIZb18sEQqtuocVtGk+Pjgau
         iTdg==
X-Forwarded-Encrypted: i=1; AJvYcCVWNOtc2vRbmsI1CaOq9RCO9aVdXueOm4z/w7E1knQp/rEQTwr0OU7U+xMem9wVx3QGvljK2o8fnWddXZidukOCbJdW/pxrecjS/tjp
X-Gm-Message-State: AOJu0YyiWNGFw2UjpOJyYS1MkQrrKOmhyQbC6T1gTdtwT0is3JGaueFE
	OlSecxubOaHBpHmvSn2xLoRzMLnC3IeLnGprZRl0026HVd8pJCDYvz6If3YF
X-Google-Smtp-Source: AGHT+IHtxvWv9hh8rTaq8NV4nS78GHyh5yq12DEQ7tkFC7Kknra5+Aj4f0qFCJmG2HlUHMN53KGwrA==
X-Received: by 2002:a0d:e6c3:0:b0:650:9e71:bde7 with SMTP id 00721157ae682-658ef24b7b8mr54470957b3.26.1720597903299;
        Wed, 10 Jul 2024 00:51:43 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-658e4d2b667sm6447847b3.51.2024.07.10.00.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 00:51:42 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dfab4779d95so6251897276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:51:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0v7vnnWJqn1gGVAzDLxMT/R9A/4DHSp0c9IUe/9sM4dSsbbuT3e6ErQ8gfRjNbgBhwmmv/fi+XVn8RLQ7ACuFIqBlWddcDKdH6nx1
X-Received: by 2002:a25:946:0:b0:e03:b319:e022 with SMTP id
 3f1490d57ef6-e041b122232mr5456419276.43.1720597902668; Wed, 10 Jul 2024
 00:51:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710073413.495541-2-gregkh@linuxfoundation.org>
In-Reply-To: <20240710073413.495541-2-gregkh@linuxfoundation.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jul 2024 09:51:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2Y57bXMHjeGt+-vVQs-12DsoeXNYQ80NL+obbCrQiZw@mail.gmail.com>
Message-ID: <CAMuHMdW2Y57bXMHjeGt+-vVQs-12DsoeXNYQ80NL+obbCrQiZw@mail.gmail.com>
Subject: Re: [PATCH] zorro: make match function take a const pointer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 9:34=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> In commit d69d80484598 ("driver core: have match() callback in struct bus=
_type
> take a const *"), the match callback for busses was changed to take a con=
st
> pointer to struct device_driver.  Unfortunatly I missed fixing up the zor=
ro

Unfortunately

> code, and was only noticed after-the-fact by the kernel test robot.  Reso=
lve
> this issue by properly changing the zorro_bus_match() function.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: d69d80484598 ("driver core: have match() callback in struct bus_ty=
pe take a const *")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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

