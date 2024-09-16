Return-Path: <linux-kernel+bounces-330358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A30979D15
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D351C22B50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F9E1465A9;
	Mon, 16 Sep 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekLWbcu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45C13DDD3;
	Mon, 16 Sep 2024 08:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726476160; cv=none; b=HLWNfIpBPevHg1ciPL3HJQY5+vpC5JCRh9oOxrjnnLpWzACopNqxl425eAJmfn0HVQD9N72ojcXwsG053aQeJrx/Sz7vbA+UdyE4fyKzY+Ii/vNjrQIGRB25GB0Go5GNedUNGPdxdrA7AysvxLGN3dKwipcxYdbnSKLscWzySHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726476160; c=relaxed/simple;
	bh=swYJlI50S7AJ+S7i31RttXpQ4Ia7PAjwfWgqOfvVGGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzAnaEUOEwPyqISusAA6eoXADk6VUlxy5mSgQhQDm+Zbks+6VtwlnLcPrud1C0qtTU2Qi28QbOUOWAem18C1Zlisbr/1kjP9FArr2ld7IklCzwEA+2S+kpuZJ3wKDwy5OH0fjLSm1RlTzlj8RUYCnI8nA9S6zxLSijZKxdJe1cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekLWbcu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE46AC4CEC4;
	Mon, 16 Sep 2024 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726476159;
	bh=swYJlI50S7AJ+S7i31RttXpQ4Ia7PAjwfWgqOfvVGGM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ekLWbcu3OR+ybUQgWZZYE3ngjaaeoqD7TPRPTIptDXkAxLKyVbAmwKkJveBU10ofy
	 IGFaR2c81Xu5nV4Q9AOV1p4x19/CisgizWGM+D96Sav4PGHSJ7PpCtKsy4y5fXgleK
	 sj8/eJHaoZwj99LI8NPBzSUzYgYS1QGW2F+5sl9hJEuyPIDYiVYwcV1JYAsNc9TnYB
	 L5YPj0m4dPxqZPJILj2UkBVU8Z5yD5mM55qZdZ+AumDG1c4g5i9yf2WfTNbttyjvca
	 aRMoa+euL5N+bE+R25QRwHIw2kyRR+XyLfw+y+vUveu4TjRM8iaEyPvYpdQwhN5S5r
	 WtS7pCgpPR2ug==
Date: Mon, 16 Sep 2024 10:42:35 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add prefix for
 Ariaboard
Message-ID: <6jpnlw3fj3l3uz4d3as7gz7lsggchnvj423bauw35cjx5kxlnh@p3trmys7yvjr>
References: <20240914145549.879936-1-bigfoot@classfun.cn>
 <20240914145549.879936-2-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240914145549.879936-2-bigfoot@classfun.cn>

On Sat, Sep 14, 2024 at 10:55:47PM +0800, Junhao Xie wrote:
> Add an entry for Ariaboard from Shanghai Novotech
> 
> Ariaboard represents a product line from Shanghai Novotech Co., Ltd.
> 
> Link: https://shanghainovotech.com/
> Link: https://ariaboard.com/
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
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

