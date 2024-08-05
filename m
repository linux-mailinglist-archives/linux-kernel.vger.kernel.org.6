Return-Path: <linux-kernel+bounces-274828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20891947D4E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 16:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CB32813B3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB8313BC2F;
	Mon,  5 Aug 2024 14:55:18 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080FA27456
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722869718; cv=none; b=oHn8cZW6yUDp13abLI0Hipyk3S8CltaOQKfxVNTNSpwQlUFjE4VJm/2IpF2U5HpeaT9ykPP1zJI8bUubEGYhoc9VFawSFH94G2iraMgnB1HBhGByqzwDWh929acMdYLHsz0yrk9QNh9aCtdlymXgGIUyo+AQWMv28jArK29qwGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722869718; c=relaxed/simple;
	bh=2OnQEzKRuyuKugV+uikpCk6esjxt7uvNxPc1Ay6v8AY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZAQq7TpIXd8dbshtl/P0k5tGOppYknrsdb2Sv4Go85O4f9FHJ3KNgRIvIf9yp43mqCnOVNIXM5BIXg13nx/BQF4LCwn5N48+XEloS6my7Djr8D2X8euu/Ejl2cT0h3pH79Wz8fAlm3q5Uz8Gsxp9OjPXvltv3C0mE3/KVOC/WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E28BC32782;
	Mon,  5 Aug 2024 14:55:16 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:55:13 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: will@kernel.org, ardb@kernel.org, msalter@redhat.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] arm64: mm: Remove unused declaration early_io_map()
Message-ID: <ZrDn0bt7sBm4CkzC@arm.com>
References: <20240805140038.1366033-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805140038.1366033-1-yuehaibing@huawei.com>

On Mon, Aug 05, 2024 at 10:00:38PM +0800, Yue Haibing wrote:
> Commit bf4b558eba92 ("arm64: add early_ioremap support") removed the
> implementation but leave declaration.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

The '-next' in the subject confused me a bit. We normally use it when we
fix something that's in linux-next only. Anyway, the patch looks good
for 6.12.

-- 
Catalin

