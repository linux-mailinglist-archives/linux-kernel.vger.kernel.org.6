Return-Path: <linux-kernel+bounces-566990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D47A67F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 877CB1642F4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1EE2063FE;
	Tue, 18 Mar 2025 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPujRcx7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316892066D9;
	Tue, 18 Mar 2025 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335952; cv=none; b=CRlnwxtfQXwwSQJJeNgzTMk8Gx8MdFmLloA2exLLCW/up4sS4zg0DGUxlNHRPdD9mc8Nu8tY0iWPAtaq058Io/DcOxqbcsbl+tGO2Ezdp2JvB/CbBFZmoPkf1n1QHOm3da5mCSlMFmuEL20rLVMmd6jvW1MsS+1Q+mp3kaWW0Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335952; c=relaxed/simple;
	bh=Szgn5zvrgXbGVWttIa/7SboYv0mHq0U18NfPj4QaSyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exN0mLxoE4r/iZhYCtC7IhsHbnO5pRw+qxAQ5VlyGqCBYelr8pGgcae7j9JsY5lk2LOzi2T9yvYB0qmtFPFmGeJnUd9rh1kavVVR7l5zgyPi7duUKNteePZi+ZhZtvGKmFFwErUV1Ymq4/ty2w+QCNEYjCSIBQLjHRRC1aH2xg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPujRcx7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763E5C4CEDD;
	Tue, 18 Mar 2025 22:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335950;
	bh=Szgn5zvrgXbGVWttIa/7SboYv0mHq0U18NfPj4QaSyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPujRcx7wt+IOsqcSHSwagpWIian9rJ43UJJMFZXlMDF3zerLYtehCwAxSu53aQyr
	 tP+IVVbcHdoqKk/kDdjmWQ7Y9YolyKSUT5syDI+MryESl1F7wSJtbB/Sm9bfhqWd1F
	 AXyoEnarwk9GpgiDbN5MKhpYmC4cm0sZhjCamLoXHcZInzzxCs/w6aw54MSCz3V2sE
	 eEYHtGjpOOiZ19GLhTVckQbQRofazOXL+uSuUW7dcPwdrpJbgmNa8d2BJURBzV5mjH
	 rJbIXNGErxDY8qGd43RLg8KSL/LO3TxzBUpL9pdDzDCQmcL9fFNfer27aOmKIw8/0C
	 g+47m4eJSqMDQ==
Date: Tue, 18 Mar 2025 17:12:27 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: devicetree@vger.kernel.org, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: gpu: arm,mali-midgard: add
 exynos7870-mali compatible
Message-ID: <174233594629.4044838.965706425062686695.robh@kernel.org>
References: <20250318-exynos7870-gpu-v2-1-58dc2094dc7f@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-exynos7870-gpu-v2-1-58dc2094dc7f@disroot.org>


On Tue, 18 Mar 2025 23:01:09 +0530, Kaustabh Chakraborty wrote:
> Exynos7870 SoC uses the ARM Mali T830 GPU, document its compatible
> string with the appropriate fallback. The T830 compatible is already
> defined in the panfrost driver, but was commented out as it was unused.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> This patch series is a part of Exynos7870 upstreaming.
> ---
> Changes in v2:
> - Reviewed-by krzk.
> - Link to v1: https://lore.kernel.org/r/20250204-exynos7870-gpu-v1-1-0db4c163a030@disroot.org
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Applied, thanks!


