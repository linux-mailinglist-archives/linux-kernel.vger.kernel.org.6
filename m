Return-Path: <linux-kernel+bounces-531310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0247AA43ED8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A101189FB41
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BCD2686B7;
	Tue, 25 Feb 2025 12:07:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A413267B1A;
	Tue, 25 Feb 2025 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485243; cv=none; b=G0eIXlXCal/4tOARTJWrjpNdoeLX1nwe+uC0XdsjcSOObE+TWJY+RbAD+pGSBnlGBWAtMBLg8lwuuEQ7bosOI3PnFzYA9W5KS2pY0nYiQdXWgAL5hYYrNPwF9y4s5GqKaxoVbJekQo/8W7sQ9Z3VWDv2W0A5sL9eY91HdX0oz14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485243; c=relaxed/simple;
	bh=BZgdWO7k4+OKLqpthfS5rJrQuQPttt/GmTiWB7L+cFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fIVoUSIJLeUwBgUctgZwSOSZiFI8bovhKesnzGIDJg72WHvXsfs+WdfnpXKZpV4CSc5qNpXDflWcsK4d3pqyTvz8cO3O75gSO4nnI8n1epyc01HsuZQBldfrdqaUn5QMNrjwSGN/adgK7vOqbzJoOSmDFyzPOEfz9FMT1A/F95U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8753152B;
	Tue, 25 Feb 2025 04:07:37 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 135943F6A8;
	Tue, 25 Feb 2025 04:07:18 -0800 (PST)
Date: Tue, 25 Feb 2025 12:07:16 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Message-ID: <Z72ydHCLxd-WGsJu@bogus>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <Z7jL5wBUJNjOlg4r@J2N7QTR9R3.cambridge.arm.com>
 <58ee2a8d-d3c1-4bc2-92dd-6568f645b01f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ee2a8d-d3c1-4bc2-92dd-6568f645b01f@arm.com>

Hi Mark,

Thanks for raising valid points/concerns.

On Mon, Feb 24, 2025 at 10:08:18AM +0000, Vincenzo Frascino wrote:
> Hello Mark,
>
> On 21/02/2025 18:54, Mark Rutland wrote:
> > Hi Vincenzo,
> >
> > On Fri, Feb 21, 2025 at 06:03:39PM +0000, Vincenzo Frascino wrote:
> >> The Morello architecture is an experimental extension to Armv8.2-A,
> >> which extends the AArch64 state with the principles proposed in
> >> version 7 of the Capability Hardware Enhanced RISC Instructions
> >> (CHERI) ISA [1].
> >
> > None of the CHERI stuff is supported upstream, so from upstream's PoV
> > this is a low-volume dev-board/SoC with an experimental ARMv8.2-A CPU.
> >

I understand and agree with your concerns.

>
> Agreed, I have no plans to upstream Morello support beyond the device tree.
>
> >> This series adds dts support for the Arm Morello System Development
> >> Platform.
> >
> > Do we actually need the dts for this board?
> >
> > I have one on my desk; it boots vanilla Debian 12 via UEFI + ACPI just
> > fine, with the Debian 6.1.0-13-arm64 kernel.
> >
> > Is there something that we can only do with the DT? i.e. some
> > functionality that isn't exposed via ACPI?
> >
> > How do you expect this DT to be used?
> >
>
> There are functionalities that are not exposed via ACPI, e.g. gpu, dpu, i2c for
> the phy, etc. My aim to have upstream support for all the hardware exposed by
> the platform.
>

Does this address some of your concerns ? I do understand some of these
are not well addressed in ACPI and hence people use DT as an alternative.

> Note: This series contains only the basic infrastructure, the plan is add
> progressively more features in the future.
>

I was thinking of queuing this in -next if all the bindings are acked.
Let me know if you still have concerns and would like to avoid getting
these merged. I will hold off then.

--
Regards,
Sudeep

