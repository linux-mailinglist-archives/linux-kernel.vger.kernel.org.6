Return-Path: <linux-kernel+bounces-227734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 982E5915600
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FB11F210C2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546F71A257B;
	Mon, 24 Jun 2024 17:54:10 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8A61A070F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 17:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251649; cv=none; b=lWh8BIqVgiGaSvUpI4x+d/Q8YMTMFdjy1vjmuFbPHoahK181/ypEdlaQYzTj3eQLn/egG/tUREKtPsqjSrm2yvODJeCUAEEhyl1wkfEg8/ZjJZWZZhRxG7pMWfLblszzXc+A9EimgM+kwLKk8QSbsfDcq0KIQdEtugLPK9UYIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251649; c=relaxed/simple;
	bh=eZISsWq+Zbh1zUlkNXNx3aK3v1zGbcqMb+n5yJw8Ft8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONdNs6491DvqoC7J+kramgMXudRjmrCjkYctZXdqIMpFG2a50wdA4tv6QTnFiSi+MePzskZfp540C7MLm+cWrqqmBGQZ/rT6TAG54KVKQXIatKTuYeY3XnZ4KG89h/7x3ZhXbQV7oaOtHOeaEHAVn5K0ktufikMxuA+DKXQl7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C03B068CFE; Mon, 24 Jun 2024 19:54:01 +0200 (CEST)
Date: Mon, 24 Jun 2024 19:54:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	emilne@redhat.com, jrani@purestorage.com, randyj@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org
Subject: Re: [PATCH v7 1/1] nvme-multipath: implement "queue-depth" iopolicy
Message-ID: <20240624175401.GA24863@lst.de>
References: <20240619163503.500844-1-jmeneghi@redhat.com> <20240619163503.500844-2-jmeneghi@redhat.com> <20240620065641.GA22113@lst.de> <d4ae4b0a-b3a4-40db-87e3-c9a493408172@redhat.com> <20240624084627.GA20032@lst.de> <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59921b0a-1e16-4f39-bdda-9e11ba2edbbd@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jun 24, 2024 at 01:50:21PM -0400, John Meneghini wrote:
>> Having the identification as the prefixe seems easier to parse
>> and grep for.
>
> To be clear Christoph, your saying you'd like the NQN in the prefix of the dmesg?

Yes.


