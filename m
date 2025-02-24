Return-Path: <linux-kernel+bounces-528660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B733A41A61
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 272B73B3EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D07245037;
	Mon, 24 Feb 2025 10:08:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFD288DA;
	Mon, 24 Feb 2025 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391704; cv=none; b=n2I6XQCD1YGjV5TBiSCYygd4gRRn7dAkOhkjJeYpdCZB1LXaPyQflcePoEn9eg/H95N/A4oDkDzeH71fC3jtGePh2G9ZeKEl+DGUO9ENbhxzm7Yhe9WscFfkN3HMMjz6hFxoOYrkP8QO2ll5d8V+XLvRkd93+h+X14AoGL0WbGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391704; c=relaxed/simple;
	bh=fespLaFMTMql39LCqWfuCJOVabzoi1y/N9PMgXCapXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIlrxOuB/muEpjjCbWsp//4NkIlrjAZgRNu3rnQw6ayYS6+fEf6/GyKX9XcTfoUP/DaaqTTd/YYHo0BzZx7e6fnoe+N8/o373Dl0ZZvlPha4v1W/DJINEI7KFOdca0GSMFEyQC4puwx+aBO0oebzIWSCTpUx7hCHlUDc/oQldto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883F51E7D;
	Mon, 24 Feb 2025 02:08:38 -0800 (PST)
Received: from [192.168.7.252] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20F143F673;
	Mon, 24 Feb 2025 02:08:20 -0800 (PST)
Message-ID: <58ee2a8d-d3c1-4bc2-92dd-6568f645b01f@arm.com>
Date: Mon, 24 Feb 2025 10:08:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <Z7jL5wBUJNjOlg4r@J2N7QTR9R3.cambridge.arm.com>
Content-Language: en-GB
From: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <Z7jL5wBUJNjOlg4r@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Mark,

On 21/02/2025 18:54, Mark Rutland wrote:
> Hi Vincenzo,
> 
> On Fri, Feb 21, 2025 at 06:03:39PM +0000, Vincenzo Frascino wrote:
>> The Morello architecture is an experimental extension to Armv8.2-A,
>> which extends the AArch64 state with the principles proposed in
>> version 7 of the Capability Hardware Enhanced RISC Instructions
>> (CHERI) ISA [1].
> 
> None of the CHERI stuff is supported upstream, so from upstream's PoV
> this is a low-volume dev-board/SoC with an experimental ARMv8.2-A CPU.
>

Agreed, I have no plans to upstream Morello support beyond the device tree.

>> This series adds dts support for the Arm Morello System Development
>> Platform.
> 
> Do we actually need the dts for this board?
> 
> I have one on my desk; it boots vanilla Debian 12 via UEFI + ACPI just
> fine, with the Debian 6.1.0-13-arm64 kernel.
> 
> Is there something that we can only do with the DT? i.e. some
> functionality that isn't exposed via ACPI?
> 
> How do you expect this DT to be used?
> 

There are functionalities that are not exposed via ACPI, e.g. gpu, dpu, i2c for
the phy, etc. My aim to have upstream support for all the hardware exposed by
the platform.

Note: This series contains only the basic infrastructure, the plan is add
progressively more features in the future.

Vincenzo

> Mark.
> 
>>
>> [1] https://www.morello-project.org/
>>
>> To simplify the testing a linux tree rebased on 6.14-rc4 is accessible
>> at [2].
>>
>> [2] https://codeberg.org/vincenzo/linux/src/branch/morello/dts/v6
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: Liviu Dudau <liviu.dudau@arm.com>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Lorenzo Pieralisi <lpieralisi@kernel.org> 
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Jessica Clarke <jrtc27@jrtc27.com>
>> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
>>
>> Changes
>> =======
>> v7:
>>   - Rebased on 6.14-rc4.
>>   - Added review info.
>> v6:
>>   - Introduce arm,morello.yml.
>>   - Split pmu patch.
>>   - Address review comments.
>> v5:
>>   - Add support for fvp.
>>   - Add support for pmu.
>>   - Address review comments.
>>   - Rebase on 6.14-rc1.
>> v4:
>>   - Add cache information.
>>   - Address review comments.
>> v3:
>>   - Address review comments.
>>   - Rebase on 6.13-rc5.
>> v2:
>>   - Addressed review comments.
>>   - Rebased on 6.13-rc4.
>>   - Renamed arm,morello to arm,morello-sdp for clarity.
>>
>> Vincenzo Frascino (10):
>>   arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
>>   dt-bindings: arm: Add Morello compatibility
>>   dt-bindings: arm: Add Morello fvp compatibility
>>   dt-bindings: arm: Add Rainier compatibility
>>   dt-bindings: arm-pmu: Add support for ARM Rainier PMU
>>   perf: arm_pmuv3: Add support for ARM Rainier PMU
>>   arm64: dts: morello: Add support for common functionalities
>>   arm64: dts: morello: Add support for soc dts
>>   arm64: dts: morello: Add support for fvp dts
>>   MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer
>>
>>  .../devicetree/bindings/arm/arm,morello.yaml  |  35 ++
>>  .../devicetree/bindings/arm/cpus.yaml         |   1 +
>>  .../devicetree/bindings/arm/pmu.yaml          |   1 +
>>  MAINTAINERS                                   |   7 +
>>  arch/arm64/Kconfig.platforms                  |   5 +-
>>  arch/arm64/boot/dts/arm/Makefile              |   1 +
>>  arch/arm64/boot/dts/arm/morello-fvp.dts       |  77 +++++
>>  arch/arm64/boot/dts/arm/morello-sdp.dts       | 157 +++++++++
>>  arch/arm64/boot/dts/arm/morello.dtsi          | 323 ++++++++++++++++++
>>  drivers/perf/arm_pmuv3.c                      |   2 +
>>  10 files changed, 606 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/arm,morello.yaml
>>  create mode 100644 arch/arm64/boot/dts/arm/morello-fvp.dts
>>  create mode 100644 arch/arm64/boot/dts/arm/morello-sdp.dts
>>  create mode 100644 arch/arm64/boot/dts/arm/morello.dtsi
>>
>> -- 
>> 2.43.0
>>

-- 
Regards,
Vincenzo


