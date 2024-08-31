Return-Path: <linux-kernel+bounces-309727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F928966FCA
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 08:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1622840DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 06:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41100166F29;
	Sat, 31 Aug 2024 06:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQCmVNvd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AB11E493;
	Sat, 31 Aug 2024 06:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725086055; cv=none; b=uZoj/7LHCIF86pKN9lPEZuS3nFQCWMzLdHuZ/zdED7VqmPSwDaREU6wdawpCBr7vp9pva7dwdjk6qxTeAYtyk7pxMraUtdQsb2mlvANEyK5gOzDiyHsKLnehlgJiSfe5ejktHACkycN7nKYvWV6D4r6myn1MEkDlvKeMiKo7VwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725086055; c=relaxed/simple;
	bh=CoGxzG56oI9f9J0OMAy/LIgCFm3y6tK9hF/eezj5Lyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iquDJqgzMkSl4W/ASTKLvJYGwBKrqiC9toNyg7/3tLEfGV+k9/Asrh70q0RRslyCik6htByHstx6iRKdLhmhFxJJEKINw3s4jlVLOJj7ObCOjyR+2/1r3HpdQCmmXO0tY2omhfHn4p3SheUn87R0I3LylqfJwa/OptYFwMRksc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQCmVNvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348FFC4CEC0;
	Sat, 31 Aug 2024 06:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725086055;
	bh=CoGxzG56oI9f9J0OMAy/LIgCFm3y6tK9hF/eezj5Lyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQCmVNvdZJwPuftRDCiDLV2ysKpcnsQBwMrGEv1i2/RbDre6rjysD370BvsQU3A3g
	 SRra9BSaA7ovvxzPU0F8HCoi53N+Ff7NUbWGE8rqK39eovgABtpKes2+wDpIXM/hJu
	 Um2slvdDyaSiN+FLLx5Wuym1Edu2VACLzAuuL95oDAmH3i83h8o9QXNXaMvUyLDiNv
	 EUy1IvBCwGVFg8Qw4HMf8fVvdCme0+yZx8XbZGPcQoMtCi3ms47XT/qJ1kgaN6rau6
	 qtsVVlbTLl9W6+huf3utmBxuMMRwnmS7xLrNj0JbYBBXfTbnyRJniB+rWlLvHsN9yx
	 Q2nRQvD+EgV3Q==
Date: Sat, 31 Aug 2024 08:34:11 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, konrad.dybcio@somainline.org, 
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/4] dt-bindings: apple,aic: Document A7-A11
 compatibles
Message-ID: <tri4uwxzoyrmxkmg3ur4oymzzn4f6torkpjgpkyz6lkgjefg5x@zxbzsfmbrbc7>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
 <20240831055605.3542-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240831055605.3542-2-towinchenmi@gmail.com>

On Sat, Aug 31, 2024 at 01:48:16PM +0800, Nick Chan wrote:
> Document and describe the compatibles for Apple A7-A11 SoCs.
> 
> There are three feature levels:
> - apple,aic: No fast IPI, for A7-A10
> - apple,t8015-aic: fast IPI, global only, for A11
> - apple,t8103-aic: fast IPI with local and global support, for M1
> 
> Each feature level is an extension of the previous, for example, M1 will
> also work with the A7 feature level.
> 
> All of A7-M1 gets its own SoC-specific compatible, and the "apple,aic"
> compatible as a fallback.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../bindings/interrupt-controller/apple,aic.yaml   | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

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


