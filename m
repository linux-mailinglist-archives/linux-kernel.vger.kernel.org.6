Return-Path: <linux-kernel+bounces-519701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6BAA3A0D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8893A4669
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EFC26B943;
	Tue, 18 Feb 2025 15:11:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666C326B2BF;
	Tue, 18 Feb 2025 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739891470; cv=none; b=aUpF/Ej7ovZlf6i+QARV2o2QZOqT7etfMmu9Ztt5xdO7E8VqoxNf+dFuySnMKM5t1z9N1YZHn1zn29Ay9nHBknGBx17XMrUdV1ZbW5KpkqXJiO6+fD86CTfYtICS0ku+vGszalaPO5mWK/UlxZfIIuDCSfvuQ+4gCifDkdRPALI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739891470; c=relaxed/simple;
	bh=FEnQfhgHSqo3Q7zro/Iiqg4tKjB4Eaf1e6s01EGT+o4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4FN98rmxS+N1tA9FdIbRAx1otB/AbreW/O+fkrNb2qIlLZFqEDiBtAX5e8F744i/1aKzPqdrrIavNYNkdHVLhiE75Thp1ZLed9wfDSF/HW5FKkyFVM2/Rb4CLlmEAsP325bdge1BZapsHnuwoeArU/+2rSpJnjvx7zpR/wTHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C2ED13D5;
	Tue, 18 Feb 2025 07:11:26 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA19D3F6A8;
	Tue, 18 Feb 2025 07:11:04 -0800 (PST)
Date: Tue, 18 Feb 2025 15:11:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/8] dt-bindings: arm: Add Morello compatibility
Message-ID: <Z7SjBWme-HhNYwtV@bogus>
References: <20250213180309.485528-1-vincenzo.frascino@arm.com>
 <20250213180309.485528-2-vincenzo.frascino@arm.com>
 <CACRpkda-J_NHC7Te=Shk0A-35qWms3xeM2MggdGM0ze3Gt0KMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda-J_NHC7Te=Shk0A-35qWms3xeM2MggdGM0ze3Gt0KMw@mail.gmail.com>

On Fri, Feb 14, 2025 at 11:38:54AM +0100, Linus Walleij wrote:
> Hi Vincenzo,
>
> thanks for your patch!
>
> On Thu, Feb 13, 2025 at 7:03 PM Vincenzo Frascino
> <vincenzo.frascino@arm.com> wrote:
>
> > Add compatibility to Arm Morello System Development Platform.
> >
> > Note: Morello is at the same time the name of an Architecture [1], an SoC
> > [2] and a Board [2].
> > To distinguish in between Architecture/SoC and Board we refer to the first
> > as arm,morello and to the second as arm,morello-sdp.
> >
> > [1] https://developer.arm.com/Architectures/Morello
> > [2] https://www.morello-project.org/
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/arm,vexpress-juno.yaml | 4 ++++
>
> I was thinking, that since the .dtsi and .dts files are not reusing
> any of the Juno .dtsi (correct me if I'm wrong!) this should not
> be in vexpress-juno.yaml, instead perhaps you should create a new
> morello.yaml file?
>

It is me who suggested to put it along with other vexpress stuff as I
wasn't sure how much of vexpress bindings will be reused here when
Vincenzo started this. I agree it can be a separate binding on its own
as I don't see much commonality now with the vexpress bindings.

Just a note, though the file is named arm,vexpress-juno.yaml, it also
carries bindings for all Vexpress based Arm Ltd boards(both 32-bit and
64-bit ones), but they all use common vexpress bindings in general.

I just thought of highlighting that so that the expectation to reuse
this file is not to check commonality in juno dtsi files but to check
the vexpress binding reuse. Hope we are aligned with that.

--
Regards,
Sudeep

