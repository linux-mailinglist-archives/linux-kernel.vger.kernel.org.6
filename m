Return-Path: <linux-kernel+bounces-420522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5189E9D7BED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5751B22130
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E926E15F41F;
	Mon, 25 Nov 2024 07:24:04 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C542143722
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519444; cv=none; b=XZgumQR19IeMwRz3rj0/fehYL04Ed1im0aLGBIWeLLFrKxoqUZxgSPdZ31mQZX0spU7npEGi+aPUuflGnw/VGDpOK64iyqu6QrIT1J5j12PDGGLIkNg19h6zJ1muvyDFmUi7qImq3diVTSh2sVrY8zfN3u7LP5eX56Axs7sMzJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519444; c=relaxed/simple;
	bh=SWwmgaez+aHwgSkIkthaMB8Bljq3RCA6VG+IJh9VT2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgG5fiKZcAYwL5+8p+5obXeY0iSGBP+ScQ8sN3zJjVJwbTLTX2AyUuO6rqm7z6zrqkE9WDXvhaAOFuFDIrOqtkEtK9LRaawcuPHQA27h4UcnkSSaFFLun8PH6UgcOYb97vf5zQFaB+DGRvVKRx+l/sB2DxX8ZOlpS8xrYo+x4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 54DF668D09; Mon, 25 Nov 2024 08:24:00 +0100 (CET)
Date: Mon, 25 Nov 2024 08:24:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <20241125072400.GD15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5afd7d60a07afc6f299aba8c31fe87e00484da5b.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 23, 2024 at 09:37:40PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now maybe we can remove nvme_tcp_destroy_io_queues() to simplify
> the code and avoid unnecessary call of nvme_tcp_stop_io_queues().

Please split the behavior change from the cleanup, and explain why
the behavior change is fine and desirable.


