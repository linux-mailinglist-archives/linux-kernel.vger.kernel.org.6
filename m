Return-Path: <linux-kernel+bounces-175932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B68738C2775
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7149B2871C1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACE717165B;
	Fri, 10 May 2024 15:11:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FCD12C526
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353859; cv=none; b=spcJwwY+OtAySS7bmQUMOezMWHrsvkRUd1AiXZeXkMZV4D5m/evcolgYOMis8AU2lNBU67d0GfZBSU4psKzxiqgtrpkEu6yKgMVH8477ygyFk6D/Ax04Q+SeIvYi0ulgYicfXM7RU0kKixhkO1LkhoQFblUuwHyu81UlHUlgSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353859; c=relaxed/simple;
	bh=F9XanCB2RN1Fdo7WFagHuE/HvG4YumF5Me9ofrePvAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxUy2yGU9Lts3rJmMtEZ7bAy2WW6niysCzMeQZp25APXfVuhm2fSF6r9OY3zcxYv8K9G4DuyQirD/nNhF5fqCzPP1rfrgCjaj8da66y8wyB8KOE1XcmMKQF6bbrqctVi38TzrPNj8Vqr0sYDN+4snAHImKxRbjDK/wIPfiJTfyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67AA2227A87; Fri, 10 May 2024 17:10:47 +0200 (CEST)
Date: Fri, 10 May 2024 17:10:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, tglx@linutronix.de, ming.lei@redhat.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Message-ID: <20240510151047.GA10486@lst.de>
References: <20240510141459.3207725-1-kbusch@meta.com> <20240510141459.3207725-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510141459.3207725-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Some people _really_ want to control their interrupt affinity.

So let them argue why.  I'd rather have a really, really, really
good argument for this crap, and I'd like to hear it from the horses
mouth.


