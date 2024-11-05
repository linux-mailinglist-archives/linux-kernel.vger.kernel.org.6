Return-Path: <linux-kernel+bounces-396615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E329BCF91
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6601F223B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231981D9685;
	Tue,  5 Nov 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOFkLNPn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C41D90B1;
	Tue,  5 Nov 2024 14:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817405; cv=none; b=UlH6VgZf+FDzA4iRmZBT0dxHgrIRqqtP0qazlsUBZYdCj1zwjXcB2PAp5qxACIsQQAolk2dLzoIz1av/0Q11HcqmLDEbXtcqxv88jvvxo0TIyBRBlQYYBVEHqx+/mpHP9nFqx8ekRgXoV6hXiFXf+2w0Q5zUH8nv5hTQqLmHTcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817405; c=relaxed/simple;
	bh=cv1153HaeB5oi2wTjcRRReGi3zYD4qxx3vrShHc6cRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJKfXrNlzB/OXmrIE7Nimvz/8X9mwXrU39QPlu7nxJAN2OpbQzXAAGPgBjVEIz8bSIjz7sTpShqslXdLBYVRLoBAb9oV0UFI5XmlKd1eAFhQoAiMeX0ECpImORvz4C6sflSEuPWy19qpQBgbR1Xp8Y/Q3eALAGQMmZDudIXmFQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOFkLNPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC59EC4CED3;
	Tue,  5 Nov 2024 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730817405;
	bh=cv1153HaeB5oi2wTjcRRReGi3zYD4qxx3vrShHc6cRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gOFkLNPnJFU/oJLWRdFNm9N+OOWKQImsmjx6NPHArltpdgmEucj97u68r6yb50Ycp
	 iJhae8rccxHXO/SxVjni3rstPyi5AX934DVHNIibpWWKj5Wih/L/lWyjJ+H7s0P45r
	 HIdQxOIOzJ2EVORgB7yEg+b2ek0tFzUC2vlxffBd0DTrHU9k5frhlLZZ4RcaIkJz0b
	 y8+sAFOeEZ714kREZR58aItm+5JdKic5SK/z/WbRGQuy58wM4Cx2ONakUzfPVE516T
	 SF/sR9SSWa9S7tZ3ikOb8Apl9QIbrSMbziRjtYHnS9x9wBFCsOZtzkQgLyaXuwzzCz
	 z9swHi+pEUa4w==
Date: Tue, 5 Nov 2024 08:36:42 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Fei Shao <fshao@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	David Yang <yangxiaohua@everest-semi.com>
Subject: Re: [PATCH] ASoC: dt-bindings: everest,es8326: Document interrupt
 property
Message-ID: <173081740255.3223236.18302117603636012418.robh@kernel.org>
References: <20241105091910.3984381-1-fshao@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105091910.3984381-1-fshao@chromium.org>


On Tue, 05 Nov 2024 17:18:11 +0800, Fei Shao wrote:
> The ES8326 audio codec has one interrupt pin for headset detection
> according to the datasheet. Document that in the binding.
> 
> This fixes dtbs_check error:
>   'interrupts-extended' does not match any of the regexes:
>   'pinctrl-[0-9]+'
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  Documentation/devicetree/bindings/sound/everest,es8326.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


