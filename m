Return-Path: <linux-kernel+bounces-236555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1122E91E3EB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C14332856C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B716D4D4;
	Mon,  1 Jul 2024 15:20:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1482F15A84A;
	Mon,  1 Jul 2024 15:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847257; cv=none; b=QqKLv16VSxxLfeNdzWDdWwArrdaXRsKjwNYSUInBM1Xt5rl3x+gvsRbxV1JpMGlbOYboScb6LAocvv/FM0mWL+Rzs69mTe2IdMEM3DA4ouyD1V9t+We1MYZMHV1Q9Gp/EqWSsrsWrNzhgz0RO6+KalwWzoXTNml5Zq1OavHFrII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847257; c=relaxed/simple;
	bh=M4jwutQQg+w0C+F7XN38u/Gf9eVj0pBlhgXe61FHLHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU4DPA6YjttljH7rCoTu6U+OQq0+xFUdv7TaoyqN/rOB2L3z+wIwkzmMROsOKYL4Htq+ZNV/YGKHJBD7NAum1cOOputaLi8mBsv8SXt5MlDLjiGbl4zcj9UJc8B5EpIeobo0Gg7FYRPufWRlShStf/qJRd0U+pXJGS4E0uaCnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B4FC339;
	Mon,  1 Jul 2024 08:21:20 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADD903F73B;
	Mon,  1 Jul 2024 08:20:54 -0700 (PDT)
Date: Mon, 1 Jul 2024 16:20:52 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH 0/3] Add Per-transport SCMI debug statistics
Message-ID: <ZoLJVKqx0erHdmyl@pluto>
References: <20240701142851.1448515-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701142851.1448515-1-luke.parkin@arm.com>

On Mon, Jul 01, 2024 at 03:28:48PM +0100, Luke Parkin wrote:
> Hi,
> 

Hi Luke,

thanks for taking a shot at this, a few comments down below and along
this series.

> This series adds support for tracking Arm SCMI statistics, [Patch 2]
> A config option to enable this, [Patch 1] 
> And in [Patch 3] a selection of new debugfs entries to present these statistics
> 
> These statistics are per transport instance, and will be a helpful resource when
> debugging the SCMI and running tests.
> 
> Based on v6.9, Tested on Arm Juno [1]
> 

First of all a nitpick on commit messages themselves...when posting patches on a specific
subsystem, the commit message "style" should align with the subsystem conventions:
IOW all the patches in your series (beside this cover-letter) should be titled as:

  firmware: arm_scmi: My patch starting with a capital letter

as you can guess having a look at git log --oneline drivers/firmware/arm_scmi

So please do this in V2 together with other reviews.

Thanks,
Cristian

