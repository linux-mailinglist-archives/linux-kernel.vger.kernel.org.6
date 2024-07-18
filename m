Return-Path: <linux-kernel+bounces-255969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81C93472F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 06:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF3E1F21E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B935A3F8F7;
	Thu, 18 Jul 2024 04:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="IWBaG5kh"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36171B86FB;
	Thu, 18 Jul 2024 04:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277381; cv=none; b=BIG568/mZZQtSazggnhGcKd1RuP6OYCZ0Y+C33f9BXzCdXaQdjyr2OBgxTdnZ7j3+DQorWpVGWZfkkWtHMzXqEPsN3O2S7aTjW850Ybgo76HETQb9gPcnvRDlEX8iiyDxRswPCdn5O4O2ymJ9Yl7sXIiYnI1fDoUfmJgUPpKdKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277381; c=relaxed/simple;
	bh=L6XLXMwNzjIRYrf7YyEUyCXji/eqfOMPxL1quiGMKEc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=S7iGtXUATKeyliQbiz43BmvcVJALsZBnfcmswv+nBp6S7HyBttLI4kFDHWc217ewUyqabdHJDdpIRri7A5SNtOzDMFLnorOZyUA7s/7fqWRbv4CVNcB4nLLInR1ZH77dqZOpM4NmoqLM79q5mmMGf6/gQKDIdyq+CUPeym01sSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=IWBaG5kh; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721277377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tOqNb1H2eOYhzV9Qd6Dsedv66pK9VwGnewTuikI5a20=;
	b=IWBaG5kh85WTR4/3uiiIoGv3jOMvzJVWWgErMsjsg9/FqzDS8zGFp6VYN0mVmCV7+i7JO1
	lnC7i6SW/++7ZISec/iGNU8yYlBfkDCYGxBj9/UcR9gS565ELKGWjEbgobyGPDLBf7czcd
	yHIs3w75OqHN3iqMSH+hNvqE11oJw8I5huoJwKZm5FxwdpzzHYY+fjWEnV5tqftXEIwlD9
	+w1NCO1nmIW38pmDcFxGYuN6VJ0S2lAJwGPBiFGsSX5FAZLmLzENLo5r/EkWxuHKMmkNPK
	HK0rOjWoj0gRjMem88+CC6MUNQ5i27WZd/np4LbF5OivH4nxb/cssi3E5E6zhQ==
Date: Thu, 18 Jul 2024 06:36:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>, Collabora Kernel Mailing List
 <kernel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
In-Reply-To: <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
 <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
Message-ID: <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christopher,

On 2024-07-17 18:46, Christopher Obbard wrote:
> Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
> with the MB-JD4-RK3328 & PX30 baseboard.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1ef09fbfdfaf5..33ca8028bc151 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -148,6 +148,12 @@ properties:
>            - const: engicam,px30-core
>            - const: rockchip,px30
> 
> +      - description: Firefly Core-PX30-JD4 with MB-JD4-PX30 baseboard
> +        items:
> +          - const: firefly,px30-mb-jd4
> +          - const: firefly,px30-core-jd4

Similarly to how I suggested the new dts(i) files to be named, [1]
the model names should be named like this:

           - const: firefly,px30-jd4-core
           - const: firefly,px30-jd4-core-mb

This would also follow the "inheritance graph" pattern, so to speak.

[1] 
https://lore.kernel.org/linux-rockchip/38d7b7e9ab71bf1b0817e666f4233b9e@manjaro.org/

> +          - const: rockchip,px30
> +
>        - description: Firefly Firefly-RK3288
>          items:
>            - enum:

