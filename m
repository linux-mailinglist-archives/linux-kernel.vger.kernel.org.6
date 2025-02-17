Return-Path: <linux-kernel+bounces-517412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A005A38062
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5328818831D3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A295521764D;
	Mon, 17 Feb 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZvygCIoz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064D12135AF;
	Mon, 17 Feb 2025 10:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788757; cv=none; b=O+oJGSZlRaOrIpN9WSUjwO2g48dFp6bHV7bGxf7EqesirflvwXzrhp3o6w+ZePsy3zEsF56VsVW1VcM/P6X2eO5on+bVtzQlwRIYGE5/g6G6yehHVkVEBv8Od7x/TyhhxfdMXvkb7HUe3XODsDQpqO/fVtWto+pT20Chuk0wh2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788757; c=relaxed/simple;
	bh=i5nw3uzsfqERrxdW53BblyO62bMN/J0CY5acf/Q5x8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu7uCCh5wypDAUJfXjv9X5b0gM5sHKrkpEO3CJQzga8ArECQWaMTzabuiuLLaM1TwMe/68BppNafrx0Pp22K/V2EIUaWMguabwpqj5zqs/2fEo6djgaMo7obTSUFJtqcryqqtuOnZLCEWDzcRlPtwaAr9d4FBh0EE8DoDFXdxzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZvygCIoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0974C4CEE2;
	Mon, 17 Feb 2025 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788754;
	bh=i5nw3uzsfqERrxdW53BblyO62bMN/J0CY5acf/Q5x8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZvygCIozU4NfAJrE5eukh1boVjuwX7sk3RFAOlJVaOA259ppDxtgpeBfQySTs3/tM
	 vyvftzXjY5Al1xXbhcnL8A5SB6jFohG1P0q7jB15r1JFtV2KA8bCE0W5OvPBfq1pCw
	 i2m5wSIgPwJf74JCFPzgv3uqwWbF2UhvjYN7lk3c=
Date: Mon, 17 Feb 2025 11:39:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	dan.carpenter@linaro.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH v3 4/4] [PATCH V2 4/4] staging:gpib:agilent_82350b: Fix
 Indent issue with block
Message-ID: <2025021742-shoplift-arrogant-937f@gregkh>
References: <20250217103046.54294-1-kumarkairiravi@gmail.com>
 <20250217103046.54294-5-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217103046.54294-5-kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 04:00:38PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> There was a empty line, which was causing the checkpatch script to think
> it's a single line statment, after removing the empty line it's no
> longer asking to check that line.
> 
> Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> ---
>  drivers/staging/gpib/agilent_82350b/agilent_82350b.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> index b6871eb3c8..1d644d000a 100644
> --- a/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> +++ b/drivers/staging/gpib/agilent_82350b/agilent_82350b.c
> @@ -228,7 +228,6 @@ static int agilent_82350b_accel_write(gpib_board_t *board, uint8_t *buffer, size
>  		return retval;
>  
>  	if (send_eoi) {
> -
>  		retval = agilent_82350b_write(board, buffer + fifotransferlength, 1, send_eoi,
>  					      &num_bytes);
>  		*bytes_written += num_bytes;

The subject line is really odd as this change has nothing to do with
indentation :(

thanks,

greg k-h

