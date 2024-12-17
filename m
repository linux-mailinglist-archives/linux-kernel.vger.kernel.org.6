Return-Path: <linux-kernel+bounces-448394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6909F3F90
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87AF2188C879
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2948A13AD03;
	Tue, 17 Dec 2024 00:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIO5iMFp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131B5B1FB;
	Tue, 17 Dec 2024 00:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396754; cv=none; b=PELKz91BE3j3SMG5n4uEWUp/D4y+BpsrNG27oymblDxmGzikVo8y/koF0I423DzxQxzxEhLsff2X8c2BTaSR9/ggaJLNv3WPb2rYqjCsK1n4s8Z7qPZZjmlSdukzKzVWKgM4Lhzt0zh9wYlWlG/h3iGQ1Ws4swlrxOdrT37BqLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396754; c=relaxed/simple;
	bh=ahJoUPijgcUGbeJiMKEim4VJ7XgJMHjQ91nAUfS9MJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dfglYTh0YkIh3/7vUk1FsBYWjyWp+W3FsvZNx2U4B3ixGtxI5Or4LwrwRk8+SsxewsMHLUzP6Pnpo6oS01IMqmG3JeQejx9Hp+PaROc6qtzOilQ3kTlUXCwma+Gjz/AhltqCIIr1kmdAELiFmNcDkVSz9Mc1MWr9GTWh+2HBMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIO5iMFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95083C4CED0;
	Tue, 17 Dec 2024 00:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734396754;
	bh=ahJoUPijgcUGbeJiMKEim4VJ7XgJMHjQ91nAUfS9MJY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iIO5iMFpA5bZTofjIrZGXvpnBGQ3xKak6oW1STEpNFRR5uj96LdGgPozz/MYOH4Nj
	 rC2uxj9ZFRxyAfyPo8KyUh2PCOp9yeqWVfwv5vZdirh/vZdlgrqmLE2DzgEPeBw1Gm
	 qnevoMQ+brBy25W1qt0NZ3pKqZ6YcpoOiYKsBZu6h454KOxXG8yAdpmZwXks6N6Kza
	 ZB2zyZe1VUaMBBVEWi5a77y+16Q3gEG6P+NUo1akYEJnY4FSnrjmIQnlt9NMwao59C
	 dtyqcQ1J7BgfQLz4boKgOdXWW9grrnApgOS3d7/pKsKq9+/0EZffjX2y+oqLwv+1YP
	 5ObWnAzKACOig==
Message-ID: <9636aa09-ab89-4d7e-8677-ff5dc58788ae@kernel.org>
Date: Mon, 16 Dec 2024 18:52:32 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: socfpga: agilex: Add VGIC maintenance
 interrupt
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241209023611.1216499-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20241209023611.1216499-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/24 20:36, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add VGIC maintenance interrupt and interrupt-parent property for
> interrupt controller, required to run Linux in virtualized environment.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex.dtsi | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> index 2a5eeb21da47..1235ba5a9865 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex.dtsi
> @@ -101,10 +101,13 @@ intc: interrupt-controller@fffc1000 {
>   		compatible = "arm,gic-400", "arm,cortex-a15-gic";
>   		#interrupt-cells = <3>;
>   		interrupt-controller;
> +		interrupt-parent = <&intc>;
>   		reg = <0x0 0xfffc1000 0x0 0x1000>,
>   		      <0x0 0xfffc2000 0x0 0x2000>,
>   		      <0x0 0xfffc4000 0x0 0x2000>,
>   		      <0x0 0xfffc6000 0x0 0x2000>;
> +		/* VGIC maintenance interrupt */
> +		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>   
>   	clocks {


Applied!

Thanks,
Dinh

