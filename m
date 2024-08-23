Return-Path: <linux-kernel+bounces-298303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C495C571
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87B9D1C2406D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86833768EC;
	Fri, 23 Aug 2024 06:26:37 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB204A08
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724394397; cv=none; b=r1hIKwN8un3p3RJ9yXV/hc3hnVhb9z4R9HoiTggdSN1rTQN4fYON2NcsDFCvQ8oi1cM4g1EoDvXHE8j/1+GrLXjNwV6+MP8rbK42VK0+HueRrkEMvID5Dlu1/Sl6Gl3zXjRIcwjCNcOxLAwnxEA0OgtyJU8yYZu2jf2XkIAGjnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724394397; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZCp61nh/+RUX6oHye1WWficl2G/T0sLHqzilIU20h+zuQfrrj5pbVkqDa4TrVWtIUmu9CEoQcOh5/rP1XojK/eHtCM2IG7cCl++pgGxyA7JAC6s1H0o54whPY+1VrXPXOSRie6RhlUlH2SYEqk4UEjVzWhg9QhWshA+TW0DQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C2E6B227A87; Fri, 23 Aug 2024 08:26:31 +0200 (CEST)
Date: Fri, 23 Aug 2024 08:26:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 2/4] driver core: separate function to shutdown one
 device
Message-ID: <20240823062631.GB31588@lst.de>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com> <20240822202805.6379-3-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-3-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

