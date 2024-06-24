Return-Path: <linux-kernel+bounces-227705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C689155B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BDE1F249CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B53319F47B;
	Mon, 24 Jun 2024 17:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jz2MvtqR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9513DDC4;
	Mon, 24 Jun 2024 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251197; cv=none; b=Ec1OlCRXiXtOtamuEia44reIuBZmQLMOkXb+SQjGVNQO+CvuL1xFybvZ+0syK547GJMXzSVB1ngKZPgZam6fHuuwTLtmnRLLKaVF6jYpmY+Sm3vk0IDHepGV0Lhs9q2+RriEIKMlab1+52Gsm7enzcdL7UxKIlS4RBkcg01yS9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251197; c=relaxed/simple;
	bh=7Ro/6yue2aS0LQJnIFiNpr5UaZHO/IJXTOrf6chLrpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1/6Q3Hxhh0EHjvSYKc/d3GV95Y1wKCE2YVysTNjc9XZjC2IbKJSwv2CQRe8btsUpj59E58SGGVCCXEA/3m/IvxUREjoU6J3pJTXNUj9COMSvWiqZEoD35uVPJfkq3VcIZ8PbivGvUEZJ7BTh5wThZ1dF21hl94ezVtObdIPTWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jz2MvtqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B93C2BBFC;
	Mon, 24 Jun 2024 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719251197;
	bh=7Ro/6yue2aS0LQJnIFiNpr5UaZHO/IJXTOrf6chLrpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jz2MvtqRvRnHGPh5x1SrJNCTfQN8bP1qFS4zUHYvmvq72MTiOZYnCpT21YCU/Dv14
	 sO49F+03tKL7goy0RM0h4suaZVc3dkZaBVlBGD6XXHcHfj2HZa6SlZNclAFOgdgjfO
	 au4AkLDvpKMpu+XMLDkJsnDTrgg28k4TPpGNOb3GcJny7C/yZinFXHe0YpNISNvRXr
	 FXYTurVTtbtDLCA3DZDUdXlSI9qH5HpX8L+eMqfslr+JQKm6UOCkyNGpPnCvwu8LqR
	 dbw/Gp1xe4NLnLp2H6YW+1QO3UQzr1rFO01pWK6/aAScvu81luHZDkAMW9sGseMd0E
	 ++s+lZQSU7wjg==
Date: Mon, 24 Jun 2024 11:46:35 -0600
From: Rob Herring <robh@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org, Jun Wu <jun.wu@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: arm: cpus: Add new Cortex and Neoverse names
Message-ID: <20240624174635.GA17664-robh@kernel.org>
References: <20240618160450.3168005-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618160450.3168005-1-andre.przywara@arm.com>

On Tue, Jun 18, 2024 at 05:04:50PM +0100, Andre Przywara wrote:
> Add compatible strings for the Arm Cortex-A725 and Cortex-A925 CPUs, as
> well as new Neoverse cores: Arm Neoverse N3, Neoverse V2, Neoverse V3,
> and Neoverse V3AE.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

This patch is fine, but the PMU compatibles are needed too.

> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index cc5a21b47e26a..f308ff6c3532e 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -147,6 +147,7 @@ properties:
>        - arm,cortex-a710
>        - arm,cortex-a715
>        - arm,cortex-a720
> +      - arm,cortex-a725
>        - arm,cortex-m0
>        - arm,cortex-m0+
>        - arm,cortex-m1
> @@ -161,10 +162,15 @@ properties:
>        - arm,cortex-x2
>        - arm,cortex-x3
>        - arm,cortex-x4
> +      - arm,cortex-x925
>        - arm,neoverse-e1
>        - arm,neoverse-n1
>        - arm,neoverse-n2
> +      - arm,neoverse-n3
>        - arm,neoverse-v1
> +      - arm,neoverse-v2
> +      - arm,neoverse-v3
> +      - arm,neoverse-v3ae
>        - brcm,brahma-b15
>        - brcm,brahma-b53
>        - brcm,vulcan
> -- 
> 2.25.1
> 

