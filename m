Return-Path: <linux-kernel+bounces-269118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E977B942DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5953285E42
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376C1AE879;
	Wed, 31 Jul 2024 12:14:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440481AE868;
	Wed, 31 Jul 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722428050; cv=none; b=RwIEKDLgU+74yQueolYwXcL6AhYyCcVxIQK+I23d9SzuJcR38IcZPc7QmKt1GQ1NR5iPvKBzHhhZ6VWH4JIEJZ4Kewi7V8+yiWnG9P/BYIL52ZVXuLj88cN5GrIZw0AShP7tuqVjU0JHOvIYhdk/FIMiQdP3rjA6ZiJWrInxkEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722428050; c=relaxed/simple;
	bh=wFR0UxG5PNit1u0AdPSe1AID1vRUjTbFB4Xbjv/7Pyk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oewS4MKczkB90y44MvI+C4AYWdTO/KtDejqK7HUsz1PW5xLOinSXe5/+tjRhfQoZNPPFEMDrj8YsNyp+UWDepw2hOi6RYFzzIcIFOtkX1XzI9xHRphHhYQaKIYmsN0d2r14ken+fExiCD2EZ2Ny45ZMoibLpcssw5zeV3sw5Nn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4459D1007;
	Wed, 31 Jul 2024 05:14:33 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD5C3F766;
	Wed, 31 Jul 2024 05:14:06 -0700 (PDT)
Date: Wed, 31 Jul 2024 13:14:03 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Debbie Martin <Debbie.Martin@arm.com>
Cc: liviu.dudau@arm.com, sudeep.holla@arm.com, lpieralisi@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm: Add stdout-path
Message-ID: <20240731131403.54a9443a@donnerap.manchester.arm.com>
In-Reply-To: <20240730103758.907950-1-Debbie.Martin@arm.com>
References: <20240730103758.907950-1-Debbie.Martin@arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 11:37:58 +0100
Debbie Martin <Debbie.Martin@arm.com> wrote:

> Add stdout-path to the Arm devicetrees to specify the primary console.
> This means that distributions can boot without the need for
> platform-specific command line parameters i.e. they can use earlycon
> with no parameters and no console argument is needed at all.

Looks good to me, and aligns with what the other DTs do:

> Signed-off-by: Debbie Martin <Debbie.Martin@arm.com>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/arm/foundation-v8.dtsi | 4 +++-
>  arch/arm64/boot/dts/arm/fvp-base-revc.dts  | 4 +++-
>  arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts | 4 +++-
>  3 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/foundation-v8.dtsi b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> index 93f1e7c026b8..083be35495b3 100644
> --- a/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> +++ b/arch/arm64/boot/dts/arm/foundation-v8.dtsi
> @@ -18,7 +18,9 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	chosen { };
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>  
>  	aliases {
>  		serial0 = &v2m_serial0;
> diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> index 85f1c15cc65d..19973ab4ea6b 100644
> --- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> +++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
> @@ -24,7 +24,9 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	chosen { };
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>  
>  	aliases {
>  		serial0 = &v2m_serial0;
> diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> index afdf954206f1..7f7226711d4b 100644
> --- a/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> +++ b/arch/arm64/boot/dts/arm/rtsm_ve-aemv8a.dts
> @@ -23,7 +23,9 @@ / {
>  	#address-cells = <2>;
>  	#size-cells = <2>;
>  
> -	chosen { };
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
>  
>  	aliases {
>  		serial0 = &v2m_serial0;


