Return-Path: <linux-kernel+bounces-511444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53813A32B22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996F81883675
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5E210F59;
	Wed, 12 Feb 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTrhUs0y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4985F1EC011;
	Wed, 12 Feb 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376421; cv=none; b=TRbCNRicRyeuYk/TslxbS8EIz//QUaGe9YIcokbXpySKLFHZDkdei8lp9rY9LuHJMs5pCF+HaCihoLgAj906gAmsVN+cbM53oMQfkGNVaz/J2XMD+OxB8maPzWQCzoWmtUeEfrhwV9djM4FOIMh6zw1EvE+A6VOkk8uAF2qF1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376421; c=relaxed/simple;
	bh=DtovoddXJ18poDRZ4vbP7OjpbXwDBro1r4lUquhEprQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHUOG7ohTKaqsldRRaHGp6MmAAb/47iVhkMnlDR5DFmAsV8A7+VGI2lAqLM8b396SqvsWhv03pNOkVjGzOVR5M0/A9aCait0MHVc12vMsDBZ1AjSl1w4a9bmKV+X1glbMlHIN7OyDOtRj5OFG0+LU3OYi7PanL9DaqIxl/JYxDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTrhUs0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7F8C4CEDF;
	Wed, 12 Feb 2025 16:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739376420;
	bh=DtovoddXJ18poDRZ4vbP7OjpbXwDBro1r4lUquhEprQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTrhUs0yFCO8s6nTGOWuKDRgvVsSeU/uokg+mhSj3yP0lbJlJuG+nXNyjlZA85rca
	 QHns45dGnZTjymwwTfONn2w6RfUCjxkpw4YEkGadzfzFAl9OuDAEw+BckrE1ixOu5L
	 aF6h7ha3q4tZvQ/+BLtlrPyVHINGBiOf61oBok+D9FNEUuv/o5D/WBO5oqwhWdZ4Ag
	 mbmN7wArkjTc/wWwCw9OtnT3PpdlHv5l/69iWVO8KY6B7SmeXfVHbFtSxHsde6iFiI
	 mGYtaqNEjcaIwYCb/oD7plsL3TayoYssJSP5mdVQ49zZ40/TUhkuEfO7Djkbnwliob
	 XOtFNqW5JX02g==
Date: Wed, 12 Feb 2025 10:06:59 -0600
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, richard@nod.at,
	vigneshr@ti.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, git@amd.com, amitrkcian2002@gmail.com
Subject: Re: [PATCH v12 1/3] dt-bindings: mtd: Describe MTD partitions
 concatenation
Message-ID: <20250212160659.GA3883406-robh@kernel.org>
References: <20250205133730.273985-1-amit.kumar-mahapatra@amd.com>
 <20250205133730.273985-2-amit.kumar-mahapatra@amd.com>
 <20250211212928.GA1188800-robh@kernel.org>
 <87r043r2lq.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r043r2lq.fsf@bootlin.com>

On Wed, Feb 12, 2025 at 09:25:53AM +0100, Miquel Raynal wrote:
> Hi,
> 
> >> The partitions that gets created are
> >> part0_0
> >> part1_1
> >> part0_1-part1_0-concat
> >
> > 'part-concat' doesn't work if you have multiple sets of partitions you 
> > want to concatenate.
> >
> > I think you need something like 'prev-partition' or 'next-partition' in 
> > the partition nodes to create a linked list of partitions. Hopefully, 
> > you don't need both properties, but you do have to scan everything to 
> > figure out which ones are concatenated or not. For example, no property 
> > can mean not concatenated or last partition if you use 'next-partition'. 
> 
> Out of curiosity, would the chosen node be eligible as a central place
> where to look at?

Why would you need that?

Rob

