Return-Path: <linux-kernel+bounces-182637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B168C8DAB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 23:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907B61F23A0C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BC71411D7;
	Fri, 17 May 2024 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EboZcV6I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6A013DDB8;
	Fri, 17 May 2024 21:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715981223; cv=none; b=rcG9jD7nc3jYlkd1gYylyQpSBTvkUFa8E5+sNQt4WEHdy9oIdB6BGFrw4UoNm82YkmCbWEy30VFpXSfLw3JxTmm4lWB4CWy2x1xQMtBbrDlqhD8ahYm8TLm1FFsbGx3YXpRNZNa0f2FlIigKmvglJHvOk89+CpN+3bnWwMmjvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715981223; c=relaxed/simple;
	bh=PJfFobmO7oLu8nBoq8HcGEfemzdhWXV3xccoH2kXskY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr7V1bmx/EhYUyBMwn7qL+FieyFAh75wnb47NuIlfbasHCu1e8Dp9TWYJoIHcCuaKGCqv7AtHpJ5gkCZxw+8nyCs9nfoinIxSYK1cacrj86TsBZO9Fw9TWPWZAPecNN7sRiONIiTDRiAO84xKrxTBKZiEhClEQQ7pFEOjN/GiG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EboZcV6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC35C32782;
	Fri, 17 May 2024 21:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715981223;
	bh=PJfFobmO7oLu8nBoq8HcGEfemzdhWXV3xccoH2kXskY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EboZcV6IDm9TJNHpHC9g6zKZ2TH93UF+ldmtcTA0UjDARo6ioYCa2eQhxNSc3UmtJ
	 2WGR2xS/IQpwvvR2r+4QtJjDp8NL5gnfRKjxXRDzFcA8VeZ1iOPnxGxtohYp1MxzIc
	 meZT/iTn8QbuXSMGwkvnh+71fQmLiNDaKRo0Se0bASu/BmJq/f5yDg5Vt6zRc4mtZ2
	 4zewBr94V6/bhIWO7rkz25OXhfWHqX++apOCGSD7qCOL+MTIZr7Xs0f2+Jf4rgWFFi
	 iOBs/LucA8OrvRVCpRug8VV+c5LN9Awv9EAWF2OiTWY5b+dfzQIul1PiGXiSlgwIMZ
	 uNfm+dEV3Itlw==
Date: Fri, 17 May 2024 16:27:01 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: soc: bcm: document brcm,bcm2711-avs-monitor
Message-ID: <20240517212701.GA2977461-robh@kernel.org>
References: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517125138.53441-1-krzysztof.kozlowski@linaro.org>

On Fri, May 17, 2024 at 02:51:38PM +0200, Krzysztof Kozlowski wrote:
> Document alreasdy used binding for Syscon / AVS monitor:
> brcm,bcm2711-avs-monitor to fix dt_binding_check and dtbs_check warnings
> like:
> 
>   brcm,avs-ro-thermal.example.dtb: /example-0/avs-monitor@7d5d2000: failed to match any schema with compatible: ['brcm,bcm2711-avs-monitor', 'syscon', 'simple-mfd']
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../soc/bcm/brcm,bcm2711-avs-monitor.yaml     | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2711-avs-monitor.yaml

I was about to start just deleting the remaining examples causing 
warnings.

Reviewed-by: Rob Herring <robh@kernel.org>

