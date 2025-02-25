Return-Path: <linux-kernel+bounces-531753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1815A44471
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B676718908CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A106925771;
	Tue, 25 Feb 2025 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="L8hsneJE"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC86290F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497436; cv=none; b=WHnwVtFKQrG1scquXdZ4kKuBZaaQIwHj6glMV8kQmyfi5jIDl8Wcs6g6D3ijlTqgUDAmOlwFQ0a78NAlIGeuXYj4vpKWuEOMtdJ+oF/Dx2NNvN1oWjz4IdtaepKOEZq3PyR785nPVDGtmVQK4uvQyrWlDg7A89SN2vYch8DyDzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497436; c=relaxed/simple;
	bh=IaKNOR+jJAMt3BEDuqUtFSYG0Yat04sYjFaoF4lMOyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeJBOfKuEEb5c61ZVxbq/arrsIltl7AxuBvdgt7EpvA7es2SZ64B+ZydHa1jSuseXCNoyFzTQY8Ub9WQeGpu10HEJ3TyomEeVzhyyRmAfeUYpSKM9dmb2v3OOAF11BSXWbM4tqqHVAO7NZbF1zgYtjj/9WsYvOzvTIeroinXcmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=L8hsneJE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e549be93d5eso6184688276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1740497432; x=1741102232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KwFIy+pfxKXbXFSW3tXFLJhNS2T5ZHeCg/y22PAaxLU=;
        b=L8hsneJE5y8QHXQk5CGCnHufi+uvUEDcnBMHu8LTJ8HS5/YJMexlFYEU0KwVTJkBeV
         joKtY6PLA7hOwx0g1QksVmcyHg21ZXdSVZZyEQhNAFqyJA35/2TtUdJ7DS+wcAg7zBci
         ws7rpRttZuAX8sm9i7AZ/z6Ium2ZkhWvnl810vlxLe+vrE/K5XHul71LJPHotk9Sgdxy
         UiWgbS1DzlDrc9cTO9akUqdRIM61HN0wL2TrmIlOmq9FurFgd11MrDELGd9dI0NcVduY
         05fgXyeCOOIyrAl0P6v6QN/dagrWf12ew21v4l610QrKtk7RNDMraVLYKyJKoWcZdhRp
         BncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497432; x=1741102232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwFIy+pfxKXbXFSW3tXFLJhNS2T5ZHeCg/y22PAaxLU=;
        b=V6ZWwJrg2jrG9LK+/rjACFmxsej9l1hLRZpcC74d3RXFZ1e6hU1khGVkf2sIVe+yz8
         OKhmODNqLomW0AsLJAk126ywga8DXYnrNhBNl87Tg6h8e2ccXTbc/uaLiB2ajP4gTNzO
         meSneiJ3h4TpN4hNENGv4r2fD8Ih7jEqQIi/K3sSZBAjz4P9cfKema2N7nXTb5dlbVn1
         hEhbVjWFBmK72ozdeJVb4AsQV3jetLfLFP5V8A5Bby2/YSrQM7w5WclcnOpMBmwx4oP+
         IWxUhYmbjxGfEL9aLwuz8YyaLzaHj2zQPrI2JlMb0OysNffpr51pGCcJcDccX+7ZssZW
         SIzA==
X-Forwarded-Encrypted: i=1; AJvYcCV9JkcqZJXrdF4K1zvFrFraHXImIhzxHylmahfh+vgBAgEVvtml7mkotsGnlda2RVPr1kP0Wu03e2/ZCJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQUxoTFvkdvJ044XrEnze0r7NCAovG1IgRtOsO6W6FMjDPEUNk
	LivUAtQ4dgOPL3GLEk3EnIjHsVJiQxyNGxlLalg9S3YLW8UOGmEryX1WOeVXWFhTywzRSkwI1QY
	hQNPsRx/ZkEHbkxBxwkTb9yTJY1DhVJp6vxRiTRGg6i+VkX5F
X-Gm-Gg: ASbGnctt2dk5kG3u9hlMhgeJ/iSF7Vct7gr/zMEs9zBTnwGndoe8MzYDtL/WBR+LnmZ
	GtMHhmlwo39i2zOH3DG9NDmMyoncviqKEEbw9+hg71i1aCZ6iPeeJecrOIo2eruN4nNYL+LhdGV
	PsgaFfIsGIg9/xamFYgd5XleQVXdQgim0p9JbKqbE=
X-Google-Smtp-Source: AGHT+IF67EI0gNo1oQTwHhmZVcpbL4ZitqmXV46b+PzRbtROLKZwoilrpvSrY1kXE0u0S1BQog3YNexBmVYItvnDdOk=
X-Received: by 2002:a05:6902:1706:b0:e60:782f:3a34 with SMTP id
 3f1490d57ef6-e607a4c9e5dmr2905768276.2.1740497432457; Tue, 25 Feb 2025
 07:30:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-b4-ov9282-gain-v1-0-a24af2820dde@linux.dev> <20250225-b4-ov9282-gain-v1-3-a24af2820dde@linux.dev>
In-Reply-To: <20250225-b4-ov9282-gain-v1-3-a24af2820dde@linux.dev>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 25 Feb 2025 15:30:16 +0000
X-Gm-Features: AQ5f1JqDNLQeYCXCr9B35EOsUjzzSxxxDQGLVzHslMJFFKWlkPxFWSjqna-ILMQ
Message-ID: <CAPY8ntCLUVX91+QYbFk-bHQumuvs70CuDLe85VZRTS2wW-tYHw@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: i2c: ov9282: fix analogue gain maximum
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Richard

On Tue, 25 Feb 2025 at 13:09, Richard Leitner <richard.leitner@linux.dev> wrote:
>
> The sensors analogue gain is stored within two "LONG GAIN" registers
> (0x3508 and 0x3509) where the first one holds the upper 5 bits of the
> value. The second register (0x3509) holds the lower 4 bits of the gain
> value in its upper 4 bits. The lower 4 register bits are fraction bits.
>
> This patch changes the gain control to adhere to the datasheet and
> make the "upper gain register" (0x3508) accessible via the gain control,
> resulting in a new maximum of 0x1fff instead of 0xff.
>
> As the "upper gain register" is now written during exposure/gain update
> remove the hard-coded 0x00 write to it from common_regs.
>
> We cover only the "real gain format" use-case. The "sensor gain
> format" one is ignored as based on the hard-coded "AEC MANUAL" register
> configuration it is disabled.
>
> All values are based on the OV9281 datasheet v1.01 (09.18.2015).

My web searches turn up a 1.53 from Jan 2019 -
http://www.sinotimes-tech.com/product/20220217221034589.pdf
That lists 0x3508 as DEBUG, not LONG_GAIN.

The current range allows analogue gain to x15.9375.
Expanding it to 0x1ff.f would be up to x511.9375. I believe that
equates to ~54dB as we're scaling voltages, not power. The spec sheet
for the sensor lists S/N of 38dB and dynamic range of 68dB, so x511
will be almost pure noise.

Doing a very basic test using i2ctransfer to set gain values whilst
the sensor is running suggests that the image is the same regardless
of bits 2-4 of 0x3508. Setting either bits 0 or 1 increases the gain
by around x8.5, but they don't combine.

Overall can I ask how you've tested that a range up to 0x1fff works,
and on which module? I currently don't believe this works as intended.

  Dave

> Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
> ---
>  drivers/media/i2c/ov9282.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/i2c/ov9282.c b/drivers/media/i2c/ov9282.c
> index c882a021cf18852237bf9b9524d3de0c5b48cbcb..e6effb2b42d4d5d0ca3d924df59c60512f9ce65d 100644
> --- a/drivers/media/i2c/ov9282.c
> +++ b/drivers/media/i2c/ov9282.c
> @@ -54,11 +54,11 @@
>  #define OV9282_AEC_MANUAL_DEFAULT      0x00
>
>  /* Analog gain control */
> -#define OV9282_REG_AGAIN       0x3509
> -#define OV9282_AGAIN_MIN       0x10
> -#define OV9282_AGAIN_MAX       0xff
> -#define OV9282_AGAIN_STEP      1
> -#define OV9282_AGAIN_DEFAULT   0x10
> +#define OV9282_REG_AGAIN       0x3508
> +#define OV9282_AGAIN_MIN       0x0010
> +#define OV9282_AGAIN_MAX       0x1fff
> +#define OV9282_AGAIN_STEP      0x0001
> +#define OV9282_AGAIN_DEFAULT   0x0010
>
>  /* Group hold register */
>  #define OV9282_REG_HOLD                0x3308
> @@ -226,7 +226,6 @@ static const struct ov9282_reg common_regs[] = {
>         {OV9282_REG_AEC_MANUAL, OV9282_GAIN_PREC16_EN},
>         {0x3505, 0x8c},
>         {0x3507, 0x03},
> -       {0x3508, 0x00},
>         {0x3610, 0x80},
>         {0x3611, 0xa0},
>         {0x3620, 0x6e},
> @@ -605,7 +604,11 @@ static int ov9282_update_exp_gain(struct ov9282 *ov9282, u32 exposure, u32 gain)
>         if (ret)
>                 goto error_release_group_hold;
>
> -       ret = ov9282_write_reg(ov9282, OV9282_REG_AGAIN, 1, gain);
> +       ret = ov9282_write_reg(ov9282, OV9282_REG_AGAIN, 1, (gain >> 8) & 0x1f);
> +       if (ret)
> +               goto error_release_group_hold;
> +
> +       ret = ov9282_write_reg(ov9282, OV9282_REG_AGAIN + 1, 1, gain & 0xff);
>
>  error_release_group_hold:
>         ov9282_write_reg(ov9282, OV9282_REG_HOLD, 1, 0);
>
> --
> 2.47.2
>
>

