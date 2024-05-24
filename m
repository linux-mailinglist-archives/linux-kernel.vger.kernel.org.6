Return-Path: <linux-kernel+bounces-188409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 612578CE1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120C81F22009
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384AB12881C;
	Fri, 24 May 2024 07:40:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4D127E28
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536454; cv=none; b=rbZ1EjM35lBEsszPKtTC30xdE3uMR01StNTEPruU12yCPFO9GB0sQxjX53e5v+SwjF5QKe5qoK0d8pfJIRWMkQiKe8mrD7pZjcoOtNV+Fh8OoBUjyaEXJtdyYeqqQs3UOgX4Z+LKZ2isFQP+hnNS4cHaHnlwFPYzWRwi3FO8orY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536454; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DUjfVsIz13FwFKmMrzj082oxNSZikOeUeYNfV3qDMk9SFhcPVj45SGWbT54RW7bdUfKrq3n1pN54QzgSuJZyHnMgxMbRkCbNUPyRrFech/7yLTHMZUTQ5UU8hY0d2KAG/cJo8PjgqbmariuAbv6W2tcsJltQgtkMWXompc/XzBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4FA0468BEB; Fri, 24 May 2024 09:40:49 +0200 (CEST)
Date: Fri, 24 May 2024 09:40:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Message-ID: <20240524074048.GA17251@lst.de>
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com> <20240523113149.29174-1-kundan.kumar@samsung.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


