Return-Path: <linux-kernel+bounces-206258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBBB90066B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380051F23E91
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39901196444;
	Fri,  7 Jun 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqxdS2T0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C11DFC5;
	Fri,  7 Jun 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717770301; cv=none; b=h9rSyaRJBk5Cz3GoxlLEFgdC/8DwxNftT9G4mehyDQax8Z8SSnWsfwEU+++/advLAvy+Zj7eopCItMmXf6M436SL0TQe67xvLDb+OPhgWokBZ/jpVBBb+rHPZYpqVGEESs4pa1MQ7Eqmq/R7X99ECaVgc+/SghXVlP+e5Di7W2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717770301; c=relaxed/simple;
	bh=EM3y8T6KZ3vV6DsbAyhlHWkY8HcWgcCqtvWsG3kkmwQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=K3MfWEzqyijpwf7P+BcimIeraCnoJEYeM8jbzejZSOFMK+k5ItEeDJ18tuqp8qfsBdf4eIKUXXlcF7LYIqyrRcuc+/ncbXwxT01a4VMPXmWGhScd/GLtGmR5JhqmbV9vL7FFJ8SuTR2QHeoW9kH35tCimfuxEXPQolgtu2Wd6dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqxdS2T0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB5EC2BBFC;
	Fri,  7 Jun 2024 14:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717770301;
	bh=EM3y8T6KZ3vV6DsbAyhlHWkY8HcWgcCqtvWsG3kkmwQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=qqxdS2T0eu4K+egRuZvWTSgys3HQFCWU4e7t88yLQzVQPPavacLDal7QeQTsl5wEE
	 bYtf1LmH+q1O91uaqnir32ck5FLJOaojmPUQeondqDVc3TYBPCkKBVOsH09FQJKcW1
	 X2IhMa8voAadszLsM38P+dBVCbd9yJ3Rx/SSEhMNPLcc+Ih58Yqwv2cnZdouibcmo/
	 G9UP14NN9w5l/aJ87Q9co7BaHGATO4DN9V1heqH0ZHw0HEVEsv9UOoCzNmTajGwe3Z
	 jxb5CpcwYIN2adOTOZ5/Z76JPNMfsoLAaujIU9SRhhbR+SC2QaIs5C0M2DmWsvsxvs
	 6PjgIutZ1sdAg==
Date: Fri, 07 Jun 2024 08:25:00 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: u-kumar1@ti.com, nm@ti.com, krzk+dt@kernel.org, vaishnav.a@ti.com, 
 j-choudhary@ti.com, linux-kernel@vger.kernel.org, conor+dt@kernel.org, 
 kristo@kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, vigneshr@ti.com
In-Reply-To: <20240607090433.488454-1-b-padhi@ti.com>
References: <20240607090433.488454-1-b-padhi@ti.com>
Message-Id: <171777012624.2736811.12792442744239321951.robh@kernel.org>
Subject: Re: [PATCH 0/3] Add Remoteproc Support for TI's J722S SoCs


On Fri, 07 Jun 2024 14:34:30 +0530, Beleswar Padhi wrote:
> Hello All,
> 
> The K3 J722S SoCs have one single-core Arm Cortex-R5F processor in each
> of the WAKEUP, MCU and MAIN voltage domain, and two C71x DSP subsystems
> in MAIN voltage domain. Thus, Add the DT Nodes and memory carveout
> regions to add remoteproc support in J722S SoCs.
> 
> Apurva Nandan (2):
>   arm64: dts: ti: Add R5F and C7x remote processor nodes
>   arm64: dts: ti: k3-j722s-evm: Add memory carveouts for R5F and C7x
> 
> Beleswar Padhi (1):
>   arm64: dts: ti: k3-j722s-evm: Enable Mailbox clusters
> 
>  arch/arm64/boot/dts/ti/k3-j722s-evm.dts | 140 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j722s.dtsi    |  63 +++++++++++
>  2 files changed, 203 insertions(+)
> 
> --
> 2.34.1
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y ti/k3-j722s-evm.dtb' for 20240607090433.488454-1-b-padhi@ti.com:

arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg: [[0, 2113929216, 0, 2097152]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: reg-names: ['l2sram'] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e000000: Unevaluated properties are not allowed ('reg', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg: [[0, 2116026368, 0, 2097152]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: reg-names: ['l2sram'] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-j722s-evm.dtb: dsp@7e200000: Unevaluated properties are not allowed ('reg', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#






