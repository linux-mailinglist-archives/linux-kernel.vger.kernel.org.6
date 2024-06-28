Return-Path: <linux-kernel+bounces-233406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8D491B6A8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8F92B23AA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 06:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3C94D8A5;
	Fri, 28 Jun 2024 06:03:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BD3EA86;
	Fri, 28 Jun 2024 06:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719554616; cv=none; b=qMO3i/lkT783H8ostisovfG7fNc3KtdP7E9azNWspbFOyBh2K0FresifmPlMw7FsLHs4FzZ/q1YM0LdD9MrRa5T3u6WJohgq8h53S62212CcaWo3kOOPfuLufoXRIvCyygReI+JD8woMWPg5Yfb3flnKWI2I0w5XaWvKgSsFX7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719554616; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBiTR2U/IhFXdJIhXLCAWg8jtNFSUqUc9lIWGLVJDoLcYYtz+nUDW0G9jx2d6mexdemWUhaJYhEDcd/WYF138Y3PUG2T2u8eIq42DFRMAqbBNJGX3EFk9eygh8MxWCDMU3VXxjGqLV/YffBRib9EUOuG9ULAsp5Wr2ktg52dvvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AC8768D05; Fri, 28 Jun 2024 08:03:32 +0200 (CEST)
Date: Fri, 28 Jun 2024 08:03:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Thomas Gleixner <tglx@linutronix.de>,
	Christoph Hellwig <hch@lst.de>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	Mel Gorman <mgorman@suse.de>, Hannes Reinecke <hare@suse.de>,
	Sridhar Balaraman <sbalaraman@parallelwireless.com>,
	"brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] lib/group_cpus.c: honor housekeeping config
 when grouping CPUs
Message-ID: <20240628060331.GC26297@lst.de>
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de> <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-isolcpus-io-queues-v2-3-26a32e3c4f75@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


