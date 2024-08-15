Return-Path: <linux-kernel+bounces-288520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5086953B35
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 22:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6018D1F24D18
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 20:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2077146016;
	Thu, 15 Aug 2024 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmtcv5kg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A21459F9;
	Thu, 15 Aug 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752004; cv=none; b=G4N5Ds/qJkpHhVK/ve2pXMMc5uERE1LKa5Y1gXWNghN3/0A03IC9tul6jjAXj90qVQsUpHvpfO9eJTjhFpR9jYEO3Du1PAZHmfV1jthmfGi+w5E20YJi4aihC+55FSYdTb41Up4c4bvIZ6PyXUhKCGBxEFcWOOcbOEDD+sBoaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752004; c=relaxed/simple;
	bh=4RgSn9Z+qFS3Hc+SCCKD41kR9cnrKaI24LPgVaCeHtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBfoovSWifmSnDhZioXUR658v60sdxl5dj2yvIkipvsVA6qTxR1+cRmIPVOXxr34jkADQZs7+De1zzzN4gz1fAhm67iiDvG8xESaAhJ59CKE0IUA84CRqGCxFjhIfgR3xvq1RfzQ0O5d1yTFyhYcGX2SalsDLBd1Q0EYak+mj2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmtcv5kg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25C5C32786;
	Thu, 15 Aug 2024 20:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723752003;
	bh=4RgSn9Z+qFS3Hc+SCCKD41kR9cnrKaI24LPgVaCeHtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmtcv5kgQ8j/ajfOyRN3tVSYYQsdOYM5pTLNCCAPYjDLr9UKmHWeSrbQPd7Whr1zC
	 hFTaMwOxYtYtMZ2kFK5g7kMHGHlKqdsP2/FyUiw5LBWp/XzObvMvx7+zWPfVFTFM0X
	 GelyiAclavDa0ZRuNtQwU0Vup2IQMYFd0meWjEQJrgiu9h3XHLMClb4B3JuHCSQ8d7
	 XhtPJ0t6TWlrTJWIIqxfNgZTnwAZS7TsedmowRb5JUePInqwcH/TmAME4rzQiT1OiP
	 R3ngC1Hu3x7ne+wTGdZWQGon341UvTRx8J4ZOYNsVLD1y5rISfTrjA/hhxfvOgn8Vt
	 oHNALn2oYC+Sw==
Date: Thu, 15 Aug 2024 14:00:03 -0600
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the two
 simple-mfd syscons on PolarFire SoC
Message-ID: <20240815200003.GA2956351-robh@kernel.org>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-pending-sacrifice-f2569ed756fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-pending-sacrifice-f2569ed756fe@spud>

On Thu, Aug 15, 2024 at 03:01:09PM +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> There are two syscons on PolarFire SoC that provide various functionality of
> use to the OS.
> 
> The first of these is the "control-scb" region, that contains the "tvs"
> temperature and voltage sensors and the control/status registers for the
> system controller's mailbox. The mailbox has a dedicated node, so
> there's no need for a child node describing it, looking the syscon up by
> compatible is sufficient.
> 
> The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> interrupt controller and more. For this RFC, only the reset controller
> child is described as that's all that is described by the existing
> bindings. The clock controller already has a dedicated node, and will
> retain it as there are other clock regions, so like the mailbox,
> a compatible-based lookup of the syscon is sufficient to keep the clock
> driver working as before so no child is needed.

I'm confused. The reset controller is reused from somewhere else? I 
thought you didn't expect any reuse of the IP happening. If a child node 
makes it possible to enable the h/w without any s/w changes, then that 
is a compelling argument for having a child node.

> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> (I'll split this in two later, it's just easier when I have the same
> questions about both...)
> 
> Are these things entitled to have child nodes for the reset and sensor
> nodes, or should the properties be in the parent and the OS probe the
> drivers for the functions? That's something that, despite supposedly
> being a maintainer, I do not understand the rules (of thumb?) for.

Besides the is it an independent, reusable IP block test, my test 
generally is do the child nodes have their own DT resources? Say 
you have phy registers mixed in some syscon and clocks which only go to 
the phy. Then a child node with "clocks" makes sense. If your only 
property is #phy-cells, then a child node doesn't make sense. Of course 
you could reach different conclusions based on the completeness of the 
binding.

> 
> Secondly, is it okay to make the "pragmatic" decision to not have a
> child clock node and keep routing the clocks via the existing & retained
> clock node (and therefore not update the various clocks nodes in the
> consumers)? Doing so would require a lot more hocus pocus with the clock
> driver than this series does, as the same driver would no longer be
> suitable for the before/after bindings.

In the 2 cases here, I don't think you need child nodes. I would expect 
pinctrl to have one though if only as a container for all the pinctrl 
child nodes.

Rob

