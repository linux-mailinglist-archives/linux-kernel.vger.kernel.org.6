Return-Path: <linux-kernel+bounces-393327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE2C9B9F49
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 12:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C8E3B21151
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 11:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067E3140E50;
	Sat,  2 Nov 2024 11:30:06 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699A1171E7C;
	Sat,  2 Nov 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730547005; cv=none; b=YF3j3pwBlZjVAmahleGCfmXwJYDmaX5fc398y2XPTVvnuDtzyJjuklQm7VeBjKFkegbJV0wyTWSfzfYp5XcbJKXn320sjnS4kYy3qnb/SNkcmZBlF3a+J3raY/qh6LbZTDDldZVGdI7sNzyajHM9knpUAjYOFXwCxDhocpAwgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730547005; c=relaxed/simple;
	bh=/F1oVefCGAZN0JK03Otc0zwkAJofnTFCZ5g14PrPdhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tQZZgBwpZ2VP9x1c2azGal6Tj0gwG/kiE6uRH85oVy3PcN7MaeQxyGRvcWgjtB9IR+hujpUzb43rPAAdugZaKwN+KzriHrRcpWITI0yvGBiX0ClnHWzGHFaXHWbfCegzZraKTJVzzEykEJPdXKLmjrSZwMLGn3WsTn/jNJJIGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb388e64b0so26861921fa.0;
        Sat, 02 Nov 2024 04:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730547001; x=1731151801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2//9P0I4J3XvBkNzIbbNIA2dq470ULwziNwddPzImEE=;
        b=JLCeWIJwB6LA3vVhXQffzWJsT8271aEJSjVm0fhHOIFwMEqNS9bwYr/Xxs+DPmCgR1
         a2i2XVlk4zEXlR/S30F94BTi3XrbtBAVJKma++yUy1zG5HqoyMVyB+27JtYTi7UQADdZ
         NotHXZ9leTdi/dmS5q0vGO1xDggmhPfzrCQjpcQBKdNHSwsSY5b4vpT+5AIHncaR2I/J
         YjdnHtCP9HnllQhIj9OYVhe2Y6AJTMKKUlBfG5YvPv55yWYRwO10gAYswCMSp0qYwLg7
         FUSh4r+i7NFhHVawg0zF94rZWQFeeDAJ5hHu4WQKuN8Xz/RAaQ6kIhPnfBUa08EmiLMe
         aZPA==
X-Forwarded-Encrypted: i=1; AJvYcCXBdE+hSxsbphEtod99+LN8gkB5pTYHNarAJdjw9uNNYOWjg7rvv4crLpRPlPcxkKctOZ0gClev7u5X@vger.kernel.org, AJvYcCXXZ52KTS5ZU5iKHGUl2UVrQjzJc3xG9wx8U22oT76ENKWqnj4YYnwcZ991dQcy2bQoB12SWKLQublwFHWz@vger.kernel.org
X-Gm-Message-State: AOJu0YzGEcEEgtLdNnPvSjDekotJk8VYpJBC3a0FXG9HBPHVBA1l3HaV
	nvnEhwOO3SjYxdWx440V7kqo4MssG3q2RIHwwFq2PrZSkmXujkeNTwwGHmqC7vw=
X-Google-Smtp-Source: AGHT+IFrCEbx/9JVN4tXGepoYmzDI958bCIzuo4JVpLTyA3kjQUkPu4EqFij1Km2PSsNvnwyvPZNLw==
X-Received: by 2002:a2e:b894:0:b0:2fb:570a:496e with SMTP id 38308e7fff4ca-2fd058fc799mr76866641fa.9.1730547000739;
        Sat, 02 Nov 2024 04:30:00 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef8fa17asm8694781fa.134.2024.11.02.04.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2024 04:30:00 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fb5740a03bso26144251fa.1;
        Sat, 02 Nov 2024 04:30:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7KTVv7eLVaoyZ4157Y+OOQ4wBZr4wFIK+JgsOaNKfO4reqGEtG9n+579u1qriIPny41uw+MVf/Dul@vger.kernel.org, AJvYcCXAiWmRPaEocMAfwwhNdd1QwXPxIpnfWSW7ELT/BBNc/YizCeP7vKcwgbZez0s1W/3AB0WQgQ3MAWnxQRpt@vger.kernel.org
X-Received: by 2002:a05:651c:1508:b0:2fb:656b:4c69 with SMTP id
 38308e7fff4ca-2fd0df8886amr74910741fa.43.1730547000254; Sat, 02 Nov 2024
 04:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031070232.1793078-1-masterr3c0rd@epochal.quest> <20241031070232.1793078-8-masterr3c0rd@epochal.quest>
In-Reply-To: <20241031070232.1793078-8-masterr3c0rd@epochal.quest>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 2 Nov 2024 19:29:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v66meMUPwOUr4Qutqu7TO-UwDtCdwOhwDv8JE_JMZi=58w@mail.gmail.com>
Message-ID: <CAGb2v66meMUPwOUr4Qutqu7TO-UwDtCdwOhwDv8JE_JMZi=58w@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] arm64: allwinner: A100: enable EHCI, OHCI and
 USB PHY nodes in Perf1
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
> Add USB support on A100 perf1 board, which include two USB2.0 port.
>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
> ---
> Changes in V2:
>  - Add dr_mode here, instead of in the .dtsi
>
>  .../allwinner/sun50i-a100-allwinner-perf1.dts | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dt=
s b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> index f5c5c1464482..2f8c7ee60283 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100-allwinner-perf1.dts
> @@ -7,6 +7,8 @@
>
>  #include "sun50i-a100.dtsi"
>
> +#include <dt-bindings/gpio/gpio.h>
> +
>  /{
>         model =3D "Allwinner A100 Perf1";
>         compatible =3D "allwinner,a100-perf1", "allwinner,sun50i-a100";
> @@ -18,6 +20,36 @@ aliases {
>         chosen {
>                 stdout-path =3D "serial0:115200n8";
>         };
> +
> +       reg_usb1_vbus: usb1-vbus {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb1-vbus";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&pio 7 10 GPIO_ACTIVE_HIGH>; /* PH10 */
> +               enable-active-high;
> +       };
> +};
> +
> +&ehci0 {
> +       status =3D "okay";
> +};
> +
> +&ehci1 {
> +       status =3D "okay";
> +};
> +
> +&ohci0 {
> +       status =3D "okay";
> +};
> +
> +&ohci1 {
> +       status =3D "okay";
> +};
> +
> +&usb_otg {
> +       dr_mode =3D "otg";
> +       status =3D "okay";

Since you noted in the previous patch that OTG doesn't work if OHCI0/EHCI0
are enabled and probed before musb, maybe we should keep them disabled
for the time being?

You could leave a TODO item above the &usb_otg node.

ChenYu

>  };
>
>  &pio {
> @@ -178,3 +210,10 @@ &uart0 {
>         pinctrl-0 =3D <&uart0_pb_pins>;
>         status =3D "okay";
>  };
> +
> +&usbphy {
> +       usb0_id_det-gpios =3D <&pio 7 8 GPIO_ACTIVE_HIGH>; /* PH8 */
> +       usb0_vbus-supply =3D <&reg_drivevbus>;
> +       usb1_vbus-supply =3D <&reg_usb1_vbus>;
> +       status =3D "okay";
> +};
> --
> 2.47.0
>

