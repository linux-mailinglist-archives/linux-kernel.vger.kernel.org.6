Return-Path: <linux-kernel+bounces-436266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D45C09E8397
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 06:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BC4165907
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 05:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82D028371;
	Sun,  8 Dec 2024 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LadHdV6v"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4C17E0
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733634367; cv=none; b=WJK0C/cnTj1lHpIpfPGmX6FQ/ZcJ2Xm/hbEMEHG9GsvdK4dqeD7SfoC6rxoPtXi6zP0XZNZy4tnRkXu6s5niGtSQ4UapfYUDozV0P7I5DXl1dOae6jxjGHjh99rIxKa1LYWss4gCausPO2l+Ebt1rI/1goav7eGoF059fCxwWrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733634367; c=relaxed/simple;
	bh=xM0gzYJZgtcrTvc8i2tTuA1zs3s1CAxCHS74tYT2BwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsMCtyE6oS6NoYUA7V4eYqYrJie0MBBjUhPElTQ3cIt+cy1PY0uLYRFwNlnhqPulKPPqWxmUaf66iLgccC/Wrmay60JLKe5ry2uIUUaxu8NzXPAvP/umv7PhKQVZZEC+iYO6DwMtB/AyMM/43wjOGq/11nFfPomjom1MtbW/aFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LadHdV6v; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 8 Dec 2024 13:38:39 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733634360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTIMMaEabz2yNJ3BCGYu9dfy9Hdli7Hl5ja+ottT06c=;
	b=LadHdV6vwdbKRm7jeZ25s+fet1g1lR3mVmf2wE7L2H24h9YExw+OipKvMaZznsnoHt+iyS
	sCqZ1kUDRr5hill6xow9tLd9LHnKkx5oPFjFdORxaE5tlsKr67GJIDhvm/JzBoy8Ll8F04
	amkEA8ILyrepc15Wxs9ydplSmBDrLks=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
	gshan@redhat.com, steven.price@arm.com, sami.mujawar@arm.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: rsi: Add automatic arm-cca-guest module
 loading
Message-ID: <Z1Uiz7Hn2XisyP-N@vm3>
References: <20241207012128.247522-1-jeremy.linton@arm.com>
 <20241207012128.247522-2-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241207012128.247522-2-jeremy.linton@arm.com>
X-Migadu-Flow: FLOW_OUT

Hi Jeremy,

On Fri, Dec 06, 2024 at 07:21:28PM -0600, Jeremy Linton wrote:
> The TSM module provides guest identification and attestation when a
> guest runs in CCA mode. By creating a dummy platform device, let's

Perhaps could you spell out like; a guest runs in the Realm state?

Thanks,
Itaru.
 
> ensure the module is automatically loaded. The udev daemon loads the
> TSM module after it receives a device addition event. Once that
> happens, it can be used earlier in the boot process to decrypt the
> rootfs.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> ---
>  arch/arm64/include/asm/rsi.h                    |  2 ++
>  arch/arm64/kernel/rsi.c                         | 15 +++++++++++++++
>  drivers/virt/coco/arm-cca-guest/arm-cca-guest.c |  8 ++++++++
>  3 files changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rsi.h b/arch/arm64/include/asm/rsi.h
> index 188cbb9b23f5..b42aeac05340 100644
> --- a/arch/arm64/include/asm/rsi.h
> +++ b/arch/arm64/include/asm/rsi.h
> @@ -10,6 +10,8 @@
>  #include <linux/jump_label.h>
>  #include <asm/rsi_cmds.h>
>  
> +#define RSI_PDEV_NAME "arm-cca-dev"
> +
>  DECLARE_STATIC_KEY_FALSE(rsi_present);
>  
>  void __init arm64_rsi_init(void);
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 3031f25c32ef..5434e5496ac2 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -8,6 +8,7 @@
>  #include <linux/psci.h>
>  #include <linux/swiotlb.h>
>  #include <linux/cc_platform.h>
> +#include <linux/platform_device.h>
>  
>  #include <asm/io.h>
>  #include <asm/mem_encrypt.h>
> @@ -140,3 +141,17 @@ void __init arm64_rsi_init(void)
>  	static_branch_enable(&rsi_present);
>  }
>  
> +static struct platform_device rsi_dev = {
> +	.name = RSI_PDEV_NAME,
> +	.id = PLATFORM_DEVID_NONE
> +};
> +
> +static int __init rsi_init(void)
> +{
> +	if (is_realm_world() &&
> +	    platform_device_register(&rsi_dev))
> +		pr_err("failed to register rsi platform device\n");
> +	return 0;
> +}
> +
> +arch_initcall(rsi_init)
> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> index 488153879ec9..87f162736b2e 100644
> --- a/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca-guest.c
> @@ -6,6 +6,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/cc_platform.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/smp.h>
>  #include <linux/tsm.h>
> @@ -219,6 +220,13 @@ static void __exit arm_cca_guest_exit(void)
>  }
>  module_exit(arm_cca_guest_exit);
>  
> +/* modalias, so userspace can autoload this module when RSI is available */
> +static const struct platform_device_id arm_cca_match[] __maybe_unused = {
> +	{ RSI_PDEV_NAME, 0},
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(platform, arm_cca_match);
>  MODULE_AUTHOR("Sami Mujawar <sami.mujawar@arm.com>");
>  MODULE_DESCRIPTION("Arm CCA Guest TSM Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.46.0
> 

