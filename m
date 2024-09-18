Return-Path: <linux-kernel+bounces-332251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5D197B745
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22FA61C21253
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6E1422A8;
	Wed, 18 Sep 2024 04:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b9aBB5IJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153D2B2D7;
	Wed, 18 Sep 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635145; cv=none; b=Qr/7fCfG6Ptp2UIgWKIwJ6n/hh21uU55ts8Yn2oNe4b4VSka0MJIN60HBni6rrU++vDWvZZG0WcmwZ3zUVMsllxbSbtEBb9I4jwEPU64dhT298+SFfa/o3oO0j0icTPAxkVUt94GGzldvJ6rcPeEdIV6esVHX1sl+4olY2xYtLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635145; c=relaxed/simple;
	bh=ujButzrmQBfySaN+Xdg8ancXimehUSSrRankT58rsBM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=vBp+01yyuGz52qLj0cQr3NwIlEQUOIj03OHXZQZZPKSlVsxg0+UwXidTfT5BHmqM8yp14OyyvTB4zfgianqdZgCZdUmo7TpeVi1augq13o338KeYpRpg2sykH/doue3XfU7NyhpFUZo1eiZzpBbgEhcFH/gLNEEeTHGBvj6lwWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9aBB5IJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D316C4CEC3;
	Wed, 18 Sep 2024 04:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726635144;
	bh=ujButzrmQBfySaN+Xdg8ancXimehUSSrRankT58rsBM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=b9aBB5IJzeq4UwxhVXXbKLNkx2WiXLNEO+AzczMloxtTm4fN2tlDQlfdYy/Z2SFsO
	 TRkFXsQHbxwrC5G4Gr6DSQOY9OA71JSGw/HHEoQT84QeK8aVbI51D1d0kd+SJ78pVA
	 wn+V8ko7hYFmPiWkYOERnx/5CVAHxADIjAcYJZUHgVap9PahcUjW5PUJ9IoZ+nG0/m
	 bHdj3ZjesXzBDjg9gIQR3YWFPueQXvOLgzBP6aPY8ptuGX642yCpjL69Fcrn4l/Csb
	 d1/zduqCLMjB2hhIga+/kBF6TS6XXOvRocU2TA+Jj91wmrS7PxAMWN3k18EEW2LM5S
	 LUBKURNn8rGDw==
Message-ID: <4fb2e38ab5de3be67992c88cc7e9eb3f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240730-mbly-clk-v3-3-4f90fad2f203@bootlin.com>
References: <20240730-mbly-clk-v3-0-4f90fad2f203@bootlin.com> <20240730-mbly-clk-v3-3-4f90fad2f203@bootlin.com>
Subject: Re: [PATCH RESEND v3 3/4] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Tue, 17 Sep 2024 21:52:22 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-07-30 09:04:45)
> @@ -538,7 +544,7 @@ struct clk_hw *__clk_hw_register_divider(struct devic=
e *dev,
>                 struct device_node *np, const char *name,
>                 const char *parent_name, const struct clk_hw *parent_hw,
>                 const struct clk_parent_data *parent_data, unsigned long =
flags,
> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_fla=
gs,
> +               void __iomem *reg, u8 shift, u8 width, u16 clk_divider_fl=
ags,

It would be better to make this unsigned long instead of u16 (for all
the registration wrappers) so that if we add more flags we don't have to
change these lines again. Seems unlikely we'll have more than 32 flags,
but I could be wrong.

>                 const struct clk_div_table *table, spinlock_t *lock)
>  {
>         struct clk_divider *div;
> @@ -610,7 +616,7 @@ EXPORT_SYMBOL_GPL(__clk_hw_register_divider);
>  struct clk *clk_register_divider_table(struct device *dev, const char *n=
ame,
>                 const char *parent_name, unsigned long flags,
>                 void __iomem *reg, u8 shift, u8 width,
> -               u8 clk_divider_flags, const struct clk_div_table *table,
> +               u16 clk_divider_flags, const struct clk_div_table *table,
>                 spinlock_t *lock)
>  {
>         struct clk_hw *hw;
> @@ -664,7 +670,7 @@ struct clk_hw *__devm_clk_hw_register_divider(struct =
device *dev,
>                 struct device_node *np, const char *name,
>                 const char *parent_name, const struct clk_hw *parent_hw,
>                 const struct clk_parent_data *parent_data, unsigned long =
flags,
> -               void __iomem *reg, u8 shift, u8 width, u8 clk_divider_fla=
gs,
> +               void __iomem *reg, u8 shift, u8 width, u16 clk_divider_fl=
ags,
>                 const struct clk_div_table *table, spinlock_t *lock)
>  {
>         struct clk_hw **ptr, *hw;
> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
> index 4a537260f655..cb348e502e41 100644
> --- a/include/linux/clk-provider.h
> +++ b/include/linux/clk-provider.h
> @@ -675,13 +675,15 @@ struct clk_div_table {
>   * CLK_DIVIDER_BIG_ENDIAN - By default little endian register accesses a=
re used
>   *     for the divider register.  Setting this flag makes the register a=
ccesses
>   *     big endian.
> + * CLK_DIVIDER_EVEN_INTEGERS - clock divisor is 2, 4, 6, 8, 10, etc.
> + *     Formula is 2 * (value read from hardware + 1).
>   */
>  struct clk_divider {
>         struct clk_hw   hw;
>         void __iomem    *reg;
>         u8              shift;
>         u8              width;
> -       u8              flags;
> +       u16             flags;

This can stay as u16 to save space of course.

>         const struct clk_div_table      *table;
>         spinlock_t      *lock;
>  };

