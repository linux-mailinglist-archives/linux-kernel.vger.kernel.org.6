Return-Path: <linux-kernel+bounces-390155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD539B762F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A146B2234F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E34E1552EE;
	Thu, 31 Oct 2024 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gVoMdO9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F5D1547ED;
	Thu, 31 Oct 2024 08:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362633; cv=none; b=eNVEzSm6a7T2pMPedhuW+l/sqE3PA63NalZGTC4KlSo5oHz/2FYMZSVPAvMscdqha5uBLUiPK26BcFWgYHmWBROHKlbQPsdX10XjDfz0XkdnbTUuAHe9Cw9PRoW9Eu6EdvfUxrEEIZg6LfJU63uUG9j3U1IqCP4Q6i6iw/P3hzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362633; c=relaxed/simple;
	bh=/Uypm1Fod0x7S2WLQLLjrh9dUnoclEPbXXeFRSWSGig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKYEwC7pmplcyVxcHqHXp0YpqX0wmtEeOKRv0P0XRCli060rZYJFGIr0autdYivcKuXazTuWwVsUtuLRgiSHIKxg+fW686401mBcA2dW2WP1du+jPU0dSnK5pBa7sGy0TfroOx5InZB4nvqtGI0RNVvSU96kYNh89QT0Zk2C6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gVoMdO9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B68C4CED2;
	Thu, 31 Oct 2024 08:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730362633;
	bh=/Uypm1Fod0x7S2WLQLLjrh9dUnoclEPbXXeFRSWSGig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gVoMdO9lHGWjKUvm6JCnBPjQvobYbSvS8WDuDiVuizf6sersPToWLYisJcdhLEHLG
	 WfyjpM5ScGpj2ukitEJ82XMPgofzEXFmyfKcSAD+ErbwBp95Ew0PxHDHeqX4zj+IJI
	 FeAcRLP2B5W1/mvDwOUZAo1xgx2NJsiLShNgQlmMpaO825j85aogM3MDLxX8ubgkC0
	 6xwNuEcZgoDoInH4SCh8WXdLCo0LE4v0rn3Drjqcz18CSUk+b5FmNzC61UNLI8gbWb
	 WstAYKCYA48MyP0M1ej3RFA330KCkcmcJKwtzLn/sNVXBG7WbWzdXJj/JT+Aboay3C
	 wWZAcwHDyjm9g==
Date: Thu, 31 Oct 2024 09:17:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dmitry Yashin <dmt.yashin@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: rockchip: add Banana Pi P2 Pro
 board
Message-ID: <5e4tokdfdslb6gop2h2ow5inftoflfo2mlgosydyg3f6ehwmmi@kefvmy32vchy>
References: <20241030202144.629956-1-dmt.yashin@gmail.com>
 <20241030202144.629956-2-dmt.yashin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241030202144.629956-2-dmt.yashin@gmail.com>

On Thu, Oct 31, 2024 at 01:21:43AM +0500, Dmitry Yashin wrote:
> BBanana Pi P2 Pro is the SBC made by Shenzhen SINOVOIP based on
> Rockchip RK3308.
> 
> Banana Pi P2 Pro features:
> - Rockchip RK3308B-S
> - DDR3 512 MB
> - eMMC 8 GB
> - 100M lan + onboard PoE
> - 40 pin and 12 pin headers
> - AP6256 BT + WIFI
> - TF card slot
> - 2x USB 2.0 (Type-C OTG and Type-A)
> - Headphone jack

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof


