Return-Path: <linux-kernel+bounces-520685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A01DCA3AD40
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0974A1896FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528013FD86;
	Wed, 19 Feb 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lYoB9OQG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F0885626;
	Wed, 19 Feb 2025 00:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925740; cv=none; b=ZVTICcQIxfz8RAo3REEDUYg3Mo/MJEh093zj0JyyJosm0y2eJpCX3sqVA8dX6DGaqcg1Uu/pkrlE2p5aungKO9dESSx+m8klCHt6Yk9afBbXFGCD1uuOA3AZ9cMynqXOWLaHu/AW0L4pk/CllGcwJsK67MMw5/ZHKs59cCQMfEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925740; c=relaxed/simple;
	bh=Lf1QSn2HFfzd/SJAB6st4xfz9SeWKWjYwHdfEcPhoBk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=f/1KfWajOxvlntPJpFXtPOsJ4QNpf7W+/yBtDtFo2VRZzU3vw+xr6Xc47Jez1TikbuhqlX3XDMNCOo3JKjrUVSSoKQI2WN94GCj0b+5g3P5AGRMxb+VDTmW3UPweMbE92f4G1cm7WUfm2C3s/rMVDezz9v8HxZnuhma4Zi9YTwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lYoB9OQG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD75C4CEE2;
	Wed, 19 Feb 2025 00:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925740;
	bh=Lf1QSn2HFfzd/SJAB6st4xfz9SeWKWjYwHdfEcPhoBk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lYoB9OQGTtF88lve82g8lz6dwRRjXBoOP31guouiMVWULq1dJ27jIGvPoipCNRNHY
	 MB8rr6VETVLrK38XF56DgNMXbKy0E7H4uvBqWO9Xz9YjfKG6Ek9sHsRnm0NNPjmsMU
	 3SpwY/OrEDZtSXw0G/pvPQQh/DvIR8nOq8GgYTBuIR4UXW/NZ+UEpoHycWMdtiQDP7
	 skWUJD26QLqBW4qFBUdBoBpoCIfFKN0kRYd4/ZY4LLkedRgrLGqQM0psQ0PFSLw/ZM
	 jdIGwAWfzl7eMqCeZxATVtGd1FSKXJa6bWv//VVJt+c0vuI5frK2B7XNhkqNlgusQP
	 JYTU728Ue5gmg==
Date: Tue, 18 Feb 2025 18:42:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Conor Dooley <conor+dt@kernel.org>, Scott Branden <sbranden@broadcom.com>, 
 linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 ~postmarketos/upstreaming@lists.sr.ht, Ray Jui <rjui@broadcom.com>, 
 linux-kernel@vger.kernel.org, Stanislav Jakubek <stano.jakubek@gmail.com>, 
 Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>
To: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
References: <20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com>
Message-Id: <173992516047.2065189.12949590674422169603.robh@kernel.org>
Subject: Re: [PATCH v4 0/9] mfd: bcm590xx: Add support for BCM59054


On Sat, 15 Feb 2025 10:39:35 +0100, Artur Weber wrote:
> Add support for the BCM59054 MFD to the bcm590xx driver and fix a
> couple of small bugs in it that also affected the already supported
> BCM59056.
> 
> While we're at it - convert the devicetree bindings to YAML format
> and drop the bcm59056 DTS in favor of describing the PMU in users'
> DTS files, as is done for most other MFDs.
> 
> The BCM59054 is fairly similar to the BCM59056, with the primary
> difference being the different number and layout of regulators.
> It is primarily used in devices using the BCM21664 and BCM23550
> chipsets.
> 
> This patchset has been tested on a Samsung Galaxy Grand Neo
> (baffinlite rev02; DTS not in mainline yet) with a BCM59054 PMIC.
> Testing on a BCM59056 would be appreciated.
> 
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> ---
> Changes in v4:
> - Fix yamllint warnings in DT bindings
> - Address miscelaneous review comments related to DT bindings
>   - Note that I did not end up moving the regulator refs from
>     allOf compatible matches; I explained my reasoning in [1].
>     [1] https://lore.kernel.org/lkml/ab853605-859d-44c6-8cbd-44391cd677e6@gmail.com/
> - Add PMU ID/revision parsing to MFD driver
> - Fix instances of regulator data not matching vendor kernel for
>   BCM59054
> - Use different voltage table for BCM59054 VSR reg based on PMU
>   revision
> - Link to v3: https://lore.kernel.org/r/20250131-bcm59054-v3-0-bbac52a84787@gmail.com
> 
> Changes in v3:
> - Split out regulator DT bindings into separate YAML
> - Use tables of regulator info instead of get_XXX_register, reg_is_XXX
>   functions
> - Drop "regulator: bcm590xx: Add proper handling for PMMODE registers";
>   it adds unnecessary noise to the series and will be submitted separately
> - Link to v2: https://lore.kernel.org/r/20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com
> 
> Changes in v2:
> - Fixed BCM59054 ID being passed to BCM59056 function in the
>   regulator driver
> - Dropped linux-rpi-kernel from the CC list
> - Link to v1: https://lore.kernel.org/r/20231030-bcm59054-v1-0-3517f980c1e3@gmail.com
> 
> ---
> Artur Weber (9):
>       dt-bindings: mfd: brcm,bcm59056: Convert to YAML
>       dt-bindings: mfd: brcm,bcm59056: Add compatible for BCM59054
>       ARM: dts: Drop DTS for BCM59056 PMU
>       mfd: bcm590xx: Add support for multiple device types + BCM59054 compatible
>       mfd: bcm590xx: Add PMU ID/revision parsing function
>       regulator: bcm590xx: Use dev_err_probe for regulator register error
>       regulator: bcm590xx: Store regulator descriptions in table
>       regulator: bcm590xx: Rename BCM59056-specific data as such
>       regulator: bcm590xx: Add support for BCM59054 regulators
> 
>  .../devicetree/bindings/mfd/brcm,bcm59056.txt      |   39 -
>  .../devicetree/bindings/mfd/brcm,bcm590xx.yaml     |   76 ++
>  .../bindings/regulator/brcm,bcm59054.yaml          |   56 +
>  .../bindings/regulator/brcm,bcm59056.yaml          |   51 +
>  arch/arm/boot/dts/broadcom/bcm28155-ap.dts         |   68 +-
>  arch/arm/boot/dts/broadcom/bcm59056.dtsi           |   91 --
>  drivers/mfd/bcm590xx.c                             |   86 +-
>  drivers/regulator/bcm590xx-regulator.c             | 1294 ++++++++++++++++----
>  include/linux/mfd/bcm590xx.h                       |   22 +
>  9 files changed, 1377 insertions(+), 406 deletions(-)
> ---
> base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
> change-id: 20240816-bcm59054-a880695e41e8
> 
> Best regards,
> --
> Artur Weber <aweber.kernel@gmail.com>
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/broadcom/' for 20250215-bcm59054-v4-0-dbfb2d76a855@gmail.com:

arch/arm/boot/dts/broadcom/bcm53340-ubnt-unifi-switch8.dtb: mpcore@19000000: $nodename:0: 'mpcore@19000000' does not match '^([a-z][a-z0-9\-]+-bus|bus|localbus|soc|axi|ahb|apb)(@.+)?$'
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#






