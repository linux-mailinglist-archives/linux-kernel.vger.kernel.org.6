Return-Path: <linux-kernel+bounces-449827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072519F56A3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA0516F605
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2E1F8EED;
	Tue, 17 Dec 2024 18:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I+WDdntw"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98A1F76B9
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 18:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461930; cv=none; b=LGNv9SUzPoM/JgJ7B4/ulknNgcQZiflFhfjQrWZTO0UyiVrydoPUjVPtjnlvjXI+YQvpoWbK3W3jFW0OjtNXL4F+oP0uW7j0zew2v35UiTSPCGjFUB5ZY557plnqPjAK3afyUdw/uW8kL68Dkr1MohTAeY1NbxvGrRL0noSkVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461930; c=relaxed/simple;
	bh=fbHCKnfG5NRep7BfY0oobhD0kOGNRHN5i/W+xzw1qWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVQyeLkbjOs3JcJVyuvjuAuZTNw3JYI5G4bckG2BqHCSVa0tqLmwW4td1GEXqFYVtUvk9PO/86fPCuY6LVk+e0wzzqJhdsIbJbOtrSgEGNqxjGWwCMBX2WCoMni7qtK4LbLDdq8SC701YtLxHj8OU6Dtx5QpaOkj8q9sxFxIdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I+WDdntw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734461925;
	bh=fbHCKnfG5NRep7BfY0oobhD0kOGNRHN5i/W+xzw1qWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+WDdntwN2YaV3qOxpeCQWGNdY5z2byTtquxZOwOwIlaugNaYa65yLtdJOBDgajse
	 GdYWsLTrZj8ehD4d7cjNLOQ6EN7N4OSF6uUG4RdpLST2G6uyGdeG0EZ5P4Y5UfRyKL
	 zuGw3TdxYX44cQQ4P0YLyIKoEL8llOe0QcuewkL4=
Date: Tue, 17 Dec 2024 19:58:44 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Brian Norris <briannorris@chromium.org>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, 
	Julius Werner <jwerner@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] firmware: google: Constify 'struct bin_attribute'
Message-ID: <3b905b05-d8dc-479f-8f9e-dae7b119b539@t-8ch.de>
References: <20241215-sysfs-const-bin_attr-google-v1-0-e5c2808f5833@weissschuh.net>
 <Z2ClAB6qY5LaMuHQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2ClAB6qY5LaMuHQ@google.com>

On 2024-12-16 14:09:04-0800, Brian Norris wrote:
> On Sun, Dec 15, 2024 at 03:49:08PM +0100, Thomas Weißschuh wrote:
> > The sysfs core now allows instances of 'struct bin_attribute' to be
> > moved into read-only memory. Make use of that to protect them against
> > accidental or malicious modifications.
> 
> I'm not in love with all these "_new" transformations that need a second
> round of cleanup, but I'm not aware of any better way to do it.

Absolutely agree. My hope is to get the post-transition cleanup directly
through Linus or Greg in one big commit. At that point the changes are
purely mechanical and trivial.
So I don't have to annoy everyone even more...

> For the series:
> 
> Acked-by: Brian Norris <briannorris@chromium.org>

Thanks.

[..]

