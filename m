Return-Path: <linux-kernel+bounces-242474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC6592888E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB05284F0C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 12:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA1514430E;
	Fri,  5 Jul 2024 12:17:38 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C26C143875;
	Fri,  5 Jul 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720181857; cv=none; b=eWZSAsIDDtMWMjV3cOqsFRoqoEYrMvMw8xT6IgrzI+1NBKsjnZbVRCsvjjNyThYv/6o3oNom+VJVLGfxokhHTdYRI7z+qREXmB7BEu7HB5BUwgV/g75FCTFLpkix5QFvnTGtR1frHHG2VGUNmOOFLqyNss9RAAggNq0iIPJDuoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720181857; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=magIks+nVq0Fr8n+ved37IXi8UmbwpVTm5RrzdS04tOLH8kh5GPx+v/XeqrceSw2WfR+q5GMg7u6Znt9maoJlpZAbxLK6ma87zJKtFBzthvCLuoOosA/oMkbadtW3UTGNLxR4HOhuvUUQH4UaJgLXWs7wIGg/rNu4KRcWKxgNng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5071C68BFE; Fri,  5 Jul 2024 14:17:33 +0200 (CEST)
Date: Fri, 5 Jul 2024 14:17:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	pbonzini@redhat.com, stefanha@redhat.com, hare@suse.de,
	kbusch@kernel.org, hch@lst.de, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
Subject: Re: [PATCH 3/5] null_blk: Don't bother validating blocksize
Message-ID: <20240705121733.GC29559@lst.de>
References: <20240705115127.3417539-1-john.g.garry@oracle.com> <20240705115127.3417539-4-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705115127.3417539-4-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


