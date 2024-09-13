Return-Path: <linux-kernel+bounces-327572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8F29777D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFD5B24C31
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E11B3F17;
	Fri, 13 Sep 2024 04:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rkp4LbrW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5278B4E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 04:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201154; cv=none; b=ht2J3nun+7WOHvhmEyx4jHGIKTPaGAJPWr9l2nsK4cYFqCFGtX35cPqRztvvJwOqgVRtd+zNYOnxKSWZoSfC9QCevtm1M+hxtmNir0Mr3+p0vAESyAeJpEP8rhgVAI1b2c5gTzInGWibEq25UZ79Pj5WMu3kqunHGU+sPlqElgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201154; c=relaxed/simple;
	bh=ImVHjjDxkkypI4LjM0017xsItF6cUS3M2P/ttPP3Q6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HG130UGZpFqRKMhfd9Gx/yS0IEVtyD0eumo0tiABLwltG7Dg7VWC/IbFnkON7jWS1UVDSv+ReuofXTKK63PEssgsC07b6ZfEvwUzWfytBDM8NPl/FL6nzu6F9SVUzUJqF+KcROb5aw4mcksWySh5aC+PpSC1YlPtP7aCETvAqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rkp4LbrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF25C4CEC0;
	Fri, 13 Sep 2024 04:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726201153;
	bh=ImVHjjDxkkypI4LjM0017xsItF6cUS3M2P/ttPP3Q6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rkp4LbrWe7KXFmHomLH+KAwrCCCcLlf1Rr+k+pdWhXiIU5FSrsfMCJbccCSoNPpXt
	 djEEVkTGiURI7TzknRK+m9fil5+9kWg9tmojPx1/diRNi94nGqE4bTWXkuGiykXUCs
	 d19T0KC/dtup16cqTqYwpq5A/z24UUEfQ6A0MQ1o=
Date: Fri, 13 Sep 2024 06:19:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Yan, Haixiao (CN)" <haixiao.yan.cn@windriver.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting fix for CVE-2024-38545 to linux-5.15.y
Message-ID: <2024091338-diary-unsorted-46c2@gregkh>
References: <2c7135e8-c279-4307-8264-179eb69090fe@windriver.com>
 <2024091224-deepen-herbal-3961@gregkh>
 <b8b86241-4452-4096-b862-cf3e2fca6b1c@windriver.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b86241-4452-4096-b862-cf3e2fca6b1c@windriver.com>

Please do not top-post.

On Fri, Sep 13, 2024 at 11:22:01AM +0800, Yan, Haixiao (CN) wrote:
> Thanks, I will submit the patch to 5.15.
> 
> As I am currently using the 5.15.

What are you plans to move to a more modern kernel version?  You should
do that soon.

thanks,

greg k-h

