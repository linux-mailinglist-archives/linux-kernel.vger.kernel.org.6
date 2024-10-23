Return-Path: <linux-kernel+bounces-378567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2968A9AD267
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2282824FA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3761CEEA2;
	Wed, 23 Oct 2024 17:20:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B041C9EAC
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704028; cv=none; b=VR5rWRjfxKAJra2AbXVhADocLi8I4XaI7wKxoPxBmNZ4FKmuluU/is277iKlllEPqT14kVCsZkepSFYyWabcOxRecRGg5N7QRBkz/uj1WcjSs1q9g6dP+kWaaAjCSh+jVDsLAXQPEvWMuPZr68T/dCmdLb1q2FFZyZZivCldZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704028; c=relaxed/simple;
	bh=ILs+TB5urSECDjPfOferd+xzMH0FDTRFmzWeWIx7QlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MAJXG34nIZQAze8eP3RoX6Hbz5f8Zk3tpPXE4cmFH2+LtkIRIKX+sl7v83QfseXPyDGwpzN0+OgHzQi2yf/NjpSUg52Srb8kwo1fGB/WdPer+qaYCIjPtVt4IIScbt5p6o4a2+ALMlVzD2W9sEqFGPHFI+97rcmpShP14J6vT6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1t3f1q-0000HU-S6; Wed, 23 Oct 2024 19:20:14 +0200
Message-ID: <b6a6b9d8-ec2d-4360-9747-4b44d24e0b06@pengutronix.de>
Date: Wed, 23 Oct 2024 19:20:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 13/23] ARM: dts: socfpga: add Enclustra boot-mode dtsi
To: Lothar Rubusch <l.rubusch@gmail.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dinguyen@kernel.org, marex@denx.de,
 s.trumtrar@pengutronix.de
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-14-l.rubusch@gmail.com>
Content-Language: en-US
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20241020194028.2272371-14-l.rubusch@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Lothar,

On 20.10.24 21:40, Lothar Rubusch wrote:
> Add generic boot-mode support to Enclustra Arria10 and Cyclone5 boards.
> Some Enclustra carrier boards need hardware adjustments specific to the
> selected boot-mode.

Can you elaborate more on these hardware adjustments?

Do the different boot media e.g. share pins and can't be active at the same
time?

Thanks,
Ahmad

> 
> Signed-off-by: Andreas Buerkler <andreas.buerkler@enclustra.com>
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../socfpga_enclustra_mercury_bootmode_emmc.dtsi     | 12 ++++++++++++
>  .../socfpga_enclustra_mercury_bootmode_qspi.dtsi     |  8 ++++++++
>  .../socfpga_enclustra_mercury_bootmode_sdmmc.dtsi    |  8 ++++++++
>  3 files changed, 28 insertions(+)
>  create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
>  create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
>  create mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
> 
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
> new file mode 100644
> index 000000000..d79cb64da
> --- /dev/null
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_emmc.dtsi
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
> + */
> +
> +&qspi {
> +	status = "disabled";
> +};
> +
> +&mmc {
> +	bus-width = <8>;
> +};
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
> new file mode 100644
> index 000000000..5ba21dd8f
> --- /dev/null
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_qspi.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
> + */
> +
> +&mmc {
> +	status = "disabled";
> +};
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
> new file mode 100644
> index 000000000..2b102e0b6
> --- /dev/null
> +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_enclustra_mercury_bootmode_sdmmc.dtsi
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Copyright (C) 2024 Enclustra GmbH - https://www.enclustra.com
> + */
> +
> +&qspi {
> +	status = "disabled";
> +};


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

