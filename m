Return-Path: <linux-kernel+bounces-544178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A4A4DE45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8EC18903EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C46202C48;
	Tue,  4 Mar 2025 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW348z9j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FE1FFC74;
	Tue,  4 Mar 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092525; cv=none; b=F0MxMM2cS9EL0DQmn3gp6mxtWrleHoteyNTMLuhWnZBR4PAGp+vlqaZZvpWd/MGe9GMXYQhEEbZlYzLhTeJ5nHkp+57EcVAfMbpqrLKjPJk0Q/qMp4t6o1RfsHjEPLi8PAu1Kb9qN3fB3WHUNjK0PKZPCQ1FzWFQS/i7WsyCv3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092525; c=relaxed/simple;
	bh=qs1uaw+fmZ/8gb8hir4yFJES2X7FcZuc7NwFrXHu62M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoDEhdhJfqeP1k9c3QqlYklrDOQqOELdZmx4lUfesc4z4DVaLu4CwU+WPijVnSfc5DVGJT0nh3m0ipwLhd5q45qk1WIzZ+I4fPWwBJihC9Tc2lDckC5gn7jqIpJKdfoTHXC9AjU6o1xGylljeHGP4i0M4pUtF+VVhPrUS9GfmfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW348z9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77EA3C4CEE5;
	Tue,  4 Mar 2025 12:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741092524;
	bh=qs1uaw+fmZ/8gb8hir4yFJES2X7FcZuc7NwFrXHu62M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TW348z9jRX5ZSgJoPBlyk5//Ug5GqU9KnYD1BLdu2ADKTpJKJPZFTV44+ordyBa8b
	 4dJ80PIpwujBtHUJt70dfbuL6b4kioAxjeKM1A5EvKQfPm1toQkvkNl3Z6mLYFGyRO
	 ow9YIZD5TnWC2BfZSxbow5MULEoAYP2zC6lEfxii8GSxYjayYoAKx/nvE+L6tbmnvP
	 iJLW/ElVnwlAwWb1DVwoRyAv2ncYLXRXQLAJ3SlxDwKIbWkDNnk7E/WW32FWVpPHJr
	 OXLrpw9MGFfFMk+SjJsQyuiiYPml+qhnqarSVF+snpgOPbkXbQckBze1ZpQjfePTPH
	 bQ0ZkN01iyo4Q==
Message-ID: <47cb57f6-2270-43af-8786-2827a08ddf9c@kernel.org>
Date: Tue, 4 Mar 2025 06:48:44 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 2/2] arm64: dts: socfpga: agilex5: add
 clock-names property to nand node
To: niravkumar.l.rabara@intel.com, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, nirav.rabara@altera.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20250228045349.1429680-1-niravkumar.l.rabara@intel.com>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20250228045349.1429680-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 22:53, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Add required clock-names property to the nand node.
> 
> Fixes: 2d599bc43813 (arm64: dts: agilex5: add initial support for Intel Agilex5 SoCFPGA)
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> index 51c6e19e40b8..27f75e1bc8eb 100644
> --- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> +++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
> @@ -271,6 +271,7 @@ nand: nand-controller@10b80000 {
>   			#size-cells = <0>;
>   			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
>   			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
> +			clock-names = "nf_clk";
>   			cdns,board-delay-ps = <4830>;
>   			status = "disabled";
>   		};

Applied!

Thanks,
Dinh

