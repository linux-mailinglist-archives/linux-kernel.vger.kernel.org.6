Return-Path: <linux-kernel+bounces-292610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7599571CA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F571F224DC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FED187FF2;
	Mon, 19 Aug 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjjX2mQq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB5317C204;
	Mon, 19 Aug 2024 17:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087644; cv=none; b=c5l8H3ti2HWkz6PyezcsjeTJT4rKDJQJfy7aM3dcudK19AsUw3AUdy6cwtfBmrVhFLDEQlOoU2k3yxbO6d9KR03rk8t4VAiOu4dpZ+7soLtmNAh16JfJCVFAkkCSWkTRGBUbm0xHNGAZ1r4asm5giW2WH3QdA2B8qfOsNKm15XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087644; c=relaxed/simple;
	bh=39oCUAsZXZjKgxyLECNLxHaEVLN2QJjJOIsKxZx4xsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXJBJeLHIRJBe2r7os+2OZ50kmt2KL90f8hxKmA1Rf+mvMqYJOv8bQN5JkJI2inPOHsqB776+mInwj0tCIs3iZNYW0FIfHTp0v43fHz9p9UWWBnswHdNxQYR6pzrmD78nCODPz9wufvSs8oLvQqpsvKnK/vLedjxSXeGPtlqMAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VjjX2mQq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D461C32782;
	Mon, 19 Aug 2024 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724087643;
	bh=39oCUAsZXZjKgxyLECNLxHaEVLN2QJjJOIsKxZx4xsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VjjX2mQqM0fyQ4v+gD1AMuRgEz9FIOfegBSfjNRTwLJPuaGw7MbyvlF5L2m878RmD
	 mfpCRgrIHZ0PvOSHzXiEtRqm7U/uALnrRagy7srUzBMFmoUsQIZRg0NN6uA7n7bufN
	 ztRDiorcEMdCqrTJRnq7+pD3IcbZpn5aK21XcPAbiwWZ4+EeJytJfDJjNGJjMdN8Cs
	 3lKMT6S8/mMM6V6XyJerv3hYXvawfQDPtaZYRYvvnfFWA7e9uUdnNIpShadX7jV+y7
	 2NwYtgSCGm7rfXV5ixlwv3XcN0FerLm9a9jcAQfaIRon1NqRBBg/1i0Nj/8wZuxC+M
	 7tNVfdhOxVlGA==
Date: Mon, 19 Aug 2024 11:14:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-phy@lists.infradead.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: phy: socionext,uniphier: add top-level
 constraints
Message-ID: <172408764120.1697315.1961179049740064713.robh@kernel.org>
References: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818172835.121757-1-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:28:35 +0200, Krzysztof Kozlowski wrote:
> Properties with variable number of items per each device are expected to
> have widest constraints in top-level "properties:" block and further
> customized (narrowed) in "if:then:".  Add missing top-level constraints
> for clock-names and reset-names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml         | 8 ++++++--
>  .../bindings/phy/socionext,uniphier-pcie-phy.yaml         | 8 ++++++--
>  .../bindings/phy/socionext,uniphier-usb3hs-phy.yaml       | 7 +++++--
>  .../bindings/phy/socionext,uniphier-usb3ss-phy.yaml       | 7 +++++--
>  4 files changed, 22 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


