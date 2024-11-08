Return-Path: <linux-kernel+bounces-401627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AD59C1D09
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A498B25639
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7717C1E9078;
	Fri,  8 Nov 2024 12:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq8+AFQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF831E883D;
	Fri,  8 Nov 2024 12:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731069049; cv=none; b=XZoqvWN2H9iJtgRZDcvlCSlO2ZVMZek4jafckxNTCVfUxPcheMndZB/Ps2qNcy091yO1QGASoTy+vG6zY29sA4gNTaNhJvx68qwU5i4fNSa8g3to1LtVoVcKvntrjcOE322IM05uRxY0LAR25HAlzP7GbWH8wBZ2HKQAsiWPyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731069049; c=relaxed/simple;
	bh=lsRVwnN3Hmvnd8CINxQUPLlzC/Ghsnml0MyuvrzJB2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NEfCEzTE4J4tt3u2AX1EQp5wpeF92iJwY7Z0ayFOG4wpzekrNY2frQ2cfSPYEMBdqqQe5r3cqGFtkhGK0ZT/lUrrj0MWTnAe37RjkYe7CWs/3LB2ltKTL5i0orIEugR1hiryHftn/cFMkns1+C6IGy3vReuC9Bjl71OknSWonnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq8+AFQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96802C4CECD;
	Fri,  8 Nov 2024 12:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731069049;
	bh=lsRVwnN3Hmvnd8CINxQUPLlzC/Ghsnml0MyuvrzJB2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq8+AFQan/3BBhcjt6Yv0qBggmChuS+jJnt9Q0fyt5c8C1R3wh2vwfS4H6IyPVze5
	 759MTX0QieWFTgUX/G5OG4YWiCJdyCPnbnfNLS97p99HU7W/r4t6caOm7YCNpTJMDh
	 1VCy3dQoMeTf+9k+fqDruZL3/vaH34pnF7BmRwTs+5ce+rVkY1KL89s9fDHGi+uqHa
	 e6l0kJHUjUcxErt48ibUjbyb7PsqYVml1ZHyZcpqb8WALKA3bM1NQ1eb9DuGNo7U7H
	 zRjbwmMJ7w9sz3UT+dlD8gLDM07BMbaMER76eRVk9UGCVLZH3nF1GKX3QLlx1lPb4b
	 NLGH4JYP/l21g==
Date: Fri, 8 Nov 2024 13:30:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org, 
	krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com, 
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
Message-ID: <c7llcnzthr2ydp4zlyk7rhovwauy5cqeqllvmgmyluypxq3opv@c4suatmd7k3w>
References: <20241107104557.1442800-1-danishanwar@ti.com>
 <20241107104557.1442800-2-danishanwar@ti.com>
 <7f0a73c3-9977-4d07-b996-683ed18e4724@kernel.org>
 <8156fd61-c476-4b58-b3b2-e8bc4f93035e@ti.com>
 <2c368f5a-4b58-45de-8140-21b2f7af4d12@kernel.org>
 <4ba0381b-d30a-4469-a7c4-327f6ac20c9c@ti.com>
 <2e7a1eb6-df8f-44d4-9342-1bc6d8b5ad11@ti.com>
 <1fa4323b-4cee-4dfe-9c68-55f4465999cf@kernel.org>
 <2a3c54e8-46fc-48f9-8c01-f3bb0c4907af@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a3c54e8-46fc-48f9-8c01-f3bb0c4907af@ti.com>

On Fri, Nov 08, 2024 at 05:49:54PM +0530, Anwar, Md Danish wrote:
> Hi Krzysztof,
> 
> On 11/7/2024 5:51 PM, Krzysztof Kozlowski wrote:
> > On 07/11/2024 12:58, MD Danish Anwar wrote:
> >>
> >>
> >> On 07/11/24 5:16 pm, MD Danish Anwar wrote:
> >>>
> >>>
> >>> On 07/11/24 5:14 pm, Krzysztof Kozlowski wrote:
> >>>> On 07/11/2024 12:36, MD Danish Anwar wrote:
> >>>>>
> >>>>>
> >>>>> On 07/11/24 5:01 pm, Krzysztof Kozlowski wrote:
> >>>>>> On 07/11/2024 11:45, MD Danish Anwar wrote:
> >>>>>>> Add clocks, assigned-clocks and assigned-clock-parents for ICSSG
> >>>>>>
> >>>>>> Why? We see what you are doing from the diff, no point to repeat it. I
> >>>>>> don't understand why you are doing it.
> >>>>>>
> >>>>>>>
> >>>>>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> >>>>>>> ---
> >>>>>>>  .../devicetree/bindings/soc/ti/ti,pruss.yaml          | 11 +++++++++++
> >>>>>>>  1 file changed, 11 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >>>>>>> index 3cb1471cc6b6..cf4c5884d8be 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
> >>>>>>> @@ -92,6 +92,17 @@ properties:
> >>>>>>>      description: |
> >>>>>>>        This property is as per sci-pm-domain.txt.
> >>>>>>>  
> >>>>>>> +  clocks:
> >>>>>>> +    items:
> >>>>>>> +      - description: ICSSG_CORE Clock
> >>>>>>> +      - description: ICSSG_ICLK Clock
> >>>>>>> +
> >>>>>>> +  assigned-clocks:
> >>>>>>> +    maxItems: 1
> >>>>>>> +
> >>>>>>> +  assigned-clock-parents:
> >>>>>>> +    maxItems: 1
> >>>>>>
> >>>>>> Why? This is really not needed, so you need to explain why you are doing
> >>>>>> things differently than entire Linux kernel / DT bindings.
> >>>>>>
> >>>>>
> >>>>> I need to add this to the device tree node
> >>>>>
> >>>>> +		clocks = <&k3_clks 81 0>,  /* icssg0_core_clk */
> >>>>> +			 <&k3_clks 81 20>; /* icssg0_iclk */
> >>>>> +		assigned-clocks = <&k3_clks 81 0>;
> >>>>> +		assigned-clock-parents = <&k3_clks 81 2>;
> >>>>>
> >>>>> But without the above change in the binding I am getting below errors
> >>>>> while running dtbs check.
> >>>>>
> >>>>> /workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30000000:
> >>>>> 'assigned-clock-parents', 'assigned-clocks' do not match any of the
> >>>>> regexes: '^(pru|rtu|txpru)@[0-9a-f]+$', '^pa-stats@[a-f0-9]+$',
> >>>>> 'cfg@[a-f0-9]+$', 'iep@[a-f0-9]+$', 'interrupt-controller@[a-f0-9]+$',
> >>>>> 'mdio@[a-f0-9]+$', 'memories@[a-f0-9]+$', 'mii-g-rt@[a-f0-9]+$',
> >>>>> 'mii-rt@[a-f0-9]+$', 'pinctrl-[0-9]+'
> >>>>> +/workdir/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtb: icssg@30080000:
> >>>>> 'anyOf' conditional failed, one must be fixed:
> >>>>>
> >>>>> To fix this warning I added these in the binding and the warnings were
> >>>>> fixed.
> >>>>
> >>>> nah, cannot reproduce. Just be sure you work on recent kernel (last time
> >>>> you were sending it on some ancient stuff) and your packages are
> >>>> updated, including dt schema and other kernel dependencies.
> >>>>
> 
> The purpose of this series is to add 'assigned-clock-parents',
> 'assigned-clocks' to the DT node. Initially I was only trying to add
> these two nodes to DT and at that time I got the above error. I also got
>  the below error as well

So you pasted different error, not related to topic we discussed.
assigned-clock* depend on clocks. You must have clocks to assign them,
obviously. Device should no assign rates to clocks which are not its
inputs. :/


> 
> /home/danish/workspace/linux-next/arch/arm64/boot/dts/ti/k3-am642-evm.dtb:
> icssg@30000000: 'anyOf' conditional failed, one must be fixed:
>         'clocks' is a required property
>         '#clock-cells' is a required property
>         from schema $id: http://devicetree.org/schemas/clock/clock.yaml#
> 
> 
> To fix this I added 'assigned-clock-parents', 'assigned-clocks' to the
> binding and at this time I got only the below error,

To fix this you must add clocks. The error tells you this.

So again: drop assigned properties. No error msg asked you to add them.

Best regards,
Krzysztof


