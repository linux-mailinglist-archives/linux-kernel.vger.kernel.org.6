Return-Path: <linux-kernel+bounces-267876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B194186B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD5D282E65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903F8189517;
	Tue, 30 Jul 2024 16:21:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635B71A617E;
	Tue, 30 Jul 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356486; cv=none; b=D1spc4xiFdsTAzwK5x7C2q2Nzci7KG5UKjryp1x5VYqk1M73CjiYTy3kQXvPYS31lWn37UsWThtbbZ0hZukHZKzUSFVZWzFmuyjXIpvNQ+tAEte22766Gei+QU+2CtdP/8YbyGqJ26tjR5vYciBZw4GPpyAOTUnz88cv/JecFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356486; c=relaxed/simple;
	bh=ie9/9gx3ARFRW0pM8mPcKQOsuD9ZYZdMZoovobmOJpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca7U3CJ9b+7W1A+EePmwtcS7J95EC42Mh8yXXFy5F77VvvFklfTDy0+87wRt34h6Bs6/ldFg3ennKjkpK5PgZeOPWoN4Ko7vwKd2LqnFsFxw1dkvU6NbyMHg2Y6G1NwPLVPJkM1tJDE3GpFL24OyR1jR70L/IPC2ZVrxGswRF+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1743A1007;
	Tue, 30 Jul 2024 09:21:47 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57E3D3F5A1;
	Tue, 30 Jul 2024 09:21:20 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:21:12 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v4 2/5] firmware: arm_scmi: Add support for tracking
 metrics
Message-ID: <ZqkS-G2QvplYNxSA@pluto>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-3-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093342.3558162-3-luke.parkin@arm.com>

On Tue, Jul 30, 2024 at 10:33:39AM +0100, Luke Parkin wrote:
> Add a new optional config option for tracking, configurable
> 	at build.
> Add methods for counting key metrics

This commit message is a bit messed up, BUT it is fine, NO need to
respin a v5 just for this, we'll fix this on merge.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

