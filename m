Return-Path: <linux-kernel+bounces-242471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A945928886
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C07D1C22246
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0C114A4FF;
	Fri,  5 Jul 2024 12:15:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F23414A4D0;
	Fri,  5 Jul 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181700; cv=none; b=VNUb+6kowlGQYpJ5uNiRf0/DnceeYgv5YhJkFQyXjzxKYQtEQEzm2Lw/lJTLlB5ho3QS5vDEe7zoB2XbzQwaV2W0cXyPOqneLfktRDo3b/2OgIF4/5v9cS8ZW26MrMGhfHi5z58WdHl02kcg6LUtuz8Cnd+2DA1rtO3yfVEgkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181700; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rA/YXYINSbAOP7YjQf+PTpByQOitupiuq57exCwmLzGkZ7HF4vem9lg97rvcEjzX/L99Zezl8kAuOhgI1wMBRXPWDWJ0JmPRXim3CpWm3Xr9BV34ikiZcPVhfwY8STgEsbalhZDU1W5TcWDSVz32Hajo2kOleTLBtooIJh9maeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DAAD668B05; Fri,  5 Jul 2024 14:14:53 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:14:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 1/5] virtio_blk: Fix default logical block size fallback
Message-ID: <20240705121453.GA29559@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-2-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-2-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

