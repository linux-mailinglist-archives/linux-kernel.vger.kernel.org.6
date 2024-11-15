Return-Path: <linux-kernel+bounces-410394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CF99CDAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 09:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBD2728186B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FF18D63A;
	Fri, 15 Nov 2024 08:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="RXtFmyF1"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4729E18C03E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731660735; cv=none; b=eroS9Qa1ULIppCOF4FkXBZ8fHD1/dLZUvxyujb74D4JPbdehENseAWry2xsWoaOrUUTg7wCCPqPN00uW5ndje92uGqgTlATqD68ZP2L5bn5JiwCA2GHNaRK9r8MaXQbDuCbrHbiEamsNqeu9g+RUJnoVW094iiZi5iykaNw7eyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731660735; c=relaxed/simple;
	bh=bGxmR42ZqhzPo5U+KBhp/Vo3Bch/V1hPQBqkPLuoFbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlYhz3ALv3qI0phHPrSMNEx626lGGALyMwcI2GsgZxTNADPhAQNk/rqXSny38LDjLdDhW3kOdXZtS7B86ZeLVgsuH1h3dlhoDxq0cVllO82E0rBxsGkVFz+ZefZUrV0atO+eJmQlx+QwjYT0TtLAP4n+srLV1R2w2paBF1fyTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=RXtFmyF1; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e380fe87b09so1515452276.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1731660732; x=1732265532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6S2nGodUHkF7oQtN5BOS0le7eARr47Goh8++DpENQG0=;
        b=RXtFmyF1kwJI4Xu+Nj7c1cdPuhQ6xn70kaUB2BkhNU45gOlLGzrUpuKa2U1kzXxnrt
         xc0OKc27vb1ksGl06OQpRfuEcb7os4UCrVAbVO8tGeyOMn6iI9ehQQrZ/OQSgBsjaZP4
         dQxB3ADPBco0uttpWwK0aZCnejHlQVivISG2myDD5k/i4U6YZMDTRKAAlf7Ex9C5mghM
         zf2D3eMtd9JvhCo7wP+hpUo7JWvXUEOP8pAzfubJneMx+CDsGXcEIiv1gyjJDd/EzHZw
         83A10BJoUE86vVuSNDYrF/MjxDjuToQu+x4CYA+O/NguoXhFiM+2dOizr/s3EbgEGVk4
         8yCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731660732; x=1732265532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6S2nGodUHkF7oQtN5BOS0le7eARr47Goh8++DpENQG0=;
        b=NIJ964aI3TiTPyqmhTV4tfCmeDEC7TE0xJccQeODDPlfxqbKSJeLVbSZsMShDBUyVF
         shjJYlOB7FPM1Oc7ur28Ey5IbO15xCLlz+Qg3LsrcX2qPp7ummVbth0TFCBg8wKlYw3D
         nY3QIiD7Md2oUFMPzYbi4OtU/HhOv1/ppksJrTuRsVd6bMUcXw0V/F8+kxEpvMYAmQSq
         eZYJWFHrymaZJPjQUsQa3IxTB3dEdkERIHNF/tPUFYw3WgPeC85mbOSGqsnUwOoITj0s
         oY/faF3ClY5bQ0s3OpJCoXvDxL+SfcWHaOoaKqzv0MMy1Xo5edfJTzjSkiRSdhtiwx4+
         GjlA==
X-Forwarded-Encrypted: i=1; AJvYcCUhxwfPvoQUXnLw0Rxu7fkztGR4vxOxxtaEnLvp4RsTocTK9clRRY2qUGbi13kUcuGkL2uPR9vrhQ4rtcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZEZeI4YJ7Gdv0nL408ICElCOMkpI7+W93XMD5C4QHRrtweCaL
	uFkWPIT0Ts1Tm3yDJVg+9clHrpb7s8CSyjQ+wzAy7+qaPVtzIuwNR+hvQBrxnI57FFeYO5B2BCU
	4ZEy7Z5aq8JHVYQwRPzcpryFQTrTevJQtFmM1vA==
X-Google-Smtp-Source: AGHT+IHV94ciQ8ydggMMk7IA4ri1B28vEf2MSAaktiuDxaGnxBdFoxYrqrbgaH4WT2Q9fn8dihjYsjg1qMjvep1DlaY=
X-Received: by 2002:a05:6902:b09:b0:e30:cea9:ba28 with SMTP id
 3f1490d57ef6-e3826165b1bmr1162795276.30.1731660732215; Fri, 15 Nov 2024
 00:52:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114-media-imx290-imx462-v1-0-c538a2e24786@raspberrypi.com>
 <20241114-media-imx290-imx462-v1-3-c538a2e24786@raspberrypi.com> <20241115000637.GK26171@pendragon.ideasonboard.com>
In-Reply-To: <20241115000637.GK26171@pendragon.ideasonboard.com>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 15 Nov 2024 08:51:55 +0000
Message-ID: <CAPY8ntBJu+mA3BcYkkVpr1L0jf2hp6e3kbpyGkB7mwbiDQDGzQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: i2c: imx290: Add configuration for IMX462
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 15 Nov 2024 at 00:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Dave,
>
> Thank you for the patch.
>
> On Thu, Nov 14, 2024 at 04:01:15PM +0000, Dave Stevenson wrote:
> > IMX462 is the successor to IMX290, and wants very minor
> > changes to the register setup.
> >
> > Add the relevant configuration to support it.
> >
> > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > ---
> >  drivers/media/i2c/imx290.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >
> > diff --git a/drivers/media/i2c/imx290.c b/drivers/media/i2c/imx290.c
> > index da654deb444a..f1780cc5d7cc 100644
> > --- a/drivers/media/i2c/imx290.c
> > +++ b/drivers/media/i2c/imx290.c
> > @@ -170,6 +170,8 @@ enum imx290_model {
> >       IMX290_MODEL_IMX290LQR,
> >       IMX290_MODEL_IMX290LLR,
> >       IMX290_MODEL_IMX327LQR,
> > +     IMX290_MODEL_IMX462LQR,
> > +     IMX290_MODEL_IMX462LLR,
> >  };
> >
> >  struct imx290_model_info {
> > @@ -316,6 +318,50 @@ static const struct cci_reg_sequence imx290_global_init_settings_290[] = {
> >       { CCI_REG8(0x33b3), 0x04 },
> >  };
> >
> > +static const struct cci_reg_sequence imx290_global_init_settings_462[] = {
> > +     { CCI_REG8(0x300f), 0x00 },
> > +     { CCI_REG8(0x3010), 0x21 },
> > +     { CCI_REG8(0x3011), 0x02 },
>
> As far as I can tell, the only difference in the init sequence between
> imx290_global_init_settings_290 and imx290_global_init_settings_462 is
> 0x3011 register which is not present in imx290_global_init_settings_290.
> It is however included in imx290_global_init_settings, and set to 0x02.
> Could we therefore use imx290_global_init_settings_290 for the imx462 ?

I'd done a comparison of the datasheets, and register 0x3011 was the
only one that changed. I'd missed that it was in
imx290_global_init_settings.

My datasheets:
IMX327LQR-C rev E17Z06B93 2019/03/25. 3011h "Set to 02h" (value
changed in doc rev 0.3 from 0Ah)
IMX290LQR-C rev E15510G82 2018/02/09. 3011h "Fixed to 00h" (always
been that value).
IMX462LQR-C rev E19Y13C13 2021/03/19. 3011h "Set to 02h" (value
changed in doc rev 0.2 from 00h)
The default value stated in all of them is 00h. In true Sony fashion,
there's no description for that register functionality.

So actually it looks like it was the addition of IMX327 in [1] should
have changed that setting, unless someone else has a more recent
datasheet for IMX290 that updates that.
cc Alexander as the author of that patch. I'll find any discussion on it later.

  Dave

[1] https://github.com/torvalds/linux/commit/2d41947ec2c0140c65783982692c2e3d89853c47

> > +     { CCI_REG8(0x3016), 0x09 },
> > +     { CCI_REG8(0x3070), 0x02 },
> > +     { CCI_REG8(0x3071), 0x11 },
> > +     { CCI_REG8(0x309b), 0x10 },
> > +     { CCI_REG8(0x309c), 0x22 },
> > +     { CCI_REG8(0x30a2), 0x02 },
> > +     { CCI_REG8(0x30a6), 0x20 },
> > +     { CCI_REG8(0x30a8), 0x20 },
> > +     { CCI_REG8(0x30aa), 0x20 },
> > +     { CCI_REG8(0x30ac), 0x20 },
> > +     { CCI_REG8(0x30b0), 0x43 },
> > +     { CCI_REG8(0x3119), 0x9e },
> > +     { CCI_REG8(0x311c), 0x1e },
> > +     { CCI_REG8(0x311e), 0x08 },
> > +     { CCI_REG8(0x3128), 0x05 },
> > +     { CCI_REG8(0x313d), 0x83 },
> > +     { CCI_REG8(0x3150), 0x03 },
> > +     { CCI_REG8(0x317e), 0x00 },
> > +     { CCI_REG8(0x32b8), 0x50 },
> > +     { CCI_REG8(0x32b9), 0x10 },
> > +     { CCI_REG8(0x32ba), 0x00 },
> > +     { CCI_REG8(0x32bb), 0x04 },
> > +     { CCI_REG8(0x32c8), 0x50 },
> > +     { CCI_REG8(0x32c9), 0x10 },
> > +     { CCI_REG8(0x32ca), 0x00 },
> > +     { CCI_REG8(0x32cb), 0x04 },
> > +     { CCI_REG8(0x332c), 0xd3 },
> > +     { CCI_REG8(0x332d), 0x10 },
> > +     { CCI_REG8(0x332e), 0x0d },
> > +     { CCI_REG8(0x3358), 0x06 },
> > +     { CCI_REG8(0x3359), 0xe1 },
> > +     { CCI_REG8(0x335a), 0x11 },
> > +     { CCI_REG8(0x3360), 0x1e },
> > +     { CCI_REG8(0x3361), 0x61 },
> > +     { CCI_REG8(0x3362), 0x10 },
> > +     { CCI_REG8(0x33b0), 0x50 },
> > +     { CCI_REG8(0x33b2), 0x1a },
> > +     { CCI_REG8(0x33b3), 0x04 },
> > +};
> > +
> >  #define IMX290_NUM_CLK_REGS  2
> >  static const struct cci_reg_sequence xclk_regs[][IMX290_NUM_CLK_REGS] = {
> >       [IMX290_CLK_37_125] = {
> > @@ -1455,6 +1501,20 @@ static const struct imx290_model_info imx290_models[] = {
> >               .max_analog_gain = 98,
> >               .name = "imx327",
> >       },
> > +     [IMX290_MODEL_IMX462LQR] = {
> > +             .colour_variant = IMX290_VARIANT_COLOUR,
> > +             .init_regs = imx290_global_init_settings_462,
> > +             .init_regs_num = ARRAY_SIZE(imx290_global_init_settings_462),
> > +             .max_analog_gain = 98,
> > +             .name = "imx462",
> > +     },
> > +     [IMX290_MODEL_IMX462LLR] = {
> > +             .colour_variant = IMX290_VARIANT_MONO,
> > +             .init_regs = imx290_global_init_settings_462,
> > +             .init_regs_num = ARRAY_SIZE(imx290_global_init_settings_462),
> > +             .max_analog_gain = 98,
> > +             .name = "imx462",
> > +     },
> >  };
> >
> >  static int imx290_parse_dt(struct imx290 *imx290)
> > @@ -1653,6 +1713,12 @@ static const struct of_device_id imx290_of_match[] = {
> >       }, {
> >               .compatible = "sony,imx327lqr",
> >               .data = &imx290_models[IMX290_MODEL_IMX327LQR],
> > +     }, {
> > +             .compatible = "sony,imx462lqr",
> > +             .data = &imx290_models[IMX290_MODEL_IMX462LQR],
> > +     }, {
> > +             .compatible = "sony,imx462llr",
> > +             .data = &imx290_models[IMX290_MODEL_IMX462LLR],
> >       },
> >       { /* sentinel */ },
> >  };
>
> --
> Regards,
>
> Laurent Pinchart

