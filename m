Return-Path: <linux-kernel+bounces-379852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D39AE4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94C41C21786
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0791D5AB2;
	Thu, 24 Oct 2024 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMC9mC5G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CD01CF7AF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773140; cv=none; b=JWBWp0x1PPxUXGx24LAuh9txigFKqYkUzM08HDNaM8p5zmvwE+Rdii8I+jUNcNc2GsISKBXu9bJ5DdqRwyrPsYJFD63QfxlOHpRGItWeJR+wBglDWC07ySEmYXxLhrrGBlovuauh6n9+HjTdKEEGFJ8iRaUVxjSJCaQzvSIh78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773140; c=relaxed/simple;
	bh=Wd/KflD3TuIrYexF+RqDPBbsLv7X8c2ZJeNEkLJ+9Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8awz1VrKzsOMfB2Aq1bkskQe9W8T0wBCgxIPo4YaXcD1UoYoBPu9ZFZpGlBk8r6afJr69J1khN2BcDw9SDOMTcZvhBBrdPLXOsKoJvPw+uxo8yxj3c/7woOkUgUOew0bXuSwZ9hl0fzaTgsEGo6OECNvQ3/8XOWjmzVuKb3ZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMC9mC5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38110C4CEC7;
	Thu, 24 Oct 2024 12:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729773139;
	bh=Wd/KflD3TuIrYexF+RqDPBbsLv7X8c2ZJeNEkLJ+9Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nMC9mC5GVQvL557SJMJTQl6N8GXLEXz8m/cOr8+XNEm26Aa1tYfStcj38lAHJuYkr
	 /3l0KyJlhzwSfNa/F09PzatmeMxLtXUKlUgrSfb+mzpLdFN7KwrdNNyITuNTT9ql+7
	 aYn2n9KcaC0fnll0zYtSIg16XuS9kVKXLgXB+FBbfD9l5jkJCDuNxGkNY0uuS46oy6
	 q7B7FAgOpZ3G93HYyjWFAUU4S0DpFsCujlZFW8Kar+zBHh2Z/0DaYztQ+IFbnKCCiV
	 oVHUce9uUUHxwR/S55Up9+4uIvEI1n3BZqhZ6qQo+lKvVwRiBWOjk2iGUG02xiqWAI
	 axnVtltC7Gjmw==
Date: Thu, 24 Oct 2024 13:32:14 +0100
From: Will Deacon <will@kernel.org>
To: Gowthami Thiagarajan <gthiagarajan@marvell.com>
Cc: mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, gcherian@marvell.com,
	sgoutham@marvell.com, lcherian@marvell.com
Subject: Re: [PATCH v9] perf/marvell: Marvell PEM performance monitor support
Message-ID: <20241024123214.GB30704@willie-the-truck>
References: <20241016131457.3821256-1-gthiagarajan@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016131457.3821256-1-gthiagarajan@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 16, 2024 at 06:44:57PM +0530, Gowthami Thiagarajan wrote:
> PCI Express Interface PMU includes various performance counters
> to monitor the data that is transmitted over the PCIe link. The
> counters track various inbound and outbound transactions which
> includes separate counters for posted/non-posted/completion TLPs.
> Also, inbound and outbound memory read requests along with their
> latencies can also be monitored. Address Translation Services(ATS)events
> such as ATS Translation, ATS Page Request, ATS Invalidation along with
> their corresponding latencies are also supported.
> 
> The performance counters are 64 bits wide.
> 
> For instance,
> perf stat -e ib_tlp_pr <workload>
> tracks the inbound posted TLPs for the workload.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>

I think this Signed-off-by: line from Linu is new in v9. What happened?
I notice that Linu is listed as the driver author:

> +MODULE_DESCRIPTION("Marvell PEM Perf driver");
> +MODULE_AUTHOR("Linu Cherian <lcherian@marvell.com>");

but the patch author is you, so git blame will be inconsistent.

Please can you make sure that MODULE_AUTHOR and the patch author are
consistent, and then use Co-developed-by as well as the additional SoB
for the second author?

Will

