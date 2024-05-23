Return-Path: <linux-kernel+bounces-187059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F9E8CCC69
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABC41F22EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 06:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E67413C838;
	Thu, 23 May 2024 06:45:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3453A3CF51
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446741; cv=none; b=HlRAz9fkvSWovHCrZQ85XQ2pkuzzuSEF6SEVxv9M7pQfIV7P+jFD3K1VbOI+soJ+gcHFIASPhyj1ajqdMs5kRycvNvAngjiOnVLBUAmY/g1KRW744iQz5J353/R7ex+aswBwFNFCEK8Nfel9voMf+fJyeryw6NU2yrMPunBRA+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446741; c=relaxed/simple;
	bh=wZ2BXq7x8QqvF7uwNlE8U88BI0SS6Igwng+Aps7LUAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ine8hJ0UwZZvNN4KykMI3/1sXoUAwOMYiGNgOmOC1gRt6GcogAQEIoKIxM4X6wWY7IdLlVAccJBB9jKN6oPpyGUG6Nopu5XlrauWNg7NCm83zUpt+aalgG254vPbAueMYkhFZkq2kF6S5UHRzj0unAiB4EFq5bNBr5V+MxUhsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 551AD68C7B; Thu, 23 May 2024 08:45:26 +0200 (CEST)
Date: Thu, 23 May 2024 08:45:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Meneghini <jmeneghi@redhat.com>, hch@lst.de, sagi@grimberg.me,
	emilne@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jrani@purestorage.com,
	randyj@purestorage.com, hare@kernel.org
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Message-ID: <20240523064525.GA28524@lst.de>
References: <20240522165406.702362-1-jmeneghi@redhat.com> <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zk4sEpypKqeU67dg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, May 22, 2024 at 11:32:02AM -0600, Keith Busch wrote:
> Christoph, Sagi, 6.10 merge window is still open and this has been
> iterating long before that. Any objection?

No, it's not.  The window for development closes with the release for
6.9.  New features must be in before that.

