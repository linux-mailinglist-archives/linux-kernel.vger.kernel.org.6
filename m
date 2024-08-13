Return-Path: <linux-kernel+bounces-284186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38394FE16
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DBF1C224D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959042A93;
	Tue, 13 Aug 2024 06:50:03 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ED680B;
	Tue, 13 Aug 2024 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723531802; cv=none; b=SiBJ9tWhprWfi+jC+K4ofdt6UlkY7lTzEaWce2e4HtyJdennlgC6OwznhAmylgZkz6nRshqTZPPr+CPBuNL/c0chCTvm09Md71hPYEuXfejBfu+07GbyNaui9ONraHr3cBW+EfaQUUeZLAUkYCTcug5ZiJaQSfXJyfETkbeYqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723531802; c=relaxed/simple;
	bh=gD/Ui70zBwVz7Gda/HuSk/dn2pBMMFdVHJjVhz1fzb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXmNkqfydBP0M/Y18xuymPRE6MjOXVpBZXpZ8/Xr55WUfQJPZ1ZE7SNPL0TTE008VVRW9iwxLODxQ8sXNTrhuK6QiXQkaEq1Pk8Krq+ChO8rjiElO+qN+Pv+74ikk4oOHxNK5xGqkslwpn2lCWQ81fjOBU77aihO89nRqnOJ7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2ED96227A87; Tue, 13 Aug 2024 08:49:56 +0200 (CEST)
Date: Tue, 13 Aug 2024 08:49:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Anna Schumaker <Anna.Schumaker@netapp.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nfs@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [nfs]  49b29a573d:  filebench.sum_operations/s
 -85.6% regression
Message-ID: <20240813064955.GA14163@lst.de>
References: <202408081514.106c770e-oliver.sang@intel.com> <20240812112145.GA15197@lst.de> <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrsBlLtc5g4WbuP2@xsang-OptiPlex-9020>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 13, 2024 at 02:47:48PM +0800, Oliver Sang wrote:
> no in our tests, becomes even worse actually. detail data is in [1]

Thanks.  Do you have a good summary of what operations this counts?

