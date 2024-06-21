Return-Path: <linux-kernel+bounces-224489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427AB91230C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F103F28498B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C98495E5;
	Fri, 21 Jun 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gil2qews"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414A3172799;
	Fri, 21 Jun 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968205; cv=none; b=LjcaTHKQBFkyGpRLjF2Wcy/CP2T4ns8cMjkRkM+hxfh6LXrVFHsYOxG0Qrn6wGINdb+PwTo4UOyREdPaVCklhIwTzVksYXz1cWgNPY+g7NmMZj2pv90BiejEU5rr2HWd2iKHZrVuFW7txnL3Q3i/RXwrCxLzzlkl4okYd2ct6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968205; c=relaxed/simple;
	bh=+sBJX3KKg/gR5+auVGBo73xjnxGcJtdyCfJ+Jpk+s0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyiais6m1qVQ8lbxVT8Aqmkc/YYovKBH9Zn3ujMhrvgeW7gXxrMQPAyM1mMl56YHzfK+/uduCdpP7KzGo/u2l9xWYW/atinBZ/ruBtbmjVlaKo/YJH8Xn5JGvk6MdgFR4GledhENE+YgahyqBcoCAQ1LCjQzVir1za+y9hAmYdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gil2qews; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E32CC2BBFC;
	Fri, 21 Jun 2024 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718968204;
	bh=+sBJX3KKg/gR5+auVGBo73xjnxGcJtdyCfJ+Jpk+s0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gil2qews28H66rVvjMOyBQUib5fkVPt15UQDd/zhWJm0epvfs+YENLsA3W/VoO9Bk
	 FSQrvAttKNAu5O7zZet1BCmeetzO9yrVG974dOgnuAx+vrcJjf3zjVUAdfA3XbGtIC
	 Spa0gWA9SIlE+X+QK5KzdlD9bwjqfeEyTfxxyJtZGdqcH9UATun0DYnH795dA6ie/L
	 VlOe3nsm1HvsLm1xpinfOYCd8hASb1AdFQw7E91UIQ6f8CEhYL3fkqkfgsn67Efsxw
	 K31MFmG9V/FY4kaQvyDHC1OdJzabK5qYWB7YDnT8BhO1kLN+NsSkZBavEcQgipEWbR
	 1ilrd/Uvd4oFA==
Date: Fri, 21 Jun 2024 12:10:00 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
Message-ID: <20240621111000.GN1318296@google.com>
References: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>
 <20240620171756.GY3029315@google.com>
 <97b84ce1-3ed2-48a8-bed4-9a671b61cd6d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97b84ce1-3ed2-48a8-bed4-9a671b61cd6d@linaro.org>

On Thu, 20 Jun 2024, Krzysztof Kozlowski wrote:

> On 20/06/2024 19:17, Lee Jones wrote:
> > On Sun, 16 Jun 2024, Krzysztof Kozlowski wrote:
> > 
> >> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> >> children on resources acquired and managed by the parent, e.g. clocks.
> >> Extend the simple-mfd documentation to cover this case.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/mfd.txt | 13 +++++++------
> >>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
> >> index 336c0495c8a3..98b4340b65f3 100644
> >> --- a/Documentation/devicetree/bindings/mfd/mfd.txt
> >> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
> >> @@ -18,12 +18,13 @@ A typical MFD can be:
> >>  Optional properties:
> >>  
> >>  - compatible : "simple-mfd" - this signifies that the operating system should
> >> -  consider all subnodes of the MFD device as separate devices akin to how
> >> -  "simple-bus" indicates when to see subnodes as children for a simple
> >> -  memory-mapped bus. For more complex devices, when the nexus driver has to
> >> -  probe registers to figure out what child devices exist etc, this should not
> >> -  be used. In the latter case the child devices will be determined by the
> >> -  operating system.
> >> +  consider all subnodes of the MFD device as separate and independent devices
> >> +  akin to how "simple-bus" indicates when to see subnodes as children for a
> >> +  simple memory-mapped bus. "Independent devices" means that children do not
> > 
> > I'm not against the change, but I think it can be phased better.
> > 
> > Quoting the new part and going on to explain what you mean by it doesn't
> > flow very well.  Are you able to massage it so it reads a little more
> > nicely please?
> 
> Does this feels better?
> 
> compatible : "simple-mfd" - this signifies that the operating system
> should consider all subnodes of the MFD device as separate and
> independent devices, so not needing any resources to be provided by the
> parent device. Similarly to how "simple-bus" indicates when to see
> subnodes as children for a simple memory-mapped bus.
> 
> For more complex devices, when the nexus driver has to probe registers
> to figure out what child devices exist etc, this should not be used. In
> the latter case the child devices will be determined by the operating
> system.

Flows a lot better, yes.

Submit it and please include the original author this time.

-- 
Lee Jones [李琼斯]

