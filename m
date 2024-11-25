Return-Path: <linux-kernel+bounces-420519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D97739D7BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A434B217D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB46184551;
	Mon, 25 Nov 2024 07:23:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C59F1426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519383; cv=none; b=LR4x4G3OCAFeXxBV7jPm3tW/s7P/3JUa1M3HNidD7Z/6+wxVlDCIMG8J1INtxxo5LomQX2ky4SyujVXwawlp4hx4ZWgjaGYGxjepc6qVcegjry2muceA0rdjRyf1rT/pyDNxLaeGa8HTCt+yx1DMW1kc6rBubwXSpKwWF+TVe1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519383; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7PiZHPvNhAHcCZ3vIkeV2FY0twPxj0JqpeV/x4EJ8y2lrsRCzdC1zK7CxLDchkdxU9FyW6hpm/LwO/lkM9cEXhqSPs1/ARRh0ZKBtSqUW7OGpiBiWy5LSFcZhrfAVkfjb18l5AzD6JRJ/0jXkSUhs1iA5Pw24/QxCQkHc+aItQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8CA568D09; Mon, 25 Nov 2024 08:22:58 +0100 (CET)
Date: Mon, 25 Nov 2024 08:22:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Message-ID: <20241125072258.GC15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


