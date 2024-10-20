Return-Path: <linux-kernel+bounces-373204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07AD9A53BB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAC11C20CEF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7192A28689;
	Sun, 20 Oct 2024 11:24:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE482866;
	Sun, 20 Oct 2024 11:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423460; cv=none; b=Rxb1Epsk82ypH/rl30FOigTgCTkZadBvxvKHdWmpMk0e6BijX001Yv9vkiG3QrO+zjgK/p4FDYdDwnWEKqMJNlLklghPv4fZWDJN4iDU85p6qtaRnDirt/PXDxL33zS/QNYqVpqNG2loDs1s14kmHp652fWYDA5rIa6K1chwZQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423460; c=relaxed/simple;
	bh=AqyvcQC/J3kx32qXVO9hZK9UDxRF5G7XFRvT7rBBTyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRe2qi05X4Vnzi2A3JreUjocI3geJ6bJNIaNwwpDtxTYBEjlLmRO8CHRxi1O1yCeBefK4jFhCINHB2sB/iFpt4PGBgkDFIaP3K9bMJ/rUxWKLR9MR2gdXUEo1J9RN1ZQCLny2FMJv+AGcyGFh8NumJMX6mbt3JvYx2wx2H6zcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC9BDDA7;
	Sun, 20 Oct 2024 04:24:46 -0700 (PDT)
Received: from minigeek.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86EF23F58B;
	Sun, 20 Oct 2024 04:24:15 -0700 (PDT)
Date: Sun, 20 Oct 2024 12:23:21 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Parthiban <parthiban@linumiz.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, wens@csie.org,
 jernej.skrabec@gmail.com, samuel@sholland.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, masterr3c0rd@epochal.quest
Subject: Re: A133 support
Message-ID: <20241020122321.141727c7@minigeek.lan>
In-Reply-To: <2dc2c052-8fde-4656-8dbf-a6980cd968ae@linumiz.com>
References: <2dc2c052-8fde-4656-8dbf-a6980cd968ae@linumiz.com>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Oct 2024 15:06:46 +0530
Parthiban <parthiban@linumiz.com> wrote:

Hi,

> Am currently adding support for Allwinner A133 SoC based on A100.

Many thanks for picking this up, but what do you mean exactly by
"adding support"? As you probably have seen, there is already some
basic support for the A100 in the tree, and since we assume that both
SoCs are basically identical, there wouldn't be too much left to do,
would there?
For reference, there is some leftover patch series from the original
A100 upstreaming attempt, which you could rebase and rework:
https://lore.kernel.org/linux-arm-kernel/cover.1604988979.git.frank@allwinnertech.com/

I haven't checked in a while, but some patches in there have either
been merged or are superseded by other patches, and I guess the others
need at least a rebase, but it's certainly something worthwhile to work
on.

> Based on the [1],
> A100 and A133 uses same IP across. But there is no public available datasheet or
> user manual for A100.

Indeed there has never been, and back then we relied on information
provided by those Allwinner employees sending the patches.
For now we assume that the A133 manual describes the A100 as well.

> Should A100 kept as base and A133 dtsi needs to added on top or A133 can be duplicated
> into a new devicetree?

As far as we know, the A133 is the better bin of the A100, so they
should be identical from the software perspective. This seems to be
similar to the H616/H313 situation. At some point the A100 totally
disappeared from Allwinner's documentation (in an almost "Orwellian
1984 fashion"), and they only mention the A133 ever since.

So, since the A100 is already in, and was the first one, I'd say:
- Keep using an allwinner,sun50i-a100 prefix for any compatible string.
  Rationale: it's the base model, and was the first one, and we have
  compatible strings with that in, so we should keep using that for
  consistency.
- There is no need for any kind of a133.dtsi, since they are probably
  identical.
- If you add a board with an A133, use that name in the root compatible
  string, but include the a100.dtsi. See the H616/H313/H618 situation,
  for instance as in sun50i-h618-transpeed-8k618-t.dts.

Hope that helps, and thanks for your efforts on improving support for
that chip! Please come back to the #linux-sunxi IRC channel on OFTC,
there is someone (MasterR3C0RD) actively working on some A133 board as
well, and he even has a working DRAM driver for U-Boot. So you should
coordinate any upstreaming efforts.

Cheers
Andre




> 
> [1]: https://linux-sunxi.org/Linux_mainlining_effort#Status_Matrix
> 


