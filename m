Return-Path: <linux-kernel+bounces-330368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D26979D35
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A690283437
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEA71487DF;
	Mon, 16 Sep 2024 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9OknfZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C0F32C8E;
	Mon, 16 Sep 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476556; cv=none; b=r6aTRnJxV1boHWInVq8UzBKPzwbA0BGtRyXfVLZOFBYl7SJBRWW0tcCjzy4L/9OZfbgjz1wbjgWmeLDKXH1ucJ75gT2agFDfFj3DzzhQIdQz6OkKmXlczFmP8ZbX34CI99TPh/Xl8stpUAuBvK7EE2DN4I25ZrCnMMUKCdFAArc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476556; c=relaxed/simple;
	bh=cpAwsamAlG1/bhk8zJP82ugA8nlHWRkt62vBDI8NH2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChQMfZ0A6xheCVywpZ5wyFo5W4zdKFsP8js5TVuWIpqyp1ZrAPOQtuy7tIB0FsQJsjNlD9JrWtIzTTKWhQvS4LTk9gozCyHnj/7mt/K9fgtN0bBDFmzkRdyZk+CBBT+5+8OO6AxKYwmo2q31OAvfb/n4dO3GI51zwKaI6OTeqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9OknfZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFBBC4CEC4;
	Mon, 16 Sep 2024 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726476556;
	bh=cpAwsamAlG1/bhk8zJP82ugA8nlHWRkt62vBDI8NH2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9OknfZUY5XJI6zmPcYqxYpiT6PVhyQfD+oYMXOd5borsv3e96mpkQ7gY+e9RHjZ2
	 jL3Uk1eFS3dpozfe6p006klQ8DQT0zXGblvHnUKiLlidnRd1rrQM99RW7rFX6EN8dn
	 ZjS3PQHpEzk6SEyGC6t9+h5uEAZH/koXRwOoQ3+ycCZZiwyYDuhunRdvngAx7McbcS
	 UtCewC6eayCOvsw53+ylQO/QHxrYOZmtJegnwms0RXUlUJeFXvRkXToI06iVFIPvrM
	 0m2U+OGSECDvRFLB8VOFCfTq2S3THFiRMV7TgXS/S/SczTTrG2bFkY6Rs3SYwpm5It
	 Pz0LfAtEzlh/A==
Date: Mon, 16 Sep 2024 10:49:12 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, macromorgan@hotmail.com, jonas@kwiboo.se, tim@feathertop.org, 
	knaerzche@gmail.com, efectn@protonmail.com, andyshrk@163.com, jagan@edgeble.ai, 
	dsimic@manjaro.org, megi@xff.cz, sebastian.reichel@collabora.com, alchark@gmail.com, 
	boris.brezillon@collabora.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add RK3588S EVB1 board
Message-ID: <krfo47rjxks7gouirhmcfwa67sy3vztq2ktdcs4kkikhtwgbv3@ofvnobfyqzhf>
References: <20240914095456.2347532-1-damon.ding@rock-chips.com>
 <20240914095456.2347532-2-damon.ding@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914095456.2347532-2-damon.ding@rock-chips.com>

On Sat, Sep 14, 2024 at 05:54:55PM +0800, Damon Ding wrote:
> Add devicetree binding for the Rockchip RK3588S evaluation board.
> 
> RK3588S EVB1 board features:
> - Rockchip RK3588S
> - PMIC: RK806-2x2pcs+DiscretePower
> - RAM: LPDDR4/4x 2pcsx 32bit
> - ROM: eMMC5.1+ SPI Falsh
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
> 

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


