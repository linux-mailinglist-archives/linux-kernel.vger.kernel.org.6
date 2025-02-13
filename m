Return-Path: <linux-kernel+bounces-513499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6670EA34ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC93178622
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54E245AEC;
	Thu, 13 Feb 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnmCJccJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D482524502A
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465199; cv=none; b=IvQbGtLVKkvv4dIcGVJzioEiFUZT5hHXTBR3cANsNTaqhUIEHpuQW5P/Qz97edbDZ7Fp32gei0ldK2BIv+ts9UilcKVrtr5R0sPLJVPj5m06CjBmQli4i4JvRTTTtzmw+sptA8M47Dzlrsx66lxNbNd3tpTpnAI3Z1JKtfoCtNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465199; c=relaxed/simple;
	bh=7MnmMrnzdp7Tha9+9t2+bcP9SACYRnNvBdJrozvaUgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNX1CCBIlXqUlwfLx1zqixpXJ9otOwV8TeQQn8RO069SIO5PS2SfCQ4h9WrLLk237msKHd5G/Z4Ms+Ce+XsHmCrBlhUAleiw/+TyPOUHDp+opxJvXYAWn0Qmg4qxqRaR3tbHXg7eHIRw8+ZQhjrOB7Ok0vJLUZr1F++TCeKLdA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnmCJccJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37912C4CEE4;
	Thu, 13 Feb 2025 16:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739465198;
	bh=7MnmMrnzdp7Tha9+9t2+bcP9SACYRnNvBdJrozvaUgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RnmCJccJlU8PUjGmVOoioKFlGWP/uhKOSRgfkWP2+Bn8oxHVE14A/eL3KTU9a7Q2j
	 O9ZUQTVMnO1xiGm5ge7B75boa+/IgH6pypFygFIU11wxgJ85MxN2sF0V0IybXnuiCq
	 9Lj69/OZVOf61S4XCYRA+4keS0Qhi4GTogz8mVAH2cDuqXskMc3h70iDYPSD9NXp+f
	 rNJg6/NLE/MvN+sW0gEOSHkYGHBYPjL+Ms/WesfxgbeEDgDYiqFjjkeoz1tse6VTIU
	 VPwYMElVY6LPUVfIbYnELorifjk1Mb7ecBZcnjBW23gzUy/q6BtpGRBkdSdQEmL4lS
	 NQK3LKzhLaf7Q==
Date: Thu, 13 Feb 2025 06:46:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Devaansh Kumar <devaanshk840@gmail.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] sched_ext: selftests: Fix grammar in tests description
Message-ID: <Z64h7dCnOwo3SM4m@slm.duckdns.org>
References: <20250211171851.1518556-1-devaanshk840@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211171851.1518556-1-devaanshk840@gmail.com>

On Tue, Feb 11, 2025 at 10:48:48PM +0530, Devaansh Kumar wrote:
> Fixed grammar for a few tests of sched_ext.
> 
> Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>

Applied to sched_ext/for-6.14-fixes.

Thanks.

-- 
tejun

