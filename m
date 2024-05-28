Return-Path: <linux-kernel+bounces-192276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0F78D1AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB5691F230FC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB2516D4DF;
	Tue, 28 May 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n38Vtenf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDD79F5;
	Tue, 28 May 2024 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898776; cv=none; b=tZh+Z3ni2f1RD05OWSop13G+51bBI/1//o3sTgFR8HHkdsQYfAM/KzSBVK4aJNxPFy8T7sJ3gHiHjgO79OQSGurr9jqRaRhJBtKOFkjPHenbS9qBcc32jnknr9L1GD31rVIyxuOYUFtj4Tf+MjpuPXZlF1ZotTinQW2YZXYX8RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898776; c=relaxed/simple;
	bh=uDlDC/kSByaVQE+lkrr6hynap5IlA9IpLkI2wjQ9KBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qo76qoriUIb244E+ZpIEgrl8QZ7Iz7zeub6spuzOSHd6IH8QeoI/OJWUd/QLa+F/atvIegCN7bDyoX931MOdjkRf/RuA6x9BsuRvxJNrqXvBa4Tx9hJVOei2ANL7x1K5/upmPY556yJyGWOxdTa91HbCcCUcubVHiGXVVrYLH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n38Vtenf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B43C32789;
	Tue, 28 May 2024 12:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898776;
	bh=uDlDC/kSByaVQE+lkrr6hynap5IlA9IpLkI2wjQ9KBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n38VtenfkN/LEwZ9h8Ki0oP026KwYPlL4e8LVcWxi9V/rioNhxu8/+sgAdq06B0mo
	 guN1NhRpu2nSOjlek+k7mmvIMab5DTuTvTAjyeoCwW/GFzQOLke6m5+0N9laTVmJ0z
	 aeoJcTzFcE/qeG72p3IwfcGahsQn60ivoKUBfPVfdiFIwx/0M9Kbh/iBEvFxbZ0KNU
	 1xz3bsWb8EI6VokEbagaICbE0RUSJtox/T6TpVG52Owi3VT49AYV61Vq5paX4am16K
	 oENGwfRENsJoHsRJt7EgQkQC+hT2raIRk+8jQt51YXgPiQs1Hm8tmwz8eAseH4WLNd
	 ztCANhYH6T7XQ==
Message-ID: <def2fd41-371a-4b2a-925d-81b149aaae01@kernel.org>
Date: Tue, 28 May 2024 15:19:30 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: ti: k3-serdes: Add Serdes1 lane-muxing
 macros for J722S
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-5-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-5-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> The Serdes1 instance of the Serdes on J722S SoC is a single lane Serdes
> that is muxed across PCIe and CPSW. Define the lane-muxing macros to be
> used as the idle state values.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> Current patch is v1. No changelog.
> 
>  arch/arm64/boot/dts/ti/k3-serdes.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-serdes.h b/arch/arm64/boot/dts/ti/k3-serdes.h
> index e6a036a4e70b..ef3606068140 100644
> --- a/arch/arm64/boot/dts/ti/k3-serdes.h
> +++ b/arch/arm64/boot/dts/ti/k3-serdes.h
> @@ -206,4 +206,7 @@
>  #define J722S_SERDES0_LANE0_USB			0x0
>  #define J722S_SERDES0_LANE0_QSGMII_LANE2	0x1
>  
> +#define J722S_SERDES1_LANE0_PCIE0_LANE0		0x0
> +#define J722S_SERDES1_LANE0_QSGMII_LANE1	0x1
> +

Maybe this one patch can deal with both USB and PCIE0 additions to this file
and could be moved earlier in the series.

>  #endif /* DTS_ARM64_TI_K3_SERDES_H */

-- 
cheers,
-roger

