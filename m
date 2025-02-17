Return-Path: <linux-kernel+bounces-517396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA4AA3803E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43BE169074
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9C3216E06;
	Mon, 17 Feb 2025 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PYq7Rqwh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80321917D7;
	Mon, 17 Feb 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739788319; cv=none; b=U53bwrtaK4Mu1yY2b5dj4S+cm+/iy2pBpiAcLLFStkkM1F+CLw3+2yTO/M3VaMB/7I6VH87qsL/vezmdQl8iSS2HUWtTL6G39qEB1WHPdJ6obRn5WNlrCMNmbfnFh2agqfZlOqrwe+8vPXihMqiUu+d2f42yYtWKjHoNFXOUv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739788319; c=relaxed/simple;
	bh=kNWeVzEdKM2vjX9bON7JjoAEnQKOTqfdp3/XMoeAn9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkPd/o9FPMfoxwho5bLw9ptTmaP163zhD4nSAgf6cGrpBF04xp1lJUWFoSkk7cVPX+htGFcSeLU28+PFax6kuDen5+2vpVHXpKGh8Fura36LgQYJhwLqunC2JUgK2G+rvBDYkEuo8iCbClV91rvgVPC6LQD0RmjPJq+A8jh8uF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PYq7Rqwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C019CC4CED1;
	Mon, 17 Feb 2025 10:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739788318;
	bh=kNWeVzEdKM2vjX9bON7JjoAEnQKOTqfdp3/XMoeAn9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYq7Rqwh350BzNF1zSzPqSGcomuTtI70hAm79ghpTCBnYiusx8OflCZHE1iQeNlTh
	 HW9EkqGeGwYuO9qZGWlUPHoSgZodj4AZFqvf/2r6rFek7zVtWCXARNSIY00o2elir9
	 kwkFAWcDMzqGArHnK0wjqFFmx1ZFWhdG2KtJ8x2Y=
Date: Mon, 17 Feb 2025 11:31:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ravi Kumar kairi <kumarkairiravi@gmail.com>
Cc: dpenkler@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kuba@kernel.org,
	dan.carpenter@linaro.org, rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH 0/4] staging:gpib:agilent_82350b:Cleanup and spelling
 fixes
Message-ID: <2025021729-angular-ignition-0858@gregkh>
References: <20250217100526.49495-1-kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250217100526.49495-1-kumarkairiravi@gmail.com>

On Mon, Feb 17, 2025 at 03:35:09PM +0530, Ravi Kumar kairi wrote:
> From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
> 
> 1. Fixing spelling mistakes such as "havn't" → "haven't"
> 2. Removing unnecessary commented-out code
> 3. Cleaning up whitespace and formatting inconsistencies
> 4. Removing a empty line in if{} which was casuing it be read as single
> line
> 
> These are minor changes aimed at improving code readability and maintainability.
> 
> I appreciate your time in reviewing this series.
> 
> Thanks,  
> Ravi Kumar Kairi
> 
> Ravi Kumar Kairi (4):
>   staging:gpib:agilent_82350b: Fixed spelling error
>   staging:gpib:agilent_82350b: Removed commented out code
>   staging:gpib:agilent_82350b:Removed blank line
>   staging:gpib:agilent_82350b: Fix Indent issue with block
> 
>  .../staging/gpib/agilent_82350b/agilent_82350b.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> -- 
> 2.48.1
> 
> 

Something went wrong with your submission here, look at how these show
up on lore.kernel.org and in my inbox:

 Feb 17 Ravi Kumar kair (0.9K) ┬─>[PATCH 4/4] [PATCH V2 4/4] staging:gpib:agilent_82350b: Fix Indent issue with block
 Feb 17 Ravi Kumar kair (1.5K) ├─>[PATCH 3/4] [PATCH V2 3/4] staging:gpib:agilent_82350b:Removed blank line
 Feb 17 Ravi Kumar kair (1.5K) ├─>[PATCH 2/2] [PATCH V2 3/4] staging:gpib:agilent_82350b:Removed blank line
 Feb 17 Ravi Kumar kair (3.0K) ├─>[PATCH 2/4] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed commented out code
 Feb 17 Ravi Kumar kair (3.0K) └─>[PATCH 1/2] [PATCH V2 2/4] staging:gpib:agilent_82350b: Removed commented out code
 Feb 17 Ravi Kumar kair (0.8K) [PATCH 0/4] staging:gpib:agilent_82350b:Cleanup and spelling fixes
 Feb 17 Ravi Kumar kair (0.9K) └─>[PATCH 1/4] [PATCH V2 1/4] staging:gpib:agilent_82350b: Fixed spelling error

I count 6 patches in a patch series of 4?  And the threading is broken
in a very odd way?

Please fix up and send a proper v3 series.

thanks,

greg k-h

