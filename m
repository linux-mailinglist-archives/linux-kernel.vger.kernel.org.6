Return-Path: <linux-kernel+bounces-173669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C058C03BB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 664D328557D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAEE12DDB0;
	Wed,  8 May 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rla7ceu3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401B12B148;
	Wed,  8 May 2024 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715190615; cv=none; b=lOCKcBo9Wf3JYKNZvbk2EKv/tk03luV5GdU3PhLQu8oOkFU5qCOw05CY3ReKSe7gTOEWIEFPs+E82q63xBjeIB973B3KS1zJ9VDOmMix8ROyPQ5d1NzZwrlFLWNqsyRPcRxzV0FtWHIRcnZLhDk4xWCPp5pfaS3YjGuRsXzSifE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715190615; c=relaxed/simple;
	bh=O7Iu+gfiqdTrJ5Xezid8yKZhJ+FRommTaNGfEwrOI4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QV5W+fdL+xkh0ohjfYecZFknJcuIObVK5CJVhd+ltiPfoYUb6ldCv4rOi3bOX/kdX856nzMVifYYNaxLpvzh3kImnlLp8Cs+dwFlyAMIpxPDrewWrQnlbexPrL1HvevWqSFIt+H+pmo3HZkg3CyD5xQGZWu7pcr0XbDvAGakq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rla7ceu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2F2C113CC;
	Wed,  8 May 2024 17:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715190614;
	bh=O7Iu+gfiqdTrJ5Xezid8yKZhJ+FRommTaNGfEwrOI4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rla7ceu3BrmVcpFdRGNn0AW4gfXOO8LADVNVvrR3LyWGxP8tus/4nJsxlUDdrt7GV
	 z+pEWZlWgrStd0c13TYNY7Srhyrf4OaxBvpZr1Rj21qyBbR2TSVAUhgRSBOaLLJnUX
	 MmxCRGMZqAWDDLykIjLGUyqfUOpatzkat2PuyGDOX4V9+phJ8EmDkvsgNmzTQSRw9l
	 vy4o+oEQPZMKyhXbzTX5jGkDqxdhnO5jgmlWlo3lOxL5HOz3+z48mvMjW2z9UXC7UZ
	 44PXuLMukcEAPC/Y1Nr6SrhOaw39O4rHg/E2ZA/NE7rBCwy3grmUF/HvHNiFNyuMqV
	 HcIrvNEhdhuoQ==
Date: Wed, 8 May 2024 12:50:13 -0500
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [APPROACH 2 1/2] arm64: dts: amlogic: list all slave clocks for
 audio clock controller
Message-ID: <20240508175013.GA2244257-robh@kernel.org>
References: <20240508144259.191843-1-jan.dakinevich@salutedevices.com>
 <20240508144259.191843-3-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508144259.191843-3-jan.dakinevich@salutedevices.com>

On Wed, May 08, 2024 at 05:42:58PM +0300, Jan Dakinevich wrote:
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 27 ++++++++++++++++++++--
>  arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 26 +++++++++++++++++++--
>  arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 26 +++++++++++++++++++--
>  3 files changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 6d12b760b90f..28f4ec5f39b0 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1342,7 +1342,9 @@ clkc_audio: clock-controller@0 {
>  					 <&clkc CLKID_HIFI_PLL>,
>  					 <&clkc CLKID_FCLK_DIV3>,
>  					 <&clkc CLKID_FCLK_DIV4>,
> -					 <&clkc CLKID_GP0_PLL>;
> +					 <&clkc CLKID_GP0_PLL>,
> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>,
> +					 <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>, <0>;

All 3 cases are just unused clocks on the end. I suppose that's not 
always the case. You could just set 'minItems' in the binding to 
avoid needing to pad the end and the dts changes.

Rob

