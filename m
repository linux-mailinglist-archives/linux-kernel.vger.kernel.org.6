Return-Path: <linux-kernel+bounces-425306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0019DC043
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 09:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1F9BB21C21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 08:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738311586FE;
	Fri, 29 Nov 2024 08:11:23 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916D91581E1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732867883; cv=none; b=QGobelqi3Fl6xf7CLEYAAsbFWt6QQoHfrLe+SBa6EyoFtraT/PkbGuj46NjLZCt1WUB6QGc76IkIBd3dvPgowyXZpZtF2TDjvvPuFU+96xW8XiQLCZ8kpF5MYj+d/5PUhr9D2lFc24eholb+ysY/hJ0pLBWXzlbvI6ibeomvu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732867883; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y61lP8KL4wKWUKQODj6NDbUVrWX8NFRHJiUoYgBBkNvCs4LUvDmIYknWeOg+jQzZn7sL2M0xVxA587nsrppwrqJ+ntj9zVW0iE07RaPN1ysqGMYtEv3SN+vl1qxBVIIa/LJIN29Skp8n6Vdro1TDYh/J+3SjJUwU22HSea9ydIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B587268CFE; Fri, 29 Nov 2024 09:11:18 +0100 (CET)
Date: Fri, 29 Nov 2024 09:11:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	hare@suse.de, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] nvme-tcp: no need to quiesec admin_q in
 nvme_tcp_teardown_io_queues()
Message-ID: <20241129081118.GC6819@lst.de>
References: <cover.1732699313.git.chunguang.xu@shopee.com> <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e662471e392c6b45fc37de94139e886c53c9cdd.1732699313.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

