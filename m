Return-Path: <linux-kernel+bounces-280907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCC794D0B5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170B2B2344D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876C7195FE8;
	Fri,  9 Aug 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GChuUNQl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF9A194AEF;
	Fri,  9 Aug 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723208326; cv=none; b=Wuj2wTW0c61rXrBzYmSgRq2FYxd7GVsSVPyPjjy5rH70WMm6VvdVHCTzR3gA3OEjYHHtBV1zDbiOU+utOpMbszsGnAFM+SG+GPkq+1IG6LznciWq4j55tEcq3M+NzTHyq9o+B0kIk2+ZBemfGZph1dWuP3eyybdurIb9GYtDAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723208326; c=relaxed/simple;
	bh=cAkY3m22VNEzj6y1ANIhyRk+wG9PJM8CYwVxMMiXIgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB07HvzOl3TaFhkLzQ5l1PlDCvFK4FzBFfhNI1yWIWkrgK3e9yEhG0TDL4Q79tNHKLl1t+qnwNg84yONya01kfSYPufxLCiNhj7s5PmN2cx9x2O/+w7nYTpVOD1jQQsXkvqVOEk05Ids4g97yn1MIVtoXTeMcbu8i3V/RMola8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GChuUNQl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9477C32782;
	Fri,  9 Aug 2024 12:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723208326;
	bh=cAkY3m22VNEzj6y1ANIhyRk+wG9PJM8CYwVxMMiXIgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GChuUNQlMCw0s31/fz2P+3VBe76BpxYbpHB7c3B8FeWHtNYX8Mkn/1/1ep2K5dnIk
	 xyi3tf+FHvAlpGDQoYAZj5yQqc4rlbKQGUJ0fLgL8vsWwCCljUFyTjaQxkyHvXFfgT
	 y2xpj5VSBpYAiCjEekQXM8EWAwle4Fy90vJNAQZjvAP3yOJ3qWZvCRgmGcLwtkl4C0
	 8DUV65BzpMDiiWLQQ2kPuKCfkOzscBnfxeZvgzQSBISYEW06Lz+Pgo9u6JwsNdyoA0
	 +sHlUyGzRU0H6WIYzshojuQynC26efJZpDsCYKUBmvjnmaLlFbYpxipMy5awlaMve+
	 775Yg4fyfcrlA==
Date: Fri, 9 Aug 2024 20:58:41 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Cc: chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: add remove driver hook
Message-ID: <ZrYSgVDwJwDpvp4u@tzungbi-laptop>
References: <20240726181235.920335-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726181235.920335-1-cascardo@igalia.com>

On Fri, Jul 26, 2024 at 03:12:35PM -0300, Thadeu Lima de Souza Cascardo wrote:
> This allows the driver to be unbound and bound again. Otherwise, when
> unbinding the driver, there will be leftover sysfs entries.
> 
> When rebinding the driver, it also ends up touching freed memory when
> adding to the notifier chain as the old one was not removed and ends up
> being traversed.
> 
> [...]

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

Thanks!

[1/1] platform/chrome: cros_ec_typec: add remove driver hook
      commit: a1927fbbf74f9f61eb5c6d1414037c97a8d942ab

