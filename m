Return-Path: <linux-kernel+bounces-173713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063AF8C047E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898E128C2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3AC12BEAE;
	Wed,  8 May 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gO3E0DaG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E7F38DE8
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193432; cv=none; b=fM9jMMOvX2bJAvJj99JrqTBd02J/pQHx8eAZMiVm3REvXyNyMoW09pFMLbJceUQmD965pF190Pi4oH8Elsrteu+XgjG8JBxRzi31JcfAoqt7TsWQG6Q83NECD9iGvjOUBafxcMqTk+K+O7QUnLyyREjVuJjs/Y/bCRZK3KLcyk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193432; c=relaxed/simple;
	bh=MciKHbwCRCZocb0y0/ngL+fepdAMO6cqibuETRwWydw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWwo3Wcu2Anm6Haljo3AY33F3KzGjQ4ccZVlmj4CacfPEzrOIhcYttgXN4WCS9pJvAt5o+2wKWIM47Apo0/AfVStbfmDJwm+xLjMtnQMQDRjcjiFTxn3y7gtPpW3Q6mNA715AoLzvs9jrZyM9EDfGJH5O7GmqHZmgawAFm7xE/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gO3E0DaG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35CCC113CC;
	Wed,  8 May 2024 18:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715193432;
	bh=MciKHbwCRCZocb0y0/ngL+fepdAMO6cqibuETRwWydw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gO3E0DaGO73b2f5FcAOfapcvEgsDqp84KD2qorxDRaDQNBO7m2EsJ4qWCEP7oAcsQ
	 shk6DDTYwgQbAPxbYnPhJvDIWKgPQovhe2l6cOd3hR3ElWXZNq1q1VXW7nPsRubvh1
	 ni1mUS+Zw5tsqfQ3Q89NosO3xHH9nXyDMh9H9m9g=
Date: Wed, 8 May 2024 19:36:48 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for v6.10
Message-ID: <2024050838-quicken-oxidation-64fe@gregkh>
References: <baff2bab-3aad-41a6-a0a9-5be64bb2ef43@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baff2bab-3aad-41a6-a0a9-5be64bb2ef43@kernel.org>

On Thu, May 09, 2024 at 02:01:11AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.10. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:
> 
>   Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.10

Pulled and pushed out, thanks.

greg k-h

