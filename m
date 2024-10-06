Return-Path: <linux-kernel+bounces-352377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB8991E4D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79187B2124C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357F6175D29;
	Sun,  6 Oct 2024 12:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkgqQVVL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907602572;
	Sun,  6 Oct 2024 12:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728218747; cv=none; b=Pviv8pjFIwelIxToDH4a68q5g5d/DL+ZMKInVJeGF8kxyqs8e7PVEaBn7ID9Gq7UxvftYTKxobm0zoGy06tKD8umJJNvmTuflmx3c+/OG2ytiI9UG51Oag6/R7dqnagwcX56N4iNg+RX4l2ufUlXtpxOpgL1bBaJZdBsiaYW3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728218747; c=relaxed/simple;
	bh=vGSkzTDuOud0fNf4yd92jwXPUpTOLMYireKSsyt1WRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYgOSrGRtQVX3r0p/ETIOFW7gvC9Zi2VQ/aRHHolRfbTRaAHlpg4ZA3iHzmBZlRtNjXKi0U4GFZhmEepP3Tj99WGnGjiOwK+xM5P7mTv4maGXzinFbe6sYMJRpD+mY4gpYE2bELQJWu0JY2O7XVBlZ8A7eJrOuuyGld+Sv4mHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkgqQVVL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83023C4CEC5;
	Sun,  6 Oct 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728218747;
	bh=vGSkzTDuOud0fNf4yd92jwXPUpTOLMYireKSsyt1WRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CkgqQVVLrGoCOcxAHxDSl71HaE8QNmkuiDbjn3jLENdbw8g0lbBD31CSqJAeMso5e
	 qN5Ip0vc13CFdOIYBBX0hza3gHFm7d5Lwuy42HUN+VWL05vWYT4slT9+/pFgve6Mzu
	 2zvnrWvFjIrpIKd5z/KOjD4sVRcvhsubKKKzqEj1AVVX9C5JGr/QS/xMss1fx/gPB9
	 Rl7tju1+NiNxzDi6wxZD3N+h7t+Oy31fNkobYNjA8SuPptgGPyXomuoPOcHkw3X+pD
	 QrjJLJulx7jESlbLld4wzVtfDJ9cIE/ak6zBcgrIO0mbPW071AZq/dSR4gKzESYaVN
	 YXLt8+mCU1Vhg==
Date: Sun, 6 Oct 2024 14:45:43 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Alain Volmat <avolmat@me.com>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Patrice Chotard <patrice.chotard@foss.st.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: mali-utgard: Add ST sti compatible
Message-ID: <t6ueaovdm5gfqmdsedm4aaz7zabsf5lcx3jpintfwyx26uokup@2qhaqycrj2sl>
References: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
 <20241005-sti-gpu-v1-1-9bc11100b54b@me.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241005-sti-gpu-v1-1-9bc11100b54b@me.com>

On Sat, Oct 05, 2024 at 06:07:59PM +0000, Alain Volmat wrote:
> ST STi SoC family (stih410, stih418) has a Mali400.
> Add a compatible for it.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> index abd4aa335fbcebafc9164bd4963f9db60f0450c4..97a7ef0fea1a10df0ff485b9eb4468f44c92da39 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> @@ -33,6 +33,7 @@ properties:
>                - rockchip,rk3188-mali
>                - rockchip,rk3228-mali
>                - samsung,exynos4210-mali
> +              - st,sti-mali

That's quite generic compatible. I would expect here per-soc.

Best regards,
Krzysztof


