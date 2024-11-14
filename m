Return-Path: <linux-kernel+bounces-408730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631359C82D4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 06:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 195A51F22D07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 05:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294B81E7C2A;
	Thu, 14 Nov 2024 05:55:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245AA54723
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 05:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731563750; cv=none; b=KvD2UKEK6rwhxBS4eLXmfh3LA+1/BeBgaWW8dy45vlO7Rumcb0Hu7DWe+9kNwrT9noEERpTvWsLjxfG7hwiNF2+cOqou+bS/Dn4vEWU8e0Rp2rZ3YSeiWy5qGBu/skiEswdCmzCz9QPWrTa+wbLppL0NHf4sXGQxHrz8cHUt1pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731563750; c=relaxed/simple;
	bh=1fjbd+1ScPFuNyIKg2k7FiPC7zc2roK++6Yb3Zo0Il0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXmfbpA9BjGt/BsCCzCbaQjmmEpQAYTa6Oy+mBxSn03xofYpholGjdSVzX/7AQ25vv7ffISyBf0j83rF3inccgmvqRsWWK0dAOkntAI5tzrROoaNXpL2TFEFQ5Rr+5KkPFhB02ydus9CyQosmohORLnAMPoN9BIyGcXReuCPspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0AE5068C7B; Thu, 14 Nov 2024 06:55:45 +0100 (CET)
Date: Thu, 14 Nov 2024 06:55:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Bob Beckett <bob.beckett@collabora.com>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	kernel@collabora.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241114055544.GA10948@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241113043151.GA20077@lst.de> <ZzTqgXqjN4UrT392@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzTqgXqjN4UrT392@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 13, 2024 at 11:05:53AM -0700, Keith Busch wrote:
> Well, he's doing what I suggested. I thought this was better because it
> puts the decision making in the initialization path instead of the IO
> path.

I guess it's fine in that regard.  It just usually expect patch
authors to at least reply to reviews..

