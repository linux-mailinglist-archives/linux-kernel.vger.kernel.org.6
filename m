Return-Path: <linux-kernel+bounces-267902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE65941A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 18:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3001C232D1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D21189513;
	Tue, 30 Jul 2024 16:41:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40561A6192;
	Tue, 30 Jul 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357697; cv=none; b=E2XM/vebUVB7PtUZraDQqakQwHRBwxEjBfeCuO0V3UWkewmwqCfK33AC4QaXL/ARFyh9pL2w/zAGA72ES1pWD317Jcv+jJylHZh1stPgZL2rovwMUJE2nQemvR1SJ2zfQ6O6LpqaNXzleRYsqPlnNfkUvQBLArlR/NOvHY1zNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357697; c=relaxed/simple;
	bh=EtPEL1Nf9EXLM+pG1wvii6IcIpXv5FfRQ4NRRjBZPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMETwNa5eU7cL4EQNWCE+U2M0RWmP8awMQiWuOLM8TE6uKErKN3uXSuL7izxd6MlqcoqbGPIO95VBRFeQjs1fa5f6WK3q0WduW1jJl7FaKCDSbpVxbOiF5oxHdj5Q/dvuI+lrrcdHPAovnNq7TT6ehP9Ro+DXRi7knypYD2XDT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A013A1007;
	Tue, 30 Jul 2024 09:42:00 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0F8B3F5A1;
	Tue, 30 Jul 2024 09:41:33 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:41:31 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Luke Parkin <luke.parkin@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, sudeep.holla@arm.com,
	cristian.marussi@arm.com
Subject: Re: [PATCH v4 0/5]  Add Per-transport SCMI debug statistics
Message-ID: <ZqkXu4ccY9BS0_I9@pluto>
References: <20240730093342.3558162-1-luke.parkin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730093342.3558162-1-luke.parkin@arm.com>

On Tue, Jul 30, 2024 at 10:33:37AM +0100, Luke Parkin wrote:
> This series adds support for tracking information about the SCMI [Patch 2/3]
> A config option to enable this [Patch 2]
> Cleans up a unneeded call to handle_scmi_info [Patch 1]
> In [Patch 4] a selection of new debugfs entries to present these counters
> Then finally in [Patch 5] enabled writing on the debugfs entries to reset counts
> 
> Based on v6.9, Tested on Arm Juno [1]

Hi,

seems good to me. (...you have NOT rebased on v6.11-rc1 ... but it does
apply cleanly anyway apparently...or you dont have updated the above :D)

... anyway...let's see if Sudeep has any remarks...if not this will go
straight into -next soon so that bots can keep on bothering you on my behalf :P

Thanks,
Cristian

