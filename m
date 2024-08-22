Return-Path: <linux-kernel+bounces-296728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB3095AE4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28916B22E1B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 06:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C9152790;
	Thu, 22 Aug 2024 06:58:00 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146AB14B964
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309879; cv=none; b=tGqVIJ5QTjp+JNYdg/n2+OdvYXiJP4NO+axeiPr7GGitxBuTqfAu3wQKOq8udWuX4SZp3CJwS5T6rweyR24IBUU+vvt3LqWwIL/qtqVN03GJ73qXsaTWzKjdmgG5OLAXb8NPf2iNuGzuz9n5B68sNSvNEMV7F6Tjku8mmesiwgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309879; c=relaxed/simple;
	bh=KA3T2sPD9t8FDgC66LWUzuRNnIMgCU2pyme7wb8r3Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glrftA8GpEX5KBFaYW2oX/qUSwm1D3v4c6dqW4aObVt2L6JTfSSFk3z8p6Dw6WNgAh5IBbtypC7vR935JJA6r3g2hxA/AG8hxOW6wM7Ipb+R/pbdj/leKFzMP3XI6nsexiR4NCcWwHHTsy65bbG85mpqFF1Si/p66SxO2mWaeGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0E85227AAA; Thu, 22 Aug 2024 08:57:54 +0200 (CEST)
Date: Thu, 22 Aug 2024 08:57:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 4/8] nvmet: Make nvmet_debugfs static
Message-ID: <20240822065754.GD3141@lst.de>
References: <20240819120020.3884893-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819120020.3884893-1-ruanjinjie@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

The change looks good to me, but given that you sent a series where
I can't see the other patches I have no idea what context this needs.

If this is a standalone patch, please resend it standalone, if not
make sure every recipient is Cced for every patch.


