Return-Path: <linux-kernel+bounces-253843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 680249327CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A86A1C2254F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3B719B3D1;
	Tue, 16 Jul 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQn2nCh/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3871DFD0;
	Tue, 16 Jul 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721137773; cv=none; b=YSxTOpwIDRH4q6fnDyDJn2R1EKXyo1T0tDGMUnMGc4LWYtHcxKHSX8X2thFAHkMEHt3fihG3s805NXG/1WSB20F9pXGsOpydMyGBnSaDbCm3N2JjEypKS2/xBgApPY1LNsbsNZDR83apK/w1DedUw6FOmb8yvSsN4qxwICtyy5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721137773; c=relaxed/simple;
	bh=ZagyeD+CEK9Z3Hve10RQR+fjhAm6R+NptML0r820+WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mogOXsXPnspoOWQua7Ovql+LSLOVZC41qtU7J+E2kfmNZpicb80Oy5l2kbf4NIas5yqwzOASfW6q369R+Y57frQxPk+GW5M8x7ZxWpjb5kMZx1J6uqMr8PCoi09+V8jVV3IZ2QTZ64WQEjM8+WkClJliQahw/Wr3SKLF5BM99XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQn2nCh/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0348CC116B1;
	Tue, 16 Jul 2024 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721137773;
	bh=ZagyeD+CEK9Z3Hve10RQR+fjhAm6R+NptML0r820+WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQn2nCh/CorITB3iIkDQDu6EQsG46Ik9SRkS0pO0FNe3PPT65F68SqGZrwVbB16N2
	 ROov0kdR2P6oNfhyT7+B7byGa6sRrIQ8MyLcU0a0wDXSseqHCU74QaNTU2fFdgZHA/
	 8UfzeyoTKdu7eO6w5p8AnkZ0jaa90L+MxFrcr3hR/JOsyNu2KVL4mwE6Gr1/jKk6zY
	 Psgxerp7VWJUjvLclg01z6yVdPi2iBIsezAjHDhBd4T1DkTSaWfzxn3IR+w0WoigYv
	 Afzk6K3VTJNkK065+EsjLx8vRE0Z8uYPKcW2oXMgURvDfSP7ypTUu4D2i4o9UKXnB8
	 Uv7UlLOeA3eyA==
Date: Tue, 16 Jul 2024 07:49:31 -0600
From: Rob Herring <robh@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org,
	linus.walleij@linaro.org, dianders@chromium.org, hsinyi@google.com,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan
 ekth6a12nay
Message-ID: <20240716134931.GA3574060-robh@kernel.org>
References: <20240716082851.18173-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240716082851.18173-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716082851.18173-2-lvzhaoxiong@huaqin.corp-partner.google.com>

On Tue, Jul 16, 2024 at 04:28:50PM +0800, Zhaoxiong Lv wrote:
> The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
> Changes between V3 and V2:
> -  1.  "ekth6915" isn't a fallback, modify it.
> v2: https://lore.kernel.org/all/20240715073159.25064-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> 
> Changes between V2 and V1:
> -  1.  Respin the series on top of v6.10.
> v1: https://lore.kernel.org/all/20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com/
> ---
>  Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> index a62916d07a08..f683048fd0c4 100644
> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> @@ -24,6 +24,7 @@ properties:
>                - elan,ekth5015m
>            - const: elan,ekth6915
>        - const: elan,ekth6915
> +      - const: elan,ekth6a12nay

Combine the 2 const into an enum.

With that,

Acked-by: Rob Herring (Arm) <robh@kernel.org>

>  
>    reg:
>      const: 0x10
> -- 
> 2.17.1
> 

