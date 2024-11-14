Return-Path: <linux-kernel+bounces-409493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CFB9C8D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E989B2687C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 724921531C1;
	Thu, 14 Nov 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l1AxMmRd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940AA95C;
	Thu, 14 Nov 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596572; cv=none; b=TtcnDttoO091BkSdtX6z14WCbVKQVCumXbgcrWJZJzi2E346uQuWDc9IGxrjlyw5y6Ta0PFPaf5N24gLfGvrTXXD/O7ztirHmbjRy+lLhIrPbN+7FTc2OB2QsenbOa3USX+7s7Xne21GrxkC2L3HVocE9imrwsdneYzqVDAgnC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596572; c=relaxed/simple;
	bh=qkCfLK8TN9LfCtEHifzagUv0rpLufiCXO5LjmnrKp14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKVQZGAfLS+kgyHMpFN0rkXXXhTlZ/xyo2CwFerp8IWpeARpIUOc0cvgeTaldQgJoVL5smdTqQJQ7t+he4+H0RL5I6bG0asuwH87X1OcRCJqlhG0HoPGy7kT53jHAns5ZYdNHCP/V0ayQ830XQxV3OrZ4MjOWJ/rpXEuICxbbTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l1AxMmRd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294F5C4CECD;
	Thu, 14 Nov 2024 15:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731596572;
	bh=qkCfLK8TN9LfCtEHifzagUv0rpLufiCXO5LjmnrKp14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l1AxMmRd/9WD2D08zRN8Wff55wvB7ENnRu1mW5vroki87pay0bOjR7xMhdGjK0vfh
	 5h/iBZqv2ljwBTAym28dAaGjARbkg15HEsCHyfh3+ATSEfv+cj7nChKALB1yrCEPo0
	 6rXSJtsW64SGDfEG+wNZw9mJ86KqfKHoeG0DCjfw=
Date: Thu, 14 Nov 2024 10:02:49 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rdunlap@infradead.org, 
	daniel@ffwll.ch, laurent.pinchart@ideasonboard.com, broonie@kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Dan Williams <dan.j.williams@intel.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
Message-ID: <4d44dry7ypmiglysj5ovrv3zv2g6uabezosck6ae6hkf2wha4i@eculpqwugece>
References: <20241113232557.29854-1-skhan@linuxfoundation.org>
 <5rkn65qu2i3kz72hxbmcg25mrq5ehmb4y6xia2p3k4naiogi44@rcaoz3xnqlcf>
 <2dafc0bb-4dee-4c7e-91b0-01fa66a822aa@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2dafc0bb-4dee-4c7e-91b0-01fa66a822aa@linuxfoundation.org>

On Thu, Nov 14, 2024 at 08:01:34AM -0700, Shuah Khan wrote:
> >      c. restricting their ability to communicate via kernel.org platforms,
> >         such as mailing lists and social media sites
> > 
> > It makes more sense to phrase it this way, because it's really the
> > communication that is the focus of this policy, not general access like git,
> > patchwork, etc.
> > 
> 
> Thank you Konstantin. Correct. The intent is to restrict communication.
> The way you phrased it makes perfect sense. I will make the change.

Thank you!

Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>

-K

