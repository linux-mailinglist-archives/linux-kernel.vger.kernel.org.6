Return-Path: <linux-kernel+bounces-512323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DB5A33799
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 06:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B143188BDFD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 05:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED81D206F2E;
	Thu, 13 Feb 2025 05:55:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D51204F85
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 05:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739426144; cv=none; b=St19iB5QN4S/oLLP4E2zRwe2uM6wDyZSAYeWsFjSxhX3SfHvUiYb91lWn4Sj5dwxkrACr2bVD135AxLoOn5TT7O420OJHTZfWpL4gyK+Ugy46bIiKnkASJChqHsNnVzHohtxMDsVW8Qtml2GvLPW/fxtS6J0DpI4zJcR413zTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739426144; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXheYeDr77wbp8wtRiNV9CQbTVNvyyUT1gGNZXFhfdoTDFUu0pIYhyC4rXjKa/j47tyQgIVHH7DEjNpFLRpZdnaJ2ZjCw/9z4jXjzNZjBjznozjEd3NN68fBQ0tLE4obyB1iSqP2N7JVcTBVtJESEbsWRKWENqBmJNTr/EUNoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B2A567373; Thu, 13 Feb 2025 06:55:39 +0100 (CET)
Date: Thu, 13 Feb 2025 06:55:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-pci: clean up CMBMSC when registering CMB
 fails
Message-ID: <20250213055539.GC19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me> <20250212170444.16138-2-uwu@icenowy.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-2-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


