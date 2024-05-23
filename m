Return-Path: <linux-kernel+bounces-187555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BBB8CD38F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0512A1F2426D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 13:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671B14AD0C;
	Thu, 23 May 2024 13:16:24 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B101E504
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716470184; cv=none; b=aXtBHCiqXfy0UuqSE7k64+9lCgJrIbu6ePUcnNoL+41l8j2AnJRE3tlbg5qh/hVhj+AOjZdv2MvVvkxs08IrC/PKmpPlVJaUgViBZKU0uAAYIuxW6fI/lq32sRsIIP9LE74KVxCjxV7cGCTyfT6wKtu1EqbzDAXuhyPjl+ZU7A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716470184; c=relaxed/simple;
	bh=qCQNnEm5MMCrNRvKs0n8fRnR+zjyw0ZbY2JmHPK2KLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltOcS8Ts0PmITUkp/E8xx6pg5geY6+2fEiA/ybwAKoWNBOBAuAZMfr6380xiS3Kz8CIaZj2nmhm/lg9igFf7MD6eQ0E0uZbkMQkZabMfa04Et4QEfMhl1rAsVTz6jct9Dtb9w890zonJ6Rzca75T4J8pbO7zj8FlpPYUvpAu5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7F59E68BFE; Thu, 23 May 2024 15:16:17 +0200 (CEST)
Date: Thu, 23 May 2024 15:16:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	sagi@grimberg.me, emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523131617.GA23604@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com> <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com> <20240523064525.GA28524@lst.de> <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe13bd05-76c5-4bf8-bfda-f9ecf08b2272@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, May 23, 2024 at 09:12:21AM -0400, John Meneghini wrote:
> On 5/23/24 02:45, Christoph Hellwig wrote:> On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
>>> Christoph, Sagi, 6.10 merge window is still open and this has been
>>> iterating long before that. Any objection?
>>
>> No, it's not.  The window for development closes with the release for
>> 6.9.  New features must be in before that.
>
> So what's the next window for new features?  6.11?

What else?


