Return-Path: <linux-kernel+bounces-539401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545B7A4A3C8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E2E189CCA0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B69727E1D1;
	Fri, 28 Feb 2025 20:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9B5TJvO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E74270EC9;
	Fri, 28 Feb 2025 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740773387; cv=none; b=hv+UT7mwzCqjSjPWOsWZLTxsirELBGOy/vPz6yPiICwsCaMt2b6xCT05S5pRaO1/5Jnrfnn7EpHxLuee66gjsIfZjEjPtTVkIwe6wsAWEgBODWATFX95yZsbqdfmkCbQNvRdYNX2aTzqlKjbAB+BW7nEb2Eo992HpVpYRtNd3VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740773387; c=relaxed/simple;
	bh=CcsjvI4s8nt3qjVDCr68+9sFHV7ptEqC8BGwTZNTugw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYvJEpa/WF0MM4swZV9vcIZNjV0isNJ8rJf8HWoDJOPowJVcOdelXE+6abixCABvbILjGtL+6VZRr9mwvplG0KMRF80Pjva7DVb0eZVS2+2nTCFV5QAKmwSGhnXZaedfc7ByeYlqVJ9bL1HcuGGkXtfBY30M1O9XB8koCULwY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9B5TJvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4F6C4CED6;
	Fri, 28 Feb 2025 20:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740773387;
	bh=CcsjvI4s8nt3qjVDCr68+9sFHV7ptEqC8BGwTZNTugw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9B5TJvOntFWEtmuNvKnpa1nHATisyBvmI4Qs41ewlfntfxp2JCcwjx3tu4iWHkoh
	 0VoIasoeEEnHN3k8GYAgUCM0ZfEdAVVo0ol3CdGCPqCTPyniRqyZA1dW+UOoPQOfdm
	 tl1zvyHYzWMICYhVH/h2VXtLKOC44N8nboTEvqh4qtwEUl8HJCf/viUVoW3xdTtCRe
	 8VUtkuf6rZOsGruc5zy+T6PbQEaFP4BCszqT9E4C4TsW/mYm/OTPw+8+U/xetm06gS
	 blEf/0y1CX83XNgT0exFy00jtCFhD9rFO3eJXzlGRtymZySLdm0TwuaU2Dusosirh9
	 TBboOv3trjEOg==
Date: Fri, 28 Feb 2025 14:09:44 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: linux-phy@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: rockchip: Add rk3562
 naneng-combophy compatible
Message-ID: <174077338453.3518826.4750088621864636437.robh@kernel.org>
References: <20250227110836.2343158-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110836.2343158-1-kever.yang@rock-chips.com>


On Thu, 27 Feb 2025 19:08:35 +0800, Kever Yang wrote:
> rk3562 use the same Naneng Combo Phy driver as rk3568.
> 
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
> 
> Changes in v2:
> - Collect review tag
> 
>  .../devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml     | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


