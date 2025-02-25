Return-Path: <linux-kernel+bounces-531323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB5A43F01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57ED73AAC0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6F267F48;
	Tue, 25 Feb 2025 12:14:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840BC20D4F4;
	Tue, 25 Feb 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740485679; cv=none; b=ChSStS3JPeyJWF0uZ+TfzInVUlI3vShwPEkyvekIdI5P+EIXGtVp8kMuYndtTGHHnB9oVrfN6X6w7Y6aWi+JGQsNgNG4nwX7EQUFEd4uaJtOp3Toa+OsFb8u0WGcJ3y2REdAp8/a0vupIptuauDJbI8q39UespJ5FqGh96ukT/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740485679; c=relaxed/simple;
	bh=NjO2UsCxHsCEuHAosznzavXIWUpuAab8MfW3uiAraUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFwOPeOoRrvibQCmIcnM9nEE+9yI5nLD58Qb/qFDlmSPK6JbFM+3zCXSWzfNtPIs3SErC/VS428bhAop9mgRexgE+krGP4Kv6NHxBnX2liQl30Y930I2m5LbasblAz3s9xZ9+FXhHslbxtbisADW6bg0+vLuRFS1zpS9JJ1zDPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06CB7152B;
	Tue, 25 Feb 2025 04:14:53 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1B463F6A8;
	Tue, 25 Feb 2025 04:14:33 -0800 (PST)
Date: Tue, 25 Feb 2025 12:14:31 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v7 00/10] arm64: dts: Add Arm Morello support
Message-ID: <Z720J5kXEnj5sZn0@J2N7QTR9R3>
References: <20250221180349.1413089-1-vincenzo.frascino@arm.com>
 <Z7jL5wBUJNjOlg4r@J2N7QTR9R3.cambridge.arm.com>
 <58ee2a8d-d3c1-4bc2-92dd-6568f645b01f@arm.com>
 <Z72ydHCLxd-WGsJu@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z72ydHCLxd-WGsJu@bogus>

Hi Sudeep,

On Tue, Feb 25, 2025 at 12:07:16PM +0000, Sudeep Holla wrote:
> On Mon, Feb 24, 2025 at 10:08:18AM +0000, Vincenzo Frascino wrote:
> > On 21/02/2025 18:54, Mark Rutland wrote:
> > > On Fri, Feb 21, 2025 at 06:03:39PM +0000, Vincenzo Frascino wrote:
> > >> This series adds dts support for the Arm Morello System Development
> > >> Platform.
> > >
> > > Do we actually need the dts for this board?
> > >
> > > I have one on my desk; it boots vanilla Debian 12 via UEFI + ACPI just
> > > fine, with the Debian 6.1.0-13-arm64 kernel.
> > >
> > > Is there something that we can only do with the DT? i.e. some
> > > functionality that isn't exposed via ACPI?
> > >
> > > How do you expect this DT to be used?
> >
> > There are functionalities that are not exposed via ACPI, e.g. gpu, dpu, i2c for
> > the phy, etc. My aim to have upstream support for all the hardware exposed by
> > the platform.
> 
> Does this address some of your concerns ? I do understand some of these
> are not well addressed in ACPI and hence people use DT as an alternative.

Yep; I'm happy with this so long as there's an actual functional reason
to have the DT, which it seems there is.

It would have been nice for that to be spelled out a bit clearer in the
cover / commit messages, but that's not important and doesn't need a
respin.

> I was thinking of queuing this in -next if all the bindings are acked.
> Let me know if you still have concerns and would like to avoid getting
> these merged. I will hold off then.

No need to hold off.

Sorry for the confusion; I should have been clearer with my questions.

Mark.

