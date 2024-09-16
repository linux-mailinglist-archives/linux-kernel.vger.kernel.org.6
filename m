Return-Path: <linux-kernel+bounces-330251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98B9979B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE6FB20E4E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 06:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA65A8287D;
	Mon, 16 Sep 2024 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EdZDsE7G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F07523A9;
	Mon, 16 Sep 2024 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726469540; cv=none; b=cdSDHJOgXZ86Xp3Fy6G5tl8JpHbD9LcJAbLpB2+jc4F5PlbGsUv1xjlGZWe/9I0uKy2belqOSEatmlUf6sZ4kfa5yOXOJJweDWZ7A2mWOnRmI32CkMbY6U0n7i6MMp/oqfRF4yUZQ+GyuDINUGGr/Xhd8hSwbNxllIfed1YndHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726469540; c=relaxed/simple;
	bh=erVwroX0EYxBlfLPn9xaj2JYjfZ/Sfv/EMD4+BSx31o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=suJRR/T9qvKPeTpAiu0+7mMo7XDQmm++7+tsxJPeWywUDT8RRlH8UqE/bXUSh9lV+m6RlS741PBcAwdPEjAlI/XpRllatgef/lFEl8yKbf0WcC2bC5+R1cPRyQ/UUPsbX91GD65c7CKPrDauO0Ju3lKwhpBiARNLzl9+aaRScLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EdZDsE7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3D5C4CEC4;
	Mon, 16 Sep 2024 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726469539;
	bh=erVwroX0EYxBlfLPn9xaj2JYjfZ/Sfv/EMD4+BSx31o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdZDsE7GClnmwz5KFPZf8T1A9FICtG7t85hW/ptGttjIQFtplR/KsyXezqf8mPdj2
	 PZ2ZGfc5tXByTNYO/PRtIb6rpNLUDsXL1CSKfvYYNevT/IYwJ7U9VkDPLI3wLctvy3
	 QN+3lfi6h9GeLZR6Sqteu9sYnUgkGsiS+iW9L/TA=
Date: Mon, 16 Sep 2024 08:52:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Fix spelling errors in file
 drivers/usb/gadget/udc/m66592-udc.c
Message-ID: <2024091639-tasty-relay-5082@gregkh>
References: <2024091626-trailside-grandkid-5f86@gregkh>
 <20240916052357.6487-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916052357.6487-1-everestkc@everestkc.com.np>

On Sun, Sep 15, 2024 at 11:23:56PM -0600, Everest K.C. wrote:
> Fixed spelling errors in error message and comments that
> were reported by codespell as follows:
> 	unexpect  --> unexpected
> 	workaound --> workaround
> 
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>  v1 --> v2: Removed the coding style fix. This patch now only
> 	    fixes spelling errors. The coding style will be fixed
> 	    in a separate patch. 
> 
>  drivers/usb/gadget/udc/m66592-udc.c | 18 +++++++++---------

If you do:
	git log --oneline drivers/usb/gadget/udc/m66592-udc.c
you will see the format for how to properly write the Subject: line
here.

As this is your first kernel contributions, I recommend working in an
area that is designed for new developers to help work through these
types of issues, drivers/staging/  Get some experience there before
moving out into other areas of the kernel.  Also note that many
subsystems do not care about things like spelling fixes, so be careful.

thanks,

greg k-h

