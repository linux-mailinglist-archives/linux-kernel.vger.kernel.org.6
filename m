Return-Path: <linux-kernel+bounces-330359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A43979D17
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149251F223B3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54514600F;
	Mon, 16 Sep 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDF26Fxz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592EE5647F;
	Mon, 16 Sep 2024 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476190; cv=none; b=nm7KhYoEwP2j/UwsMJZospky/+Od7jv2wolbQXANd2G4EBRKXo4qUQ0Hs3sGWMfaHCPpY9bupT9LeP0zLLHoPwjr6hhpmCf66MHAQlQZ7/bsI6qcr70KDHeub5sLpFSUrmL2YI9N/vTvA7zp8b6lZmouxitqc/LDAh6K9SPgmgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476190; c=relaxed/simple;
	bh=OdSbYiA3FhrwpTqzLiimGFT12yNCCVPtCd9GZuOseO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWErPJ2okywu9V1EmT9tq3+7B79WdRnuRwkKFphOXlL4o8l9ywTMdC3pfYu1UMgrlyYGhluuHPtoNHCZ3zgU0G+QJB4l1TQ0I9thmH7m7SzmdvfXc3vdo8LMmEoCupXCUYHblQWy7QQFVkXRZRKoVNWuWkTkYOrEU+PHAP0oUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDF26Fxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2D2C4CEC4;
	Mon, 16 Sep 2024 08:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726476190;
	bh=OdSbYiA3FhrwpTqzLiimGFT12yNCCVPtCd9GZuOseO4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDF26FxzaV2oJiVU9oy2JVrDPQhIG2ouUhd5TI3Js8YQeVKR+n2ZUfJd+r7qatuvf
	 Lev11a7W6FfNvWCWj6agaZTQBJYPItkM0+nji5h++uWyH/I78wjwC0CNeYm2zVXV/L
	 9MuYckHdND7HhoWOFFDMMlAcH5wumbj9RpKGcHGF7WTwk5P3oamrm53qmb/ZYKKL4a
	 K6f6rBvkEfJU+484cMxSMLw/7OURxCN1YCDIb2XqHJeJXQ35hPMe2M2XCBf382huKj
	 OO3wxmF//7pi8vq6rzrfooFVmaGeLI+sCDQS/6rcZiqtkQbRX8Tv6ifeaBh96fRHId
	 j4rb28Vm9tScw==
Date: Mon, 16 Sep 2024 10:43:05 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: arm: rockchip: Add Ariaboard
 Photonicat RK3568
Message-ID: <7oijuzeq4desbml22eg72oqlsz6uwgyh2fjy3w4ncl5p6s2cbk@tl4i2eb2pjjv>
References: <20240914145549.879936-1-bigfoot@classfun.cn>
 <20240914145549.879936-3-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914145549.879936-3-bigfoot@classfun.cn>

On Sat, Sep 14, 2024 at 10:55:48PM +0800, Junhao Xie wrote:
> This documents Ariaboard Photonicat which is a router based on RK3568 SoC.
> 
> Link: https://ariaboard.com/
> Link: https://photonicat.com/
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


