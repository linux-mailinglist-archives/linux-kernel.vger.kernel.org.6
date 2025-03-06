Return-Path: <linux-kernel+bounces-549810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75316A55780
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A077D173830
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1BB2702CD;
	Thu,  6 Mar 2025 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/k6vPYS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAAE249E5;
	Thu,  6 Mar 2025 20:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741293286; cv=none; b=kvWu4WZDPq3IOs3DaR0tAJEsCRoMCvtY8azny2LFOZWvTAzgYRlDGJW0EeAujiOmDmrSuZ9j9sK/VcxuhggElnwLA7O6RXi855Ap0+E//+I864UDDfY+mMJhvM5s6yc0rxbHVOSRWr0cDayjD+Ucci28Meaffmz2BF9lhl0FHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741293286; c=relaxed/simple;
	bh=fEVqDpO/35p9tPuJm0FDXst+QSbIafm5kupIMkvxhnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcUNmBp/AUDnhCPnE//QTX/H9fXq8LDCf8nqm1oY6en8AITUbMud/Me55dD2BHgUEQCd3L31nl9XtSuL38e2PHLV9ICwPncxj7hxSiUrueV820vuV1ngBcqwDdZJV5g3fD7FIjxJIpWuKout1d/YpdzzL+eec/i6j8pU78PmH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/k6vPYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261BBC4CEE0;
	Thu,  6 Mar 2025 20:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741293286;
	bh=fEVqDpO/35p9tPuJm0FDXst+QSbIafm5kupIMkvxhnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/k6vPYSqWwRQhS7/u2j8QqVXHeuWI04eHC5KytFd2rzRfGsd7eMdaAsMibXVP2+d
	 3B1GpEA50uo8ieggb/YjUxeowxQVSFaMLIrjvxkT1k0pbYkkFOuidxM/FVO1NmbEuC
	 1G82vpWUsAwohCSOW1ZzXlzzm8ihnJeMnnFQJ+DM/K84Ohw2lFJ9NnOSnXDbWp5HD9
	 gw2sCUt9p6GcIeBs401NZqj0Hd9nZpa/HKyP3ymDlmw3O/GgzaYqBquk1BOKoyH4WT
	 eY1n2Dduk1IQrA0FRVSpwI2rJKVYDvXNgVDpxm11dQtlaa2UXA7NbWf4U2QxcqPAWv
	 BEYm9LTCCQQBw==
Date: Thu, 6 Mar 2025 14:34:44 -0600
From: Rob Herring <robh@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [PATCH 3/5] dt-bindings: display: simple-bridge: Document DPI
 color encoder
Message-ID: <20250306203444.GA570402-robh@kernel.org>
References: <20250304101530.969920-1-victor.liu@nxp.com>
 <20250304101530.969920-4-victor.liu@nxp.com>
 <20250304152320.GA2630063-robh@kernel.org>
 <1891036.atdPhlSkOF@steina-w>
 <20250305163805.GA2071011-robh@kernel.org>
 <7d98163d-10c8-457d-92e7-6a1d6e379beb@nxp.com>
 <20250306-kangaroo-of-pastoral-typhoon-8aefb2@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250306-kangaroo-of-pastoral-typhoon-8aefb2@houat>

On Thu, Mar 06, 2025 at 12:35:49PM +0100, Maxime Ripard wrote:
> On Thu, Mar 06, 2025 at 03:02:41PM +0800, Liu Ying wrote:
> > On 03/06/2025, Rob Herring wrote:
> > > On Wed, Mar 05, 2025 at 10:35:26AM +0100, Alexander Stein wrote:
> > >> Hi,
> > >>
> > >> Am Dienstag, 4. März 2025, 16:23:20 CET schrieb Rob Herring:
> > >>> On Tue, Mar 04, 2025 at 06:15:28PM +0800, Liu Ying wrote:
> > >>>> A DPI color encoder, as a simple display bridge, converts input DPI color
> > >>>> coding to output DPI color coding, like Adafruit Kippah DPI hat[1] which
> > >>>> converts input 18-bit pixel data to 24-bit pixel data(with 2 low padding
> > >>>> bits in every color component though). Document the DPI color encoder.
> > >>>
> > >>> Why do we need a node for this? Isn't this just wired how it is wired 
> > >>> and there's nothing for s/w to see or do? I suppose if you are trying to 
> > >>> resolve the mode with 24-bit on one end and 18-bit on the other end, you 
> > >>> need to allow that and not require an exact match. You still might need 
> > >>> to figure out which pins the 18-bit data comes out on, but you have that 
> > >>> problem with an 18-bit panel too. IOW, how is this any different if you 
> > >>> have an 18-bit panel versus 24-bit panel?
> > >>
> > >> Especially panel-simple.c has a fixed configuration for each display, such as:
> > >>> .bus_format = MEDIA_BUS_FMT_RGB666_1X18
> > >>
> > >> How would you allow or even know it should be addressed as
> > >> MEDIA_BUS_FMT_RGB888_1X24 instead? I see different ways:
> > >> 1. Create a new display setting/compatible
> > >> 2. Add an overwrite property to the displays
> > >> 3. Use a (transparent) bridge (this series)
> > >>
> > >> Number 1 is IMHO out of question. 
> > > 
> > > Agreed.
> > > 
> > >> I personally don't like number 2 as this
> > >> feels like adding quirks to displays, which they don't have.
> > > 
> > > This is what I would do except apply it to the controller side. We know 
> > > the panel side already. This is a board variation, so a property makes 
> > > sense. I don't think you need any more than knowing what's on each end. 
> > 
> > With option 2, no matter putting a property in source side or sink side,
> > impacted display drivers and DT bindings need to be changed, once a board
> > manipulates the DPI color coding.  This adds burdens and introduces new
> > versions of those DT bindings.  Is this what we want?
> 
> There's an option 4: make it a property of the OF graph endpoints. In
> essence, it's similar to properties that are already there like
> lane-mapping, and it wouldn't affect the panel drivers, or create an
> intermediate bridge.

Yes, that's actually where I meant to put the property(ies).

Rob

