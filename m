Return-Path: <linux-kernel+bounces-204623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 538CA8FF21C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3D9FB31532
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967D8198A34;
	Thu,  6 Jun 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckowu5SF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E89198858;
	Thu,  6 Jun 2024 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689373; cv=none; b=jCmFKsPiRSWfWnAYtA9BRLmaBCwfI0VUMSLdlzP1/9iCzAyaXeXCipM6ZkIhzt28piwFBQx/pp4ozFcRN2pKXJR4h+7qfcfMhINlvMWVrj0k0RshJFy68IQUAaEWqyKRT1/iQc+NFChcB+rFPm+WLzQ+IiVvSjQf6ftw4ojlCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689373; c=relaxed/simple;
	bh=5l77wiJJzbmsT9FOUGqOi81vSYosoZGu6nMuZ4VVoI8=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Cn3sxCLUNS23M2LLG9jdw/VZ+RZKIhoxuX84TDnySm+hflfet6jkE7hp73EqhpCuk6E5ovhR0G7QLsQetJxjI7W8uLfx4dYC5FJyNvjkm0k7gjV6UJi4zD/+7wv0B1uYMRMjYfalJ/VRSBgvo1//SycPPSaMiSqHRFz2qkr34JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckowu5SF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B455C2BD10;
	Thu,  6 Jun 2024 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717689373;
	bh=5l77wiJJzbmsT9FOUGqOi81vSYosoZGu6nMuZ4VVoI8=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=ckowu5SFXA7wGJegZi0jPnN7ClwPiEfl98Xd/ILAe6s3cpCkU73X000lDw8TACwrx
	 qRIZpTwNwW+S4IPvTg/o0ZLWiq06L99Ljrq6xPOvR9MPuPiI9cCJmT1YlHgbI0C+cr
	 YQWpih9wFnVqgUNu/NWU9rnYkY/JEq3r66EzKbjI91pxKuPdDJa5Rh0A0qOsyb6Epm
	 gYPkrEm52lP98mFJ+cwc8x+lHqB+jgqjwnkGQiXsiQfQVToseCgl0bd2+xYaFMoYvK
	 e5bkBAIhEw9hNhszk7UE0YglTSzt2aBGnYyBYhJLZQIB97p78rIa69dHjFVKEodDNG
	 +BIRZ0y+14D7w==
Date: Thu, 06 Jun 2024 09:56:12 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Hari Nagalla <hnagalla@ti.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kristo@kernel.org, 
 linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org, vigneshr@ti.com, 
 nm@ti.com
In-Reply-To: <20240605124859.3034-1-hnagalla@ti.com>
References: <20240605124859.3034-1-hnagalla@ti.com>
Message-Id: <171768925461.3793135.11230797607122517451.robh@kernel.org>
Subject: Re: [PATCH v3 0/4] Add R5F and C7x DSP nodes for AM62a SoC


On Wed, 05 Jun 2024 07:48:55 -0500, Hari Nagalla wrote:
> This patch series adds R5F and C7x dsp processor nodes and shared
> memory based Virtio/IPC configuration for AM62A SoC.
> 
> changes in v3:
> *) Separated DSP node binding patch and submitted to remoteproc
>    mailing list, rebased the patches to linux-next.
> 
> v2: https://lore.kernel.org/all/20230810005850.21998-1-hnagalla@ti.com/
> 
> Devarsh Thakkar (2):
>   arm64: dts: k3-am62a-wakeup: Add R5F device node
>   arm64: dts: ti: k3-am62a7-sk: Enable ipc with remote proc nodes
> 
> Hari Nagalla (1):
>   arm64: dts: k3-am62a-mcu: Add R5F remote proc node
> 
> Jai Luthra (1):
>   arm64: dts: k3-am62a-main: Add C7xv device node
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 11 ++++
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    | 35 +++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi | 23 +++++++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     | 68 +++++++++++++++++++++
>  4 files changed, 137 insertions(+)
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


New warnings running 'make CHECK_DTBS=y ti/k3-am62a7-sk.dtb' for 20240605124859.3034-1-hnagalla@ti.com:

arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: reg: [[0, 2113929216, 0, 1048576]] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: reg-names: ['l2sram'] is too short
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#
arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: dsp@7e000000: Unevaluated properties are not allowed ('reg', 'reg-names' were unexpected)
	from schema $id: http://devicetree.org/schemas/remoteproc/ti,k3-dsp-rproc.yaml#






