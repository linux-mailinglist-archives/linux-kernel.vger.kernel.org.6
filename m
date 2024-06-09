Return-Path: <linux-kernel+bounces-207268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38399014D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F18F1C20400
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 07:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631891C2A8;
	Sun,  9 Jun 2024 07:29:52 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5599EEAD;
	Sun,  9 Jun 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717918192; cv=none; b=H+9EYFLQXGrp0S5oelmxRnRbKV2OpsRKqs9WxMUkJvPaaWUAzS18xa2XHXZJ4ADy5AAzFnA+j3FAj7op0HMm91HbpOknDNPYmITNwa5klCpKW8nYgHC7hu0AuJ9+yHL0OqF7R2YdYKTC/Dq/zssZuvnM0KnxHbZUNBkTCcbtXqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717918192; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2D3vMw9I0LYksjx255m9wIMyPWrduPRc5kFU4b0lrGhnMO7tNR+4JkBSIrIYscW9u5TYytxF6uYoKlJIomv6McqO2pzFyU/Xpuc36NUg/s+du4zX6Ns3CzlTMxb6pjzGeFSMULw6u7OclG/ek4zQsUosoDcYmQ6t+cevnacxbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4F7E68B05; Sun,  9 Jun 2024 09:29:38 +0200 (CEST)
Date: Sun, 9 Jun 2024 09:29:38 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: axboe@kernel.dk, ming.lei@redhat.com, hch@lst.de, f.weber@proxmox.com,
	bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
Subject: Re: [PATCH v2] block: fix request.queuelist usage in flush
Message-ID: <20240609072938.GA10728@lst.de>
References: <20240608143115.972486-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608143115.972486-1-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

