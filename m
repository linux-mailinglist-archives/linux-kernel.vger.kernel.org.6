Return-Path: <linux-kernel+bounces-374996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FAB9A72EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886E428353E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5C1FBC81;
	Mon, 21 Oct 2024 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bhx8KcNi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EB2209B;
	Mon, 21 Oct 2024 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537669; cv=none; b=YWcJoVey2obHPt9RRlLfZiXNfCbWAS9KXJI76fBAyNOWRB5VJK0UgNT4u9WFf1V2C+BQfbfpiwOX0ywRpE+kgf8TbOZKEp0iI8Btetn1ZDHG2LDmBR7GvuaVBslNryZVgNkwY/+cLhsQaW9Im1shQto97uz97YIWY0Dzg9WXJes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537669; c=relaxed/simple;
	bh=6N9mdOnKjd9p1pGUymuDuTFWp+pKf4k/EQmhMnrd6Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eII+objiEqOfiZwy86TbIUZqA3PYtDd6U4MnEKmDQUvZSfM1/FpuAT+PZwi9EQtw1KGs/1wA7KtPS9c1j9zuSTcos2nXWkRVLCbpDLC85ciFidSXAAV23bK6dUNsLW9DpmAoOACj0T3CS1XYR4fTvijmrlNmfYGOarJLCg/fIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bhx8KcNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5E5C4CEC3;
	Mon, 21 Oct 2024 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537669;
	bh=6N9mdOnKjd9p1pGUymuDuTFWp+pKf4k/EQmhMnrd6Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bhx8KcNi8QM3iYmhzGNohkjJwltaEKuv0/fmcW7s6nV1vvNtSb5cJM/jYBnrHLJIk
	 HcXOcBSY+55K4K/b5hMlVGsDDIsd0cBzuNEjpfj2knDY/i8mSqXdugmYbu5FPAiLbM
	 lXkZ1dXyMn7Xnf1yp70sWbvauDupLaq1oVWJfdbBkGGPrg0tC8BHiEzv7hFOqdHG+N
	 KIRvFiTioBB9ffxFXTCfMAfhqywHgYIhNstt91rA4LfbDxYULhDXpMc6f4Gn9Gshoa
	 P0gDAmBaYqDdvjIv6NsrUsUk6DenC7MUjrMkMQoWhetkekQiwXqQJVaQszTVu+YC4A
	 V0Dp5U28daDjA==
Date: Mon, 21 Oct 2024 14:07:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sound@vger.kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	David Yang <yangxiaohua@everest-semi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] ASoC: dt-bindings: everest,es8328: Document audio graph
 port
Message-ID: <172953766731.964533.1953303689089289577.robh@kernel.org>
References: <20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241019-es8328-doc-port-v1-1-25c1d1b5c65c@collabora.com>


On Sat, 19 Oct 2024 03:43:14 +0300, Cristian Ciocaltea wrote:
> The ES8328/ES8388 audio codec is currently used in conjunction with
> audio-graph-card to provide an endpoint for binding with the other side
> of the audio link.
> 
> This is achieved via the 'port' property, which is not supported by the
> binding:
> 
>   rk3588s-indiedroid-nova.dtb: audio-codec@11: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>     from schema $id: http://devicetree.org/schemas/sound/everest,es8328.yaml#
> 
> Document the missing property.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  Documentation/devicetree/bindings/sound/everest,es8328.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


