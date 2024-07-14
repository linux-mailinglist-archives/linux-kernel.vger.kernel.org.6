Return-Path: <linux-kernel+bounces-251844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A3E930A8E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 17:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE04281515
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 15:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C613A241;
	Sun, 14 Jul 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="huuyehEz"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763911E890;
	Sun, 14 Jul 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720971141; cv=none; b=tRzr/D1CeFEMR7dbEQfNGbW63GwaHOvn/cwkgApaV4ivcwg8RzjbZ+K3/RthX8yjekvyyEjJOVre27tC01PWBMU/J8O9acFMHGz9gGIEHp4CdeoTftuuFGny2fJybnJT7b3H5nCnkLiPb5BceLwnIpKTmeO1y0ZehEwsc9fGgE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720971141; c=relaxed/simple;
	bh=Ls/dRXCYYsgdSxkx8hQ4rkcwVvnm0Fd9hWScW6nkWCI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=r/77iOnOrhVv6puR5S+xnwojcB4PJS/hAhfb3wOYd5Gl1ePO4x4AmQSRdVy3/xjZhotx499gxcTbWCHodGhK6Q2yJEb/BM9v00OJpqIUGyw13Lky9jhOcQnU2pXt55f+W3gJgIitW+1dA03tZhswvfQP9E7/g/gA8EMZjqsL1lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=huuyehEz; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720971136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wy0Bf3YMqWddUJe1N25USLRZl92AbRJGOg+06VaELdY=;
	b=huuyehEzkVIrvGCUV/K9t5egIoJs/k5KFWJAR+Ewlk+/JAK+N6pyop/6GQg9IZtjWXmqDx
	7ksmde0WiOQnb8GYNu24Sk9Azak9SSv3LNO6YHm9ChprqblGmdMPsrlkWKKS/EpdiCgs6l
	CdTXc2RmQYv0hiIEtIUEnIlyEJmkbbVgpJFda4T4w55nP8PWUjC5GoQZO1rnblYu/f9sxP
	jglhLGwxwQJRW2pGyEHmfNtx0LRI8UBgcAqg177hsmFTVIZxrZTB66wX78rchSSV0bk9+L
	mBNpYexT0PNFQ2kyXP6BkwToP4gPsRY2469DDscHPj9+HDy5LCg6GSw+1zWWRg==
Date: Sun, 14 Jul 2024 17:32:16 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add Cool Pi GenBook
In-Reply-To: <20240714112851.1048184-1-andyshrk@163.com>
References: <20240714112851.1048184-1-andyshrk@163.com>
Message-ID: <953e26c282874039f15f1237322c24b7@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy,

Please see a comment below.

On 2024-07-14 13:28, Andy Yan wrote:
> Add Cool Pi GenBook, a laptop powered by RK3588
> 
> Cool Pi GenBook works with a mother board connect
> with CM5
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1ef09fbfdfaf..e4f2ae9ec457 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -96,6 +96,14 @@ properties:
>            - const: coolpi,pi-cm5
>            - const: rockchip,rk3588
> 
> +      - description: Cool Pi GenBook
> +        items:
> +          - enum:
> +              - coolpi,genbook
> +          - const: coolpi,pi-cm5

The system on module (SoM) used in the GenBook is actually called GenM5,
according to the product announcement [1] and the SoM schematic. [2]

[1] 
https://www.crowdsupply.com/shenzhen-tianmao-technology-co-ltd/genbook-rk3588
[2] https://wiki.cool-pi.com/notebook/coolpi-genm5-schematic-v20.pdf

> +          - const: rockchip,rk3588
> +
> +
>        - description: Cool Pi 4 Model B
>          items:
>            - const: coolpi,pi-4b

