Return-Path: <linux-kernel+bounces-196982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 068528D6492
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378F01C24AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F42A3CF65;
	Fri, 31 May 2024 14:31:53 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78E2E64A
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165912; cv=none; b=iLYjEgq8Sx+vYgYAk0jotGs2lXL9YEBE0iOuoclSWMYz4rAZ0K76EiEjve0pUFWXdmICAFryLofjXQ0BTc0fbIE3yUCSjR+8GkubLLxCjz2H9wS0ueXv88PP4aghjCcxQ7Zci/mftNLm75/auIbl0FisCRn0p7wd7GK+C8b2Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165912; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kl4GNlTQ1MZeioIadOu2FybUlFpo+Yx0YynDM2/bN6+x5jmLk7/Z+Oxrj2UPN+t8DUL3UJGGnspPbU9Udu+jWTFoM7QoZ3/ZvD9HC1FO0/dowOBWuS+tgOjccKbp8CIO+wMT7H5FBFI887jCNZwHJrSMJ+6s+nGtJcv4tSPx1X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C99BD68C7B; Fri, 31 May 2024 16:31:43 +0200 (CEST)
Date: Fri, 31 May 2024 16:31:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] nvme-fabrics: use reserved tag for reg
 read/write command
Message-ID: <20240531143141.GA26703@lst.de>
References: <20240531092421.317296-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531092421.317296-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

