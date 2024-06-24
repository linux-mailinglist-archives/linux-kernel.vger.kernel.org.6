Return-Path: <linux-kernel+bounces-227089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1794B91482A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A183CB248E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EF4137914;
	Mon, 24 Jun 2024 11:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/SDMO1c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46544136E2B;
	Mon, 24 Jun 2024 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227462; cv=none; b=eYsdSK3T4+tx6HfrSkUVHBRnwEHeCKRC4jC1Yrv6BvA1dSxPJ5WRKtXw9E2K4CprPpjvQmX3so89lucTjJ57VLr/5Wy6Cnsyl2S5AGN1STSe5XteZAYRZpviUYq8kAAAfzLYKx2kosCSrqL661itcP3n3sOek10ckVeu/cykfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227462; c=relaxed/simple;
	bh=L8qkm8VIL7qDZsSm7A7x9r2fH9DJN684WVn1N5PSwcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/pzEY2T4hZ9RMGTb8sqGC4wOEkSO5w4cyhlMOPFtXSCePiSFpQgBJtLmgIgRw3OwVxDeDk0Vd4+uLcWAP6G6IvKSeOVZyPTp+glse4wL1IKqq6MHxGZEBKCdCfa303pngkIRl5RWvQjGdPWoxVOVr2SmW8sjjO1MEepMtw1/94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/SDMO1c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5D2C32782;
	Mon, 24 Jun 2024 11:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719227461;
	bh=L8qkm8VIL7qDZsSm7A7x9r2fH9DJN684WVn1N5PSwcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r/SDMO1ccZWCVvvZQ9T09NEeRNoNQZJ4iwAuambzy62k4HFjzjDodEjs9Z5bWH7wB
	 995ALrGDfi7eE1qjqB29C9pLGgmn/+Ik0qHtemQrXnTbm0EGOp0yV0GqZnDWitd8Ie
	 nHgjvrwvvWFJ4b8Exlp3fqonE1uGc1ZZ1F9sE5pl+ZHD4h9sC2H+esddOq7/jYC7by
	 92QGMuMVDDxDi+JrZZiXuteduDUTjSXQFbC73Ze/z9jotT3OnujPvEq6JRcDgbHsye
	 PnwVOjK4Rom5baVOH7jh1oFnKW4JaK1nWQLOJsTDOzM6May0oeicT89pPOxUZgXQb9
	 tcnbi+MoTW8EQ==
Date: Mon, 24 Jun 2024 12:10:57 +0100
From: Lee Jones <lee@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: Explain lack of child dependency in
 simple-mfd
Message-ID: <20240624111057.GR1318296@google.com>
References: <20240616080659.8777-1-krzysztof.kozlowski@linaro.org>
 <20240620171756.GY3029315@google.com>
 <97b84ce1-3ed2-48a8-bed4-9a671b61cd6d@linaro.org>
 <20240621111000.GN1318296@google.com>
 <b078d8de-78f4-4125-8971-d76f354c7b30@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b078d8de-78f4-4125-8971-d76f354c7b30@linaro.org>

On Sun, 23 Jun 2024, Krzysztof Kozlowski wrote:

> On 21/06/2024 13:10, Lee Jones wrote:
> > On Thu, 20 Jun 2024, Krzysztof Kozlowski wrote:
> > 
> >> On 20/06/2024 19:17, Lee Jones wrote:
> >>> On Sun, 16 Jun 2024, Krzysztof Kozlowski wrote:
> >>>
> >>>> Common mistake of usage of 'simple-mfd' compatible is a dependency of
> >>>> children on resources acquired and managed by the parent, e.g. clocks.
> >>>> Extend the simple-mfd documentation to cover this case.
> >>>>
> >>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/mfd/mfd.txt | 13 +++++++------
> >>>>  1 file changed, 7 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
> >>>> index 336c0495c8a3..98b4340b65f3 100644
> >>>> --- a/Documentation/devicetree/bindings/mfd/mfd.txt
> >>>> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
> >>>> @@ -18,12 +18,13 @@ A typical MFD can be:
> >>>>  Optional properties:
> >>>>  
> >>>>  - compatible : "simple-mfd" - this signifies that the operating system should
> >>>> -  consider all subnodes of the MFD device as separate devices akin to how
> >>>> -  "simple-bus" indicates when to see subnodes as children for a simple
> >>>> -  memory-mapped bus. For more complex devices, when the nexus driver has to
> >>>> -  probe registers to figure out what child devices exist etc, this should not
> >>>> -  be used. In the latter case the child devices will be determined by the
> >>>> -  operating system.
> >>>> +  consider all subnodes of the MFD device as separate and independent devices
> >>>> +  akin to how "simple-bus" indicates when to see subnodes as children for a
> >>>> +  simple memory-mapped bus. "Independent devices" means that children do not
> >>>
> >>> I'm not against the change, but I think it can be phased better.
> >>>
> >>> Quoting the new part and going on to explain what you mean by it doesn't
> >>> flow very well.  Are you able to massage it so it reads a little more
> >>> nicely please?
> >>
> >> Does this feels better?
> >>
> >> compatible : "simple-mfd" - this signifies that the operating system
> >> should consider all subnodes of the MFD device as separate and
> >> independent devices, so not needing any resources to be provided by the
> >> parent device. Similarly to how "simple-bus" indicates when to see
> >> subnodes as children for a simple memory-mapped bus.
> >>
> >> For more complex devices, when the nexus driver has to probe registers
> >> to figure out what child devices exist etc, this should not be used. In
> >> the latter case the child devices will be determined by the operating
> >> system.
> > 
> > Flows a lot better, yes.
> 
> Sure.
> 
> > 
> > Submit it and please include the original author this time.
> 
> Everything is scripted, so you ask me for additional, manual steps just
> to find the author and then Cc-them. I'll do it but it would be much
> easier if the interested party added themself as reviewer or maintainer
> of the binding.

How you set-up your tooling is your business.  =;)

Who to Cc is often situation dependent, some of the semantics you'd find
hard to script.  `scripts/get_maintainer.pl` provides some helpful
arguments (e.g. --git-min-percent 75) which seem to work a lot of the
time.

In this particular case, you're making heavy changes to a passage of text
which someone has taken the time to craft.  Adding them to the
conversation should be seen as a common courtesy.

-- 
Lee Jones [李琼斯]

