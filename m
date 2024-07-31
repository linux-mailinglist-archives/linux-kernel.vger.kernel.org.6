Return-Path: <linux-kernel+bounces-269516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01A9433B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907C51F28BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996911BBBF3;
	Wed, 31 Jul 2024 15:53:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA91AD9FE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441196; cv=none; b=gWH+KzYE8Q1aHM+fRwpQiio+g5nVqs6kdnhOfAEXKxL0r4Zey7AXcF4kj5GITfpojG7dcfd7X8iznEko81RNGKjOaz4Z6lG04RJLsgkLbL1uoqs8wYdlksXifwr5lw1gdD5YbOncwfX7iGrp0qiVXPb8g8Qtt+HUPguIg5hiXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441196; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mp8ldDuLDNFW9sShd+qn8hNk53j63HjCO5tsqUypb6xECEQLgmUGu76Gsb2BofRx+bfMjJCtDxT92Fy3wlAaR7aJ4ccXxyE8NJn8cQ7mrNBLX7XDcYzTIjEgA6Z3qdPKr5OyHBGdabuX5xIBveaMEHAk3wDp6MFJO5NlIDoX9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6E5568B05; Wed, 31 Jul 2024 17:53:03 +0200 (CEST)
Date: Wed, 31 Jul 2024 17:53:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: dan.j.williams@intel.com, vishal.l.verma@intel.com,
	dave.jiang@intel.com, hch@lst.de, ira.weiny@intel.com,
	dlemoal@kernel.org, hare@suse.de, axboe@kernel.dk,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvdimm/pmem: Set dax flag for all 'PFN_MAP' cases
Message-ID: <20240731155303.GA23096@lst.de>
References: <20240731122530.3334451-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731122530.3334451-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

