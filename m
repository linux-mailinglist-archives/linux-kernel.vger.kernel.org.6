Return-Path: <linux-kernel+bounces-197023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1408D6516
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B901F22C96
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFF674C1B;
	Fri, 31 May 2024 15:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRi4X51A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BAF7406C
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167652; cv=none; b=e7p7y5088IZex/BWzum93O7M1J9HzsY1rvTMv5sjmUThW/ynxkEDAVWqZBKPP7QFITNiB9/VL5KxDKhMnuPTutEuYPzdVBI+/y3M3EX+CTwgh52xraP1eC7MaeKmvzrhxSiWlo+7E80KTPfVgyfBYObZ9MSL9G/nggpdN1UbUhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167652; c=relaxed/simple;
	bh=4RjP91PklYITeHDXwHU/eFtBK/XClAbaP/R273zB7ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC81CUcvkDuyXbxtAwXJamOLaFBB3SGc3UQWmfL9ypz3wIDNSmlzMZo/eALj2e+G/hLB7l/Z5xnRj1bLPd2FVTnC1r3hFjB83A06tWoMrnPP0xrWiejKkpsYqcBudNonPb43iBp7eiQa5dHEbUu78OzSBzYB7KHvtZzCSJvx7tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRi4X51A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56EFC116B1;
	Fri, 31 May 2024 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167651;
	bh=4RjP91PklYITeHDXwHU/eFtBK/XClAbaP/R273zB7ZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oRi4X51AHt2LfXSr7VqBZwUgTjqHCodTz3zfR/DCo4p7t6pw4m11bt6JbGT9SsZdD
	 euGiJmJdUD28qW/Zxt7WUCEvFwbuJtdYVJNZ17yo36xup6JGq54nAgpAvHi0Co4Yj3
	 ItsQnl1JHU8QrfFGgQvObVC8ffXDdgWbt12UFt8bCfGn9igmybs9sMj/hzAPuKZW9E
	 i2tKLd5C9DARdpYak6RBky0EKNwM1EQPIN83ZiQqmfNg8YEMC4hbDFjrcnsqdC4pZk
	 8P8RJo0Nn9b9SvGD6kMjAT3YkGb4opNAONzCWM2wppSvLjniYgnvo7lfeueJLxOnJj
	 P0zr0uoT6rZnw==
Date: Fri, 31 May 2024 16:00:48 +0100
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/2] mfd: lm3533: Hide legacy platform data in the
 driver
Message-ID: <20240531150048.GO1005600@google.com>
References: <20240508104848.846580-1-andriy.shevchenko@linux.intel.com>
 <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240508104848.846580-2-andriy.shevchenko@linux.intel.com>

On Wed, 08 May 2024, Andy Shevchenko wrote:

> First of all, there is no user for the platform data in the kernel.
> Second, it needs a lot of updates to follow the modern standards
> of the kernel, including proper Device Tree bindings and device
> property handling.
> 
> For now, just hide the legacy platform data in the driver's code.

Why not just rip it out entirely?

-- 
Lee Jones [李琼斯]

