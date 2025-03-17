Return-Path: <linux-kernel+bounces-563692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBAEA646C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE65E1718FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31324221712;
	Mon, 17 Mar 2025 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjKN/zG7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5EC3AC17;
	Mon, 17 Mar 2025 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202788; cv=none; b=cGKKLJ9g8NFcrnAxlz2udhsuGeJDMYaSUU8W8gKiDPOZu4oUc2GnxaM6B2gwlcq3lfp5TUQQ7BGyap88qf7gpN4UCdq6XRSXvuP36/ECOpMdJ+6SZhct7oNB5E0fUvrETFj+/g3vfFyXwf3r45XWlrNMNDzxaM7B49yksw0ewrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202788; c=relaxed/simple;
	bh=egUbHhdw/VIJUm8LAkutH+qWohBTh+J4+/zQg3hloi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sm7MqJAAZQ8UP6Z4Nts2jlTpSuOUgFlCoDMRMdY9GtgLCVvXqtIh9tUqlvObc6VpVNfzyUO/CAdbwUGKx+eAuewakBmw/s+zErlVFsiD9J2MtpaQBmgLciODPyHVZA9YUQ85JX63+o/cmBOLSiD2g6BJXFcDX9Z1B0vKKo5YA3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjKN/zG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED64C4CEE3;
	Mon, 17 Mar 2025 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742202788;
	bh=egUbHhdw/VIJUm8LAkutH+qWohBTh+J4+/zQg3hloi0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjKN/zG7AcRdgZCTvQmGNJS/2vUNCY0+Vj973da/zf3skngITlJdC8hKBNeJ2k+TX
	 zzhTEyI04kRxaWNf9LjC0c37o6ZztkmkjIQR+xXdmsTbx99+HC8OdE2vHc5lQODm0g
	 zZs3js/JJAVI6s4zJairySxrmVYks36twqWF9hCzjyviyXzFpJ9Ql4bjlMYM1lp1NS
	 cmvAh5KTGD8vTn/lCAhbgw/0lX+6OkG+MKHJzK7EsvK8DfR8d3UDuyDLwgp64Zd2Hp
	 tNwzcvIjhmguyrmtYXZSBKebeW44t0TMzlu0yLSAb4WXImdFY+tSUXf8VX1ofmtNrH
	 9ER51BCV754Tg==
Date: Mon, 17 Mar 2025 10:13:04 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kevin Chen <kevin_chen@aspeedtech.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au, 
	derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Message-ID: <20250317-chital-of-unusual-force-a4b7b7@krzk-bin>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
 <20250314112113.953238-3-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314112113.953238-3-kevin_chen@aspeedtech.com>

On Fri, Mar 14, 2025 at 07:21:12PM +0800, Kevin Chen wrote:
> The AST2600 has PCC controller in LPC, placed in LPC node.
> 
> Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
> ---
>  arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> index 8ed715bd53aa..f238337e02da 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
> @@ -626,6 +626,14 @@ lpc_snoop: lpc-snoop@80 {
>  					status = "disabled";
>  				};
>  
> +				lpc_pcc: lpc-pcc@0 {
> +					compatible = "aspeed,ast2600-lpc-pcc";
> +					reg = <0x0 0x140>;
> +					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +					pcc-ports = <0x80>;

So this is 0x80 for entire SoC, then it is implied by compatible, no?

> +					status = "disabled";

Where is any DTS user of this device?

Best regards,
Krzysztof


