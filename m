Return-Path: <linux-kernel+bounces-313199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC63296A1CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 17:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A04A2877F1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 15:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60764185E65;
	Tue,  3 Sep 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXgbbrA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA6183CB7;
	Tue,  3 Sep 2024 15:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725376489; cv=none; b=oC9ZZG7SpPxv0Y0WNCGFL388SijwGeGOHQXcgxJixLEE0hfNgOI3NCyoNIGSZDHCySPCkQ6WTYfEXZKPI/XfpjGjpnDVqw+MW0I9Y/u09PyJdNarIxehjKrAgGHxBGIUFVBy74gLXobtCMVxFS4yX3ic8Fq0Kw34bSqFhjYVHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725376489; c=relaxed/simple;
	bh=uFgFEPAxbDvAfL++QT4kan7FKDz65W7ggNlfblXXvK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHJpGE6D/1LQUBMChcoqLtsa4YClx/Rvl9wSCS5NU2X6zMDeB/M/JQ47gVHygb+NITHDhxPF/P/jzCaYJwErZ46JGProfgbd5msBRLGxZ4pTg1oz29B71ZMnl0URKUhuTK6hfFblCSIti0E/hgpJJ/wz5+c0tN8wFW6ejW1Rb/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXgbbrA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306A5C4CEC4;
	Tue,  3 Sep 2024 15:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725376489;
	bh=uFgFEPAxbDvAfL++QT4kan7FKDz65W7ggNlfblXXvK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXgbbrA0g8JX+FdhM81jkje0NNXBh2FpV6IeNyA1N2bVUP8BlBOUHFt8HYRj/3x5Q
	 Heo8LdhTjpkgx97H3K66i3HA2c2a4ibUX0zoAuKRp6WScpT/zqjXKB+zvvs0AYWUDs
	 BYvYVCvMDRKXpGsobVteXGKKb4H0nQXmb4GwC8Qhz8baV+wGrBInpnmKqRg3Z87Bae
	 xWc+ne6nakz0fc5dEjav6sMwf52gzH27z8ga7c6TbzUp+E5GSQD4j4jR685Ie/5yMP
	 wJ4g7hychRHKv8+yK0f8YTgD8YrnnTUgM2B612BxB8IbwCgbQM+ZCsipSsYnmdEeWG
	 yDN3HBGAAHS6A==
Date: Tue, 3 Sep 2024 10:14:48 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 2/2] dt-bindings: arm: fsl: drop usage of VAR-SOM-MX8MM
 SoM compatible alone
Message-ID: <172537648767.1030355.3315694462211303884.robh@kernel.org>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
 <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902075220.27971-2-krzysztof.kozlowski@linaro.org>


On Mon, 02 Sep 2024 09:52:20 +0200, Krzysztof Kozlowski wrote:
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used alone
> without motherboard, so drop the usage of its compatible alone.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


