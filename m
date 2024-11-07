Return-Path: <linux-kernel+bounces-399671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1A29C0293
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02774281477
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862AB1EF924;
	Thu,  7 Nov 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VADCOzFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5101E1325;
	Thu,  7 Nov 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976022; cv=none; b=UwcfvW3pudKjDOBt3W9ANpO71bWMuTdGDpTbv6pfl2t8s2l53Bv16OTeMmhlzm94QMmRPi4cXR76cBkdhl9UUHX20AWvUq7XVv5w/z+7kCFJxPkMARqwHZYXT2StYe/dgxLnveelaRxQJf2ftGNH6f7GEMj31KbAttRMtgTC5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976022; c=relaxed/simple;
	bh=VRa2mI7dVpDSpKy9Wwljp/gFO/T3/KSxHI247WS5TrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFc1rrZPT2mCcX9eH0E+r8zi3D7y1ECE3bAY8Ksjzg+jzoXz5MoBvMWlYorwDexrviHdVBe2p5cSfh8GlEOLCO2HsZ2g9mx4bG0jdDNRDEwKV38kuz3KAfOC1OB45nC2Mk1rQjc5RLWO4N3b2Tda1BxZJY7Su1rqGmTJ6r4/gGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VADCOzFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC7EC4CECC;
	Thu,  7 Nov 2024 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976022;
	bh=VRa2mI7dVpDSpKy9Wwljp/gFO/T3/KSxHI247WS5TrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VADCOzFPpJ4Ika22a9Ctfw75oRTQdgYokAlAjZd7OPy2rtj96ZMEvXjBocKAby9Sj
	 LNDIf1+TNqRu9rzfDXyfZGArMqnzr5eD29925xfyx2xbKcm1+kFHQQz1ULdYqt5IUi
	 xzXk2O8tgvikkGJnkUJbf00OfoN5fMdTuOf01iVZaCBCRakNRvw1zzcsdB8pdbrSFx
	 /zSVDyHU/BRFTb1/BtXuJi1e3AR6GVVUZfpsNTmpnOpDoosHtpr3fOVmKHIiYfMdBZ
	 K80KZOxtyfYqsQtuLxFCIbVIm5W1Xurj/6Vws6p7gBL/LO8dDcVGrfaTQ8e9Uik1Nn
	 rQGnyoryKt0Eg==
Date: Thu, 7 Nov 2024 11:40:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: clock: actions,owl-cmu: convert to YAML
Message-ID: <4kmt23n5v5ppqf3sc5bdag76r7vxsnryazh5xytfevt25c3wrq@ptnk5wpb67ol>
References: <20241106153141.375389-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241106153141.375389-1-ivo.ivanov.ivanov1@gmail.com>

On Wed, Nov 06, 2024 at 05:31:41PM +0200, Ivaylo Ivanov wrote:
> Convert the Actions Semi Owl CMU bindings to DT schema.
> 
> Changes during conversion:
>  - Since all Actions Semi Owl SoCs utilize the internal low frequency
>    oscillator as a parent for some clocks, require it.
> 
> Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
> ---
> v2: drop address and size cells from example

...

> +description: |
> +  The Actions Semi Owl Clock Management Unit generates and supplies clock
> +  to various controllers within the SoC.
> +
> +  All available clocks are defined as preprocessor macros in
> +  include/dt-bindings/clock/ headers.

You could list the headers. Otherwise it is pretty obvious and could be
skipped.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - actions,s500-cmu
> +      - actions,s700-cmu
> +      - actions,s900-cmu
> +
> +  clocks:
> +    items:
> +      - description: Host oscillator source
> +      - description: Internal low frequency oscillator source
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"

In the future: please keep the same order of items here in required: as
in properties:. No need to resend just for that... but:

The clocks property were required in the old binding.


> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    cmu: clock-controller@e0160000 {

Drop unused label 'cmu'

Best regards,
Krzysztof


