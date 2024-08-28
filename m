Return-Path: <linux-kernel+bounces-304406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F4A2961FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8131F258EA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 06:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E77F158555;
	Wed, 28 Aug 2024 06:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOcBjUMs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3541553BB;
	Wed, 28 Aug 2024 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724826213; cv=none; b=mRAT34B+HWEp4oCLpBJtv63L5zWiE+dZZOOM4ksut9/I0zzo2ringOqxPNLLzRwjDmMJu1qxuU3ZaXc+ojtnB8IARC0zr2J84raFmS9UnyVZ9tmAeuViKjDWbFnTKXzolDi1eS8d8t1VI30MjwJIG11IHiXkfF3X+bQgJ0z/ftg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724826213; c=relaxed/simple;
	bh=byXfuoq79N/V0IYSGU9kcsAei/E3VUj3YPsQQ/jkVqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptLej6s9+A28Zgz+W/hqaw+xy9GVrpfHMA8GFSs54tEeEQXNecc/LGyaCcOc4OjAI8anmLTVP4MZU9UZiJ9H96Q8FYV4vWvLMV1RdAO5Kh8wH44cEgNs4EGafums+YOI6fgPKNqvDXG9bm63Eghie5CCGTpQvs8M1Y/SbqIO4iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOcBjUMs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09700C568C9;
	Wed, 28 Aug 2024 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724826211;
	bh=byXfuoq79N/V0IYSGU9kcsAei/E3VUj3YPsQQ/jkVqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOcBjUMsYtwZQUNV/tcS8ud5boakq+K7s8SolJkdSqbJbhHwnNTEsTAkAYXwvsneE
	 rGHr4MtdCjcegKyR38ooP6AFwdZHAH7RiSRqSiqeF/NoKI3+6rlTI7jE1kiD5jo9C7
	 ojzC98j18q+5xO4hg/rpLoN0HsRQ4uSEfQf/Zpms641mcGk5H041WyH7JZROshwrUP
	 GJAfBc3n6EHycVtohJ7+zlfXxd4eZs7y5gBfLVfLGiTO6FiL0OwCFgn/4RWfx+JEi4
	 PgwHplXxz0Gt0I6VEiWNqgqryv57HwQgWXfb2IVcCW7fAVrsY41Lv6udIQz/HdqP3z
	 oUW7QyngHezyA==
Date: Wed, 28 Aug 2024 08:23:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Lijuan Gao <quic_lijuang@quicinc.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, kernel@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/6] arm64: dts: qcom: add initial support for QCS615 DTSI
Message-ID: <gtoz6fzmukti7mbdihsw5ycltoozhrxgery536rh6dgpcqoru2@gd27iemigqae>
References: <20240828-add_initial_support_for_qcs615-v1-0-5599869ea10f@quicinc.com>
 <20240828-add_initial_support_for_qcs615-v1-5-5599869ea10f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828-add_initial_support_for_qcs615-v1-5-5599869ea10f@quicinc.com>

On Wed, Aug 28, 2024 at 10:02:15AM +0800, Lijuan Gao wrote:
> Add initial DTSI for QCS615 SoC. It includes base description
> of CPUs, interrupt-controller and cpu idle on Qualcomm QCS615
> platform.
> 
> Signed-off-by: Lijuan Gao <quic_lijuang@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615.dtsi | 449 +++++++++++++++++++++++++++++++++++
>  1 file changed, 449 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> new file mode 100644
> index 000000000000..cf7aaa7f6131
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
> @@ -0,0 +1,449 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +

No need for blank line.

> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	chosen { };

Drop, redundant.

> +
> +	clocks {
> +		xo_board: xo-board {

xo-clk? xo-board-clk?

But if board, this does not sound like part of SoC. See other files how
they do it.


> +			compatible = "fixed-clock";
> +			clock-frequency = <38400000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {

labels are lowercase.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a55";
> +			reg = <0x0 0x0>;
> +			enable-method = "psci";
> +			power-domains = <&CPU_PD0>;
> +			power-domain-names = "psci";
> +			next-level-cache = <&L2_0>;
> +			#cooling-cells = <2>;
> +
> +			L2_0: l2-cache {

lowercase

> +			      compatible = "cache";
> +			      cache-level = <2>;
> +			      cache-unified;
> +			      next-level-cache = <&L3_0>;

Best regards,
Krzysztof


