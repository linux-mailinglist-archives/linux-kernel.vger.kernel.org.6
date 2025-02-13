Return-Path: <linux-kernel+bounces-512187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875A4A33560
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 03:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23D4D188B0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64CB374D1;
	Thu, 13 Feb 2025 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtKKpE9P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC613635E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412921; cv=none; b=hFNkhx+SaEq/7Nm9WHr8+liYoziFgxEN6m7EnEfMteR6PTdjUIotYuLGC89Jf3ZuD+gbRNPalvoAWwNsBN/uaZUZuWEmvKjPmyUlQCDZejengC03XBbChE5tFzya+Q1GZTzjE14TDpuLXtVzIBGeWVtG5Blexe5BYEpG7OvrN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412921; c=relaxed/simple;
	bh=mST8ETe+CoH5pqNO25ZA1AqNJb2gdz1ovJLhGwKV+dE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oetNkNhtwupaiKsZQvrn0zGRMCDtdEsbLCPPR6JBnVCcdPtUd6wI0ylM3JwR4V2cyiy63FuxmSW85qINOB/z3dvnFDSYXjOqkX8PxDhnZ+ifSF3NIyt95LGVf64AbjQactbyiW7ci+8/+za8T+2nUvnw3S4MNWu54Tgw4ud4Q3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtKKpE9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F9C4CEDF;
	Thu, 13 Feb 2025 02:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739412919;
	bh=mST8ETe+CoH5pqNO25ZA1AqNJb2gdz1ovJLhGwKV+dE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=BtKKpE9PonSp0lPpeWz7EJsN+PgWl41JO7RTvooEYrMe79IyxCikI/btG5LnqRqW8
	 jpdt9zr+uF20uusDJhY0g4DKMyWe7Pe8UXdg/Gsmo1QhYkqyQaniZsxKtgc3xt1Tob
	 zA03hq7JMGro3Zy7xLB4X1s3K8NP5vl13fqc6y/MLokFHZBrwmOslcI0+OTP5cD0zP
	 XteyVjg9iSWr96fOdYgUbZFmiVelDieApaRODn5miAsg+gALnaaiVGMaeQvqZCpgpv
	 Ku4WMzQXgS5I5EjG/i3Vm1IiO+UG6B+UTXWAz7Lek8g84osc7loJea6dhF6Ef5D0kH
	 taePXCTRXYHgQ==
Message-ID: <cdd5f34a-51dc-40f4-89f6-70179c7b738a@kernel.org>
Date: Thu, 13 Feb 2025 10:15:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: add a sysfs entry to reclaim
 POSIX_FADV_NOREUSE pages
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20250212023518.897942-1-jaegeuk@kernel.org>
 <20250212023518.897942-3-jaegeuk@kernel.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250212023518.897942-3-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/25 10:31, Jaegeuk Kim via Linux-f2fs-devel wrote:
> 1. fadvise(fd1, POSIX_FADV_NOREUSE, {0,3});
> 2. fadvise(fd2, POSIX_FADV_NOREUSE, {1,2});
> 3. fadvise(fd3, POSIX_FADV_NOREUSE, {3,1});
> 4. echo 1024 > /sys/fs/f2fs/tuning/reclaim_caches_kb
> 
> This gives a way to reclaim file-backed pages by iterating all f2fs mounts until
> reclaiming 1MB page cache ranges, registered by #1, #2, and #3.
> 
> 5. cat /sys/fs/f2fs/tuning/reclaim_caches_kb
> -> gives total number of registered file ranges.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

