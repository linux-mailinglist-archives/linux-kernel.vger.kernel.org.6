Return-Path: <linux-kernel+bounces-242117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079889283BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 10:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37FD41C20FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C65145FEB;
	Fri,  5 Jul 2024 08:35:23 +0000 (UTC)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7912145FE0;
	Fri,  5 Jul 2024 08:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720168522; cv=none; b=cAWaXd7CKf54fS/WfkUl1Xf2gvqpKoB7VQSQETHicc6aQ+kDSnJyXT8Gso8BYDRVVjfpAATFISf5cmwoQm0o6NbQcGdfzUpMn5gshBqCUajOBRKBKg6fCAHP+Tu8RLI6r9q44CnyYaML1QFoG3WiAu8pIg2ARe33EX5pjeM9T1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720168522; c=relaxed/simple;
	bh=7SKVpXebhGtAULUA84jFZRf2ihA+hSwEJm+gpDjigQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jraB6QADocf7sgdPR6Zf9h1AY9IfGs8sHPIvwnSxQyrOQD1lOVYfypn4H/h+Vk65MPoCsDdYgtrP00iImX2TgjiG+rDu/ExV+5poIWqdefq1zWHF/tLCyHZu19EGHd08cUb6rgN0qb/QoLubw5JjpS9Jqmirfxak7pd09SOzSdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-64b9f11b92aso11605247b3.1;
        Fri, 05 Jul 2024 01:35:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720168520; x=1720773320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE91erkMeoxPa1kwR1rnj3p6jtCHsExCdaiCmXk/lwQ=;
        b=OlPAdhIbPN32uSMqhih9wxuRbAMECMNJQm123yLJPZ+DNeHILcPfhILxT++uqGTvms
         zz8/qmS2CXoZFQGVHcdO/V2Kwypw7b28Xw/mXe+r6Sp323MOsZJB+yExBnNB/lsA1svQ
         0l4pBlKOL1fAqWi5nBBGnhmWR4BilsWqp6mKnL6852wwktHAPZTwb+ssggQy+ln6Zp3Y
         AKqj+K91ZdPaQx/+gqymnZss/r0Lu2PNz86cIoDcuKxcu4HPEppII7ZYIWWRMIiRu3vg
         YO8hfY+gsKJz1WrXcuMvyTyPkiMQuaRNQjAERx9HNX0iYgkmoxkRkwwVSEvxGRBTTw9l
         t4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1OvK3J1eBHlKdU8gGydGDmkHQB7QxfM9F8tL/AyHAR8BqlWGcM1TfJccdbdS9E6Q68rhp5hW4ByxNg52kcvEZNK3Kzq0GHp6p9RpDfc62CqKw90fWby8gZl/8oQcaAJCp0PsD2NGB0A==
X-Gm-Message-State: AOJu0YyRov3nFExNXqFZB9wwPs0PdpzvDEDsvBQH0X9CWVeeBnmzunX3
	HVY7IEPdINMVXuQXP1gIGQDFPyXo61HA0D8MwKZJxzI/BH/1bacBr/Ezjjte
X-Google-Smtp-Source: AGHT+IE5/lgBUlRXB4hx4/LLpzozqgz/KOnvtK7vZm/XFhpS6yvgQCk/Dhuvj8gdumYUddcAyehMEg==
X-Received: by 2002:a05:690c:6ac2:b0:64b:1e55:9bc7 with SMTP id 00721157ae682-652d5448f14mr51404657b3.14.1720168519762;
        Fri, 05 Jul 2024 01:35:19 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6529cb1d468sm5326457b3.105.2024.07.05.01.35.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jul 2024 01:35:19 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-64b29539d86so12029317b3.2;
        Fri, 05 Jul 2024 01:35:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW11Y5FL56O+72KpYAVNVjjtCu2WCDF1fhlSnOrs3CsPRwghZvon8q9KxM2rT88OuUr1D2DV1+5zdOy/GoqwrN4ij3un/xPJ25dNQ0EOBknDzhXE/YTo48GYwS9biLP/e5vzDDa0QMQNw==
X-Received: by 2002:a81:8b45:0:b0:63c:416f:182d with SMTP id
 00721157ae682-652d5444259mr39064367b3.12.1720168518902; Fri, 05 Jul 2024
 01:35:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702164403.29067-1-afd@ti.com> <20240702164403.29067-4-afd@ti.com>
 <df0f9705-b1e9-4dce-b110-09be540d5e25@beagleboard.org> <edfac25c-d708-4a55-a9bb-97d329877444@ti.com>
In-Reply-To: <edfac25c-d708-4a55-a9bb-97d329877444@ti.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 5 Jul 2024 10:35:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU55v0AR_jWojbWqdfWyzM-40Jvm5LnjE+hjdC5zNwRnA@mail.gmail.com>
Message-ID: <CAMuHMdU55v0AR_jWojbWqdfWyzM-40Jvm5LnjE+hjdC5zNwRnA@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] arm64: dts: ti: grove: Add Grove Sunlight Sensor overlay
To: Andrew Davis <afd@ti.com>
Cc: Ayush Singh <ayush@beagleboard.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Vaishnav M A <vaishnav@beagleboard.org>, 
	Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, Michael Walle <mwalle@kernel.org>, 
	Jason Kridner <jkridner@beagleboard.org>, Robert Nelson <robertcnelson@beagleboard.org>, 
	Robert Nelson <robertcnelson@gmail.com>, Ayush Singh <ayushdevel1325@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Jul 4, 2024 at 6:56=E2=80=AFPM Andrew Davis <afd@ti.com> wrote:
> The issue then is the overlay mechanism is not complete. We
> can add properties to nodes, and add nodes to nodes, and append
> properties to nodes, but cannot append values to existing properties,
> only replace them completely. This gap in the overlay system will
> prevent a general solution. So I've started to work on adding
> that property appending ability to the overlay system. I should
> have some patches posted against the upstream dtc/libfdt here
> in the next week or so.

This is not limited to overlays, but also true for plain dts.
We have /delete-node/ and /delete-property/, but lack /append-property/.

Hence we end up having to repeat all existing values when appending
to a property (e.g. see [1] appending to clocks from [2]).

[2] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rene=
sas/r8a77951-salvator-xs.dts#L39
[1] https://elixir.bootlin.com/linux/latest/source/arch/arm64/boot/dts/rene=
sas/r8a77951.dtsi#L3334

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

