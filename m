Return-Path: <linux-kernel+bounces-536161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099A8A47C3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103F1164362
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212022A7E5;
	Thu, 27 Feb 2025 11:31:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42621C197;
	Thu, 27 Feb 2025 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655897; cv=none; b=IpHTWeGOqjRrPNMl2BPBU97vX9Ux1c/gpfRnp+KvT7b+gjvTr5syi0+3JJWFWivqKvYVYynVW0halAQcqhc5qUmyCO4OpatJrgKwIzKIq+pCfkeJm1hL6v5mk3T0AO2V3ElqBgFDG/xZ4oUXYJv9MADTXPUiyU1lxJbTFgXuMUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655897; c=relaxed/simple;
	bh=sDj3J3eyO/n3cAM0nb6fEPRi1/eZS8UFgJTqHdnYU6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovf3snr/iw1LQ3Umf+hAggj9vJtagcYDaiOLmol7VF5ETGkrBzyuNdOVaWsdHpmBEZVNbbfyOKElIifHyszYs+xvVgSvZRVZOYIr3HJpYNWTZnvCZBckXNZbtxtpNTnL+HR3fsk5nwBRqvDnGGEDj5r0oh8M0kmXnWtEDZEXpyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F87115A1;
	Thu, 27 Feb 2025 03:31:51 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F98A3F6A8;
	Thu, 27 Feb 2025 03:31:33 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: (subset) [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Date: Thu, 27 Feb 2025 11:31:19 +0000
Message-Id: <174065576473.2740592.10867811098764653721.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 21 Feb 2025 18:03:39 +0000, Vincenzo Frascino wrote:
> The Morello architecture is an experimental extension to Armv8.2-A,
> which extends the AArch64 state with the principles proposed in
> version 7 of the Capability Hardware Enhanced RISC Instructions
> (CHERI) ISA [1].
> 
> This series adds dts support for the Arm Morello System Development
> Platform.
> 
> [...]

Applied to sudeep.holla/linux (for-next/juno/updates), thanks!

[01/10] arm64: Kconfig: Update description for CONFIG_ARCH_VEXPRESS
        https://git.kernel.org/sudeep.holla/c/a3b955ac911b
[02/10] dt-bindings: arm: Add Morello compatibility
        https://git.kernel.org/sudeep.holla/c/51e877f12d23
[03/10] dt-bindings: arm: Add Morello fvp compatibility
        https://git.kernel.org/sudeep.holla/c/73d251e7068c
[04/10] dt-bindings: arm: Add Rainier compatibility
        https://git.kernel.org/sudeep.holla/c/91ee16438965
[05/10] dt-bindings: arm-pmu: Add support for ARM Rainier PMU
        https://git.kernel.org/sudeep.holla/c/807945ae7325
[07/10] arm64: dts: morello: Add support for common functionalities
        https://git.kernel.org/sudeep.holla/c/8fc53e26fdd8
[08/10] arm64: dts: morello: Add support for soc dts
        https://git.kernel.org/sudeep.holla/c/7f6838da3c67
[09/10] arm64: dts: morello: Add support for fvp dts
        https://git.kernel.org/sudeep.holla/c/34f3b3745ce5
[10/10] MAINTAINERS: Add Vincenzo Frascino as Arm Morello Maintainer
        https://git.kernel.org/sudeep.holla/c/6ceb0dd64727
--
Regards,
Sudeep


