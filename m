Return-Path: <linux-kernel+bounces-529677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 942A2A429D4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDBF23B5F69
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1563F265CAA;
	Mon, 24 Feb 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9jOf27s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719C0264A6E;
	Mon, 24 Feb 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740418172; cv=none; b=sr69X25hTOj1k176/QtiIoJJG2ZGCJ1vx9wFlI/Gj1Ws06wikJ2OBlkT/XzcQJe1Far8/ztDOQcE/ZeAdEtm0Th1q0joaGz+Sv7O/IIRHZIRVuVCBJGuIJmsnnim3BIB3Ih92XzMsGwApSY4JgSHPVmxjNFfwseh5HTFbx8WEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740418172; c=relaxed/simple;
	bh=ZE/NEtbynjcPPwiQn6F5zBRoR3rxw4L9qULJd2Dyna4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaqC26xFhaSCgQRiJvr1uHeMJTxjSaJAkm9rKafvaO9rL2jxYXlRJiLm8AH5VbRXKiV/YqAl49dEJUNwReKKPhvPJJcNIX12FoSCwYZmjZNwKAIgBWxuSfzqgs51sHN9KHD01MIx9wywNTV9+J2B0bVXYohkjriM0lhjJQZIvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9jOf27s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23093C4CED6;
	Mon, 24 Feb 2025 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740418172;
	bh=ZE/NEtbynjcPPwiQn6F5zBRoR3rxw4L9qULJd2Dyna4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l9jOf27sh5BxkMJnzTSGKLkK3hX9UoVHBuhMfVa85W0SbmoxIouYZh/1xTg46QW0t
	 3kQYJhAXzTvFqFUUH/w4Dl/4IcPbiBoZXNPU53neJDI6FDevXvA3TJUPhjd4Lw9mkA
	 ZbdJmESM+8VETxkughSaDzHfMqZurlcKcG+3brIhAwzaTI7Yn1GNEWeOL+mfc7i5hH
	 0qOwgOz4wKxs6xFNSPwb7aghuEaIAOf8hZoWFu+nSvHC3qbZxAv+uh29erCRd6IIjy
	 t+Tyr6EYF2HRENtHVzp3pDlQTiWQkdQSuX1TAFBaAIPBsM17mFHwIK7mg6IiVS2nm/
	 OJD6Idl/Y5lxg==
Date: Mon, 24 Feb 2025 11:29:30 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v7 03/10] dt-bindings: arm: Add Morello fvp compatibility
Message-ID: <174041816976.3560154.3926708156600957732.robh@kernel.org>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <20250221180349.1413089-4-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221180349.1413089-4-vincenzo.frascino@arm.com>


On Fri, 21 Feb 2025 18:03:42 +0000, Vincenzo Frascino wrote:
> Add compatibility to Arm Morello Fixed Virtual Platform.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,morello.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


