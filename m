Return-Path: <linux-kernel+bounces-250911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8C892FE73
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D99282B81
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72D3176250;
	Fri, 12 Jul 2024 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qheNKlkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C5176231;
	Fri, 12 Jul 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720801540; cv=none; b=ZsrPNnMkbm1jO3qk1icyMoxaTzkHZn8maaxLnbO861aPkoCGXqZJsoMc4gI+6ygzltqs47fIkc9+xV3a2hdGOGorpyACNKCH41Bba6DQVG6Vl+Hg1bj3XAwQ/Ip5XswX5SlfDVMXkV7VFu3BqiVoXXo9XLVV5W/gdAZDE37q4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720801540; c=relaxed/simple;
	bh=vKbYjpqSW68vls9/ccAwcEsiYRHH2lrWUF7KjbHlMEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OWPNudvyc4SSikAslxA9V+O+8BnpILFT+24U56GIQOfiyO4V0bAEW47rE4o3xLf/X+nkx8uiVDetlqydkKVvA3UkMh5uTHelb2R+J5Rhl3tV0BwAohAkUUMuLw4h5uGoXVZRXYeL2C1OaaQoUueOsdUFwVawcr4RKzeuCvJsb/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qheNKlkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B37C32782;
	Fri, 12 Jul 2024 16:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720801539;
	bh=vKbYjpqSW68vls9/ccAwcEsiYRHH2lrWUF7KjbHlMEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qheNKlkm2Idxpgf4Uo5eN5a4AFkxhoiFJax9yW+nJDJI4QA+uUuiZ6whRtpx5QTOr
	 hPg0XMVsG356juBaiHXaqUcpNuMFASVb9uzikwS9WXk2QDcrQAwg7/4n6hbdvrdX7C
	 gB9ABOl3gGZkvSlpdR9jLtjCfY6NQ0aaVuWbWy8z7kn4RNhHr1LrTq/AS3n9i3iZTf
	 xfGG3nyMeV5suicqZDD2Yot8XN6/j4sNIPyfHH0Lmr/MrkhFFNM/aTq3GEY2PVPpoW
	 CYDU9aG/Dsatw0zowI43N9ZpYA1dhJQ6x3HF1Ay2yxeVGnmU6L8lhoTTz21HWRn7YZ
	 TzNO8xSerdKvQ==
Date: Fri, 12 Jul 2024 18:25:34 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jikos@kernel.org, linus.walleij@linaro.org, dianders@google.com, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: HID: i2c-hid: elan: Introduce Elan
 ekth6a12nay
Message-ID: <c4d37nhn5mjzftvde4hk377vyz3dqp4d75hctobaeclzk2orxa@pxweixkkn3zl>
References: <20240704085555.11204-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704085555.11204-2-lvzhaoxiong@huaqin.corp-partner.google.com>

On Jul 04 2024, Zhaoxiong Lv wrote:
> The Elan ekth6a12nay touch screen chip same as Elan eKTH6915 controller
> has a reset gpio. The difference is that they have different
> post_power_delay_ms.
> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/input/elan,ekth6915.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> index dc4ac41f2441..0bbf9dd7636e 100644
> --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      enum:
>        - elan,ekth6915
> +      - elan,ekth6a12nay
>        - ilitek,ili2901

This is not in v6.10-rcX, ilitek got removed and the compatible node got
updated.

I could amend the patch for this but I'd rather have you to do it as I
can not test the change myself.

So please respin the series on top of v6.10 at least, keep the various
acks/rev-by and and make sure you test.

Cheers,
Benjamin

>  
>    reg:
> -- 
> 2.17.1
> 

