Return-Path: <linux-kernel+bounces-401431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A43199C1A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9921C22A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9601E2600;
	Fri,  8 Nov 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb7SeBLx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D4119259F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731061513; cv=none; b=SBzV1uCAqyKTCTsWvbvA3mYsrP7v0dXf1NcVRXCjUTohqKTzJA1A1iuKceeFVpTvkYD+EmGSnWOmdiyTdZfVRWq6xr2dSUOap28gbdss/z8RGJiCKEYPEhBwszCGU/jr271Nst9qqfpcBkuqu5CYCJcxAaGw5bJ0I/Ht5IubC0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731061513; c=relaxed/simple;
	bh=kl33zYAFIppqdQFBZYFvJVhFufqIS4wslTTIJSzed0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9cNQe4dFCPawqJgv5QQgbLwvpZeQSZseerTg+Td1RhgA4X7wOm1cw4b4wLdP5HAksuwASEry2rZhUbKGONVc9f/XoJ70e7UVqf/D0lhMUQ0NOB9I/DIa0mbwFJAtvCiFPeBtAKIT3oHh4mf1LjA8LvUWbTiH0O/lxwmyZf1rsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb7SeBLx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D679EC4CECD;
	Fri,  8 Nov 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731061513;
	bh=kl33zYAFIppqdQFBZYFvJVhFufqIS4wslTTIJSzed0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nb7SeBLxhTgeo+AdoNoxl7gUv+a4T1l8oM6pxz4QxmKOhsu1azsKtDcyh8ZzPB17j
	 6Sn3EW+E8s61sCgGUB6cuFvTzvSiU5xE1unr2KFlN/K5ZMh4NkIGDsXE6QYSc5Mbnb
	 /mdt488LVHVPYOWR4pY5dAAU/+iyYnsfk/MugwkBC9Wgt1iqm1uhco7vOonvAQhFtj
	 j5hTo83fggEo0axcRMotclvntjQa/OM1qZk9x9++8CKJpSYPZ3YlL/XMj5bpxRHNL2
	 oGYTWLRvCeqgFNdx6GjLG/LkI56ReEWWvGzu5hh7z0Jys/hRB2HYJwVO97oqXRdTFX
	 Q63KdRRBLzL+w==
Date: Fri, 8 Nov 2024 10:25:09 +0000
From: Simon Horman <horms@kernel.org>
To: guanjing <guanjing@cmss.chinamobile.com>
Cc: rogerq@kernel.org, s-anna@ti.com, nm@ti.com, p-mohan@ti.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixup for "soc: ti: pruss: Add helper functions to set
 GPI mode, MII_RT_event and XFR"
Message-ID: <Zy3nBW3XvFy-Y1Fe@kernel.org>
References: <20241108055507.173622-1-guanjing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108055507.173622-1-guanjing@cmss.chinamobile.com>

On Fri, Nov 08, 2024 at 01:55:07PM +0800, guanjing wrote:
> Fixes: 0211cc1e4fbb ("soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and XFR")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>

Hi,

I think the subject should describe the problem rather than how the problem
got there. Perhaps something like this:


  Subject: [PATCH] soc: ti: pruss: remove misplaced semicolon from pruss_cfg_xfr_enable

And I think it would be best if there was a patch description. The problem
is self-evident, but I think it should at least be stated. And some
information on how this problem manifests wouldn't go astray. Something
like this.

  Remove misplaced colon in inline variant of pruss_cfg_xfr_enable()
  which results in a syntax error when the code is compiled without
  CONFIG_TI_PRUSS.

  Found using ...

> ---
>  include/linux/pruss_driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
> index c9a31c567e85..29a76a60869c 100644
> --- a/include/linux/pruss_driver.h
> +++ b/include/linux/pruss_driver.h
> @@ -167,7 +167,7 @@ static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
>  
>  static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
>  				       enum pru_type pru_type,
> -				       bool enable);
> +				       bool enable)
>  {
>  	return ERR_PTR(-EOPNOTSUPP);
>  }

FWIIW, I believe that in order for compilation (of
drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.o) to work without
CONFIG_TI_PRUSS the following is also needed. Because there is a mismatch
between the return type of these functions and the type of the values
returned.


diff --git a/include/linux/pruss_driver.h b/include/linux/pruss_driver.h
index 29a76a60869c..2e18fef1a2e1 100644
--- a/include/linux/pruss_driver.h
+++ b/include/linux/pruss_driver.h
@@ -144,32 +144,32 @@ static inline int pruss_release_mem_region(struct pruss *pruss,
 static inline int pruss_cfg_get_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 *mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_set_gpmux(struct pruss *pruss,
 				      enum pruss_pru_id pru_id, u8 mux)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_gpimode(struct pruss *pruss,
 				    enum pruss_pru_id pru_id,
 				    enum pruss_gpi_mode mode)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_miirt_enable(struct pruss *pruss, bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline int pruss_cfg_xfr_enable(struct pruss *pruss,
 				       enum pru_type pru_type,
 				       bool enable)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 #endif /* CONFIG_TI_PRUSS */

