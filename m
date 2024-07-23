Return-Path: <linux-kernel+bounces-259716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 607CF939BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 920791C21B53
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2BA14B07A;
	Tue, 23 Jul 2024 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1j8CuDuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A715F3D6A;
	Tue, 23 Jul 2024 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721720886; cv=none; b=EoLv2o5N2SoefmR5MlxUgZLQU7/Z8yAgLvmylr1OxX7pMmhyucVY474MphltzdFNQbv4Tl5ZfH/DhCvl4XdxFHiamq5Day/SdoJeu+YjRPxG2fr0aw6UOdylTTX7evIHyUbijuYazcIvQACNmhFq0m1SA7G8qe62LE+J5rJvvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721720886; c=relaxed/simple;
	bh=lw5BRIxdZhgSbYdabgpVUzM7vRVd60aH0Xo/ulGphnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAMif2kFE6pH7jd2FJWg6U9bR8OgciPc4eq2ou48D3BYyOMJlV7J/R1CzyT1gHfKUv0Hvu8+ZRxOKxA2pC8liugSP5yyuP/uls9IWMGXrmrnq5QT9SL+argz70BacFRjMF+lvZ/ytt52Fh9quljIgYMTqWNHwzzrSUCqRt68Xbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1j8CuDuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF8EC4AF0B;
	Tue, 23 Jul 2024 07:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721720886;
	bh=lw5BRIxdZhgSbYdabgpVUzM7vRVd60aH0Xo/ulGphnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1j8CuDuLBCvrEKyKmZvbO6ICKZIPAUFOnZFt3yobWZ2bweTJqDRehoV44rt+n1YrN
	 lQASGTkETcMNk1ip7Nx6HIw9KMDJ4SrKHcgYfN8J8T4odePto3vsOI1z+G+9vhdH9t
	 nhFd4tNi+LnVi/uEzzsnrfDdQ2iriMFRmf1qts9k=
Date: Tue, 23 Jul 2024 09:48:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Steven Davis <goldside000@outlook.com>
Cc: christian.gromm@microchip.com, parthiban.veerasooran@microchip.com,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Capitalized "c" to "C" and changed "expect" to
 "expected"
Message-ID: <2024072344-ripeness-ablaze-43bf@gregkh>
References: <SJ2P223MB1026B72D6CED70A91E8E55CCF7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ2P223MB1026B72D6CED70A91E8E55CCF7A82@SJ2P223MB1026.NAMP223.PROD.OUTLOOK.COM>

On Mon, Jul 22, 2024 at 12:59:44PM -0400, Steven Davis wrote:
> This patch makes three error messages in the driver easier to read by capitalizing the first letters properly.

Please wrap your changelog text at 72 characters, checkpatch should have
caught this, right?

> For example, "channel already linked" became "Channel already linked".
> In addition, "expect" becomes "expected", as you would typically find in an error message.

When you have "in addition" that usually means you should split this up
into different changes, rigth?

> This patch is necessary for improving user experience and the kernel's quality.

This isn't a quality thing, it's a "spelling fixes are nice" thing.

Also, please fix up the subject line to match those that have been made
to this file in the past with the correct prefix.

thanks,

greg k-h

