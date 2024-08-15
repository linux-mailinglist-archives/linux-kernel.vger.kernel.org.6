Return-Path: <linux-kernel+bounces-288430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCB9953A04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7EA628853C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 18:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742E77D40D;
	Thu, 15 Aug 2024 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kln1oX+o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8B770E8;
	Thu, 15 Aug 2024 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746498; cv=none; b=I/B151Zn0SD+otUdQvRANXSMxabgonEjuuor7xNnbQqrT+UiijhwQW+EKiOoiiSGiufwKnEDDM0ifh0TmSGwiJmjXGyVt44Q/6RLA1dBNHcgulf4UWLp7krjZoQWJoRUbiaJ47YQKEPBVQ6NM2wyxTfVPZWAeRX+zUSVBTWuTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746498; c=relaxed/simple;
	bh=NCh3OvJdaVuugMSHbHIXwM3T1Uw1k7HWDJF8Mph8NV0=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=BAs5WL6vPAeljESt14HBJWF0Uq+Jvv7/egd9y49gDkcA6SV0qmw+XMAi/n0fQ0C1qgK6D90q7hLdY5HV0g4Qr76j12fMET2GeVMX2mZK6S+cvRJqTFYPuHwwgXzgQAZQ6W+SyJ8c62+AVF14DJMYK6N6LApb8GfX2qmQlA7hr3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kln1oX+o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A248C4AF0F;
	Thu, 15 Aug 2024 18:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723746498;
	bh=NCh3OvJdaVuugMSHbHIXwM3T1Uw1k7HWDJF8Mph8NV0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Kln1oX+o4+UvTd1tMGxIpQbm9vWy2SLnvGn4nJZdeZkyUeJHVfofFfLcWTTkHSvx/
	 +AhDACYRqj/NhhTIgtBzkRSmAGvhJd6kaP5SE1QG9+iFF3oNdiGV+iNeNznG63k6p+
	 6kqmpUjAw/Xkzc/BUgKy2u0aO05dQaikTCMWjdkGUHIRX6LijfgWuSTQ4kxE47ai4o
	 T+r1YjJNb5/YMjTqP4Xx5jRa1yBGPOHCUugjn89+eKCoAkFMSr8cQnOZeH9jzaDa9o
	 uRvS+28EPB16B/0J3ZB76nxzR9eelvBsPv2eRoLJedtx7N5llAFMYYq9zSY3w8ERvA
	 ZNdkCAXJvpZWA==
Date: Thu, 15 Aug 2024 12:28:17 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, devicetree@vger.kernel.org, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Orson Zhai <orsonzhai@gmail.com>
In-Reply-To: <cover.1723716331.git.stano.jakubek@gmail.com>
References: <cover.1723716331.git.stano.jakubek@gmail.com>
Message-Id: <172374583311.2826973.18334755436603011801.robh@kernel.org>
Subject: Re: [PATCH 0/3] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)


On Thu, 15 Aug 2024 12:12:21 +0200, Stanislav Jakubek wrote:
> This series continues cleaning up various issues with the Spreadtrum/Unisoc
> ARM64 DeviceTrees.
> 
> Stanislav Jakubek (3):
>   arm64: dts: sprd: sp9860g-1h10: fix
>     constant-charge-voltage-max-microvolt property
>   arm64: dts: sprd: sc2731: fix bat-detect-gpios property
>   arm64: dts: sprd: sc2731: move fuel-gauge monitored-battery to device
>     DTS
> 
>  arch/arm64/boot/dts/sprd/sc2731.dtsi      | 6 +++---
>  arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 7 ++++++-
>  2 files changed, 9 insertions(+), 4 deletions(-)
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


New warnings running 'make CHECK_DTBS=y sprd/sp9860g-1h10.dtb' for cover.1723716331.git.stano.jakubek@gmail.com:

arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: fuel-gauge@a00: 'bat-detect-gpios', 'interrupt-parent', 'interrupts' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/sc27xx-fg.yaml#
arch/arm64/boot/dts/sprd/sp9860g-1h10.dtb: battery: 'internal-resistance-micro-ohms' does not match any of the regexes: '^ocv-capacity-table-[0-9]+$', 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/power/supply/battery.yaml#






