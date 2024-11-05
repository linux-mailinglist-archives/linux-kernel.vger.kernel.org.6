Return-Path: <linux-kernel+bounces-396640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4200D9BCFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06692282EB3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA621D9A71;
	Tue,  5 Nov 2024 14:59:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499EC1D9588
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818743; cv=none; b=UMDda6iyQA6P49kaxHYAoKaqBZlZUsIDTlUkpXOo4U/++p10y0QqBXcHhKSBKG3Byyelfih/pLlgaWaWNUvip5MFfGdhPwxqfTBeVgHd0h9YJtlUalOsO9xaj1xCZa2kpIla+glYDU3EpyYBprPNkdof9Ol6u0V4dCq+D+G5TS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818743; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uO78uz0ZdlI4I/R6NWOvhpW5TGkGxt9c5oG1QPxIgNMFTGKTtjYopfZMlyQaPd0fNJyuNSfXsjoTyLEhb9FBxK8fWOsp3cdtX+8rpvh4gzL7wOly+nYZJ6g4oeHkhCNajoLL2A6jQWnyhoxVvP49CrF2ppoLe/ir/nk6vus1prU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE9FE68C7B; Tue,  5 Nov 2024 15:58:56 +0100 (CET)
Date: Tue, 5 Nov 2024 15:58:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
Message-ID: <20241105145856.GA6583@lst.de>
References: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


