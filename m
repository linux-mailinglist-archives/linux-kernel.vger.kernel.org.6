Return-Path: <linux-kernel+bounces-425305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF149DC042
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A672817CB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A4B1586CF;
	Fri, 29 Nov 2024 08:11:09 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC8D155A34
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867868; cv=none; b=gABcCnmQucHIlVClgJNFVR+cHhT4r0ZIhgD/Kn/wvuXNF1SyZ8aXzXKSbWIKtknjtlzU1X72nQbJzEcWXHW49FyhDRONWFIWBv6O8QO1c5ZToi5SvnMWcbAxa8i1kFFQbSfUlGr9Tsj1A0hpxYREskgs6JfeeL1pDSDdIAWm/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867868; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObvAMDOpOegK0cYEihF47tM9IlrU5UDFqzsRB+aVLFTRIMzCXMMI1j8/0wWnyWB359SyKtZFN2nohWZ82tlj0NkaX8RPkFAWfpnE7EkIcmx7WKCnq7dg2AaqzKkUjlI5RxUSnIkWdCNB8Ko9k/Yqh5wKi/TuvNqxrcRgKCC0Fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B4BD068CFE; Fri, 29 Nov 2024 09:11:03 +0100 (CET)
Date: Fri, 29 Nov 2024 09:11:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] nvme-rdma: unquiesce admin_q before destroy it
Message-ID: <20241129081103.GB6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <1be6b47b5d05975d7ac7ffbc20257c283b179491.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be6b47b5d05975d7ac7ffbc20257c283b179491.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


