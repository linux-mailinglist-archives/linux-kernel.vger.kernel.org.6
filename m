Return-Path: <linux-kernel+bounces-386449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B20139B4399
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 578761F2362F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85656202F89;
	Tue, 29 Oct 2024 07:56:16 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97571202F85
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188576; cv=none; b=nCi8TzB5pqGijq/lCF2djRHC8SAG2vZSycNEbtW9qspQ0V+maVW42TENCcaT/Vj/6Nh3Zd5LRx++G6Rg3/UUYgNTohm4pWZJTL1lezTYLm2WHavfM7IdWn+l2oI2si5+DfdmML5ywLGNUY/3Mxa7E3REQRdnjcTB3vZMbZDpLlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188576; c=relaxed/simple;
	bh=oQ2Oy2vE4Y+KSIGzjxEVBp2pts3FTmVlEXlZ7nc293g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcIlbGh/5nBgTJI7xTz1NfWN+OShE3l6K8AYAc/2EMnBsCCPGErpio5oPE2N6fxB1oa05mfrAhPJ6pkCUHN1WWMUSy/bHKsTeFj8gApW0gL+nUNGvJiXEC1zYfS7IHeHfQNRD4kXQEU1+bI3bjz8WHB2HCLscgdoQWx4/yw2fu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id F27FE227A8E; Tue, 29 Oct 2024 08:56:10 +0100 (CET)
Date: Tue, 29 Oct 2024 08:56:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-mapping: dma-map-ops.h: Remove an outdated comment
Message-ID: <20241029075610.GB23876@lst.de>
References: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023032544.2809331-1-sui.jingfeng@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Thanks, applied.


