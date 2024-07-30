Return-Path: <linux-kernel+bounces-267877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB0994187C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BB51F23062
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36A41A619A;
	Tue, 30 Jul 2024 16:22:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB291A6161;
	Tue, 30 Jul 2024 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356554; cv=none; b=QbALzAFVuNnM0lg+90vyrrDtT5hfRUXTgDkUGIKjVo+h9p4HqTpi0M7NdWfxa+DPqHpWBXy2YrJFgm2wlDGM7dnYerfoOIF8VNM8IqTlc1qPbakpQtbWaf1UeQeoZkhzBgI8a4ysSMIO7fYqzWMaHaRGUW8jvHIRraUhE3EPt/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356554; c=relaxed/simple;
	bh=HPQ3woMNdHUlY6+PRLZwYS77o2heqzbU5nAveGUbw7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmKhwGKcdwJq133GPnyoHIXzM4mRo/SRLa8H98+UHyLHef6X9uIpRCFFErOHJtXVlxSPWMqoZosRUg9qWAIo3BqHuOU2MHnSx6xhQoT4OC3DhwiacBcrcbzrcRbORyP1cCPJw+XdhKXpDNJrURQiyB5O0r7+mtm4U8meMw4IUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E510F1007;
	Tue, 30 Jul 2024 09:22:56 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CC5F3F5A1;
	Tue, 30 Jul 2024 09:22:30 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:22:27 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v4 3/5] firmware: arm_scmi: Track basic SCMI metrics
Message-ID: <ZqkTQ0CTo61DSnVa@pluto>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
 <20240730093342.3558162-4-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093342.3558162-4-luke.parkin@arm.com>

On Tue, Jul 30, 2024 at 10:33:40AM +0100, Luke Parkin wrote:
> Add counting of initial metrics
> 

LGTM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>

Thanks,
Cristian

