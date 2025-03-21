Return-Path: <linux-kernel+bounces-570767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3193A6B44C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED69A7A573A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FABD1E9B3F;
	Fri, 21 Mar 2025 06:14:36 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B946C1E990E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537676; cv=none; b=B5Tw2KEuod++o6LZe79k/xwUFkBzlv448ziOjMUuB20UT4ZxRtIcxjHT5uoCw1WITCc+2XHmP6GF5d99De2JAuW55vK0xn94aIFMZfFDKiiQlEPHhcVfVp/lOcmLo/p1Yjz70Sngu+78wvjzdxDZ/YuP4UgKH1rMXBItROl9XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537676; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5OcIG2y5dlPudrF61eWMcxGgx5JnUpzu3/QMn7lCL6WaQIoNooAPcKLiQBuQriyNimzoAUoRx5vbnBLmC46x0PfGu6UwRZm/hexFbKxSp9mYN7SmeFVr+M37lIgltGMk5/qkUOBsSkAmFpVSyscONXm5Tjp8WfKiP/J7XEutEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4290D68AA6; Fri, 21 Mar 2025 07:14:31 +0100 (CET)
Date: Fri, 21 Mar 2025 07:14:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 11/18] nvmet-fc: inline nvmet_fc_delete_assoc
Message-ID: <20250321061430.GC3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-11-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-11-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

