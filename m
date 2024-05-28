Return-Path: <linux-kernel+bounces-192737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE828D2176
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5ACE287136
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 16:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EFC172BAB;
	Tue, 28 May 2024 16:17:34 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5C172786;
	Tue, 28 May 2024 16:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716913054; cv=none; b=N81oU4dT5TLjC/mtV0rMPch26a9ChWfW8X3xLfe5KEVVCwj2BEJYeXMDTCWyAsiUkVkqb1gEP8331lkAqhYA+CrOIFKwOnV3ueNAlptQ6ujkSoKoOEu4SK8xJ+nZyNR6GPV9aY7YnUOgh5HzRtF9uObImQoTISF2wGCqyBgRI8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716913054; c=relaxed/simple;
	bh=Qg1ZgDVmVI3JngvJbDkj1kDsBOQuYV4ctHoNN85SGpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GH4/zQPjHN64I4WISAF+XPmSzSsbjwbxAulh/r9jKmof5JdxYfbrZZNNylw7VCBnZAKmD7RZEnThMZIkPLDK8nCx8YRsYExme0wnOmQ+EGRnVnOCo6rCanOTvZM3LZUJ0OJ/jUQrb19Dp0cAYeuyH3T3n/QHNgqZF06fYZFFc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e716e3030aso9791281fa.2;
        Tue, 28 May 2024 09:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716913050; x=1717517850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YuYYPRGQXgZywwznt1xenM17tafI6dgKzS08CmDQDQY=;
        b=PCZv+7z+MyJZNAymjuSdRxHAdqxjIzcrXdKZZiYkNg+eQOqsRrxo+05LDBUeaHrgsL
         vIH4rebA+5NyA7wdGlF78ZXME8VApQlsTFjYdCv5usoivhKhtuG1eIGL1fzO/G/cZcAb
         B4rS8mNNizrtGkk7nsfKXWQmCu9zQ5V8Xnsp16BXcW5oy9pHlmsfcYfaG7VLdSNO5Ad2
         IwNVoHvWRcEj9rrXJJMuHkWhiW/yNdIGBvJN0khwtN0LZNtCQ87CMYPhe0TogeGMCTbR
         jkAKBC8nAvyq/QPe2TFoHLqkQgeaOPfJs6bPT3AoL3JjCzcFFvUxoC6ehjzwDLKKajWC
         PXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnSSZOADDWbNRbfACGYuq6/cxG5YkBI07XDAJKCH7YeFWSiG/f57pF6wkvt04OU+2A9Wz4kw58WHNjofN/pASQ1cK5KrT03GzC1pOMihKclGTR/kkf2+MNyzPkWPgxzfZC9eCme/XULg==
X-Gm-Message-State: AOJu0YykVNPlXMIsRkCfFYwULmjzY53Xw4O8VP0lRNbECSYGhytyEcFR
	sc0eSKg4v3T1G2l9MG7SqmQu8HFBfjAVv+S4InKpv/Lc1hJkgSYhwUZGnR/V
X-Google-Smtp-Source: AGHT+IHFWt6YoFADT6Qj7CHe+dkcJHQFzidXJxAdZCxH2yphoW+W9v+twUc1VtikHozMhXq9zN+nDw==
X-Received: by 2002:a2e:3518:0:b0:2e1:7acb:6c40 with SMTP id 38308e7fff4ca-2e95b0c12f8mr71156421fa.29.1716913049997;
        Tue, 28 May 2024 09:17:29 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcd8e21sm23048941fa.43.2024.05.28.09.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 09:17:29 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e72224c395so9889621fa.3;
        Tue, 28 May 2024 09:17:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3yD9MIE/07BhM/J/Su8bib+Yo14KZHHTMgfSMULhMNVQ4JNfng+ZaYDboOrjj4NYtG+dlOGd9T6gyiWvFvhb5KR+CBbe0TyAAeLF/zobWnjMi8mOV5iuMSMtdYbGvS7+KhEgG/ouQcA==
X-Received: by 2002:a2e:b8cf:0:b0:2d9:eb66:6d39 with SMTP id
 38308e7fff4ca-2e95b09446emr83148521fa.19.1716913049300; Tue, 28 May 2024
 09:17:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716768092.git.dsimic@manjaro.org> <171691265237.683236.11362059742528552634.b4-ty@csie.org>
In-Reply-To: <171691265237.683236.11362059742528552634.b4-ty@csie.org>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 29 May 2024 00:17:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v66LrU86h3pDDwZ=30n14PtAhHU0Etxiqac5WKCTLqdZEw@mail.gmail.com>
Message-ID: <CAGb2v66LrU86h3pDDwZ=30n14PtAhHU0Etxiqac5WKCTLqdZEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Correct the model names and descriptions for
 Pine64 boards
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: jernej.skrabec@gmail.com, samuel@sholland.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, robh@kernel.org, uwu@icenowy.me, 
	andre.przywara@arm.com, didi.debian@cknow.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:10=E2=80=AFAM Chen-Yu Tsai <wens@csie.org> wrote=
:
>
> On Mon, 27 May 2024 02:08:16 +0200, Dragan Simic wrote:
> > This series corrects and, in a couple of cases, additionally simplifies
> > a bit the model names and the descriptions of a few Pine64 boards and
> > devices based on Allwinner SoCs, according to their official names used
> > in the Pine64 wiki and on the official Pine64 website. [1][2][3]
> >
> > These corrections ensure consistency between the officially used Pine64
> > board names and the names and descriptions in the source code.  These
> > changes complete the correction of the model names and descriptions of
> > the Pine64 boards and devices, which was started earlier with the Pine6=
4
> > boards and devices based on Rockchip SoCs. [4][5]
> >
> > [...]
>
> Applied to sunxi/dt-for-6.11 in sunxi/linux.git, thanks!
>
> [1/2] dt-bindings: arm: sunxi: Correct the descriptions for Pine64 boards
>       https://git.kernel.org/sunxi/linux/c/e1410c817ac4
> [2/2] arm64: dts: allwinner: Correct the model names for Pine64 boards
>       https://git.kernel.org/sunxi/linux/c/a72cf19bf50c

I had to do a quick rebase as the branch start point was incorrect. The
commit hashes will have changed. Rest assured that the patch is indeed
merged.


ChenYu

