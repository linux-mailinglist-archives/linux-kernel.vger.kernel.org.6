Return-Path: <linux-kernel+bounces-436947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1069E8CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB5518868F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DAB215F46;
	Mon,  9 Dec 2024 08:02:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C979215078
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731371; cv=none; b=mAVCljG4NKU8DaqdVRVeIoebrpsC5wlNq18E9STVYvRgQaqMMuSSJNizaBFTLTo4Sc8MuSJxi6efdz/cYVZitAcv+/SqdZuF1dAcbCATbDaim8rES4UwWgjcryrDlYerr8MC4EqaSCZhNkY4fLiwpdW20xFq2pD6BmU1jDALI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731371; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxJMzFtTMwrQY9Tgny4MrGpA5eeEsLj0TMlpNPOAqyB5hQwmU33angJUtIKwMA/03bzf4Ar2dyWGhKstwtHrZMq0gCz7qcQoTB8aHgMKXhme/ZDqN6AVqlCUpIyR1kh5iogp+KzJd/LTNPKn9wZ43NnivOVLEsAgM0P2UnRNP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 99BF068AA6; Mon,  9 Dec 2024 09:02:46 +0100 (CET)
Date: Mon, 9 Dec 2024 09:02:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hare@suse.de
Subject: Re: [PATCH] nvme-tcp: remove nvme_tcp_destroy_io_queues()
Message-ID: <20241209080246.GB24776@lst.de>
References: <20241203033955.394595-1-brookxu.cn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203033955.394595-1-brookxu.cn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


