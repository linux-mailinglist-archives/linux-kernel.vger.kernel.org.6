Return-Path: <linux-kernel+bounces-320070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571E99705D6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8172D1C20E40
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 08:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD713635B;
	Sun,  8 Sep 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esqiCvbF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56562AF09;
	Sun,  8 Sep 2024 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725785059; cv=none; b=JWsvRHsvW88c3kW6V+dL5a0ENUoS5pcNNx3ZxHlVue9noY1llF5dEmc9DWhTc/78azDKskL5mkzwQ8BIYuxChjPAoF1lsJ6jdveo4pzmrm8TNX0fFbyEgGyRJcHNlN710m+CDZawDnfVz8KFIZo7LF6MbHKLlqoDACnl6UxdrhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725785059; c=relaxed/simple;
	bh=1x4faPVymiRDVgWHocoMMmvn+fAB0HBRw9eKgy70B48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqKPKKwEk2DZ4XdQdswWXG5MJMX3//lIJSTVF/zq/oxKQjwaNrgCwTjzNECwPmJz6rcZsgqRMRZCSCMXFztuVY59p1Rbs6gnMFAC+NmhhFucWkHBOaCfSK3113xqiiFPkI1k0fy539Xnaxh2LjWkqcI0XDcwPgeozZ81xAQEOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esqiCvbF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71941C4CEC3;
	Sun,  8 Sep 2024 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725785059;
	bh=1x4faPVymiRDVgWHocoMMmvn+fAB0HBRw9eKgy70B48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esqiCvbFnxsnc5OWIivc0/xWPzL1VjiQ5T4zNJ/noL0ZEKjOdTJgFD4n2s4t++xPo
	 lxuR/XQZEVAc0j0FOzwSPwnW9K9k4JKp4MYh08ywFbP64DXmQJ2c+9kBzmSGcmMlH3
	 vg42i0EF5+pRVs0kGgicJ2pvNNJQ2WExUHCIDHN2VzYYxbhSaGTqeh7HVhsW4cV9sx
	 TTD+cv4zHeVfHnEU4XFujAWYMeoZKbvJnIdUw2en/SP37kRpYJMIkTstCWnfXtiyTw
	 6GQ1of4VNhsmrwTD9eM8PF47wWWb9bS2IvQAWC2IsiLPVCdrmiksO2lRuXYMZBlBXJ
	 vyw4/q8OOW+uQ==
Date: Sun, 8 Sep 2024 10:44:15 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, robh@kernel.org, 
	saravanak@google.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] of/irq: Use helper to define resources
Message-ID: <w4mq5nareqaf3fpwf3hr4oywgxlnjy33va5ftspw5rmdxuflms@x3lw3pj64tig>
References: <20240904160239.121301-1-vassilisamir@gmail.com>
 <20240904160239.121301-3-vassilisamir@gmail.com>
 <ZtltLjZkFBWSbl2s@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtltLjZkFBWSbl2s@smile.fi.intel.com>

On Thu, Sep 05, 2024 at 11:34:54AM +0300, Andy Shevchenko wrote:
> On Wed, Sep 04, 2024 at 06:02:38PM +0200, Vasileios Amoiridis wrote:
> > Resources definition can become simpler and more organised by using the
> > dedicated helpers.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> ...
> 
> > +		*r = DEFINE_RES_IRQ_NAMED(irq, name ? name : of_node_full_name(dev))
> 
> Just use Elvis to make this shorten.
> Btw, have you ever compiled this?

It wasn't ever built... and if not built, probably not tested, either.

Best regards,
Krzysztof


