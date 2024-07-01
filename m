Return-Path: <linux-kernel+bounces-236352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA8191E0FA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A59C1F23270
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395515ECC4;
	Mon,  1 Jul 2024 13:40:16 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D941E49B;
	Mon,  1 Jul 2024 13:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719841216; cv=none; b=p2v9hWnFndkEECOSy6x3PUG6KtVuIkatBi0FBHQHRShpd8+mqDfNM+6rNIRHBwH82pS2+t+rDKGSln0jDvitznXjDnP/0nEmaXOFL0HXnMFChE/i162NKnCXHq6rhfemFKG+e3d+5GhRC6BJHBJRb53sS3HYXg9NeMxcsrIwtUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719841216; c=relaxed/simple;
	bh=fp3YoHVKSvn0Qjc5vfracn3c5dWX7U8SoDiJgYpp45s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvrJoU7Hlnk6crzY8044Xhc0GKJnTdyoPQwEOI6snnW+07EOWDp/eHSh4Cp6PfOpcqhUnfxuLv27ExcIL3Q1NC+c6+lAaRS5yuwwGz2+TGfF1bMsjPa8t2orbXL7SJRVzF1Hvb2RPUJjFk0tzsDIW27/5fRXZ9saYoaNOR+veGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C1BA339;
	Mon,  1 Jul 2024 06:40:37 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 961B83F766;
	Mon,  1 Jul 2024 06:40:11 -0700 (PDT)
Date: Mon, 1 Jul 2024 14:40:09 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arm-scmi@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: introduce setup_shmem_iomap
Message-ID: <ZoKxucvEQwNNj6oQ@pluto>
References: <20240701030143.2327844-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701030143.2327844-1-peng.fan@oss.nxp.com>

On Mon, Jul 01, 2024 at 11:01:43AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> To get the address of shmem could be generalized by introducing
> setup_shmem_iomap. Then the duplicated code in mailbox.c and optee.c
> could be dropped.
> 

Hi Peng,

thanks for doing this cleanup, it is certainly needed.

Since I am in the middle of a rework/reshape of the whole SCMI stack at
the transport layer, I will pick up this patch of yours and integrate
in my transports-rework related series in order to avoid clashes with
all of my refactoring ... O_o (hopefully later this week I will post
something...)

Thanks,
Cristian

