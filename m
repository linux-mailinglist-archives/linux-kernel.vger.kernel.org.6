Return-Path: <linux-kernel+bounces-425308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E019DC04A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24796B21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC60715B546;
	Fri, 29 Nov 2024 08:11:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73C158858
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867918; cv=none; b=ejCNMo5s/g0xlDlH2LewIjuyEkOEqTtxgw8o2wC9JC7AmxC9l21HubO8zRmJS3DwBbK3pFHihmZV34cvZA1w2xIQCqdffLvOOhlQi3RXrs7qPD5ReBYKo04V75V8zhcDqpXbIIjSvznt243yHUtbMtc6iUAkARZZxX4YAm01fnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867918; c=relaxed/simple;
	bh=Rw1t1Ia9sC57wYQPRh5d1DvmMRFOE79ShmbsA33ZNfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufaMBDgQ4FDrcI0kp42tH8JgDPJ4mlY7MdXEsM0Np0Ex4H4oZS11oti2PJ7DzSkIaC/hSjQr6HHH3LB0KUFT24UK4PxjLJoUhUDe4hDhdaJa5EqPo2CTlhYnMHmJHeVX2YlzUPypIJ0Fr1Agn3KSRkMCjbvS9jZWa1utYT4iN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06BFB68CFE; Fri, 29 Nov 2024 09:11:54 +0100 (CET)
Date: Fri, 29 Nov 2024 09:11:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] nvme-tcp: simplify
 nvme_tcp_configure_admin_queue()
Message-ID: <20241129081153.GD6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8282314c0d688f51be9f9ee90cd3463ff76baa1f.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 27, 2024 at 05:27:50PM +0800, brookxu.cn wrote:
> From: "Chunguang.xu" <chunguang.xu@shopee.com>
> 
> As nvme_tcp_configure_admin_queue() is the only one caller of
> nvme_tcp_destroy_admin_queue(), so we can merge nvme_tcp_configure_admin_queue()
> into nvme_tcp_destroy_admin_queue() to simplify the code.


Need a little fixing for the line length here in the commit message,
but otherwise looks good:


Reviewed-by: Christoph Hellwig <hch@lst.de>

