Return-Path: <linux-kernel+bounces-177728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD88C43CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D7A1C22050
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0706145FF3;
	Mon, 13 May 2024 15:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="E5P2q4Xq"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285256457;
	Mon, 13 May 2024 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715612814; cv=none; b=n/eA5p6UMopFgHMY7tyz6yN19nTnOiHJuPXeSykDTx+tHe3RdTyMim6hqyq7N32u1L65kxxfYZJld6cTRTLa2uIUEK4NDkVQu5rMwDiYv222lFcz7CgeyLCryxIZH8ON5hs6lLoJ+uLKN88Kr14xHCZYtc9Zm6MQ0OXGh9lfWdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715612814; c=relaxed/simple;
	bh=2yMEGAxyJ4o4Wyner8ON/55yiOqoOvkjWG5UCt5EFdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DglgLD2i7BzR0yphkUV/TlgtcxwfULCVFpcjJw8r3WkAu8HAI0fihRxdx6xhBYQJsk7GpWVL0/qAE1v/PAz7TxyDvxgA7DzHftzkAqtvytwcplh/8VdbtO6ucKve1wTzjnvIHXMqY1jzHRvv5NdBguqp5YgQoonfEKn9Faz8qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=E5P2q4Xq; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 2175D87F13;
	Mon, 13 May 2024 17:06:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715612811;
	bh=CLtRBcrV8ZA4r12w3/CUqBvLBUpcesXFzphIqIUvDqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E5P2q4Xq5fp2GI3FBySbulplbyp7OSFmdeDoMVRX2M27BCFa+wJoh4amCTdiGNjbj
	 xH7+IjNER94wmrkItXZwXbcgwpLrvefr8QdDQZmCL8Yy4S+scPB/1LEycZ2QD2GtnI
	 MHUAK4PJ6MBiORbIe+RBqpVbcMzMZxHCRWajYKLBdpSS+foHjqENVDtsSvzVovDTIO
	 seJJTZV99wJ2L8+LfRq6+Hf8q2KZ2+P2JoXrj8RUeDu+pO7Gp01s5CXNM5U+3wXK9N
	 LY9NxpZRPNrUFgUCO1x9D7HwHTS5XJsGm3mrKbBgEa2n6lP3qI1q718kODYBpXo6/3
	 XpxbGKKHs/6Pg==
Message-ID: <615dfdcb-cbda-426f-895e-810f03a8ce60@denx.de>
Date: Mon, 13 May 2024 16:34:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: regulator: st,stm32mp1-pwr-reg: add
 compatible for STM32MP13
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexandre TORGUE <alexandre.torgue@foss.st.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Pascal Paillet <p.paillet@foss.st.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20240513095605.218042-1-patrick.delaunay@foss.st.com>
 <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240513115601.v3.1.Ia0a99d90acb512aa020a6e7a8cca8cc1b71f1759@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 5/13/24 11:56 AM, Patrick Delaunay wrote:
> Add new compatible "st,stm32mp13-pwr-reg" for STM32MP13 SoC family.
> 
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
> 
> Changes in v3:
> - Replace oneOf/const by enum; solve the V2 issues for dt_binding_check
> 
> Changes in v2:
> - update for Rob review, only add compatible for STM32MP13 family
> 
>   .../devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> index c9586d277f41..c766f0a15a31 100644
> --- a/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> +++ b/Documentation/devicetree/bindings/regulator/st,stm32mp1-pwr-reg.yaml
> @@ -11,7 +11,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: st,stm32mp1,pwr-reg
> +    enum:
> +      - st,stm32mp1,pwr-reg
> +      - st,stm32mp13-pwr-reg

Should the st,stm32mp1,pwr-reg be treated as fallback compatible for 
st,stm32mp13-pwr-reg or not ?

In other words, should the DT contain:
compatible = "st,stm32mp13-pwr-reg", "st,stm32mp1,pwr-reg";
or
compatible = "st,stm32mp13-pwr-reg";
? Which one is preferable ?

I think the former one, since the MP13 PWR block could also be operated 
by older MP1(5) PWR block driver(s) without any adverse effects, except 
the SD IO domain configuration won't be available, right ?

