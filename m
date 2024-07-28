Return-Path: <linux-kernel+bounces-264508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B2693E44B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 11:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB561F217DA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A1225622;
	Sun, 28 Jul 2024 09:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="jcuV/9wP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6337A125C1;
	Sun, 28 Jul 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722158575; cv=none; b=QQrrX9mX6SI1XMR20pCsI0S5hOeo83mJ7gkj24hVf6PlFtnu6h5Jsi8PNgph8H8M4iWAgo1NSPSeFrn7d5DnzHrzdAzJBO1f7FebNP5JTpbLzzBkyA21GMxmN5oRW48dwRyDLV7xG9LpNWVzUXZYvgKovVzJF9tydPU16DP7/3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722158575; c=relaxed/simple;
	bh=pKPoRcyLgFmUfKmvWcMUDesZzv4UgLstY5CBC8wJYPQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=iPeibySVFFkK1OVJjLlHozTtRZEiwB6zet8ZkHJH0YkmfYJcvJBq2FZT1sK8ji5iWrOkVnynyKUDlzbw6/aHdHnrxjPa5S3AFYgZXxlqGUPF7+RjLBwwycFgh9f4IA9jHbtrW0ZZUGbDGbHalJ9gTfytXRd2NHEdhc7cisR0S2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=jcuV/9wP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722158570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxC1L2UkggJx7nsQkOlJrzsacVr10erig70wWiY/uR8=;
	b=jcuV/9wPwXfRCcpE8DEDzv9SOcbqZrxlh+XqjFjXu8Arv2XpLkS000GS3lPLJsvVinXwUL
	2W3pnmR1mI+C5TbPgAI7n35wdGry12a3n5ttyGuloVhwGllN5SES6astjsUU5CTGo1dszx
	k/ReKKKiJsSdXyGK2lTLnmyshpJAO+Ng1Hw2tLoA4MrvbmBYkNpCK6J51KxFYRZGDGyink
	vmoIHY6d2bh3z40Q2JLShQyuKX21t7R4MSIKTGHF3xWvpFqb+csMGOTHdt+l6U9ilAtbGc
	YQmEgYK7jGOuEagzcXjP0dlJe+G6Tu3nsOT/i+0uVaMCUKSMOC9ZhFYB6balGw==
Date: Sun, 28 Jul 2024 11:22:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add Cool Pi CM5
 GenBook
In-Reply-To: <20240728082004.36575-2-andyshrk@163.com>
References: <20240728082004.36575-1-andyshrk@163.com>
 <20240728082004.36575-2-andyshrk@163.com>
Message-ID: <99e5b9275d6c7750e916e83b9191e965@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy,

On 2024-07-28 10:20, Andy Yan wrote:
> Add Cool Pi CM5 GenBook, a laptop powered by RK3588.
> 
> Cool Pi GenBook works with a carrier board connect
> with CM5.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
> Changes in v2:
> - Descripte it as Cool Pi CM5 GenBook
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1ef09fbfdfaf..a9bfb87e69f5 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -96,6 +96,14 @@ properties:
>            - const: coolpi,pi-cm5
>            - const: rockchip,rk3588
> 
> +      - description: Cool Pi CM5 GenBook
> +        items:
> +          - enum:
> +              - coolpi,genbook

This should also follow the "dependency graph" naming approach, so it
should be named "coolpi,pi-cm5-genbook" instead.  It would also make
the naming scheme future-proof for some other SoM that could possibly
be made available for the GenBook in the future, for which the new
identifier would be "coolpi,pi-XYZ-genbook".

Though, the "pi-" part in "coolpi,pi-cm5-genbook" seems redundant to
me, but it's already present in all related Cool Pi identifiers, e.g.
"coolpi,pi-cm5-evb", so including the leading "pi-" here as well is
obviously required for consistency.

Oh, and I somehow managed to miss this in my earlier repose, which
would have saved you from sending another version of this series.
I'm sorry for that.

> +          - const: coolpi,pi-cm5
> +          - const: rockchip,rk3588
> +
> +
>        - description: Cool Pi 4 Model B
>          items:
>            - const: coolpi,pi-4b

