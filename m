Return-Path: <linux-kernel+bounces-519581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F423A39E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D1803B0C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4610269883;
	Tue, 18 Feb 2025 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k4xsONqG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F21243361
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887589; cv=none; b=OTZB2H0RMMtpBKK9zpLmzxS0cO032ij1mHwGMT4pmtdB5WK5h9QI8y/IPEO9maWMck6IjHrMuyMB5OrYsj+7E/W5jOYvYSIAdpV4TntjKZ8YA9/jqxThx3arIKMUam/KXf1aJ7uFHgwEaDKNgIy1uEAVKNsSAZ2a/Dj3aDorSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887589; c=relaxed/simple;
	bh=xnFmSzKhImdD45OJOg5yPaJ5xZrlrKdlclayTb6gCqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TABp8guf3vGZE5YhbfwdgSzz0wEDfn1dfmM+pOS5pVjVakm6tBEj6SlRSgVhDVdOQdSsnZIJxif8eeLUutZrjHe2BjCQAs9WTTkrReaosb/ZBSasj2T9p16PXSM2ExsKrxDRnSBLfwR0kg47VpcLNhF0D6dH1t0i8GRpH0tE44c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k4xsONqG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C111C4CEE7;
	Tue, 18 Feb 2025 14:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739887588;
	bh=xnFmSzKhImdD45OJOg5yPaJ5xZrlrKdlclayTb6gCqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k4xsONqG+zxkqcB42uTHdF0p0kHLK+R9Iqy5ptQE0ymXp8qUh1yD1nG7IC06SFCbb
	 5n54U5Y0e0n7qiTAgTBOueJLIYutn5zlfHK14CO2DGTvyPP34F0a7dJ6UfDVgApqTt
	 MVllw+GsUi9oP1B4MoD+fYHyOW0NQELk2UxuIlGc=
Date: Tue, 18 Feb 2025 15:06:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] CVE-2024-56642: Fix wrong fixes tag and function name in
 commit message.
Message-ID: <2025021831-sixfold-geography-c6e8@gregkh>
References: <2025021818-police-task-b198@gregkh>
 <20250218135344.166491-1-siddh.raman.pant@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218135344.166491-1-siddh.raman.pant@oracle.com>

On Tue, Feb 18, 2025 at 07:23:44PM +0530, Siddh Raman Pant wrote:
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>

Please provide some text here that descibes what is happening.  We can't
just take commits with no information at all, and neither would you want
us to :)

Also, can you break this up into two commits?  The changelog text I'm
going to have to convert into a diff in a different way.

thanks,

greg k-h

