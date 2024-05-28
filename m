Return-Path: <linux-kernel+bounces-192284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C588D1B11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5EDE1F24AEB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2AE16D4E1;
	Tue, 28 May 2024 12:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1YwINKK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47A13AD30;
	Tue, 28 May 2024 12:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716899018; cv=none; b=gDmSDw6ERYV7Yy8w8WjgVE8cJx4q5d49hZKPQcgekYxPiiYu/84ZStxE7vBsljlbYeF58tcKbJVXraMJVtxDaBi1S8SeUKyIJaf4YfHVfEBKHtZq9UCT+7vhZDQ790wyV8bux+O/T4mzmh3hudtgJpY0e7S/vleSVu4svLS2aUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716899018; c=relaxed/simple;
	bh=JWqqFhT6BMoU6aedUh2YxiyaeH9WHnDepgBZgI6tTls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c18EEVoFr2HUES+Dpr5m4daGZ6yogwphQ9J79XRixUX3msF7MS1RSOxzcdJ0Z2rNB7Ui0+G7KbZZO6yXJm3jB+//fXtN0lD88bpMGEldQ/b7tUk4kOKoWooYPMfJCvT44BqobKJ7rkeEsAJlMvJZNDzY82Xzrw0ycqzSEe7rgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1YwINKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC32C3277B;
	Tue, 28 May 2024 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716899017;
	bh=JWqqFhT6BMoU6aedUh2YxiyaeH9WHnDepgBZgI6tTls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l1YwINKKJVGJhcVsF7GsL/Vfr1KNYTo13apnp4s2e5bRB4uFIJ9owNDw6Oa1d8Gks
	 AmktQMpxqKQSrjGpIwK2c1oMW6qZQJo0eRbAmLqBuvC0i5Xxzl1YfnNbi8gBOUhSOj
	 NSYtKsV43kXLgdYi+l2ViIT1y+VWRTw/OWHTNLQ9Vc6L5AyININOczUzdJAk6s/Gbf
	 JDGov47zltypH79lOblHSo1vWAoThOF1Tkew9cKxAnE73Pcnva5y8o2W3sD6OiQ+tt
	 1gSBZCvUXzVzn+EJpYFHd4NU+Ghg5zY+XZd72+Bv3YZZoDKXQhGbbG03abPyc9MwMZ
	 uP9S6w0rSldwA==
Message-ID: <1e6242a1-2dc5-4f88-9cbb-eb14a27cccc4@kernel.org>
Date: Tue, 28 May 2024 15:23:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] arm64: dts: ti: k3-j722s: Add lane mux for Serdes1
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-6-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-6-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> The Serdes1 instance of Serdes on J722S SoC can be muxed between PCIe0

Please use SERDES insted of Serdes or serdes as it is an abbreviation.

> and SGMII1. Update the "serdes_ln_ctrl" node adding support for the lane
> mux of Serdes1. Additionally, set the default muxing for Serdes1 Lane0 to
> PCIe0.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Current patch is v1. No changelog.
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts   | 3 ++-
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 5 +++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> index a3bda39cc223..16c6ab8ee07e 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-evm.dts
> @@ -401,7 +401,8 @@ &sdhci1 {
>  };
>  
>  &serdes_ln_ctrl {
> -	idle-states = <J722S_SERDES0_LANE0_USB>;
> +	idle-states = <J722S_SERDES0_LANE0_USB>,
> +		      <J722S_SERDES1_LANE0_PCIE0_LANE0>;
>  };
>  
>  &serdes0 {
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index b069cecebfd9..48b77e476c77 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -96,8 +96,9 @@ usb1: usb@31200000{
>  &main_conf {
>  	serdes_ln_ctrl: mux-controller@4080 {
>  		compatible = "reg-mux";
> -		reg = <0x4080 0x4>;
> +		reg = <0x4080 0x14>;
>  		#mux-control-cells = <1>;
> -		mux-reg-masks = <0x0 0x3>; /* SERDES0 lane0 select */
> +		mux-reg-masks = <0x0 0x3>, /* SERDES0 lane0 select */
> +				<0x10 0x3>; /* SERDES1 lane0 select */

Why not introduce this right in the patch where you add serdes_ln_ctrl mux node?

>  	};
>  };

-- 
cheers,
-roger

