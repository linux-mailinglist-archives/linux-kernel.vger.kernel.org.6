Return-Path: <linux-kernel+bounces-426919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1140B9DFA0C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66E4281BD3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258321D6DDF;
	Mon,  2 Dec 2024 04:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="UzLNJVZl"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2A1D63E5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733115107; cv=none; b=ohDZUunP2HRpOEOPRhq9X1U5OT0e3ULJbHL1fBmbizPV1eFf9w1CscZk7wG9GNPZsp4GAQ9jVdTymoa6TyfNTwBIpS7TufCCm4b8dvbcDqE3NAgukRfN24U4qZ22NJUHBU1YpUySZ4DnzZf1UHu5DuhpECJdU3l6CMMx0DO8eEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733115107; c=relaxed/simple;
	bh=Yg/g/FB7e3yYLY33+7JIH0ON2BIK6goaqEflMQan/wk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AQTOujpf9iOiHtLaoPqd34OpJNbF/i7RVl0pAmecWRUf3ohciLOeMXJoOqT9PaWqEEgjhlPW4kp1XtazNapoVxUnZlM+l9BalIcAONljhAvk59mELy7LNC2AlYFi6U+k5T93U8t43aWoxoNEHC32P1tdsZck8/8dV7hErs9bAxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=UzLNJVZl; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id HrABtPb4JiA19HyPLtWJMg; Mon, 02 Dec 2024 04:51:39 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id HyPHtvqUWvRBzHyPJtDEhd; Mon, 02 Dec 2024 04:51:37 +0000
X-Authority-Analysis: v=2.4 cv=dubdCUg4 c=1 sm=1 tr=0 ts=674d3cd9
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=-pn6D5nKLtMA:10 a=vU9dKmh3AAAA:8
 a=c-Ag78a_ZS1VCw5oD-gA:9 a=QEXdDO2ut3YA:10 a=rsP06fVo5MYu2ilr0aT5:22
 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cDVRJapTTKIEkPi1buTVc3tXS1QEJK+G0n5EUf611IE=; b=UzLNJVZlQFq1k7ehsk6kZJSGU3
	g1M3vCrp39TdiFyZFZwRkb8mrYzKfKewwfS9EGRRpM+tp4XT6RVFVW7yB9BYRQQfMDGIiqcI+dQLw
	zpwXbwbb6uwGmwrf04kyQZSmQ4aBfA6p0bBEDETL8KToM0R1w2KbMqCAUWjiDIqiT7IGXr9JY/SwZ
	uZ4gwg41I1yXsSjr+QmOlUKiLfEGHBVtiMvcDO2+bg1HLp6TMoqGs/Jfhjh4tAHg5KSwGlVcHWDR1
	vK2SCletrX0aSkmYz32ZmqdAMF9+VIDGdcUltIMRWG2jzOjO1TQ7My+7vdhYQfnuFF9RN+Bq0q2HC
	B7AJq2Sw==;
Received: from [122.165.245.213] (port=48956 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tHyPB-003JlN-2w;
	Mon, 02 Dec 2024 10:21:30 +0530
Message-ID: <d394f125-f301-4cc6-a477-36d1267b614a@linumiz.com>
Date: Mon, 2 Dec 2024 10:21:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: parthiban@linumiz.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a100: Add syscon nodes
To: Cody Eksal <masterr3c0rd@epochal.quest>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
References: <20241202-a100-syscon-v1-0-86c6524f24d7@epochal.quest>
 <20241202-a100-syscon-v1-2-86c6524f24d7@epochal.quest>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241202-a100-syscon-v1-2-86c6524f24d7@epochal.quest>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tHyPB-003JlN-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:48956
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 2
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP40W/y4SBRkatUV4D2yar1D9V2ei2pxBJVlMb+BEi4qBNzQyIMSORJmRhKHhgAQSDHLwoCRocXC/2nPoddBHCFYdEY9kyMJ0NV/ErxXXOCdNelv0Cj+
 OlX8WexwKT845QwGu8u9q6r+0Ec+yzvqYT587hmEkx9xSyuBvvjyDhfnQApqbVQOlWWpIZPWX/uUT9D+4zEEepZj5ja2V99Z4Jo=

On 12/2/24 10:13 AM, Cody Eksal wrote:
> The Allwinner A100 has a system configuration block, denoted as SYS_CFG
> in the user manual's memory map. It is undocumented in the manual, but
> a glance at the vendor tree shows this block is similar to its
> predecessors in the A64 and H6. The A100 also has 3 SRAM blocks: A1, A2,
> and C. Add all of these to the SoC's device tree.
> 
> Signed-off-by: Cody Eksal <masterr3c0rd@epochal.quest>
Reviewed-by: Parthiban Nallathambi <parthiban@linumiz.com>

Thanks,
Parthiban
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> index 29ac7716c7a5284ccf8af675db9c7d016785f0ff..31540a7ca1f01c6c2e69e329054aca16ffd112c4 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
> @@ -101,6 +101,37 @@ soc {
>  		#size-cells = <1>;
>  		ranges = <0 0 0 0x3fffffff>;
>  
> +		syscon: syscon@3000000 {
> +			compatible = "allwinner,sun50i-a100-system-control",
> +				     "allwinner,sun50i-a64-system-control";
> +			reg = <0x03000000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			sram_a1: sram@20000 {
> +				compatible = "mmio-sram";
> +				reg = <0x00020000 0x4000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x00020000 0x4000>;
> +			};
> +			sram_c: sram@24000 {
> +				compatible = "mmio-sram";
> +				reg = <0x024000 0x21000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x024000 0x21000>;
> +			};
> +			sram_a2: sram@100000 {
> +				compatible = "mmio-sram";
> +				reg = <0x0100000 0x14000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x0100000 0x14000>;
> +			};
> +		};
> +
>  		ccu: clock@3001000 {
>  			compatible = "allwinner,sun50i-a100-ccu";
>  			reg = <0x03001000 0x1000>;
> 


