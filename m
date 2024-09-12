Return-Path: <linux-kernel+bounces-325958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDD0976037
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966721C22E04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2C017C9A4;
	Thu, 12 Sep 2024 05:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="djHC2Qo8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC94180B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726117544; cv=none; b=EIIZzK6GLkaqPY92DRIn69m9nyLQsVq/2+SXTnyURwiZ4ijlTWatpUEq8PH1TbABriX4/xkRraZf8Wfv/yj0KJDvgqhuB3G/qMD9xxvWPAPx9xVKpiRcatr7NaEIhSqF9YBNhXyz3p9OjGfoEm9iz/LaviOlQ7aimrv+w/IXU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726117544; c=relaxed/simple;
	bh=SFcQttXiGlNi5WmB/3zOouWobz3381JurrCHvr4AgWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQrZeBQ9a00yE4OyqfKBKg8ZTavmrNlGNv9Zrz0QR7FY5ycF8ILrAIi9i8v2amWfPIyTuAEx9ar7frLtkCZY9/SjgLu1c9tuVReUF/DhGYUsNqXE30vmSSwt7R6vD5W4ZukWgtyZQzXSWtqwH+9CkFFe1zsqVg08cdf2eyUm1R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=djHC2Qo8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF12C4CEC3;
	Thu, 12 Sep 2024 05:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726117543;
	bh=SFcQttXiGlNi5WmB/3zOouWobz3381JurrCHvr4AgWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=djHC2Qo8bQ8EfeebxA0yBE4qbi/YZjekieuNGuOZjjDkzFgvGksh0zyO5y31A1DSW
	 5fU9lgQEz8gSCsPIhr6NeZA6/JqMRHy/F19Dgqw+mJ3V5+EGqLTFm7tM9ENIOJ2rQq
	 Ol117hkc/MPDG+JXdO2DNxvZG0H4wccVOWRaEMoI=
Date: Thu, 12 Sep 2024 07:05:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting fix for CVE-2024-38545 to linux-5.15.y
Message-ID: <2024091224-deepen-herbal-3961@gregkh>
References: <2c7135e8-c279-4307-8264-179eb69090fe@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c7135e8-c279-4307-8264-179eb69090fe@windriver.com>

On Thu, Sep 12, 2024 at 11:33:47AM +0800, Yan, Haixiao (CN) wrote:
> Hello Greg,
> 
> Could you help to porting
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a942ec2745ca864cd8512142100e4027dc306a42
> 
> to the stable version linux-5.15.y

Please provide a backported, and tested patch, for that and submit it to
stable@vger.kernel.org as the documentation states if you wish to have
it in that kernel version.

And why just 5.15?  Why not older kernels?

thanks,

greg k-h

