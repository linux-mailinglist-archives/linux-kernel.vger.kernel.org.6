Return-Path: <linux-kernel+bounces-349178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D10E98F239
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C65B219D0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ADB19CD0B;
	Thu,  3 Oct 2024 15:13:12 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA911A0708;
	Thu,  3 Oct 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727968392; cv=none; b=bzjNppOIWTId/PiEiE6WMVhbGQkR4p2VSBjSF4udNFmbfU8XeVe9yTTxhj3kInZBNo7Bc0eKyWiUK2F9hZNE1OnnK/ng5upFE7gxqH32prJbbPCfW3WmwrV7Yr3mPp0DbBC0A5TGJd5/Y00/I+f1bulUe7CSa+ME9o+p/+kWa0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727968392; c=relaxed/simple;
	bh=dGlsxoZu8PtWpidPasr2wBeZc49hqi7PsXHUmZkFZy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1bGi8Y7t3bSSeEbWf9VDGKFKMVfYGnI03byvn52Q2Wakte9iU129m+wzQxBOEgF5x8vwp5XjX+ELIMbNx5WZhgk5QnCU6a4cUYY7twgWJAv1ICjywkuxxf+FqCoihXZ2n9/YbybbjEe2Te1wMSbOmB4qLC24s9Pp95sxmEnH6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82aa6be8457so36620939f.0;
        Thu, 03 Oct 2024 08:13:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727968384; x=1728573184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=itCr7VtHEe0udli0L/vyJJ6/QS8R3KvPPLhdxRcMv+g=;
        b=fwDQQbEks8iT9UGO1fXB/JECBA48JSqBwBIyCeFA6cWl7MgeXTuh4v6j/trjGUNo9H
         0XLLsd8AEEssSdzJcX1iutplQkfNQis5sSPOAmXi47fHwqJ4APXh8vKg/IlIwrEmWoIA
         rv/RNUVueDbuDmFpYKqmVlHtKtpF//KoBGw4SINV+VHy2ActNWXqAF5P2Wf5rMqrNDjo
         iScj17yoiiKXbugDjI5zt0howfcD8fjyEeqQ7ZlBb28sEARFe3CRIgUraDWF4P1sRSr+
         Q3p7gBhz/jS8p7Z+r0LFnxHBMdiwCNLwL7LCL2UAe/p7iuESazhBa6UzmFabe1kjpMUz
         ZtvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt3uSohd8iqsXZBqLRzY8ku2oUP3OgnH/GLrQkmbuJKkVPunra2+R4+dfhe7Pab3Bpp69OU98Qytiz@vger.kernel.org, AJvYcCWPUp/wBNLZhoGK/0h3VDa1MSHTKf99fTY/dzHWUdZq05JiHT0js/TwWF96V4PpZ1WeLcWCdr0fQu2Qy2/q@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK8PxGicXpWf5I9NY714dFRLvuRslUnvvrmdcD4wvsJDS9qWJ
	ZeNjaNq64CKG9QXnnyy2g14FRAWRB6BU5GNfMph+MX79mYlihxloYBS3R784
X-Google-Smtp-Source: AGHT+IGcg0YSneQvVfQMdQMoW73EVz5FMom32jWlJ82POoJcAH1v6AKRHAhkl28hvsomGgHcgRU9pw==
X-Received: by 2002:a05:6602:340d:b0:82c:f7c4:b093 with SMTP id ca18e2360f4ac-834e74a6138mr244733639f.3.1727968384060;
        Thu, 03 Oct 2024 08:13:04 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834efc4ef9bsm29897639f.6.2024.10.03.08.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 08:13:02 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so34660139f.1;
        Thu, 03 Oct 2024 08:13:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFDyKFTMG4ana3grsN+Hw0t/3seq39phAg68jYeDV7H624bnb7cLipNoJO+lEoeA5Z/58YZqsMxVZxiWdN@vger.kernel.org, AJvYcCVM+z0ClaGNeMuDNIj98MdNhsvIogKLcp1458IkcODNqSB8V2PZNUWEZSEZ12rAd2pNAbQda/+xu8pR@vger.kernel.org
X-Received: by 2002:a05:6602:2d8d:b0:82a:185f:5940 with SMTP id
 ca18e2360f4ac-834e76d16e0mr293099539f.7.1727968382525; Thu, 03 Oct 2024
 08:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003111444.543964-1-andre.przywara@arm.com> <20241003111444.543964-3-andre.przywara@arm.com>
In-Reply-To: <20241003111444.543964-3-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 3 Oct 2024 23:12:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v65jcxCYC7mess=4H9dz0gXk434tTyP_ATDvbrpdj_=aOQ@mail.gmail.com>
Message-ID: <CAGb2v65jcxCYC7mess=4H9dz0gXk434tTyP_ATDvbrpdj_=aOQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] mfd: axp20x: ensure relationship between IDs and
 model names
To: Andre Przywara <andre.przywara@arm.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Martin Botka <martin.botka@somainline.org>, Chris Morgan <macromorgan@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 7:15=E2=80=AFPM Andre Przywara <andre.przywara@arm.c=
om> wrote:
>
> At the moment there is an implicit relationship between the AXP model
> IDs and the order of the strings in the axp20x_model_names[] array.
> This is fragile, and makes adding IDs in the middle error prone.
>
> Make this relationship official by changing the ID type to the actual
> enum used, and using indexed initialisers for the string list.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/mfd/axp20x.c                 | 30 ++++++++++++++--------------
>  drivers/regulator/axp20x-regulator.c |  2 +-
>  include/linux/mfd/axp20x.h           |  2 +-
>  3 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 4051551757f2..5ceea359289f 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -34,20 +34,20 @@
>  #define AXP806_REG_ADDR_EXT_ADDR_SLAVE_MODE    BIT(4)
>
>  static const char * const axp20x_model_names[] =3D {
> -       "AXP152",
> -       "AXP192",
> -       "AXP202",
> -       "AXP209",
> -       "AXP221",
> -       "AXP223",
> -       "AXP288",
> -       "AXP313a",
> -       "AXP717",
> -       "AXP803",
> -       "AXP806",
> -       "AXP809",
> -       "AXP813",
> -       "AXP15060",
> +       [AXP152_ID] =3D "AXP152",
> +       [AXP192_ID] =3D "AXP192",
> +       [AXP202_ID] =3D "AXP202",
> +       [AXP209_ID] =3D "AXP209",
> +       [AXP221_ID] =3D "AXP221",
> +       [AXP223_ID] =3D "AXP223",
> +       [AXP288_ID] =3D "AXP288",
> +       [AXP313A_ID] =3D "AXP313a",
> +       [AXP717_ID] =3D "AXP717",
> +       [AXP803_ID] =3D "AXP803",
> +       [AXP806_ID] =3D "AXP806",
> +       [AXP809_ID] =3D "AXP809",
> +       [AXP813_ID] =3D "AXP813",
> +       [AXP15060_ID] =3D "AXP15060",
>  };
>
>  static const struct regmap_range axp152_writeable_ranges[] =3D {
> @@ -1345,7 +1345,7 @@ int axp20x_match_device(struct axp20x_dev *axp20x)
>                 axp20x->regmap_irq_chip =3D &axp15060_regmap_irq_chip;
>                 break;
>         default:
> -               dev_err(dev, "unsupported AXP20X ID %lu\n", axp20x->varia=
nt);
> +               dev_err(dev, "unsupported AXP20X ID %u\n", axp20x->varian=
t);
>                 return -EINVAL;
>         }
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index a8e91d9d028b..3ba76dbd0fb9 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -1597,7 +1597,7 @@ static int axp20x_regulator_probe(struct platform_d=
evice *pdev)
>                 nregulators =3D AXP15060_REG_ID_MAX;
>                 break;
>         default:
> -               dev_err(&pdev->dev, "Unsupported AXP variant: %ld\n",
> +               dev_err(&pdev->dev, "Unsupported AXP variant: %d\n",
>                         axp20x->variant);
>                 return -EINVAL;
>         }
> diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> index f4dfc1871a95..79ecaaaa2070 100644
> --- a/include/linux/mfd/axp20x.h
> +++ b/include/linux/mfd/axp20x.h
> @@ -959,7 +959,7 @@ struct axp20x_dev {
>         unsigned long                   irq_flags;
>         struct regmap                   *regmap;
>         struct regmap_irq_chip_data     *regmap_irqc;
> -       long                            variant;
> +       enum axp20x_variants            variant;
>         int                             nr_cells;
>         const struct mfd_cell           *cells;
>         const struct regmap_config      *regmap_cfg;
> --
> 2.25.1
>

