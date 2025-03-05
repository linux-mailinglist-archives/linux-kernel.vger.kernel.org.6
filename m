Return-Path: <linux-kernel+bounces-547265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59D9A5052E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFD6016ABCF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B93224EF6B;
	Wed,  5 Mar 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4Ut2cNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E6B19ABA3;
	Wed,  5 Mar 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741192687; cv=none; b=jrjMpNHQpXuQXr3+xaG+bt4Wb9m8NKWfMBL7sWmiyE3h6PKk+4MOwxrzPPpx4749fSy31tgJoho/L9JSlRTR7zpbX6nB67mV0hQ+lFkDc5u2q4uXXF4FNSjag9fYOIr4NZR+TjI6z9zlNREm2z9LfQX9AdGy7eLmWeAmADuCXas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741192687; c=relaxed/simple;
	bh=sL6HKnFMuXDXenCBceEoHD1TmQX+6oJO6AlNMpLGC5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slpxc8G5dNQD/rAfOueNKxhqYmfWVAmG4bXOI3So4rKmVBkbmsvNt1Uv/BC8oAHeT6zKrVtaNGgGf2m3xulbdnt+eUK9xintA1CpeCWTFfF0q9KBd5OMwHWiT8hfBQiLY5ew9IT79ME/EXvQKEUH9J9l1IxkFGxNSHXHyKve5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4Ut2cNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD7DC4CED1;
	Wed,  5 Mar 2025 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741192687;
	bh=sL6HKnFMuXDXenCBceEoHD1TmQX+6oJO6AlNMpLGC5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4Ut2cNzPxw/19HWcA9q6UtjX96+MvXtTOt/spQ3Kaa+W2/+8jLSKzmKdQfqq784h
	 iXyfpjwvj2pTl+oH/pXFQUSIATsV9GDQUrPpY1XGGg5K2Ec3lSimClooKk4ynyGvUT
	 r1PicB+2aVmGYeq5t8RYER35rZsdl0FcxkOhZOQIMiqVhIJjGkFPyBk/REwuohhG/d
	 euKrDtjZjx1dIMBrkGYX5ZMNE1iPMHZ8ZJuJ6YZr+yGG2ppJvpgHbjVU81Ljc4A8Cq
	 w+kRXk2NJVka0QLj05JGXMw/DRAN7bWAq46yGtSnJIxDDewUcFooFOLbAD+mTsOL1F
	 droruHgs3mybQ==
Date: Wed, 5 Mar 2025 10:38:05 -0600
From: Rob Herring <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
Message-ID: <20250305163805.GA2071011-robh@kernel.org>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
 <20250304152320.GA2630063-robh@kernel.org>
 <1891036.atdPhlSkOF@steina-w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1891036.atdPhlSkOF@steina-w>

On Wed, Mar 05, 2025 at 10:35:26AM +0100, Alexander Stein wrote:
> Hi,
> 
> Am Dienstag, 4. März 2025, 16:23:20 CET schrieb Rob Herring:
> > On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
> > > A DPI color encoder, as a simple display bridge, converts input DPI color
> > > coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> > > converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> > > bits in every color component though). Document the DPI color encoder.
> > 
> > Why do we need a node for this? Isn't this just wired how it is wired 
> > and there's nothing for s/w to see or do? I suppose if you are trying to 
> > resolve the mode with 24-bit on one end and 18-bit on the other end, you 
> > need to allow that and not require an exact match. You still might need 
> > to figure out which pins the 18-bit data comes out on, but you have that 
> > problem with an 18-bit panel too. IOW, how is this any different if you 
> > have an 18-bit panel versus 24-bit panel?
> 
> Especially panel-simple.c has a fixed configuration for each display, such as:
> > .bus_format = MEDIA_BUS_FMT_RGB666_1X18
> 
> How would you allow or even know it should be addressed as
> MEDIA_BUS_FMT_RGB888_1X24 instead? I see different ways:
> 1. Create a new display setting/compatible
> 2. Add an overwrite property to the displays
> 3. Use a (transparent) bridge (this series)
> 
> Number 1 is IMHO out of question. 

Agreed.

> I personally don't like number 2 as this
> feels like adding quirks to displays, which they don't have.

This is what I would do except apply it to the controller side. We know 
the panel side already. This is a board variation, so a property makes 
sense. I don't think you need any more than knowing what's on each end. 

> Number 3 actually describe the hardware connection. The only impact for
> software is to know which bus format it should use.

I'm not opposed to this, but only if it provides *something* that option 
2 does not. I'm not seeing what that is.

Node or not, either case needs a format property. We already have a 
variety of bus/pixel format related properties. I've rejected new ones 
because we need something common here that's flexible enough to handle 
any situation. That's either something that can describe any bit layout 
or something enumerating the formats (as MEDIA_BUS_FMT_* does). The 
former is hard to get right and there's always something else you can't 
handle. I'm not opposed to just reusing MEDIA_BUS_FMT_ if that works.

Rob

