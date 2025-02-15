Return-Path: <linux-kernel+bounces-516317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C204A36F97
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EB03B0442
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC71E5B9A;
	Sat, 15 Feb 2025 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cjDYoPbu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE8F1DD0D4;
	Sat, 15 Feb 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638650; cv=none; b=nSWL+sloaJ4OpVC2Lg6p9pTnMoluh9DcX+pCZdhTb5O9l4Nrjxzq0afFgJFJAQCstKgmQwg16ZMMvI8/tCYqHSkVG+bWcEbs+TsQHb4DwnZBIIESlzyPa9TtlKo+My5W+zhJkPXtqhP0YZdsl5EQrC9jZbi7FgPWC/OBwIRGOzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638650; c=relaxed/simple;
	bh=GXCQN7MT8CGnTqQ/r1HzEwnjX/Ald9z+Yq32owjT0Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cbIEPdfeK0Jz3uIureQT0KiBmdE7EuiPqFBHXriYmJWlunS8CTYc7n5VRvZsMEBS/YoRQ1sfVTd0f8/6dPdcJ1lZnzmNR38FZG3fFvWFI+jCltOdhrB/uhUMGlKf8mBRbvIaHgzToj0i6fvJlBg2Y//cgfJEYQajynqpXXLxCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cjDYoPbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FDFC4CEDF;
	Sat, 15 Feb 2025 16:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739638650;
	bh=GXCQN7MT8CGnTqQ/r1HzEwnjX/Ald9z+Yq32owjT0Oc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cjDYoPbulN4eFAhyWGt+lJUe3eYaieS50A3cyBOVnif3RwWjnucb/8h9xkJ4eFU65
	 dTyGyr0/D2l+TKI9bZiW0Gt7itdmjZ3KzscsTcsvUAVvWUhvZSB5atI50tmnLrxEWt
	 ZGgiwjwuQIX7+2g0zh7IM0FnUOlPisSBc/4zCumw=
Date: Sat, 15 Feb 2025 17:57:26 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian To <onlyian4981@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] stagin: rtl8723bs: fix spacing
Message-ID: <2025021557-unrated-stinger-dcab@gregkh>
References: <cover.1739351267.git.onlyian4981@gmail.com>
 <63dcd7cb7ef3f3e441b63ce0339747abda946f15.1739351267.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63dcd7cb7ef3f3e441b63ce0339747abda946f15.1739351267.git.onlyian4981@gmail.com>

On Wed, Feb 12, 2025 at 01:22:55AM -0800, Ian To wrote:
> Fixed spacing issues. Reported by checkpatch.
> 
> Signed-off-by: Ian To <onlyian4981@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 176 +++++++++---------
>  1 file changed, 87 insertions(+), 89 deletions(-)

Subject line needs a spelling check :(

thanks,

greg k-h

