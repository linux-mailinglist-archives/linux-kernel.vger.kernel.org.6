Return-Path: <linux-kernel+bounces-290633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC4D9556A9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434771F21CA4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA854146D45;
	Sat, 17 Aug 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EydyHkwG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80AB146A62;
	Sat, 17 Aug 2024 09:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723885869; cv=none; b=chBeL+Z80G3CJeCBzmm6hZvPHTQXXKrIxuMApnbz8iPg08tmpY93un8vpfI0VCyoT20RTA7lj8Ze9iWssT/qHdzK8A9ECvub0Lt+jEWVA70aGh699Anbq6+UxtGsdLn4ZQyiYQ6fpQO4jc7rW1NUKjFn/uujvrjxvI8XZFkl5lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723885869; c=relaxed/simple;
	bh=eD49Bz72iqX22IdPxS5VMho4CW98DYllXdfyURbFN2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anupRNXUfvdK0OsG7RM/R5v+LSmMwGI7X8rRDcypes/fA79yWpWoGi8q1q7CDgEJlPOb8XREtYq6Q0Ea89zLGcCyUPSCydhjKO+eI2s6OATemtsU754csWJxQ78y7P6Bns12ZOWP/Vo6AttPUXY7mjIjVJmv+kauyyifSASbgW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EydyHkwG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1147CC4AF0C;
	Sat, 17 Aug 2024 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723885868;
	bh=eD49Bz72iqX22IdPxS5VMho4CW98DYllXdfyURbFN2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EydyHkwG8qtbP8XnvVh+VwWEYEQl98J8kazUvNcOu57nHCJNY/R01M+V7sfB1qbI1
	 JRwiZzd+RzpO0bnlBsNKyWHmpteUdfJeR99Tb2mTTs15ftlIpHWdgqDZrFjQEKcm1M
	 ngFkZ1RHudBBn6RK4m2mutaaYR4nylUMLqDwo4cI=
Date: Sat, 17 Aug 2024 11:11:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: ZHANG Yuntian <yt@radxa.com>
Cc: Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add MeiG Smart SRM825L
Message-ID: <2024081718-outdated-surreal-b931@gregkh>
References: <0041DFA5200EFB1B+20240803074619.563116-1-yt@radxa.com>
 <D2E5D3206EC74463+e6e4d3ab-67f2-42e5-93c6-30feb63c7d78@radxa.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D2E5D3206EC74463+e6e4d3ab-67f2-42e5-93c6-30feb63c7d78@radxa.com>

On Sat, Aug 17, 2024 at 04:58:24PM +0800, ZHANG Yuntian wrote:
> This was my first submitted patch so I forgot to run get_maintainer.pl and
> collect the CC list, so I'm sending this out as a reminder.
> 
> qmi_wwan part was accepted a while ago:
> 
> https://git.kernel.org/netdev/net/c/1ca645a2f74a

It is vacation time in Europe for many of us, please give us a few weeks
to get back and catch up with things like this.

thanks,

greg k-h

