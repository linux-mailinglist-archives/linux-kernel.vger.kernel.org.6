Return-Path: <linux-kernel+bounces-557176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABFA5D486
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94008189A0B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A75165F13;
	Wed, 12 Mar 2025 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqoGY/xy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B2C18991E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741748013; cv=none; b=BcIEsJFpZ7FFFYwiUhmGauQXpVNYqrP0YcT5ZiIsQRQ+gIQuo5bU/IxmO0OJfXTp3q5FYAjhhz6bgpaMuWlQ2o5nDJVPzbScqfGxKOfMFYOtgiahiaMtzt+YCigg/Rda3jS/SuEdZLltHfVpLiiQgzFm3139PENKB/UbbOUtZcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741748013; c=relaxed/simple;
	bh=c0nPNHMEj2EaB+IMjd+p9+tgLxA5qJUbIMyOKfrGB2I=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ehytY0XCe+L3+AEorHhWyfzIWtcfkgDRi2t/Osnf3soyA+Awcpm/gX0q5utiZHxG1LJuwH/n3uVhaWoXxy8nLIgpOBmEJhKJkMwcC6WTbS0cKg6rPUfIqm8r7OZbvhMeL8lFbsjKeBlq6FLKE3DquKYfweWI2eu1xdRX343oBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqoGY/xy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6490C4CEE9;
	Wed, 12 Mar 2025 02:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741748013;
	bh=c0nPNHMEj2EaB+IMjd+p9+tgLxA5qJUbIMyOKfrGB2I=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=cqoGY/xy1CZSuwHMNm7+wcJRMr9dw75RK2vLwdY0xXWJSU+bhYoBY0Dzsu+9/+bqB
	 HlUX8ofx31wB+3Tib/NN9pEfjUS6tfe50oy11L4KFpAkfEYcfsBu3aaVP22H8kE01y
	 NErHMhVKZDFMV3kHCtDPfS3XqQHVNESNdkPeRorE4zCjIRAGSC3H3nC1a7i0YLHP4X
	 504lcEBts1wOk/fO+NvvE72KjT1MKjtkTlup8CoKwmrj5rAkQ/aRFYKteLL4mljzFH
	 ZEkt8M4qRbwjVsCeTcTJYcx/x6cU7DH8/rcsp4bFhcLWxMInsSNY4N/6xFJu5nLdvD
	 oV6GtYJb7cOLg==
Message-ID: <7de8de7c-4dc3-40c6-8435-122f72944850@kernel.org>
Date: Wed, 12 Mar 2025 10:53:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: add carve_out sysfs node
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250311182931.1043290-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250311182931.1043290-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/12/25 02:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For several zoned storage devices, vendors will provide extra space
> which was used for device level GC than specs and F2FS can use this
> space for filesystem level GC. To do that, we can reserve the space
> using reserved_blocks. However, it is not enough, since this extra
> space should not be shown to users. So, with this new sysfs node,
> we can hide the space by substracting reserved_blocks from total
> bytes.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>



