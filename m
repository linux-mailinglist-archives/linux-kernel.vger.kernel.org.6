Return-Path: <linux-kernel+bounces-292704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665EA957335
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 20:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8C4A285578
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6F6189531;
	Mon, 19 Aug 2024 18:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKzQTHGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34A3188010;
	Mon, 19 Aug 2024 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092129; cv=none; b=GGPnqqLzXBoy4LxPxIpWL9PmioGyYAY/2qfO5iRPrpzXYa7pAIawYaBn2OJPgRgvHR2Zg4Fym6FVlz9NIPAPjq39AjmwpMiJWRe+lVgpvjTufb7tyJBKIcR34BCBLiGPZJLAIC4CKQrtwjr/xG26zXz0gDkK9/mzN1ZbjAfoP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092129; c=relaxed/simple;
	bh=P/L3NgyYytfwnB4TlqzeCccYfyAfsEKejKjDYh6MX/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrJv8c0+KxUNeQELtBHkj5Wge8g0i7Z1LbZ4Oeliw9eRYBwx0X5Ev5Xf3RY7McXENTazeIk/7mLErUnr/HQTv+acqcV426vFpAeRM7v70qEJ3hDkliZ5eGRUCgOY91Ugii+NFmWXYiTdkmdj8hWjElDnzdtBYnudhI6ht6kVpK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKzQTHGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA196C32782;
	Mon, 19 Aug 2024 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724092129;
	bh=P/L3NgyYytfwnB4TlqzeCccYfyAfsEKejKjDYh6MX/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VKzQTHGS2YGCeP0P8MP0bRGqWkR+/F2JGntV29VBmI4XfPMTUZY5lZ6uj7ZNBvaPD
	 rI032Y/PaqT15K7kKMDPXP5E5w8/S6ohD6U4xgvC/haIp0waXk/ZgGo+rzxUoUFSEW
	 oaRmGe+66VLkbM4AcPI65pN70FOPfEyE9UOiIX6gFo5df3GqH4m5icj3dIAX0Tllyn
	 hJ9ABt4cWjNSXnfs50e/dhyUN3AzCVAKgMt9I+52mGTghDfper+Nd8M69Ma40w70AN
	 r8qXB4YnK+0AEE3DJC1UVbK1de5Oxa8aKcY55QAKYUe1skL0E9zmEAk5wXJmoe+9We
	 Mts2jeg7PaMzw==
Date: Mon, 19 Aug 2024 12:28:47 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	alsa-devel@alsa-project.org, Conor Dooley <conor+dt@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH] ASoC: dt-bindings: samsung,odroid: drop stale clocks
Message-ID: <172409212644.2046966.8530485462629543956.robh@kernel.org>
References: <20240818173037.122152-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818173037.122152-1-krzysztof.kozlowski@linaro.org>


On Sun, 18 Aug 2024 19:30:37 +0200, Krzysztof Kozlowski wrote:
> Clocks property was present only to allow usage of assigned-clocks in
> the sound card node, however in upstream DTS the assigned-clocks were
> moved in commit 4afb06afd768 ("ARM: dts: exynos: move assigned-clock*
> properties to i2s0 node in Odroid XU4") to respective I2S nodes.  Linux
> drivers never parsed "clocks" so it can be safely dropped.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 5 -----
>  1 file changed, 5 deletions(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


