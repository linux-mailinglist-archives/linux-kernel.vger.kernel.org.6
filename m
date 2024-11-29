Return-Path: <linux-kernel+bounces-425304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019D29DC041
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7086162FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6E71586CF;
	Fri, 29 Nov 2024 08:10:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFDA156991
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867847; cv=none; b=RYynxUkP4m844ESOam2loVLpPTmtIEf0kgNyUxDScwhoeiF7yoc0YJDMKYq2DbUn6WSbyhX7eJGRutzt9x1wjIRhkJ7UkIihgDGfVkWkNjmMej7jnr9Et9zzJ5ECNScC+9/Ub2Wrm/pIkt6gQATT+lHnvN9Xlr6c0ACYT9WfmSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867847; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WErtLgjF5htr2Ex5h0Nv5MZ4q1mr56yBCu9ZtS7qvxvdoen/+brb5Arj//OrGF7FhZ0RqE2i9govUJepKV1abzNzok8oFXqmAf2slDwf8D9VGbH3bl87S/ApshTdZwflJGVm1Rm8bHiUKMzruIW5fZTKzF/VoJ+7xKikBW7yUJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DD0268CFE; Fri, 29 Nov 2024 09:10:42 +0100 (CET)
Date: Fri, 29 Nov 2024 09:10:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] nvme-tcp: fix the memleak while create new ctrl
 failed
Message-ID: <20241129081041.GA6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57573f42413b9e46fe227ef389e2f8a6971f1db.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


