Return-Path: <linux-kernel+bounces-240187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538F6926A09
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 23:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1626328141A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A5B191F6E;
	Wed,  3 Jul 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="DuOh7xfk"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53DF1DA316;
	Wed,  3 Jul 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720041092; cv=none; b=ocJm9RKV7yiqVVP7zmI67d/MvY+kApAOv3Ngp6mKLIUO8/pbBFsfTDYFbupfbKD0IYC2huVrNzDfWO55Zbw1D2OhWquxwvLGqwWHGkkmNwKYEWZ6zYvoMaBtLDrYWhdysKtg3VAFPE5iRmcbEG5Dx4I6TTj8L9iQkbM1gySWNUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720041092; c=relaxed/simple;
	bh=pvGAlW1v1sUajnNNO/8v24XdU8ixai6sMIw/JqvvK3s=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=urgE7bq2ZWaqEZpkGvg3caWJRiScpMz10U4O+DlqC1Q6b7NTbj3gwbpKdH+b8IEsmBaPO6aQBppl5NvIQw9deTnssW3oNMA51/FD9C4z+skCNRhKNi/LXEkIMTJ+j/hBfW48E1jljQVHcs1eHI7QcABcEOqRGr0912lTJlo4LwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=DuOh7xfk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1720041086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g4RrLkCB33hOEMUGwheKRpmYM3thvQih+jMVkGH4nZE=;
	b=DuOh7xfkxgyG1FedaGH2jYO/BnzbrT9FMBNQfg+lfFSfQXR8ukKwto5ZcBdzwZL5LDjy7C
	wvyrUPlxzJMri0QnA46pQ1o7ERRBldSbiXksEzTTwr/5xgndcuiQgadXmC9Xxghw8xXjkI
	Xu0WTcYSkD/fFMo6lwShJaf6PVSQRTd+NQIEDV6zT0lzZh4Lk3FaKiq15eDia2a434Ul89
	QL2neb15dCAIIyn5/AfT2joXEyOuBkUCoqNBoLjBXBleeiMrms3ylfychSSBRIL6UPWMy3
	Fpg6eVlJAiXM0wcBz5Ldri1RPJlyt2dqRDOjHCIQ7ZqezyfqxvyVoMHNz4j61w==
Date: Wed, 03 Jul 2024 23:11:25 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add Rock 5 ITX board
In-Reply-To: <20240703210524.776455-2-heiko@sntech.de>
References: <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-2-heiko@sntech.de>
Message-ID: <0d1b1a5fbe97d27ee54513261d77df0e@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Heiko,

Please see a few comments below.

On 2024-07-03 23:05, Heiko Stuebner wrote:
> Add devicetree binding for the Rock 5 ITX board, build around the 
> rk3588.

s/Rock/ROCK/
s/build/built/

> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index d2e887415d5dc..7ddb008f52d1a 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -826,6 +826,11 @@ properties:
>            - const: radxa,rock-5b
>            - const: rockchip,rk3588
> 
> +      - description: Radxa ROCK 5ITX

s/5ITX/5 ITX/

> +        items:
> +          - const: radxa,rock-5itx

s/5itx/5-itx/

> +          - const: rockchip,rk3588
> +
>        - description: Radxa ROCK S0
>          items:
>            - const: radxa,rock-s0

