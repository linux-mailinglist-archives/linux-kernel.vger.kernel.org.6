Return-Path: <linux-kernel+bounces-297070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F7A95B29A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB1C28331E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742D17CA19;
	Thu, 22 Aug 2024 10:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzbZxvz5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C561CF8B;
	Thu, 22 Aug 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321203; cv=none; b=TMHMizs8oFjbHRKyWqjXCBz3G+3rZYEvbhMXwafstfPWGBP328x2aeGEbF5hcaIB/hn0M414nQixaeebcaDfG3M59PUHRPJivqaVx/C3A+30HqbHqqt/vUBLT8iwaOEZc7p3CU+KUSNywa/zPmbzQH/gbaBv6NICdj7NIRGH27I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321203; c=relaxed/simple;
	bh=JPyQgjPOezZM4QKJsyK1eSVg8qC0xtG6RWC6q8JuiKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq5SP9oArlMRphM81o2kBCQ/vYx8KvLULdX/dubEFQu47cj1BRMYbbK8LKJ0JLM1l+V5xrUq7VP+OXp9L+E0XTYtyAPpFMhhKhacYEbsNEZmKlTdAijtLcJvQW2R8VTzKppXhNFxaRSnbMssRsJwgJC22JjwNIPxTq9GDsANVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzbZxvz5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D42C32782;
	Thu, 22 Aug 2024 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724321202;
	bh=JPyQgjPOezZM4QKJsyK1eSVg8qC0xtG6RWC6q8JuiKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzbZxvz5lzvZZ9MtyLrSq6YAxdXbej+YZVbnqtR/4Gd26zybBU8Pg21e1rf7nsLYL
	 MeynED6M8P85fiLjANuBsGDNhh7CgrAfraCM0fOyAtAq9cvTA50KLELEuzDwXHUN4o
	 zqV2BVq6G8PzksvoINqXoqLFnG7iqw7PDufjL5eAhxI7G3oin8XNs+8+V1KsWYzipa
	 AdDQ2e/Z3auJHDNskoen5mH1tZV/iFWDKxIZhRo2zSWoWbZxLOtYn2AM0XANRVNNNn
	 n7H6FX7zvLzN+zPl7WvsQL9iTKZqxXYB9IMKVscT6fL2/NgyA9taSvfHdRk6348iaA
	 v+RrJ8jeMcBrg==
Date: Thu, 22 Aug 2024 11:06:39 +0100
From: Lee Jones <lee@kernel.org>
To: tzungbi@kernel.org
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec: update module description
Message-ID: <20240822100639.GF6858@google.com>
References: <20240819102342.5265-1-tzungbi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240819102342.5265-1-tzungbi@kernel.org>

On Mon, 19 Aug 2024, tzungbi@kernel.org wrote:

> From: Tzung-Bi Shih <tzungbi@kernel.org>
> 
> The module description can be backtracked to commit e7c256fbfb15
> ("platform/chrome: Add Chrome OS EC userspace device interface").
> 
> The description became out-of-date after a bunch of changes.  E.g.:
> - 5668bfdd90cd ("platform/chrome: cros_ec_dev - Register cros-ec sensors").
> - ea01a31b9058 ("cros_ec: Split cros_ec_devs module").
> - 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd").
> 
> Update the description.
> 
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 55b30076763b..8a22bd31a707 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * cros_ec_dev - expose the Chrome OS Embedded Controller to user-space
> + * ChromeOS Embedded Controller MFD
>   *
>   * Copyright (C) 2014 Google, Inc.
>   */
> @@ -377,6 +377,6 @@ module_init(cros_ec_dev_init);
>  module_exit(cros_ec_dev_exit);
>  
>  MODULE_AUTHOR("Bill Richardson <wfrichar@chromium.org>");
> -MODULE_DESCRIPTION("Userspace interface to the Chrome OS Embedded Controller");
> +MODULE_DESCRIPTION("ChromeOS Embedded Controller MFD");

Please drop the term MFD - there is no such thing.

>  MODULE_VERSION("1.0");
>  MODULE_LICENSE("GPL");
> -- 
> 2.43.0
> 

-- 
Lee Jones [李琼斯]

