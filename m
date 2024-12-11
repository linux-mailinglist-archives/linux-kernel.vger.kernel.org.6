Return-Path: <linux-kernel+bounces-440828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A28A9EC4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 07:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E801692C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 06:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A15C1C461F;
	Wed, 11 Dec 2024 06:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cx5oqhBG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4DB1B0F01
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733898980; cv=none; b=M2Bg1gRqqoKVORsbYq+pk67ixsL5hRddibqSqq2GhFOLUwjicrcVL2DO4DRTaBjfDOZ7fCE+sPS0IaoBh+0Ys+vQivJBn/MnRKtNkLzItXd7BaCi6Y7+5bOW992mdGVQlegzRHpF/FJ8OHysdNyItG8+JYVn/akwNA6XoSgrxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733898980; c=relaxed/simple;
	bh=1LwwGMKNDqPsac81Y7Muz/cGuZMV03YXn285uPa5UZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYPYQI2hhlyQMqCFY0AJsfuTcEO6KzIEhnqmQW3fh9S5OEZB6gWsuQRUdvCkd1L4H8uyzw4yPuLt6ZV5MFpjXIX2fbGjXUmfvxGeHzxM+/CLFHl+WCa93deJRJbjDIoQnwJrKTF7fSjjxNS22LJV1ygBqTxvDILEfLMPPiNeQGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cx5oqhBG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD736C4CED2;
	Wed, 11 Dec 2024 06:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733898979;
	bh=1LwwGMKNDqPsac81Y7Muz/cGuZMV03YXn285uPa5UZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cx5oqhBGB+zgLEc6q5GTEToREz/RutI9R6HRe7rQFhDKoXzjosArKo22jJdI7TgC1
	 NbgLpwdafpNipv8GtIC5y4gQququI2P1Tl+gUn6+KopYc+sQ/zQpuKeKtFE7gDLIjY
	 lDvILmZkEUCZeugT77G8Xh72uMhsWkY0hWokxhnPnUijRxs/VIQQYM1rGu84S5COrZ
	 +AYaCLC36D5LlIW0Ai9IATPLvmC8VEF9CJKP40RJln2zyMa8HSfLoDlhPnw6gCD5yB
	 cRNpYNijsvnsIa0j2U35/PGfjRNXGqjl5DqHOJPKkvdBJH0piAcRa+oimDhZYSNFwU
	 ELEHmYsYQYqHA==
Date: Tue, 10 Dec 2024 20:36:18 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add self as reviewer for sched_ext
Message-ID: <Z1ky4nj28ZGk-WFr@slm.duckdns.org>
References: <20241209174501.748908-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209174501.748908-1-arighi@nvidia.com>

On Mon, Dec 09, 2024 at 06:45:01PM +0100, Andrea Righi wrote:
> Add myself as a reviewer for sched_ext, as I am actively working on this
> project and would like to help review relevant patches and address any
> related kernel issues.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.13-fixes.

Thanks.

-- 
tejun

