Return-Path: <linux-kernel+bounces-548456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F99A5450D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 09:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A7A316829F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 08:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25962207DF5;
	Thu,  6 Mar 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeSbsgD7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8437A224FA;
	Thu,  6 Mar 2025 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741250316; cv=none; b=faNQUeJvFUk2Gicuum+DUW9u0EZj+ypc3POxWCJFX+HC1FB/a7MGQ1DxvtN2MsxC2/HFaAfbCoUPNW3/JSCPxmEt6rPH8rGtITfpeD12mxL7ACG2u0fLXuZBLAsPkNJ+x1/8kh3nU79wBik6EFDPJAnPOGa74IH5km2n5A1iHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741250316; c=relaxed/simple;
	bh=SVc8DKxbNt+l+FxYP2MLjnyozd9se439KWELWFr8Zyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODqxZxGKfrHekSTGbP5DS3yel4q9R8cRIDlUE2re+ygKUxj5PVlSuBB/1ZtQ7ewMYhsyBmdqX+0OjlMloBVDamfPKvfGMMJuL/GcDVMOaur8wHC/ZM+GGs6IVUncAp5J7ISxSDsQR/I2OfT4Qka8PHpuZMkfB79d9nkR6ZFO3eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeSbsgD7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DACC4CEE0;
	Thu,  6 Mar 2025 08:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741250316;
	bh=SVc8DKxbNt+l+FxYP2MLjnyozd9se439KWELWFr8Zyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LeSbsgD7wyHuMUS84+iH9lebnsQen3fmbxfxfkSaZKqdq/4bxSTNedS3mAO4fpa3b
	 ku0nLe+VmSIyCTXs3lGRgmphqyAco00SC6IkFsW5yWrfD6ERuRqV4N+KSSO7SMRsiZ
	 xdS8Ag4oFSpVewaSfYYSon7bH2K0u0gVP9dacK8R0G/xgAwGc1uL6mEI3Bxd6xuPYq
	 D1hco7zVUKbLp6PVgTynVuaseVPLcL35+SukkmNGslPV687nGp4F/d5y55myZrp7mR
	 yhRH8C+O5SXX7oYU6YAOE4sbu9feFGJL1WNx77PoL3iz3I6ed0pw2CBXThzab/cf4W
	 Jnd9Tf+eXCYRg==
Date: Thu, 6 Mar 2025 09:38:32 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dragan Simic <dsimic@manjaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] docs: dt-bindings: Specify ordering for properties
 within groups
Message-ID: <20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin>
References: <47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org>
 <166a7b77-74e3-40b7-a536-ee56850d9318@kernel.org>
 <f05919742c34f5d4489d2cd711c7736f@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f05919742c34f5d4489d2cd711c7736f@manjaro.org>

On Wed, Mar 05, 2025 at 10:53:48AM +0100, Dragan Simic wrote:
> Hello Krzysztof,
> 
> On 2025-03-05 10:36, Krzysztof Kozlowski wrote:
> > On 05/03/2025 09:45, Dragan Simic wrote:
> > > 
> > > diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst
> > > b/Documentation/devicetree/bindings/dts-coding-style.rst
> > > index 8a68331075a0..15de3ede2d9c 100644
> > > --- a/Documentation/devicetree/bindings/dts-coding-style.rst
> > > +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
> > > @@ -133,6 +133,12 @@ The above-described ordering follows this
> > > approach:
> > >  3. Status is the last information to annotate that device node is
> > > or is not
> > >     finished (board resources are needed).
> > > 
> > > +The above-described ordering specifies the preferred ordering of
> > > property
> > > +groups, while the individual properties inside each group shall use
> > > natural
> > > +sort order by the property name.  More specifically, natural sort
> > > order shall
> > > +apply to multi-digit numbers found inside the property names, while
> > > alpha-
> > > +numerical ordering shall apply otherwise.
> > 
> > The last sentence was not here and I don't get the point. Natural sort
> > order should be always preferred over alpha-numerical for properties.
> > About which other case ("...apply otherwise.") are you thinking?
> 
> Yes, I added that sentence in the v2 to, hopefully, clarify the natural
> sort order itself a bit.  I've researched the natural sort order a bit
> further, and it technically applies only to the multi-digit numbers found
> inside the sorted strings.  That's what I wanted to explain, and "shall

Natural sort applies to everywhere. It's just the same as
alpha-numerical sort for single digits.

> apply otherwise" refers to applying the alpha-numerical sort order to the
> remainders of the sorted strings, i.e. to everything but the multi-digit
> numbers found in the property names.

Sorry, still don't get. What would be the difference if for remainders
of properties you would also apply natural sort instead of
alphanumerical sort?

Best regards,
Krzysztof


