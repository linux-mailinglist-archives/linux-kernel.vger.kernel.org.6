Return-Path: <linux-kernel+bounces-541395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F21CFA4BC87
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9039D7A97EA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57D1F1905;
	Mon,  3 Mar 2025 10:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w6/g1iBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA65C1D79A3;
	Mon,  3 Mar 2025 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998172; cv=none; b=V43D1YkK7BUvwfmEbsX7AVHmA+JzfdDw5OO6th6uj1lvAVCugK+VAaspMUYL2rpvdeYluwi8Mx/D12qkDL+eJAqXDN14k7ZgMAI2nCjs0crJqY2i8LvErJ0jT43b9PwvC7RykpGvvoidfuCfHGs0/bxN/eJdxECu3ivZNeHgqH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998172; c=relaxed/simple;
	bh=4ZLJ88eLpjxcFeAJPWCweqX5sCqk+oeSOeyyKa9Uhns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNTRk1ENCh/sHUzqtDwMEHb+qNHnrtX0CkSOLHSqQe0gvHBlzfh5c1E82dDVC48R9exd7eUJfS1s43Eh4I9FjcTLlE1g0J6lGvQk9kpX9mL+FZd+b8l0ihAt4Q2AfHSvVAQHcRhTOSz4NdPb4zm/uBMUseoAVUsSKouQ3tzIw6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w6/g1iBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB048C4CED6;
	Mon,  3 Mar 2025 10:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740998170;
	bh=4ZLJ88eLpjxcFeAJPWCweqX5sCqk+oeSOeyyKa9Uhns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w6/g1iBgVdM9Fc/HNy6hecLirSE2+xMrzUtm0rPsbBVngtcwoyu6+MxGCqm873Lmc
	 ciH3hwgKthWL0TvyjplNbsle9KcmP06Uq04bX/1zBVnIyVF59ix1f3nd4iqIXyI8Rb
	 7Ha8RFmxKPoQGISusuAz99VZ4Cv5Y6aYfsLjvPX4=
Date: Mon, 3 Mar 2025 11:36:05 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: raoxu <raoxu@uniontech.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, wangyuli@uniontech.com,
	zhanjun@uniontech.com
Subject: Re: [PATCH] From: Xu Rao <raoxu@uniontech.com> Subject: [PATCH] usb:
 xhci: Add debugfs support for xHCI port bandwidth
Message-ID: <2025030345-hash-crunching-5306@gregkh>
References: <20250303095837.16332-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303095837.16332-1-raoxu@uniontech.com>

On Mon, Mar 03, 2025 at 05:58:37PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> In many projects, you need to obtain the available bandwidth of the
> xhci roothub port. Refer to xhci rev1_2 and use the TRB_GET_BW
> command to obtain it.

<snip>

The subject line is very odd, can you please fix that up and resend a v2
patch?

thanks,

greg k-h

