Return-Path: <linux-kernel+bounces-539400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26359A4A3C5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F9C189BB59
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2358627E1B8;
	Fri, 28 Feb 2025 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOEGFbAi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A427E1B1;
	Fri, 28 Feb 2025 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773360; cv=none; b=nQf0gnhtUvc/mCLzS6oPOIb68bOFaXgI4TiLCZAEWyEHstVRQyfPrRuudRR0xakEpBWm++WXgu4of9AIZlP5B+iaP74tCxJt+kHS0oxyfDHVLTA/6bbIF1ekdYxFDpWUVybhP6vlui2BQNP4K3XJKT/OegMSnFHofwR2Uu/p8uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773360; c=relaxed/simple;
	bh=c+sE0vRTYPK5+zxcrp1859xwPNcSp2Ia8bQxKP+1ue4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exP5DxJN2eOexKKrAMg9mrSdnqqJ8MbjUWiRZsU/xtfCyhzpE4vgTk716TQqMhn0Aize/I3NmzUgio449dWiuKid3mN3yWEEXAT+xqkGNmtEr898NUP6iCd35stLeAofUODadwl+trbttWfQi4fhCP+XZ8NXq7JNRb9aJZfySF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOEGFbAi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA5CC4CED6;
	Fri, 28 Feb 2025 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773359;
	bh=c+sE0vRTYPK5+zxcrp1859xwPNcSp2Ia8bQxKP+1ue4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOEGFbAikIKhBwP7R8Q1cczMdTxG2DxAm34nkOjMcPQOK34QCTo0FEzUP/5x+cyHh
	 yoDrzdjSR/uzA5F1IGSnyCDE9D5m2gFyKVuoHGADz7HC1xgMX2yii1lbqAW955qv8K
	 h/V412TyHwr8NGysE3uVpzKmmyFmGHl9MGTJt+iYal9u449N1KZ1KvJCKQwj+dGrqj
	 YQEi/S4DxwQYkd8Vp/FIOGDLDyuRRDoAZsGCi3ht8rVqkWJBnEoXp8t5uwU45gEmzS
	 n0VV5lfD09hK8dIoy61eN7hkmnFPpuQxylgWnkstonbpb9CGQXgVJQXz3FMx6NExqU
	 heg1FzlU7dwkA==
Date: Fri, 28 Feb 2025 14:09:17 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	heiko@sntech.de, linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: nvmem: rockchip,otp: Add support for
 rk3562 and rk3568
Message-ID: <174077335739.3514286.9596779963584656318.robh@kernel.org>
References: <20250227110804.2342976-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110804.2342976-1-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:08:02 +0800, Kever Yang wrote:
> Add compatible entry for the otp controller in rk3562 and rk3568, add schema
> for different clock names for new entry.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2:
> - Update the commit message and add maxItems in schema.
> 
>  .../bindings/nvmem/rockchip,otp.yaml          | 53 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 7 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


