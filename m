Return-Path: <linux-kernel+bounces-384476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E539D9B2A95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 09:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65880B21503
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F681922DC;
	Mon, 28 Oct 2024 08:42:25 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6FC18E354
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104945; cv=none; b=XSkJk7s69VZ5IGMVCA5M0eCMGPEF1D+1R3+tkLSOziupWB7kw0n40PWI3sfRepKZ9Qru3W1h2cR9vuuksOYH83pr/SCm1tHOkuLXIjSGxA5PLaOAd5OEerIvMfttOUPycheGCgr9hjA35qHSvXZeVfcgeRyzwbood5u1TMVwDD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104945; c=relaxed/simple;
	bh=kwIC/PrIMofg3x45o1BrEuh64V+jr2n+8IieR2DzdOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YbzOD9OLafiKFURtJNb/9YveIIkfjWgYI7O3c1doNFjd4kE2WHQHdkjlyzh1p2xLQVXzDD1F+rkI7fAr3TNyIadIRZ0uo6cP7L+uDQ46SLaUwt/rOxH+MqzKef1uq+e9mymks8oK2Fc7Lo6vQYpfnoPaW+Mh6urLIQk/Elny5S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1t5LKP-00029U-2c; Mon, 28 Oct 2024 09:42:21 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: robh@kernel.org,  krzk+dt@kernel.org,  a.fatoum@pengutronix.de,
  conor+dt@kernel.org,  dinguyen@kernel.org,  marex@denx.de,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 20/22] ARM: dts: socfpga: removal of generic PE1 dts
In-Reply-To: <20241027143654.28474-21-l.rubusch@gmail.com> (Lothar Rubusch's
	message of "Sun, 27 Oct 2024 14:36:52 +0000")
References: <20241027143654.28474-1-l.rubusch@gmail.com>
	<20241027143654.28474-21-l.rubusch@gmail.com>
Date: Mon, 28 Oct 2024 09:42:19 +0100
Message-ID: <87sesgr53o.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 2024-10-27 at 14:36 GMT, Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Remove the older socfpga_arria10_mercury_pe1.dts, since it is duplicate,
> the hardware is covered by the combination of Enclustra's .dtsi files.
> 
> The older .dts was limited to only the case of having an Enclustra
> Mercury+ AA1 on a Mercury+ PE1 base board, booting from sdmmc. This
> functionality is provided also by the generic Enclustra dtsi and dts
> files, in particular socfpga_arria10_mercury_aa1_pe1_sdmmc.dts. Since
> both .dts files cover the same, the older one is to e replaced in
> favor of the more modularized approach.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  arch/arm/boot/dts/intel/socfpga/Makefile      |  1 -
>  .../socfpga/socfpga_arria10_mercury_pe1.dts   | 55 -------------------
>  2 files changed, 56 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
> 
> diff --git a/arch/arm/boot/dts/intel/socfpga/Makefile b/arch/arm/boot/dts/intel/socfpga/Makefile
> index c467828ae..d95862e34 100644
> --- a/arch/arm/boot/dts/intel/socfpga/Makefile
> +++ b/arch/arm/boot/dts/intel/socfpga/Makefile
> @@ -2,7 +2,6 @@
>  dtb-$(CONFIG_ARCH_INTEL_SOCFPGA) += \
>  	socfpga_arria5_socdk.dtb \
>  	socfpga_arria10_chameleonv3.dtb \
> -	socfpga_arria10_mercury_pe1.dtb \
>  	socfpga_arria10_socdk_nand.dtb \
>  	socfpga_arria10_socdk_qspi.dtb \
>  	socfpga_arria10_socdk_sdmmc.dtb \
> diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts b/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
> deleted file mode 100644
> index cf533f76a..000000000
> --- a/arch/arm/boot/dts/intel/socfpga/socfpga_arria10_mercury_pe1.dts
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright 2023 Steffen Trumtrar <kernel@pengutronix.de>
> - */
> -/dts-v1/;
> -#include "socfpga_arria10_mercury_aa1.dtsi"
> -
> -/ {
> -	model = "Enclustra Mercury+ PE1";
> -	compatible = "enclustra,mercury-pe1", "enclustra,mercury-aa1",
> -		     "altr,socfpga-arria10", "altr,socfpga";
> -
> -	aliases {
> -		ethernet0 = &gmac0;
> -		serial0 = &uart0;
> -		serial1 = &uart1;
> -	};
> -};
> -
> -&gmac0 {
> -	status = "okay";
> -};
> -
> -&gpio0 {
> -	status = "okay";
> -};
> -
> -&gpio1 {
> -	status = "okay";
> -};
> -
> -&gpio2 {
> -	status = "okay";
> -};
> -
> -&i2c1 {
> -	status = "okay";
> -};
> -
> -&mmc {
> -	status = "okay";
> -};
> -
> -&uart0 {
> -	status = "okay";
> -};
> -
> -&uart1 {
> -	status = "okay";
> -};
> -
> -&usb0 {
> -	status = "okay";
> -	dr_mode = "host";
> -};

Acked-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>


Best regards,
Steffen

-- 
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

