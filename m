Return-Path: <linux-kernel+bounces-342605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8A09890CF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 19:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C031EB214C2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 17:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D94A14375A;
	Sat, 28 Sep 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjXHWoO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6B6225D4
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 17:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727544558; cv=none; b=Jljn9ZjWYKPvO4GwiG9OIpE8/HP5+wabWYaRtOfkNWFK1IJ9130xISNA5fp6obgCBarEpy0ia9lcso6JtkdjiEUKz5Ypnkny2yNPS3Kk4g+foKE305TImZmieHg2OrRiKuUNYllST3xrZMoMKeoPXHJ36O6P/+hFBuwpnnEF71M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727544558; c=relaxed/simple;
	bh=ZG+tG3HU5nKTTWRxV+jaidvjfAR2+qjcnfx9kft3H1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFtLUaBQUGt+aTJKWlOsi7KZ3FdGG4R6LCAF3CVvbXyUxJALXhzezGjcZEACe/KKBumalaYsps/bLGt8YCEg0fnvVMl3as8wUMvaOnE6MqPxf6wkS1/yRgZko+8xdxEZi2JvW81TJ5Qpdi6rppXYUKL9CnaGJ4ZEiLgddUf8qBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjXHWoO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82BDC4CEC3;
	Sat, 28 Sep 2024 17:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727544558;
	bh=ZG+tG3HU5nKTTWRxV+jaidvjfAR2+qjcnfx9kft3H1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjXHWoO7c9HEv1at6+xWIo0YBgIgev+7Yj+S0BV6RbQPCgFLo1B4JzD1MQbnbMtV8
	 6cRkGzO6ohPqCjJCX6r0wv78nIhrgXCf0q0VeCP0dT4Yd2TBEIpKkJPDZg3caUoFbj
	 gvs/ErNvCPXjK7yTzSjCdV29nuUIqQlJ4Mc83piD71VmgE0Lc+GYFDbvQtiVR6S5Mu
	 FhuFHjWUxp4er4WnRItx8UBnz7wRTv741Dk/xQwClgI2td2nCyPTZ0tEqzsN6LxySr
	 PSc9XqICXXch2pSGvfGDx9UExao3hX2BPfk67pIb8HDQ+RSQtLnbnMemAiNInOHzHJ
	 wLGqYUHLJWiNA==
Date: Sat, 28 Sep 2024 10:29:16 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Fangrui Song <i@maskray.me>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] .mailmap: Update Fangrui's email
Message-ID: <20240928172916.GB430964@thelio-3990X>
References: <20240927192912.31532-1-i@maskray.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927192912.31532-1-i@maskray.me>

On Fri, Sep 27, 2024 at 12:29:12PM -0700, Fangrui Song wrote:
> I'm leaving Google.
> 
> Signed-off-by: Fangrui Song <i@maskray.me>

Acked-by: Nathan Chancellor <nathan@kernel.org>

Andrew, could you take this change?

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index 0374777cc662..3faaa5f400c6 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -203,6 +203,7 @@ Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> <ezequiel@collabora.com>
>  Faith Ekstrand <faith.ekstrand@collabora.com> <jason@jlekstrand.net>
>  Faith Ekstrand <faith.ekstrand@collabora.com> <jason.ekstrand@intel.com>
>  Faith Ekstrand <faith.ekstrand@collabora.com> <jason.ekstrand@collabora.com>
> +Fangrui Song <i@maskray.me> <maskray@google.com>
>  Felipe W Damasio <felipewd@terra.com.br>
>  Felix Kuhling <fxkuehl@gmx.de>
>  Felix Moeller <felix@derklecks.de>
> -- 
> 2.46.2
> 

