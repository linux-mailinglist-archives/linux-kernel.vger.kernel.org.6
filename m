Return-Path: <linux-kernel+bounces-563305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD2A63D12
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520E516BE18
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888212080C3;
	Mon, 17 Mar 2025 03:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4YmSqK6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9E1FAA;
	Mon, 17 Mar 2025 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182127; cv=none; b=gvI1AwOPO6EO2oOqPfepu5mq2xoP7N6r3i78ekIIQo1S5bV8TIx4PAB7i6h26RxsYxiV+VK48BR1x/K3ciwnmk3RmtI8NakhrGN6yI6DeYaxVuVXr44zBpH8sSwL3YOSeyEJ+OnMH9AQu9uH9wZAWkIqGseeLD1ZQutzLhN1wls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182127; c=relaxed/simple;
	bh=D+FxkY/P5bIf3YRt/5c6e+SSalHrVCp4WMlM8rBOt/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izu8qlmkz5genF28xlCpZtWJM6q/KQmC8NcOzY5W+h4ORVZknTU8NODhe/twEqFwsUmimy0QAzUZcBg+Ha1higcgj3yZWtZZgUoTksRF7efd7uio1z1WuXF6B3VFExbHeuLnAnncnqXKnIeBaTsjxMBxBSoNo1i9lCbZj0dlMsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4YmSqK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2B6C4CEDD;
	Mon, 17 Mar 2025 03:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742182126;
	bh=D+FxkY/P5bIf3YRt/5c6e+SSalHrVCp4WMlM8rBOt/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M4YmSqK6p08H7tX8oxssyGbGOEvX4/yAVNEW3bsk5KeywYcdeHpeRJjRJfLTC6t5A
	 6+VDNLKVPWBMLSA/2np4SMkFvNIMcZP0RVfo5X+BDZx0U1xtt2iOmdhmgBTnvvXeqv
	 Nk8WagCLvB8w9tNpe5n6VqPTROiyMwDL9TuvY2SZBqJkzP9mWG7QkJiZngGy9sHvnC
	 ABhf7YjA8gecI+5NnTBqHLUmzdQlMA27THNOgihtpmKjILnJLBTV41oCt4ZuG541y4
	 cnRMBezY4LvX6CPDxiAvI0qX9NykQUt5bi/3LMc8yQnn/643Na6Tc72bmCSzZcdnqi
	 Is7XsZoT9n3EQ==
Date: Mon, 17 Mar 2025 11:28:40 +0800
From: "Peter Chen (CIX)" <peter.chen@kernel.org>
To: Li Qiong <liqiong@nfschina.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] usb: cdns3: Remove the invalid comment
Message-ID: <20250317032840.GE218167@nchen-desktop>
References: <20250314070921.355986-1-liqiong@nfschina.com>
 <20250314101639.424013-1-liqiong@nfschina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314101639.424013-1-liqiong@nfschina.com>

On 25-03-14 18:16:38, Li Qiong wrote:
> The function don't return value, remove the invalid comment.
> 
> Signed-off-by: Li Qiong <liqiong@nfschina.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

> ---
> v2: Split the first patch to two patches.
> v3: Add changes from the previous version.
> 
>  drivers/usb/cdns3/cdns3-plat.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index 59ec505e198a..735df88774e4 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -179,8 +179,6 @@ static int cdns3_plat_probe(struct platform_device *pdev)
>  /**
>   * cdns3_plat_remove() - unbind drd driver and clean up
>   * @pdev: Pointer to Linux platform device
> - *
> - * Returns 0 on success otherwise negative errno
>   */
>  static void cdns3_plat_remove(struct platform_device *pdev)
>  {
> -- 
> 2.30.2
> 

-- 

Best regards,
Peter

