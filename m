Return-Path: <linux-kernel+bounces-448761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FAA9F4530
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 08:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B4D168457
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7A1CDA0B;
	Tue, 17 Dec 2024 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJXTn39j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4B31D45F2;
	Tue, 17 Dec 2024 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734420825; cv=none; b=nvH1Teu0J6QgHCB4u9n28h01gEF3I/WNnLZlUh0TPQOEgujYVn6xGoV4Se8N7eBGHpHfxW1ZIaa4e6Q8X1sSPu/tNOViIPA5CKFVj49VQbB93ONVwLcE5Y80MMm38gsz9N7gtcfm6bZWvH1xgUrngZvyGU3pHakdxfirZ/+n0yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734420825; c=relaxed/simple;
	bh=M1pOmN/fmrnkiHXjXK1Xx0Kcg/VyvJPOlUCfuO+9V5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8Vq6W/R1pHbCvLLu39+GrRPAXLXKWlHGBOz4oLTrs+77KcA33YezL5DGxQsRu4PuXSuC1iFsFVBA+P6N1MLnvcxI6iTg9QuezFFELrQioR1xvsJbNU9aapTToPRFIbOaqvLuNVYunomIVFSLZ/l6lHUVvhdkcbNtqpc1GTLlXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJXTn39j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A174C4CED3;
	Tue, 17 Dec 2024 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734420824;
	bh=M1pOmN/fmrnkiHXjXK1Xx0Kcg/VyvJPOlUCfuO+9V5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cJXTn39jURAGQhGGv+xp7kNADMVxFerXYrXU8b7qLyIsuiywVaOrILfic8uMEnAGW
	 vmJjbQHH5yOlMT9jjx964286SF0GY2D77UZGu+bbFxMkN57mFvby2saIGNgLwLTppj
	 APayiuq4DVJrzr9Y5GFJM+sCHbWSPX4y5w4+yD3ypK6jnUCoSCCkrLhHmDzAhgink/
	 yg6DrxmS/R9K5Jhfu3INIeuI4fHWUEghNO9SwZvwbU3HjozLT6qoO1kOReCu7UfG3J
	 AZDfy+yUei/TU0MnRtGANQp2TOzoz8A6BT6woKokEtchkmFiSxkC7sBA2aMuTxNxuq
	 OH9aaBVq6el+w==
Date: Tue, 17 Dec 2024 08:33:40 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Maxime Ripard <mripard@kernel.org>, Roman Beranek <me@crly.cz>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: clock: sunxi: Export PLL_VIDEO_2X and
 PLL_MIPI
Message-ID: <qbtp4jvkx3r5azufe4k3vtapqpfs54dyjiu4cy5v5wkkzumrzx@vy3xzkfplbue>
References: <20241215053639.738890-1-anarsoul@gmail.com>
 <20241215053639.738890-2-anarsoul@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241215053639.738890-2-anarsoul@gmail.com>

On Sat, Dec 14, 2024 at 09:34:57PM -0800, Vasily Khoruzhick wrote:
> These will be used to explicitly select TCON0 clock parent in dts
> 
> Fixes: ca1170b69968 ("clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 2 --
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 2 +

You cannot combine these changes.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run 'scripts/checkpatch.pl --strict' and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof


