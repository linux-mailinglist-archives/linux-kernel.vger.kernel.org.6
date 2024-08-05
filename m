Return-Path: <linux-kernel+bounces-274860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD37947DC0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830981F21875
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBD1149C69;
	Mon,  5 Aug 2024 15:12:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FA2BCF7;
	Mon,  5 Aug 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722870769; cv=none; b=ub4nw7sLKdFPoVxe5k23qdkZobkKJ7XdgVCa4r51geaf/zeg9Thg3qqNHzTQ4L0s9Du5wiZe49uQ4UcNv9U+rTOaWSabJX7N2m8xScUjoFF34cvIDDfbpXWO+Wtypon52ijctlLj3ONJTyZQH9JXcj34L2jW1Bx/g+Vrpr+2siU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722870769; c=relaxed/simple;
	bh=wYZd2Yw4qEEej6r+Py+PyhAzdVhFQg5Ak4FiQ0lDUpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4v6nrZ+FWfpm4wRILhKQ0APznpyeBfbm1zaYcpiPmDAj8WHDZDobOcU3R8vR2Mu5p7OqPgAm6G9SpFm5CXcOeXQCrSGz9vk+NTmuV9lEHUVdLwZG5WRCvVuFZwfegwfV3sz9L29HDJMAGar3dB/OMubVDczAGCohbuvzHm44HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29DCB106F;
	Mon,  5 Aug 2024 08:13:13 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 763A43F6A8;
	Mon,  5 Aug 2024 08:12:46 -0700 (PDT)
Date: Mon, 5 Aug 2024 16:12:33 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v5 0/5] Add per-transport SCMI communication debug
 statistics
Message-ID: <ZrDr1tDPE2A593s9@pluto>
References: <20240805131013.587016-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805131013.587016-1-sudeep.holla@arm.com>

On Mon, Aug 05, 2024 at 02:10:07PM +0100, Sudeep Holla wrote:
> This series adds support for SCMI communication debug metrict tracking.
> I am just sending on behalf of Luke with minor reworks in his absense.
> 
> Cristian,
> 
> I have retained your review tags, please shout if you disagree.
> 
> Regards,
> Sudeep
> 

Hi,

LGTM.

If this is what was on Fri on your next, I gave it a go on my setup
too.

Tested-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

