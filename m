Return-Path: <linux-kernel+bounces-420523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0789D7BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5305D163068
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727ED15F41F;
	Mon, 25 Nov 2024 07:25:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE5413CFA6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519538; cv=none; b=G2zgIq2VWv6ilIJzlvnP/RTQvyLTadsAJiLnRw+ZcFiH7tewEEeJupm4w9g5ELqvHatAapMlZaIMtL/BRA0WS1Y4EKjYsOaYCgWPZI5noxjI+FmT1WO7rrNKTd5ckbEXKG9Tv/IuKVVtCpb3nuKMh/hh/dqSH+Y6GbiuF6ZFSxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519538; c=relaxed/simple;
	bh=Pd+fkVGZdQrBOzXnoN6rUMnnNDd4xDgZ4UKgI4hoKpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxbpTQgf7kWH0FO7Is5eS87C+hGU08+GTnSjZ273ffaz18OCzus3wNU2t1YfMfK34B+8vqtazYXN3fngQYdS33317C+MglCSCFZ0KVasbTveer6BtLLVdc9S/0fQ4c6VkES3QMJ08wxAU323gRNEDfMV1tIYGZCDRtuv7pPsyeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB0B968D09; Mon, 25 Nov 2024 08:25:33 +0100 (CET)
Date: Mon, 25 Nov 2024 08:25:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] nvme-tcp: fix the memleak while create new ctrl
 failed
Message-ID: <20241125072533.GE15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fc0f971eccc72b7ff2b2ce176a7faa8828e487.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 23, 2024 at 09:37:41PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> Now while we create new ctrl failed, we have not free the
> tagset occupied by admin_q, here try to fix it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

but please add a Fixes tag and move it to the beginning of the series.


