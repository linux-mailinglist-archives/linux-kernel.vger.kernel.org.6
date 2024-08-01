Return-Path: <linux-kernel+bounces-271362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60237944D38
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F911F22352
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD9C1A0728;
	Thu,  1 Aug 2024 13:34:02 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46CA16DECD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519242; cv=none; b=fguM6MvghRjMvCKANRdMaDaeKPk2Js/4izNE0+9nSemexvj0USZEBsdegw7kIv1sJaua7uaOoZggnU8EpfN/uA9gkjcXSjuwIWB/sf2gGJFPB4peSI0Jf066X9ypCol2reBZ6Eir1fqH3Hvt6m8U4afPWN2qOWiggmuNM2OAsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519242; c=relaxed/simple;
	bh=Gy2xjS18iAkuVybjbqW5d0pU1TCukawNQV3tJdkSI6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+PYEr5+npgPIBQU2f11oHPiOur2pKQzfBvbIZxVlNEMpHhj2GEdav0fpJUf0Abqy/jRj78PEHKsjg22rUABLLD0gUCkVjK38kaqTolIFi9ZLfnIDIieTL5sEmAfUELQyQyJK5bhvrSlbjeYIqXb29HMSi0lABDU8DSbv/KGfs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id BDEB368D0A; Thu,  1 Aug 2024 15:33:53 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:33:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dma-mapping: don't return errors from
 dma_set_seg_boundary
Message-ID: <20240801133353.GA1846@lst.de>
References: <20240723000604.241443-1-hch@lst.de> <CGME20240723000611eucas1p10986fd51e848a1ee948e71608c26192b@eucas1p1.samsung.com> <20240723000604.241443-3-hch@lst.de> <5895603b-945f-4b05-991c-76b590094354@samsung.com> <d54f486d-36ae-4668-b314-27137bc4d832@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d54f486d-36ae-4668-b314-27137bc4d832@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Aug 01, 2024 at 01:36:01PM +0100, Robin Murphy wrote:
> I guess I assumed that the old block layer bodges in this area had been 
> cleaned up already - perhaps it *is* high time for whatever's left to grow 
> a proper understanding of whether a block device actually does its own DMA 
> or not.

Can you point to a discussion on that?  The concepts here don't make
quite sense to me.


