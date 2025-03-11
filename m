Return-Path: <linux-kernel+bounces-555615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72279A5BA45
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 08:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22EB164DDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002E0224884;
	Tue, 11 Mar 2025 07:53:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866B224244
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679634; cv=none; b=oi2p+nD3ulB0GNFpTX1TwMr2NKUABgfvLe59qxLY/4CnuD2k72o7OXiqkAWbqx1RnFG0EH36+xGl5nyFLXJHXCKQSl3fz8Ge+C7gHbFiMa29NZrAyVxlKHVwxfi/Z5cuII00RdL1Jeil8Y+z2K60ctM4Gj/T3lZ5rEJs3vz1qeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679634; c=relaxed/simple;
	bh=HpFWUO8ePKNuCMY2YxiM/ouXwp5vMhpFUQh0uyEE5aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIcHsXgeYNvV0eluYMoqVQl1OfC3Gpr66lBJGirobDqsw6coGRQKb0h0t83R9QOHI4CPamSQyclRtAz6dt5w2sRpkmYmMfMuh1k13RGa045usLGo4S6nehyGvODMpCwg2C+FQsTSL3x0TzUAE/yfV8NdAmEUxsgOaPfnAlRD75A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 24A3767373; Tue, 11 Mar 2025 08:53:47 +0100 (CET)
Date: Tue, 11 Mar 2025 08:53:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Jianlin Lv <iecedge@gmail.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, jianlv@ebay.com
Subject: Re: [PATCH] nvme-pci: Remove NVME_QUIRK_BOGUS_NID for device
 vendors
Message-ID: <20250311075346.GB14844@lst.de>
References: <20250308141102.34101-1-iecedge@gmail.com> <Z88aRU7Bq3SYtyyO@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z88aRU7Bq3SYtyyO@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Mar 10, 2025 at 10:58:45AM -0600, Keith Busch wrote:
> Setting the quirk on demand lets the first scanned namespace export the
> "unique" identifiers as their own. Scanning isn't deterministic if you
> have more than one, so you wouldn't readily know which actual namespace
> a particular /dev/disk/by-id/ link points to.

Agreed.  The fact that we even allow the devices through is just to bow
down to the greast Linux dictator.  It's still a very bad idea for all
the same reasons as it was before.

