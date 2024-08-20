Return-Path: <linux-kernel+bounces-293199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BE4957BF3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 05:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3782F1C23074
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0312D50A63;
	Tue, 20 Aug 2024 03:37:52 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235DA481CE;
	Tue, 20 Aug 2024 03:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724125071; cv=none; b=F2zRCqlqrlUv1lzWNyFRRlmfKRg1DAhCuO3FiUhszf/g4c2JNZo28hc7QKtdwXkfENLoe5WVGxpHhQDAWQgI5jLYRumdVzdmd46rcwBO5maPmAEaM9w7z19TL10F0qaGuEipeosVnfog7o2m0yWSF0Iml5bYbL9aYARuKmGZuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724125071; c=relaxed/simple;
	bh=Rt3PQpGwr0OrGnVMdnb4y8XjWOV8CrCp5TrgGCBQqkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T6q0hcR3dSOGQwrFvnou00nMKwpFWJytdXFmNd8fsIg0qbuqqQs/ZBhxWx6+pVHmk/IsujIOb1mx0sRwCnlOYpXZKfrEe81eMy3jhx7l8bcJZGaRI+ApLIYW/KxCkM9tW/uel4ZWF2kdopXhIZfFnL2IXiqrlcw9zxnOMdFlQCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so32116111fa.3;
        Mon, 19 Aug 2024 20:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724125064; x=1724729864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjZJNDLPpu1pUqlpHfBE30HIhjstanAnmmTUSnp6UOI=;
        b=sHeqZxDFhulOBSfSqNhoep/+JFA/mVQJsBgoYn69hiR+k0Hg1rQK9y8kqTPWA6BNdF
         /7PGc6jMJvERKxd32jIns49CnGkkiag4sWpaguLWeVvobV10mSG2nLe6ac7bBQ19dwaY
         K6tZPwFACq9qmxplpq3javnuE5xGTru/ItS6PlJJfZiTFH01QP2vGF7MPSkF338jbeLr
         pT6MHFt6Zq3/3QWMz1ZR3kyG1j4YW6yX1IEQV8hVLUnETRMg6d1WqZxIS+qTqszWtRt1
         OTuk8qAety3WeonL/i4oAUCGQ5EMtBurPzP25idDt8RcAKr6yhZPLy0nblqKo/j9KE7+
         EwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpuZn92suAnTlkmxPN/+RpyvkJx+VzPaCEc6R6Ho8ce0htE3KC/Dw8BTDzonjgD8FzAWbe/B6LPRTY@vger.kernel.org, AJvYcCXk+8D/LvuglF9t2V2hVFTu0QLfpGD6HDmR0O+wJEao5Yr2SgOFol8xWDjQBB4HnOwLPWUxYsyiPDCkv7nZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2g5nPYnNTh/F43CU6iaKYtC39QJyzWp2n7JWjL3GY+C3bFhA0
	P47UmKnAgX+GUYaSELJEHeDtDKg6nna8m35fMPEGfs9kuJfYObckh/3M6zSr
X-Google-Smtp-Source: AGHT+IE1xeA1mzo5Ky1FakdEByR5S1oMVssbr9OXL+HA9x17AZ233yiBYgWvsO5Y2+eWSw6Gj+My4g==
X-Received: by 2002:a2e:b8ca:0:b0:2ef:2dc7:a8f7 with SMTP id 38308e7fff4ca-2f3be57e7acmr103471221fa.7.1724125063713;
        Mon, 19 Aug 2024 20:37:43 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f3b746cc8fsm16701411fa.6.2024.08.19.20.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 20:37:43 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f3cd4ebf84so32115661fa.3;
        Mon, 19 Aug 2024 20:37:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwl24tEuVUcYRuw3q8M0qjOP5jB7mIaQu+1GJgna/B4lAd9eCGlo5nqbt+hukyJbmTXzfo2OQEtb+r@vger.kernel.org, AJvYcCX0EoBuZxAax+hit6fvpNy8n8alCCLjPqM7Hbzt6TXcFkSZlDrwm6WEu46rZs3n2+7oYMct2hf7ufTnVcku@vger.kernel.org
X-Received: by 2002:a2e:812:0:b0:2f3:abca:8b0f with SMTP id
 38308e7fff4ca-2f3be5b168amr78827001fa.27.1724125063104; Mon, 19 Aug 2024
 20:37:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a17e0df64c5b976b47f19c5a29c02759cd9e5b8c.1723427375.git.dsimic@manjaro.org>
 <24406e36f6facd93e798113303e22925b0a2dcc1.camel@icenowy.me> <25b65e9ef1cae59a8366532cc8db576b@manjaro.org>
In-Reply-To: <25b65e9ef1cae59a8366532cc8db576b@manjaro.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 20 Aug 2024 11:37:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v64aQAkqj1OR55HVyrVU=uNrH70fx+jOaT0SBMHBzCFgRQ@mail.gmail.com>
Message-ID: <CAGb2v64aQAkqj1OR55HVyrVU=uNrH70fx+jOaT0SBMHBzCFgRQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: allwinner: Add GPU thermal trips to the SoC
 dtsi for A64
To: Dragan Simic <dsimic@manjaro.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-sunxi@lists.linux.dev, jernej.skrabec@gmail.com, 
	samuel@sholland.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-kernel@vger.kernel.org, wenst@chromium.org, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 10:46=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Icenowy,
>
> On 2024-08-12 04:40, Icenowy Zheng wrote:
> > =E5=9C=A8 2024-08-12=E6=98=9F=E6=9C=9F=E4=B8=80=E7=9A=84 04:00 +0200=EF=
=BC=8CDragan Simic=E5=86=99=E9=81=93=EF=BC=9A
> >> Add thermal trips for the two GPU thermal sensors found in the
> >> Allwinner A64.
> >> There's only one GPU OPP defined since the commit 1428f0c19f9c
> >> ("arm64: dts:
> >> allwinner: a64: Run GPU at 432 MHz"), so defining only the critical
> >> thermal
> >> trips makes sense for the A64's two GPU thermal zones.
> >>
> >> Having these critical thermal trips defined ensures that no hot spots
> >> develop
> >> inside the SoC die that exceed the maximum junction temperature.
> >> That might
> >> have been possible before, although quite unlikely, because the CPU
> >> and GPU
> >> portions of the SoC are packed closely inside the SoC, so the
> >> overheating GPU
> >> would inevitably result in the heat soaking into the CPU portion of
> >> the SoC,
> >> causing the CPU thermal sensor to return high readings and trigger
> >> the CPU
> >> critical thermal trips.  However, it's better not to rely on the heat
> >> soak
> >> and have the critical GPU thermal trips properly defined instead.
> >>
> >> While there, remove a few spotted comments that are rather redundant,
> >> because
> >> it's pretty much obvious what units are used in those places.
> >
> > This should be another individual patch, I think.
>
> Perhaps, which I already thought about, but it might also be best
> to simply drop the removal of those redundant comments entirely.
> Let's also see what will other people say.
>
> >> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> >> ---
> >>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 22 ++++++++++++++---
> >> --
> >>  1 file changed, 16 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> index e868ca5ae753..bc5d3a2e6c98 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> >> @@ -212,7 +212,6 @@ timer {
> >>
> >>         thermal-zones {
> >>                 cpu_thermal: cpu0-thermal {
> >> -                       /* milliseconds */
> >
> > The unit of a 0 isn't not so obvious I think, so I suggest to keep
> > this.
>
> Quite frankly, I think it should be obvious to anyone tackling
> the thermal zones and trips.

Sorry for the late reply.

Not everyone writing or editing the DT would be fully familiar with
all the bindings. As Icenowy mentioned, it's not even obvious when
the existing value is zero. I would prefer we keep them.

ChenYu

> >>                         polling-delay-passive =3D <0>;
> >>                         polling-delay =3D <0>;
> >>                         thermal-sensors =3D <&ths 0>;
> >> @@ -236,40 +235,51 @@ map1 {
> >>
> >>                         trips {
> >>                                 cpu_alert0: cpu-alert0 {
> >> -                                       /* milliCelsius */
> >>                                         temperature =3D <75000>;
> >>                                         hysteresis =3D <2000>;
> >>                                         type =3D "passive";
> >>                                 };
> >>
> >>                                 cpu_alert1: cpu-alert1 {
> >> -                                       /* milliCelsius */
> >>                                         temperature =3D <90000>;
> >>                                         hysteresis =3D <2000>;
> >>                                         type =3D "hot";
> >>                                 };
> >>
> >>                                 cpu_crit: cpu-crit {
> >> -                                       /* milliCelsius */
> >>                                         temperature =3D <110000>;
> >>                                         hysteresis =3D <2000>;
> >>                                         type =3D "critical";
> >>                                 };
> >>                         };
> >>                 };
> >>
> >>                 gpu0_thermal: gpu0-thermal {
> >> -                       /* milliseconds */
> >>                         polling-delay-passive =3D <0>;
> >>                         polling-delay =3D <0>;
> >>                         thermal-sensors =3D <&ths 1>;
> >> +
> >> +                       trips {
> >> +                               gpu0_crit: gpu0-crit {
> >> +                                       temperature =3D <110000>;
> >> +                                       hysteresis =3D <2000>;
> >> +                                       type =3D "critical";
> >> +                               };
> >> +                       };
> >>                 };
> >>
> >>                 gpu1_thermal: gpu1-thermal {
> >> -                       /* milliseconds */
> >>                         polling-delay-passive =3D <0>;
> >>                         polling-delay =3D <0>;
> >>                         thermal-sensors =3D <&ths 2>;
> >> +
> >> +                       trips {
> >> +                               gpu1_crit: gpu1-crit {
> >> +                                       temperature =3D <110000>;
> >> +                                       hysteresis =3D <2000>;
> >> +                                       type =3D "critical";
> >> +                               };
> >> +                       };
> >>                 };
> >>         };
> >>

