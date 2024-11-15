Return-Path: <linux-kernel+bounces-410945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B429CF239
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A063B3135D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3561D5149;
	Fri, 15 Nov 2024 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNCC9KXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664521CDFCE;
	Fri, 15 Nov 2024 15:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731685705; cv=none; b=hEHQ00RDe9ifTqJ3wx4f0FZ8rNDL32+1/97lXOZVu8rIpfAZuNQE4+714RNN2LdWuNzvV1+nyBFT6hwR/4KfVmLd/2nOdICJtcclp+nfRrZ++W5Ho8IY5v8zd2FYT2cPPu3vcTPRnAXSvVACsocZqyCrxiwm03y9cvX3bR8wwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731685705; c=relaxed/simple;
	bh=yJBJacWoFtin2ILARdZFHntD7M8KX+J8rKrtFyI7gig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgJBQLxnNZgvk2pGQ5Rz6hGBFhbU62qxibW/OTzgwEq0K6fMo7ARf3in0cNpA7fgXUzVWOxXdszVZS2YyG5yyeM4lLldMAh7qi7Pk+eVLdFWRVxhYa7vtejq/TXCS8S7ZHRbrtEVBufxoMO48VliyX3IKJs3LeyQdrDeQmYMJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNCC9KXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F09EC4CECF;
	Fri, 15 Nov 2024 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731685704;
	bh=yJBJacWoFtin2ILARdZFHntD7M8KX+J8rKrtFyI7gig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNCC9KXeCYEyFjc1jOpURFLAlq4jzhYz1v84iBROiCAJFSkPWBZHaVYTTFrrhxLUN
	 D6S1uoFV8e2hHDOITGx6Ca9yG6YiiJBpnmfSxO3AGLZ+vfzKB5m/0+W6nLS5ayuUQ4
	 MfQ5iraMHd57W27D7IEDSaOT98UzHE28GGPTLRDjCm1zdw7kkXCb+B+3/JuvzPVLjN
	 xQmimdJoUkqjYnz0lI5Tt7bBefRp59Cz5JXXa+/ohxVU68D8ysHoFVNc+dMuFesbqL
	 IOnBXOsVGSpUgHKIBgEKMyem9fIVvqRI0RPqPSv7vLEsNTkAFK4+zfdQqY2Pq4kJBb
	 iO2TaemFUCVog==
Date: Fri, 15 Nov 2024 09:48:22 -0600
From: Rob Herring <robh@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: nm@ti.com, vigneshr@ti.com, kristo@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	srk@ti.com
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-pinctrl: Introduce deep sleep
 macros
Message-ID: <20241115154822.GA2954187-robh@kernel.org>
References: <20241112115650.988943-1-s-vadapalli@ti.com>
 <20241112115650.988943-2-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112115650.988943-2-s-vadapalli@ti.com>

On Tue, Nov 12, 2024 at 05:26:49PM +0530, Siddharth Vadapalli wrote:
> The behavior of pins in deep sleep mode can be configured by programming
> the corresponding bits in the respective Pad Configuration register. Add
> macros to support this.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-pinctrl.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-pinctrl.h b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> index 22b8d73cfd32..cac7cccc1112 100644
> --- a/arch/arm64/boot/dts/ti/k3-pinctrl.h
> +++ b/arch/arm64/boot/dts/ti/k3-pinctrl.h
> @@ -12,6 +12,12 @@
>  #define PULLTYPESEL_SHIFT	(17)
>  #define RXACTIVE_SHIFT		(18)
>  #define DEBOUNCE_SHIFT		(11)
> +#define FORCE_DS_EN_SHIFT	(15)
> +#define DS_EN_SHIFT		(24)
> +#define DS_OUT_DIS_SHIFT	(25)
> +#define DS_OUT_VAL_SHIFT	(26)
> +#define DS_PULLUD_EN_SHIFT	(27)
> +#define DS_PULLTYPE_SEL_SHIFT	(28)
>  
>  #define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
>  #define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> @@ -38,6 +44,19 @@
>  #define PIN_DEBOUNCE_CONF5	(5 << DEBOUNCE_SHIFT)
>  #define PIN_DEBOUNCE_CONF6	(6 << DEBOUNCE_SHIFT)
>  
> +#define PIN_DS_FORCE_DISABLE		(0 << FORCE_DS_EN_SHIFT)
> +#define PIN_DS_FORCE_ENABLE		(1 << FORCE_DS_EN_SHIFT)
> +#define PIN_DS_IO_OVERRIDE_DISABLE	(0 << DS_IO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_IO_OVERRIDE_ENABLE	(1 << DS_IO_OVERRIDE_EN_SHIFT)
> +#define PIN_DS_OUT_ENABLE		(0 << DS_OUT_DIS_SHIFT)
> +#define PIN_DS_OUT_DISABLE		(1 << DS_OUT_DIS_SHIFT)
> +#define PIN_DS_OUT_VALUE_ZERO		(0 << DS_OUT_VAL_SHIFT)
> +#define PIN_DS_OUT_VALUE_ONE		(1 << DS_OUT_VAL_SHIFT)
> +#define PIN_DS_PULLUD_ENABLE		(0 << DS_PULLUD_EN_SHIFT)
> +#define PIN_DS_PULLUD_DISABLE		(1 << DS_PULLUD_EN_SHIFT)
> +#define PIN_DS_PULL_DOWN		(0 << DS_PULLTYPE_SEL_SHIFT)
> +#define PIN_DS_PULL_UP			(1 << DS_PULLTYPE_SEL_SHIFT)

Are you going to go add the 0 defines to all the existing cases? If you 
do, it's a lot of pointless churn. If you don't, then it is inconsistent 
when they do get used. I would drop them all.

Rob

