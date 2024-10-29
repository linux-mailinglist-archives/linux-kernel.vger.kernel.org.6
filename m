Return-Path: <linux-kernel+bounces-386428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BE9B4357
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:41:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73501283A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A69202F68;
	Tue, 29 Oct 2024 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njc8eg0u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67349201265;
	Tue, 29 Oct 2024 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187699; cv=none; b=WAjeQ5wsFNzg1PpnpQybUAgx24Zx/+/vdqqJJi3xxsA105zx5uJSpJqeeqgp6RDGncA657gSzn1/1nGByn8VoEzvvKY/ogwCq6ZwNYwv8EGBNq3zTwz2z53UubLJcXPWBWRnjJ9g4r47XYT4GDDJ8Ko9hPPBH5v89+DxR9fxJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187699; c=relaxed/simple;
	bh=IQEh5EussygJgUUzWfJeQ/FXr/FcOcbs/szaZmJBHo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmP4r5xzh7svJvNJteDp6n1jCmx3RXilHdYghjRtrsDmBcUKjy5WyOzB77sNHh64CrhsJqHfIGs8EezfvMG5E3wZqsD4ZY0IcoIaxHz2HzXpT5PPiUGF1n+Mq9B78vxtJPemoQF8BQM1gR4fe0dK9dAPE4uaYzzv3LubuDLumEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njc8eg0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029AC4CECD;
	Tue, 29 Oct 2024 07:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187699;
	bh=IQEh5EussygJgUUzWfJeQ/FXr/FcOcbs/szaZmJBHo0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=njc8eg0uqZRauuWTgMREq2+3I7fvICMvCytUBaD/jwew7xxd5bgg8a7910TU+wX2n
	 kiyTZNV3+e8S/pcF/U01MPhOPstYT3tEZop20jisA5cwaOLHAXAvwHY/UgCLgiOjTu
	 cxMfs6vllDscfNutuo6b+CsZkyzrjxVAW3U7p1kW5j/iKK4SFHkdFGGP2mqMYgJpLv
	 W3DVWga7+Zkz1Xa0Y1TAojKBasRXBwQkA5jEEf7ZqKiuXk25JE9rQudaRzrtKqUCNV
	 vL1zc3zVA54QF8GKsfuBaUEx1sR1zc9sFrHdQrRbN23ruSqFqFfnrSfrdCiTfb/sGu
	 VaQhZ03dg1EZA==
Date: Tue, 29 Oct 2024 08:41:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH asahi-soc/dt 02/10] dt-bindings: arm: apple:
 apple,pmgr-pwrstate: Add A7-A11 compatibles
Message-ID: <hz56qyjzjb5ah6hpp3wlpiewmo575gej6nljomgy5hdtacfuk6@7azefzbmokcl>
References: <20241029010526.42052-1-towinchenmi@gmail.com>
 <20241029010526.42052-3-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029010526.42052-3-towinchenmi@gmail.com>

On Tue, Oct 29, 2024 at 09:04:00AM +0800, Nick Chan wrote:
> The blocks found on Apple A7-A11 SoCs are compatible with the existing
> driver so add their per-SoC compatible.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  .../devicetree/bindings/power/apple,pmgr-pwrstate.yaml       | 5 +++++
>  1 file changed, 5 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


