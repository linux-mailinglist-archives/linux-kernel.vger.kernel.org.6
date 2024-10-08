Return-Path: <linux-kernel+bounces-355441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0939599524C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F9E1F2600B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18A31E00AF;
	Tue,  8 Oct 2024 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grOpUHWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5BA1DEFEC;
	Tue,  8 Oct 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398853; cv=none; b=W98SYFcaVCJQSoS/aAwu9SXVvfjduMXAO8mC+MGqiSCDUDwtnEXcN83gx1nFn85ueWCiAsbj9P8rIe8WGfD9k6H0289AsjmVJolV0fkE2tfUUybyuCmJWQxP3kgf73ZIodKU4jjz8EBfQywjCVt0z05Tfq/6t26U1FjwSfTRlY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398853; c=relaxed/simple;
	bh=QfFpobeCR6oyhKdts5WdzEnhu0SQiWgXU/4CtG5u1CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F21USvQ+QO/XEJsLHY9/fZJOSZchjVvqmn3Z1X020FVEwdIOYWnxtCvLtrj1ZwzKw8uh58eMTHD8ycyzI0mdFRMEGcrYzE3ZVJch+u0H/4BOo5C07a6j9x13umV0VINGi0Gkp5Xqgt63l9F0EYWkG+nKRegjfK9EQKczZxE6F+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grOpUHWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81607C4CEC7;
	Tue,  8 Oct 2024 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728398852;
	bh=QfFpobeCR6oyhKdts5WdzEnhu0SQiWgXU/4CtG5u1CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=grOpUHWpoL2cbNUmBecGE1NeUxgknaF+JnJQXx6332VHNa9mWx/+z7mfmroisVx4B
	 iomQsuAtc50TcWxGHq7Yq6EEdZbZP7bVSil6Q3pZ+UmcFBNqrTFTqW7fxfc/B6SY5C
	 TFKQYG7l+Q6jGYM8jFP0RoVFkbVpbPGLwLuvL+bKYAKJo0gyRMdKL6RQkz6tMizolY
	 0lxCtCB/Jj3y8hIClCzxy841Fa9j1szXJtgH8mzBVmCMAkxSR+N7n+5NwKa7w/MnCU
	 Yl7aPOcmtEKojne7FOeBA7ON7aHjUTvx7T4p6r9ODEXM9o8piCaY7VRCbdOlPKTou6
	 mO0zfHvB+kcHQ==
Date: Tue, 8 Oct 2024 09:47:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Ba Jing <bajing@cmss.chinamobile.com>
Cc: devicetree@vger.kernel.org, saravanak@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of:of_numa: remove unused macro
Message-ID: <172839885045.1298962.14336726735676958404.robh@kernel.org>
References: <20241008060645.36071-1-bajing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008060645.36071-1-bajing@cmss.chinamobile.com>


On Tue, 08 Oct 2024 14:06:45 +0800, Ba Jing wrote:
> By reading the code, I found the marco DEFAULT_NODE is never
> referenced in the code. Just remove it.
> 
> Signed-off-by: Ba Jing <bajing@cmss.chinamobile.com>
> ---
>  drivers/of/of_numa.c | 3 ---
>  1 file changed, 3 deletions(-)
> 

Applied, thanks!


