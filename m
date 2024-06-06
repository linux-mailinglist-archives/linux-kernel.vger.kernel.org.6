Return-Path: <linux-kernel+bounces-203762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFD78FE02C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A883B212E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDA613AD38;
	Thu,  6 Jun 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qY1XC7u/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F0DF44;
	Thu,  6 Jun 2024 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660294; cv=none; b=ZeRzzE+e7laNcVgOAwSord74BDt2g9ky7NlNe09IVkKmwNQUXrNL2b3Pj+LIxdshiJz4ZYO6QTKbK21cQqGPUEV8D+402iy3FD+imNTUfeCRXAjNdGmwRWfpkHYZkc7RFXeZjC1ndcvtzwh1JQXQ7RS619lr5/BjyFdPdi7PsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660294; c=relaxed/simple;
	bh=3OwO3/H69nwhm+8pvR63/ovgEqlUeLfYprL9yzUtT00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwrSrZu+WVkF+Ju/Xvd4o2VoI7kY8AMhWwuptmlDJqsRSvIqkVjvV+C9jvV+TiHCMXP9yPwIl/X6tK80zg0oLgpee/07r2b8uSkxSHM7MOhOa6SpWfKCZUY0z/WHTSI2ACdHIVXsK4zGraHUgHmuGS+lJqHJFEFVIDz55eOKcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qY1XC7u/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6226BC3277B;
	Thu,  6 Jun 2024 07:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717660293;
	bh=3OwO3/H69nwhm+8pvR63/ovgEqlUeLfYprL9yzUtT00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qY1XC7u/68GFrD6LoNxyQ4U48UIEGVvcp5m6MvZxuE7KALkcOVNxVBVNFf7FKwxfj
	 nUOhzx3BLu/rIsHgjiC10ce//QBX9fXmcRB0jHlJARRa6OceE+hu0outCTOc/iyirN
	 S/xI6SgypPRbZNTtKpKp3Ezt4ft600/ggjyBQS5PzFHaNHpdmqWGohcC5ibnVwPswA
	 GxtJkC4YAZIC7oZvKjYeLRgS8OvKEsTERUV83TFObu7A20bTNQgDHYM7uSFOkNgCIh
	 QWK+9wh0GK8N5RFRuLkBTNlDImV7YfowYNDqpCPVoHOXvaj0MBr7inCEvhY+A30eE7
	 nl/KicPYfZ0eA==
Message-ID: <92af5f36-0c21-4b6e-adde-fcf21b540291@kernel.org>
Date: Thu, 6 Jun 2024 10:51:27 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240604085252.3686037-1-s-vadapalli@ti.com>
 <20240604085252.3686037-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240604085252.3686037-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/06/2024 11:52, Siddharth Vadapalli wrote:
> The AM62P and J722S SoCs share most of the peripherals. With the aim of
> reusing the existing k3-am62p-{mcu,main,wakeup}.dtsi files for J722S SoC,
> rename them to indicate that they are shared with J722S SoC.
> 
> The peripherals that are not shared will be moved in the upcoming patches
> to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
> the filename, emphasizing that they are not shared.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>
> ---
> v4:
> https://lore.kernel.org/r/20240601121554.2860403-2-s-vadapalli@ti.com/
> Changes since v4:
> - Based on Andrew's feedback at:
>   https://lore.kernel.org/r/086fa11e-10f8-463d-8966-1a33a52a3146@ti.com/
>   MCU was retained as-is while main and wakeup were changed to MAIN and
>   WAKEUP in the respective shared files.
> - Newline has been added between the file description and the Copyright
>   in all the files.
> - Collected Acked-by tag since these changes have been made.
> 
>  .../{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} | 3 ++-
>  .../{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi}   | 3 ++-
>  ...-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} | 3 ++-
>  .../dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi}    | 6 +++---
>  arch/arm64/boot/dts/ti/k3-am62p5.dtsi                       | 2 +-
>  5 files changed, 10 insertions(+), 7 deletions(-)
>  rename arch/arm64/boot/dts/ti/{k3-am62p-main.dtsi => k3-am62p-j722s-common-main.dtsi} (99%)
>  rename arch/arm64/boot/dts/ti/{k3-am62p-mcu.dtsi => k3-am62p-j722s-common-mcu.dtsi} (98%)
>  rename arch/arm64/boot/dts/ti/{k3-am62p-wakeup.dtsi => k3-am62p-j722s-common-wakeup.dtsi} (97%)
>  rename arch/arm64/boot/dts/ti/{k3-am62p.dtsi => k3-am62p-j722s-common.dtsi} (97%)

This is not correct.
If J722 has different CBASS components than AM62p then we should leave k3-am62p.dtsi
as it is and introduce a new k3-j722.dtsi with relevant CBASS components.

> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> similarity index 99%
> rename from arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> index 900d1f9530a2..bf6384ba824a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
> - * Device Tree file for the AM62P main domain peripherals
> + * Device Tree file for the MAIN domain peripherals shared by AM62P and J722S
> + *
>   * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> similarity index 98%
> rename from arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> index b973b550eb9d..1d4e5fc8b4e0 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
> - * Device Tree file for the AM62P MCU domain peripherals
> + * Device Tree file for the MCU domain peripherals shared by AM62P and J722S
> + *
>   * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> index c71d9624ea27..f6ec6e8e171d 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-wakeup.dtsi
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only OR MIT
>  /*
> - * Device Tree file for the AM62P wakeup domain peripherals
> + * Device Tree file for the WAKEUP domain peripherals shared by AM62P and J722S
> + *
>   * Copyright (C) 2023-2024 Texas Instruments Incorporated - https://www.ti.com/
>   */
>  
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> similarity index 97%
> rename from arch/arm64/boot/dts/ti/k3-am62p.dtsi
> rename to arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> index 94babc412575..d85d05e0792a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common.dtsi
> @@ -120,6 +120,6 @@ cbass_wakeup: bus@b00000 {
>  };
>  
>  /* Now include peripherals for each bus segment */
> -#include "k3-am62p-main.dtsi"
> -#include "k3-am62p-mcu.dtsi"
> -#include "k3-am62p-wakeup.dtsi"
> +#include "k3-am62p-j722s-common-main.dtsi"
> +#include "k3-am62p-j722s-common-mcu.dtsi"
> +#include "k3-am62p-j722s-common-wakeup.dtsi"
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> index 41f479dca455..b7bb04a7968f 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p5.dtsi
> @@ -8,7 +8,7 @@
>  
>  /dts-v1/;
>  
> -#include "k3-am62p.dtsi"
> +#include "k3-am62p-j722s-common.dtsi"
>  
>  / {
>  	cpus {

--
cheers,
-roger

