Return-Path: <linux-kernel+bounces-574959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02935A6EC01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BA53ABFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 08:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D843E1D63C3;
	Tue, 25 Mar 2025 08:56:35 +0000 (UTC)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469F1B4231;
	Tue, 25 Mar 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742892995; cv=none; b=Q+L94Y7LjHC9E2oyqUyiPx3NGHGZPQMBQHpmQ/bgFnELjrqWNFKQNTqJ6u6veA3PwleEvphXIwe+UFwUdwDbrZ9tMH644dSxC6UDS4X/VZAv3Z2DRzer+HAtdVeE0ognzmMl+/lF2VgfESQM9MTsf6wiiC7w6gkxhxN+N9BOstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742892995; c=relaxed/simple;
	bh=pF3R+3YDau9KUabMuvlU3fzSyQgYNUpoXNHr0OjVo2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkyWwflEgcrCYAdsT48JhNHn01aCnpVyuerxlG5HQTfOLFNNkblS1y3LMWWGmlTb5LLET3SouEjvj3DP0k/D6Eny/V9FDnRBG390oeVC3840Oe+oD93MGEOpNt8YrselgEWtBq+S9unDU7P1cyBgiFtcF3Phn2DJcudaEBla8us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bee1cb370so55471801fa.1;
        Tue, 25 Mar 2025 01:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742892989; x=1743497789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yug/5aBsatlN0TKX/juq/d600tRujIOyiR7/duVhtrI=;
        b=WWbqedqchCv8tDEcT4nnBn4qXZqpTzm6nMor5t0RRChminYDdP2z3uf+5z5rli+Wsb
         uznc7W3QnKNzUfDPKyEdyxka2iDMzahrXaOcwtYdue2sVUpvaeOCf1xCKvX/+UCXzAbD
         8cK+RkU8YuQXu63uVgYjGEjFgb/am8zDVVVNuuJvLWdre1crWOkuSOchPfXRixNH7eVc
         bQzOYtzDy9rpN/wuAYc/tcQY1p0ryVmXhHePGi4b11BpC7MbqojPju/4k0XSGymiwp3P
         64cm4hMGm4+UIzeIHsWs7guKqIbLHdgj7bJtR3iP8rGUKq6MKvQ+F2s4vaqIbrZeYy6F
         +SVg==
X-Forwarded-Encrypted: i=1; AJvYcCWTa9I71ZfNxLrUxL5XjgVX0PcDiTizRVGHPxRcxU6jdI/8oThFe3Lu+hl7wFc6A14Nw7GQRb5Fi1Zm780=@vger.kernel.org, AJvYcCWth/YB9LJG+S3AGlu0/LQJj6pDxLqWUbyaapcWopBN90DyYILFPgrFEg0SGvID6+62I2u01gM0Mwa9xkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbbVWdudO87Gjxj/YfFZK3tBFxtcP3xfU0tqqHMHEzLU+HNo/a
	GAhTBGAY+TDR4LAmMj9MF15ABvWTjf62v8tA/hnBP43nuxf4ni0O5b3LGTD6
X-Gm-Gg: ASbGncv7yog7krEku2cnTu3qenAeUIKbQces1vih9MKohFcLUfvyfXdz6TYj4eQ2b7K
	m/n7qmwQ1tf7zulQtiJ/mqxB2eqMKtGMKkxdEhzIQCatjSlCuMceYyoOmdmYLl8ZY9qxKxMxUO8
	eNOlmfI1lA6VhiqtOZBjjmRPgd95j03cjiN1WwqOvEZJX4XNyjWbioZgyZQkNG1DZcwPYmoXkH1
	/fqX+3Ty6P33LqXEjBNF1T2nrM3eBpPRGjQ6v5GhEJT8UuWXvWDTQ6XEmDIr0/m661dxR3M3zj3
	kw4uh4gWWWMTRGhpVs5fBSlGDTvSvKWilS5RMb8JLQdehR1qVGNX/k2XS5BENHabAfS77aWVFSW
	3iw==
X-Google-Smtp-Source: AGHT+IGVAB2fOaJkWOw6CpS34WT0+hfGJcY9iOlB2QnL9TiJjqm4d+mTLD3G216x20PwPNqW8R9a6w==
X-Received: by 2002:a2e:be8b:0:b0:30b:d156:9e97 with SMTP id 38308e7fff4ca-30d7e2012f3mr62233681fa.8.1742892988461;
        Tue, 25 Mar 2025 01:56:28 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe73bsm17672951fa.50.2025.03.25.01.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 01:56:28 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30c05fd126cso47565251fa.3;
        Tue, 25 Mar 2025 01:56:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVyEPeIJJz3DDPXqLP+1JDrXtrlXCvI5SlTAP8oEzyq10xIm8YX7XTdZj25sd6bm8R9jcPZvOBq7lNTAhE=@vger.kernel.org, AJvYcCWfVEPfOp6dGT9NyE+tChyPGuGbdRpFBhpL/msh3DueXu+HY4beuBEHeAIH/14QBRg0UdQiEyHhy+c+C4c=@vger.kernel.org
X-Received: by 2002:a05:651c:221a:b0:30b:971c:96e6 with SMTP id
 38308e7fff4ca-30d7e2a2635mr57206101fa.26.1742892987667; Tue, 25 Mar 2025
 01:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325032833.604073-1-nichen@iscas.ac.cn>
In-Reply-To: <20250325032833.604073-1-nichen@iscas.ac.cn>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 25 Mar 2025 16:56:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65e8Hk7aZ543pEXYKJ9VDs1znuCtaDDdCOfaRKWrT2MdA@mail.gmail.com>
X-Gm-Features: AQ5f1JornbCi49rWdD7DV_uaQAEm5VTpxGrz64paaXxDiD5xJP4tev5eWwCG9IU
Message-ID: <CAGb2v65e8Hk7aZ543pEXYKJ9VDs1znuCtaDDdCOfaRKWrT2MdA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sun8i-codec: Remove unnecessary NULL check before clk_disable_unprepare()
To: Chen Ni <nichen@iscas.ac.cn>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	jernej.skrabec@gmail.com, samuel@sholland.org, ckeepax@opensource.cirrus.com, 
	u.kleine-koenig@baylibre.com, megi@xff.cz, linux-sound@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:29=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrote=
:
>
> clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
> Remove unneeded NULL check for clk here.

Please also clean up the clk_prepare_enable() call.

ChenYu

> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  sound/soc/sunxi/sun8i-codec.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.=
c
> index 8b9eb1a202f7..a27976c375fe 100644
> --- a/sound/soc/sunxi/sun8i-codec.c
> +++ b/sound/soc/sunxi/sun8i-codec.c
> @@ -274,8 +274,7 @@ static int sun8i_codec_runtime_suspend(struct device =
*dev)
>         regcache_cache_only(scodec->regmap, true);
>         regcache_mark_dirty(scodec->regmap);
>
> -       if (scodec->clk_bus)
> -               clk_disable_unprepare(scodec->clk_bus);
> +       clk_disable_unprepare(scodec->clk_bus);
>
>         return 0;
>  }
> --
> 2.25.1
>
>

