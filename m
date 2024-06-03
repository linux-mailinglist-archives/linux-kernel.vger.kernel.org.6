Return-Path: <linux-kernel+bounces-199127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540BD8D82AA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106C0282F1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF0312C7FB;
	Mon,  3 Jun 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LohHcb5c"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6529F12C7E3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418798; cv=none; b=NcRcfwqDR96M4xFU31X4R4tOdyqU7llYKHETOG1b0L5tTCzhIa/rbdL4hiyk6UchDplpjYhOgvXxh2/0rodSw9efuzxv/nEV987NQxWItcqrAvyyjoRUQLW3/V9f/ynCyoUvTADdmNBo6Lr+r7sLgUpiVZWxHdEmZhEncZQatUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418798; c=relaxed/simple;
	bh=lQ61YxZVUBj/F8hh+Ierb08BzryUCSUJ1lFXGMMdj74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDxG6xVpJ01Km0rDH5jYIukgTzTiQ5TJmVcUnCTCaOIY15OXZSaaETcrVNlYbBZOS99jc/wS65EuJBBGHJbh4r56XLaqQZhEj33y/MfbL7FapT0YwuwMTxKyTqkVfzY6etzjRtG2SmKKrIFKqOl1huzzQzzs68Jr6gIztLx6HKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LohHcb5c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bmfnZKfCgRwsGkioRJvWkyb/LftuLHVcEkZkw3PqV9I=; b=LohHcb5cctuvUz3a5kcQbgijDG
	sFnYZEmcYHNULmLvAVCSC1rVsUXgSxB4j6rfy3UqXiNE5AAdlhBYGrMDT7OXy6+0/CyAGZnzGKTCV
	RJgmabMYOetaESMkQmkC8aoa4Whxi7Xlh/26/REZGwAGhjICXdKwgvsjXe4+R4QT3BZ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sE754-00Ghw0-Fx; Mon, 03 Jun 2024 14:46:30 +0200
Date: Mon, 3 Jun 2024 14:46:30 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Benjamin Schneider <bschnei@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Benjamin Schneider <ben@bens.haus>
Subject: Re: [PATCH] cpufreq: enable 1200Mhz clock speed for armada-37xx
Message-ID: <f2284d6b-2e75-4896-9e10-caf2f72854a0@lunn.ch>
References: <20240603012804.122215-1-ben@bens.haus>
 <20240603012804.122215-2-ben@bens.haus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603012804.122215-2-ben@bens.haus>

On Sun, Jun 02, 2024 at 06:26:38PM -0700, Benjamin Schneider wrote:
> This frequency was disabled because of unresolved stability problems.
> However, based on several months of testing, the source of the
> stability problems seems to be the bootloader, not the kernel.
> Marvell has recently merged changes to their bootloader source that
> addresses the stability issues when frequency scaling is enabled at
> all frequencies including 1.2Ghz.

The problem is, most systems don't have the new bootloader. And so if
you enable 1.2GHz, they are going to be unstable.

Rather than making this unconditional, i think it needs to be
conditional on knowing the bootloader has been upgraded. Could you add
code which looks in the DDRPHY and see if 0xC0001004 has the correct
value. Only then enable the additional clock speed.

	Andrew

