Return-Path: <linux-kernel+bounces-520537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C0EA3AB36
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 22:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 429993A300E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F41CAA73;
	Tue, 18 Feb 2025 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FdNP8HF7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC2814BF8F;
	Tue, 18 Feb 2025 21:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914745; cv=none; b=TDEE5fGjXE5FKwLaUK0Z3FwpiKiWgnxegTzQEM9w2iZ4tINwZb4uoOof/kbkfj4Kb2sTP/p76tqzFeebWqvuHwH+sSktrTMr+QdSDwFeShc2NxW2zC2JovxQX4HJE0YX7wXin0UyvaAz3KIHNX482r4M23DU10WPAc/A8GKc7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914745; c=relaxed/simple;
	bh=y27wX8vWpKgnYWddqTGYwQR4K1r03gutos/Zex7AhL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1nUep+EnpkiyGhBNqCM8sB6LGiDJEzAzx0BZy39Vj3dJaoLEub5ElkMm6pvo0wsX+1Ffq08ImWyD9PVHfxSpMospnW7Qumy7YPkQxE9JfD/tewmaJKrEalqK7mp6/m8+cV2xVzptYTu8TQ++VVnp66va/t5H48x8GDeYYlFBa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FdNP8HF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC25C4CEE2;
	Tue, 18 Feb 2025 21:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914744;
	bh=y27wX8vWpKgnYWddqTGYwQR4K1r03gutos/Zex7AhL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FdNP8HF7uFB3J37nEtpFvf5FG33uwBaNeA1rWL5b42Iqed3vsaB8OcGv0wVf+SRvo
	 cwDoP52dfO2koaQfiTEtqQXoO2PokOmL2KqGVo+rf/NT6Vochjfc7sgKZlS1dMR/W5
	 Ankl8KpvENeT6VEEBVjc8SkKbN8lRCURoVXQ9LseWzHI8qW8jFXMMmdxjL5lq/3PYJ
	 U/6UUdMTkF9OsGiZbbzf6+Pkioz0EFgmVYxlC9fyy3D1sA2ZMSFCfREsY8amAf0SQP
	 AUJsIjPKlWNBQI9zdBraZacFWdLnghsSHfZG1/hQWdng72wFdKHfm43m5W5GlUUFXP
	 BkBfd1rICSbew==
Date: Tue, 18 Feb 2025 15:39:03 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, richard@nod.at,
	vigneshr@ti.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
Message-ID: <20250218213903.GA1203860-robh@kernel.org>
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
 <20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
 <20250211212928.GA1188800-robh@kernel.org>
 <87r043r2lq.fsf@bootlin.com>
 <20250212160659.GA3883406-robh@kernel.org>
 <874j0zqgps.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874j0zqgps.fsf@bootlin.com>

On Wed, Feb 12, 2025 at 05:18:39PM +0100, Miquel Raynal wrote:
> On 12/02/2025 at 10:06:59 -06, Rob Herring <robh@kernel.org> wrote:
> 
> > On Wed, Feb 12, 2025 at 09:25:53AM +0100, Miquel Raynal wrote:
> >> Hi,
> >> 
> >> >> The partitions that gets created are
> >> >> part0_0
> >> >> part1_1
> >> >> part0_1-part1_0-concat
> >> >
> >> > 'part-concat' doesn't work if you have multiple sets of partitions you 
> >> > want to concatenate.
> >> >
> >> > I think you need something like 'prev-partition' or 'next-partition' in 
> >> > the partition nodes to create a linked list of partitions. Hopefully, 
> >> > you don't need both properties, but you do have to scan everything to 
> >> > figure out which ones are concatenated or not. For example, no property 
> >> > can mean not concatenated or last partition if you use 'next-partition'. 
> >> 
> >> Out of curiosity, would the chosen node be eligible as a central place
> >> where to look at?
> >
> > Why would you need that?
> 
> I'm talking about storing in a central place all the concatenated
> partitions. Your proposal with "next-partition" works fine if we locate
> it inside the 'partitions' node, but I feel like the 'part-concat'
> instead was not fitting very well there. So I was wondering in this case
> if moving the concatenation of the partitions would be eligible to the
> chosen node, or if that's reserved to *very* few properties (and should
> remain like that).

You would have to solve the same problem as this patchset which is how 
to support N sets of concatenated partitions.

In general though, we add new things to /chosen very carefully. It's 
usually "things the bootloader configured/enabled" which I don't think 
this qualifies as. 

Rob

