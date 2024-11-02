Return-Path: <linux-kernel+bounces-393347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B149B9F86
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47E2826BB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70719186E40;
	Sat,  2 Nov 2024 11:49:03 +0000 (UTC)
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920C7F6;
	Sat,  2 Nov 2024 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548143; cv=none; b=LNQ0rQOtLZ4cK1VqLHLmWVMOHTts6ZI3AEy79RNGFZjItRx08Yy3B15/pXo0QMvsKLpWWjR9RhdK6yBwObUNEnJavu0PkK9LHgeAQWEids5AK4LtiLK55fJBWpwfcr/ZUBedsjUnUulcJ2AIO4PveZW1uY3SppXVpJRftN9xrTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548143; c=relaxed/simple;
	bh=W2cSYdIgTxYR8mOPhf+ODb+RkckYv34eRxJumqWmJ98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jzr3Tknydp7X2ww467gO3Y/BUuW1UHLJ9FhOgpbpL+hc6UNbGIdL1tZgplz+nPhk1DPVT/wrZHnu7qI+0oxbne9y8NKqgMxgnnXtmf9m5T4JoYPGvCOEt14A+RtoHuYhVYpK5dBrTRVZtwy+5JkkBegsD8pV7WrrIz65JAETmOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a6adaee7acso7914645ab.0;
        Sat, 02 Nov 2024 04:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548137; x=1731152937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCDur7kMwBxLZ7iPM36W+L8Iemo6gZ+3RoWOEA3d2yQ=;
        b=H9nEIKCvpGy71QNZu/p7cVNGyxTsvpwnQJweO8tKhcIZjzqqDgnanmy0T/wPqqYEm1
         dG4qlNnSo3/Lj6JJsGvea/pHde3177YdK01IYcLnCXBu1GGASWqiSZBXBJs2W3PKMKF/
         +3URsqhRayPXl73R3Zrzfb37qTOpmVqr87kFW+Nsrd/bu+HBrZzBqLmW/+KPjgaYFi05
         sJ42Yyehz8UhoMFLkQohl1HkMZhFh56sHJbEGJhfux/a1GxAbZ3ZHhJhE6JTYl3fbtAR
         XFHCX5zD6a1s1JS+bmPnJ1x9DMcdsG1ZjffgMiRPbIfYdZC3l097OSlyDpRsYzIZaEdG
         HiXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPolnl3mAOzMF/9zMcdwRFYD63CyciSRJjFEAU3e7xoK4f7ewhfu+p0Ljy039mgd816gH0vLDmIlePW/mn@vger.kernel.org, AJvYcCVPpSfVApHZhZHNHnugo0xkzLM0tVFwt4IKhIgiDhx+p0ruFNEZOMbgdsTa7uk5j34+7QVvW5C1iURO@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZpcL5Uc7mBLYREdEdZjrZ+BkMq2xFjp2HI+rfPhYYDKnLbuC
	ZMkE1IfHQW5jI3g/qZEOnuD98oDFG11FfmeF2Ep53vQccktYe+JFUQ6dxvF3HU0=
X-Google-Smtp-Source: AGHT+IHcWdsMnb+Nu566FNwvSGOeJZwI2yU7n3VRWpobNlLaab3UQj8pI3gEvfEQ9ARE/GpX2qQ1XA==
X-Received: by 2002:a05:6e02:1c01:b0:3a6:aee2:1696 with SMTP id e9e14a558f8ab-3a6aee218b9mr59957085ab.21.1730548136763;
        Sat, 02 Nov 2024 04:48:56 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4de048bfbe7sm1131748173.54.2024.11.02.04.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 04:48:56 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-83abe4524ccso99132239f.1;
        Sat, 02 Nov 2024 04:48:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZja1syE9tnXG5AV51O9pizDsVWhSxDiUhRmkY5wa2xJlNOJlEqPTs36DfxbPbaFvUoow7LfPhE7rH84qq@vger.kernel.org, AJvYcCUpGLXIl3gZQSXTSr3mzI1SaLJwbVGRuhsiH05YIXfJYpf528HIvxBe+bJsevepIz6Ruxptr66NytVz@vger.kernel.org
X-Received: by 2002:a05:6602:29ce:b0:82c:ed57:ebd9 with SMTP id
 ca18e2360f4ac-83b650372b4mr1250261339f.10.1730548135524; Sat, 02 Nov 2024
 04:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest> <20241031070232.1793078-11-masterr3c0rd@epochal.quest>
In-Reply-To: <20241031070232.1793078-11-masterr3c0rd@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 2 Nov 2024 19:48:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v66TAttAezXE7TnT5N6XFW2482ipuqkcpwjeDud6v=xD3w@mail.gmail.com>
Message-ID: <CAGb2v66TAttAezXE7TnT5N6XFW2482ipuqkcpwjeDud6v=xD3w@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] arm64: dts: allwinner: a100: perf1: Add eMMC and
 MMC node
To: Cody Eksal <masterr3c0rd@epochal.quest>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Nishanth Menon <nm@ti.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Viresh Kumar <vireshk@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Yangtao Li <tiny.windzz@gmail.com>, Parthiban <parthiban@linumiz.com>, 
	Andre Przywara <andre.przywara@arm.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 31, 2024 at 3:03=E2=80=AFPM Cody Eksal <masterr3c0rd@epochal.qu=
est> wrote:
>
> From: Yangtao Li <frank@allwinnertech.com>
>
> A100 perf1 hava MicroSD slot and on-board eMMC module, add support for th=
em.
>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>

So I skipped this one since Andre had some questions about the previous
mmc clock patch. And I believe this one won't work without it?

ChenYu

> ---
>  .../allwinner/sun50i-a100-allwinner-perf1.dts    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index 2f8c7ee60283..d418fc272b3c 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -39,6 +39,22 @@ &ehci1 {
>         status =3D "okay";
>  };
>
> +&mmc0 {
> +       vmmc-supply =3D <&reg_dcdc1>;
> +       cd-gpios =3D <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
> +       bus-width =3D <4>;
> +       status =3D "okay";
> +};
> +
> +&mmc2 {
> +       vmmc-supply =3D <&reg_dcdc1>;
> +       vqmmc-supply =3D <&reg_aldo1>;
> +       cap-mmc-hw-reset;
> +       non-removable;
> +       bus-width =3D <8>;
> +       status =3D "okay";
> +};
> +
>  &ohci0 {
>         status =3D "okay";
>  };
> --
> 2.47.0
>

