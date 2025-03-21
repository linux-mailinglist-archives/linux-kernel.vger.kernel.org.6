Return-Path: <linux-kernel+bounces-570774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF46A6B45B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556C7189307C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4321E3772;
	Fri, 21 Mar 2025 06:19:27 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598E08836
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537967; cv=none; b=NnLbf3oYzS2irTUgf+fDSSS/A7cYRK+Fpm5N07DJto1vSDU0snbXZDPErLm1p74CaQ8e+rTsmkOEnuE8bdVWqTREtE4yBzzKjouCBMpEHHm8O7vHDmSvp6JRBCf5NFCTsoEIwKYpZAl55wA6L4j3KCGWBf9RPcJCdP3SCwaejg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537967; c=relaxed/simple;
	bh=27KmGi7h5nB1p8p4616q7p1chkRefL+ulFQEMrpSQVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8aHjoC8NXo5b5X3RZGVHKz7RP9uCdmPNqPcUTb8LvHyulEQuU0atkMG8XogbIMG1Mhxd0O2m58scPZ8d7TYp/djgogTm9ss6NduMd3hj2rIc4MadhMYVWYiAMk3J6ituIHHMoRQQN4N8XfJKxBoH5+FH9YfviikVyZCaxh172A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8ABA768AA6; Fri, 21 Mar 2025 07:19:22 +0100 (CET)
Date: Fri, 21 Mar 2025 07:19:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 17/18] nvmet-fc: put ref when assoc->del_work is
 already scheduled
Message-ID: <20250321061922.GH3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-17-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:11AM +0100, Daniel Wagner wrote:
> Do not leak the tgtport reference when the work is already scheduled.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


