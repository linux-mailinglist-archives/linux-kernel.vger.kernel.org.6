Return-Path: <linux-kernel+bounces-300778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A049095E838
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCA2281799
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EDC8062A;
	Mon, 26 Aug 2024 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imNI34Jc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644229CE7;
	Mon, 26 Aug 2024 06:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724652262; cv=none; b=pWifil313WtcseUm2z0jTn/SLy6BpZWI0Q2sUuM6jy+z4ZAhZBjYm13NXV+j5WNUDhjNDe+8N9ASbYStJNjXVV2fypusBQH2EfUNcWir/gQLi+pqMmeM9nwkHLp5uWCsStA1EmYyv0eJCzW/Rpz+vz41yAY21AwhTucnJbpAkgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724652262; c=relaxed/simple;
	bh=ur8pt0WT04EkZ25i73aiTye05nOAgI+FmA8o1K4mR8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1BtpHzMPIkUmtO6hb6A8PjOt7EOcWS1DMEsRlVwBo92oF+uCLGHRmrpms5yAudNFbhfxfen8Oa0zVxdE+rLgxTdENUq3tNYEcwqb8Ore197EhDI+LnQJtUCFVdX8GdpCvfVD653EmkN+EMbovTBXhFMi0uLYGbGzU+Etyd/G5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imNI34Jc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C150C4FE11;
	Mon, 26 Aug 2024 06:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724652261;
	bh=ur8pt0WT04EkZ25i73aiTye05nOAgI+FmA8o1K4mR8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imNI34JcSFo2326mgmfOp3z8hsZC9bdRawfX9fllJ9yhtsGf2eYIWTgXATE3L+Njf
	 E31EjIHY0qP7hiGtTkv1rxR9x1t7s0iA+9D7CPx7gfDz2uIX/zSElOeCZMC9k7luy1
	 cEzcRUfN7d8iOdTgbe6AHLEsHvLGNEuAw0p4GiX8mlGFNFR9FkYew72A/k1l4BJX6A
	 VmyiH9ZrtCum/Cii/rBDVeRsjwBLky9NFJAnDO2WCwOIsqR39QhZyOM+1zSgIMT+Wk
	 5O7v/82i3j+wULRVvctceU+/5V8Y+jGsspRT1n+Pxk2IJsjcEKqZTve6QUqNmF6PhX
	 B9J00lSnGJlVw==
Date: Mon, 26 Aug 2024 08:04:17 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Junhao Xie <bigfoot@classfun.cn>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jonas Karlman <jonas@kwiboo.se>, Chukun Pan <amadeus@jmu.edu.cn>, FUKAUMI Naoki <naoki@radxa.com>, 
	Dragan Simic <dsimic@manjaro.org>, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Shenzhen JLC
 Technology Group LCKFB
Message-ID: <twps5rvr23xohlqml7mqfhlau5m2ay5ygp4mq4ngmnhullh534@6u5bl2upsspf>
References: <20240826044530.726458-1-bigfoot@classfun.cn>
 <20240826044530.726458-2-bigfoot@classfun.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240826044530.726458-2-bigfoot@classfun.cn>

On Mon, Aug 26, 2024 at 12:44:11PM +0800, Junhao Xie wrote:
> Add an entry for Shenzhen JLC Technology LCKFB (https://lckfb.com/)
> 
> Signed-off-by: Junhao Xie <bigfoot@classfun.cn>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

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

