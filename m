Return-Path: <linux-kernel+bounces-569236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6BCA6A063
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE61178CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CE41EF396;
	Thu, 20 Mar 2025 07:25:25 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96496189B80
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742455524; cv=none; b=pb8JDULRltU34yeBR6uWDZiuybMiNAG7W5N8O0OSJ37nGxRYQVCB/Zu0aZeW+mwESYL/fBGEYLJztmoyBiIW8jhAcLVnTamXSS9R8ByLXJLGUh6itZV+7mlkSgA8DIX50K2HokLXAHAZKa1MVOemqzU9YPaa6TkF0YI4YBNoLd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742455524; c=relaxed/simple;
	bh=85L13trZfCuQ7be6Es1EZ0KB2bRH0NDjktwQYu6e/CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td8v65Ew8opSs0f+IH6iC20suayDqrmXVwowQ4r6qYIKyDcnhNrj8o9A4ibmDEi8VqSLBaEglx4Xy76Dn86zuSDcIPdz1iLgCeyliRGMbx4WultlPI3lswvFSZ6nKXveP074AkzhyrRNdhEbLaR6+olNLvRSTP064obpDxKd+Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 359CC68B05; Thu, 20 Mar 2025 08:25:18 +0100 (CET)
Date: Thu, 20 Mar 2025 08:25:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: shaopeijie@cestc.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	zhang.guanghui@cestc.cn, gechangzhong@cestc.cn
Subject: Re: [PATCH] nvme-tcp: fix selinux denied when calling sock_sendmsg
Message-ID: <20250320072517.GA14672@lst.de>
References: <20250320063523.2201926-1-shaopeijie@cestc.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320063523.2201926-1-shaopeijie@cestc.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Can you send a patch for the target side as well?


