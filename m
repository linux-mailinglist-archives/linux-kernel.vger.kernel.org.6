Return-Path: <linux-kernel+bounces-574677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D85D7A6E860
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F6367A4470
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4DD189BAC;
	Tue, 25 Mar 2025 02:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6k6WhZw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6888A927;
	Tue, 25 Mar 2025 02:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742870987; cv=none; b=M9sKPLw4fkec75PP4wRW1ktWWVEp7u69gszerhlvn8dx4/krHV+JpI/n6xQsAXDF+VCcJjAcyC+jJ+ERfqSJIR3b47N9++9mfkSj4WoNjHtWH/5mTC4zy67OaaL3U1f5b28WvpvVMG0X0gSaMmJI+WUOZTQqyDwmGDjyvT15Svc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742870987; c=relaxed/simple;
	bh=kzEDoLXYoRLg4bIFcw01+2FmmdfSHx/Mqfyj4i5mSJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBXhirqnp+kh2HNgPR3VlnMn16RvRRU+0zZ0gnKQ/LziUVHoRFQXcoHu0vNjN5ENLQlDx2TOx/iucySIFtiW1n/XsghPpbCHN3xtqpOK74TvZrNffv3Uizr1oTcFSigSwIlc28P6h932ThMQoOlJDWziTRSXuTE2+3Xqc9VXCXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6k6WhZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F37C4CEDD;
	Tue, 25 Mar 2025 02:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742870987;
	bh=kzEDoLXYoRLg4bIFcw01+2FmmdfSHx/Mqfyj4i5mSJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6k6WhZwnR8EXCsrq4/rrPLd3oVKgxxPC4tvPKQ/220SRREdm3++oCCG3eE6gDe4m
	 M8p6zv3nKFNSdTFGJWndCQOYPYyZTi7LziREVsW+nH27li4kSdLTMDJbu8OtGTET9p
	 l5ckX40XxsIqwBxkAEEwf5B5bdtmkUWqnFY5LWGvNHSyFUpAXQCEDzFU649/Z9x+z3
	 2KGeK1ZhKt9ZKPCZmxv9E8/SiFBuQD9vp+J1FJvGW+CZS+w+Jr3DgAwmzJn/s3+yEO
	 +BFgNPQTmbGXy7oQ+dq2G5D4Q7ZylEGLxTZeY5WIU6aDxsnyobIhdqcNWeCGWSCuDk
	 n1sDAvEUO1QaQ==
Date: Mon, 24 Mar 2025 21:49:46 -0500
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: arm: rockchip: Add Radxa ROCK 5B+
Message-ID: <20250325024946.GA1544352-robh@kernel.org>
References: <20250324-rock5bp-for-upstream-v1-0-6217edf15b19@kernel.org>
 <20250324-rock5bp-for-upstream-v1-3-6217edf15b19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324-rock5bp-for-upstream-v1-3-6217edf15b19@kernel.org>

On Mon, Mar 24, 2025 at 06:04:24PM +0100, Sebastian Reichel wrote:
> The Radxa ROCK 5B+ is an improved version of the ROCK 5B.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Same patch has already been acked here:

https://lore.kernel.org/all/20241226005845.46473-1-naoki@radxa.com/

> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 650fb833d96ef67ea1bba33c0767777378a38fa7..fe1fe8fe52fa3594a0da8e0263cb46949436a021 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -946,6 +946,11 @@ properties:
>            - const: radxa,rock-5b
>            - const: rockchip,rk3588
>  
> +      - description: Radxa ROCK 5B+
> +        items:
> +          - const: radxa,rock-5b-plus
> +          - const: rockchip,rk3588
> +
>        - description: Radxa ROCK 5C
>          items:
>            - const: radxa,rock-5c
> 
> -- 
> 2.47.2
> 

