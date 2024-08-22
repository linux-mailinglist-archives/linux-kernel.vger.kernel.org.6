Return-Path: <linux-kernel+bounces-296770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD1F95AEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 387BD1F26166
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C007186E54;
	Thu, 22 Aug 2024 07:14:34 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12C186E30
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724310874; cv=none; b=uaPuNAMvQ2LDQ5q5l0DLsRRBEvAKaEPZ2Svkl/GWPap/Tm75VKT19HuZVwoyuvOaRIPZ5bFlpCiJ0bhMkgWEWLfC9aMdWD/O4tEXZVm0yY9DWgEWj9E1COookTOERGFDHdcwZE48obn/jNqrQLhXaYzq6u91F/5inI/SYsiWNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724310874; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK5rF7VLM+M1pZDS+dlZ9hhwAD6qaqcgznyzIIGCmEkIujlTdDgFVeS2C++jnK8PGV/bJDDgAvF2LkS1nuqrYdxx1J1S/2jbYBBafKC11VYsXkgTwdyuC5/0jspPCgeiHHOs3qszwLuGUFdkZduG9zoJot+D4v50S/C7TVQctkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3993F68AFE; Thu, 22 Aug 2024 09:14:28 +0200 (CEST)
Date: Thu, 22 Aug 2024 09:14:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next RESEND] nvmet: Make nvmet_debugfs static
Message-ID: <20240822071428.GA6374@lst.de>
References: <20240822071916.3547318-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822071916.3547318-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

