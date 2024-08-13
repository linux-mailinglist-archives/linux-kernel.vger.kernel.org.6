Return-Path: <linux-kernel+bounces-285104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5873D950961
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E969BB2700D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88DD1A0729;
	Tue, 13 Aug 2024 15:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BK+vCDi0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E0E198A0D;
	Tue, 13 Aug 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723563989; cv=none; b=pwh5rpsjKCuJvLt4VeMLTsLmPlblogNS/8InkgjL7WgjNPNJPaZ3/0sU6WTI4IBSPXKlY67Cc9DLtulWS/QqlcoD33/gpu2Ovi4341OM/SBkJ6s8vkWJa7nEOF6g5/AjAohBKZcTRnEBb8d2Y+jwd4sXGSlJANDXPC7g5wvs+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723563989; c=relaxed/simple;
	bh=OvSdMM09vl0EzDvUZOZ3ckjGUvUcbMqlTlXMiqisvpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LaXgS0zrEIIUhVcWMwCEBaPBIFZbbgL3Wx3gdxM5FIOGaFmCe3V3wUq7292lqUpk8tyVnA+tl4vnJlcZzW/AQ+nYlGSrxYeo12yQ9lIDkCde2Z09RTjKZsLuuQ9Db+f8RL2F2wqAtzFKiwzTVnCTxWvE9fMCjqdl1nZoYUd9lqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BK+vCDi0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30244C4AF0B;
	Tue, 13 Aug 2024 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723563988;
	bh=OvSdMM09vl0EzDvUZOZ3ckjGUvUcbMqlTlXMiqisvpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BK+vCDi0AQmNFPNbEZQ25I7BdA8glOk+cUQX1ar+u9Ji9Z2JWh9QYnXx+cxZ3RS0s
	 xIA/rWmq71oZI4IMaxDQKPkqWKiEookEGU9xZDPI6rhgywrLpkNfoy1TFYGSennB7K
	 lg3opmpqhmeGHrcnJU9Cjaujoz0Fz0MK+y2YakA6Wm/LVN7zhbZ5zylDjhBOLdLdt3
	 e+RnyJRyWy2O0TnuTB89xlgosdkG11c3J6V6EWeitT5JtZ8By+VN5JzEdSkjbU5qVW
	 N2W4P4mMgaiykgGZZl21WmUGnTm2/pguS+n+lvPtCke6BgKuVD65XdF0/HpCCa8VBZ
	 vUo4Rl5SOjJ9g==
Date: Tue, 13 Aug 2024 09:46:26 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 2/2] dt-bindings: misc: aspeed,ast2400-cvic: Convert
 to DT schema
Message-ID: <172356398413.1009063.989428547920653092.robh@kernel.org>
References: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-0-c2531e02633d@codeconstruct.com.au>
 <20240808-dt-warnings-irq-aspeed-dt-schema-v2-2-c2531e02633d@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808-dt-warnings-irq-aspeed-dt-schema-v2-2-c2531e02633d@codeconstruct.com.au>


On Thu, 08 Aug 2024 13:44:25 +0930, Andrew Jeffery wrote:
> Address warnings such as:
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: interrupt-controller@1e6c0080: 'valid-sources' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> and
> 
>     arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-galaxy100.dtb: /ahb/copro-interrupt-controller@1e6c2000: failed to match any schema with compatible: ['aspeed,ast2400-cvic', 'aspeed-cvic']
> 
> Note that the conversion to DT schema causes some further warnings to
> be emitted, because the Aspeed devicetrees are not in great shape. These
> new warnings are resolved in a separate series:
> 
> https://lore.kernel.org/lkml/20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au/
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>  .../bindings/misc/aspeed,ast2400-cvic.yaml         | 60 ++++++++++++++++++++++
>  .../devicetree/bindings/misc/aspeed,cvic.txt       | 35 -------------
>  2 files changed, 60 insertions(+), 35 deletions(-)
> 

Applied, thanks!


