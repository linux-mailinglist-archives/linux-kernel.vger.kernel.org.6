Return-Path: <linux-kernel+bounces-333182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD78E97C501
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 09:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B72FB21944
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 07:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DE9194C6A;
	Thu, 19 Sep 2024 07:41:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174957E765
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 07:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726731708; cv=none; b=ThVJCN0hRkG4CGtTov9oMPQKQVbu5A0ZV87IbsJtRtGBwle5PDchxgSBvmL9Rd2Z0a437r3hLuBRSOfZcRNwx0+3nK+CAVwgx5sx3hnVxP/EZbwLW1QrzreJ6QiaZiW8LRrJSGjuOvLLxx9rpl3q3alNS3IYG2/ulUmyvAls+6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726731708; c=relaxed/simple;
	bh=P5chTAJhzgcSOVZi9MlR+G0Sfml0Jgqb7wT0YNw3Gh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjZjL6MbEs1IjaZSmCrJ/m+Ry36Q7rpwXWWu0eu4e+06C0YCBZNAve8zrhq/Y+pKuvP4IXnvfe/EGs/qwgwwyDy49+RHiAayUB15HYMts4qLn9MJe+07wqdKksDrGAiUZlAKgn+PxEvFcD1Gzo22hJK7RokYmMlc4IezmEmTijA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03089227AA8; Thu, 19 Sep 2024 09:41:40 +0200 (CEST)
Date: Thu, 19 Sep 2024 09:41:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andreas =?iso-8859-1?Q?K=FChn?= <andreas.kuehn@diekuehnen.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Open brace following function definition on next
 line
Message-ID: <20240919074139.GA23725@lst.de>
References: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918132939.10127-1-andreas.kuehn@diekuehnen.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Sep 18, 2024 at 03:29:35PM +0200, Andreas Kühn wrote:
> Open brace following function definition go on the next line. Fix it.

That's indeed our usual style, but random drive by cleanup aren't
really all that helpful and just create clutter.


