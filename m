Return-Path: <linux-kernel+bounces-409465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309809C8D05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC87B337BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A22E84E18;
	Thu, 14 Nov 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jIDKPgaJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1347210FB;
	Thu, 14 Nov 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595084; cv=none; b=gz98iih16oOube/+iknuWICSg5tN98OUDs7fjKQbo544+23NK9n2tLhrdLqHz1S9yM7Dx6H7CPNNw+NMr2caZbePBcK/vt0XMcdEL7hLQMBk46R1EEJ2Idbeu/W5r2LEtB5pYkoSVKFSt6r+BO2OeGNkfV/3egXUpN5opcY7xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595084; c=relaxed/simple;
	bh=RGNh4jzl+kH1ih7bBrAZ7eWM/S4wEjjd0r+yjtwML7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7Hx2EcZ4ca61lJj5N1Mji3dRC6pM6gmhGulyyYLRESkvTqtY/iRztkOBz5QiuzyX4s/AW08gKvi8njzyfl9tF6frmcLUIGR3Ech6BgwJqqoXentHg1ertBZaWIyQ3DOoNJZ/vtJXHMZfKV8Oj0sgJQHhv90xMgCQNdx05ws+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jIDKPgaJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2935FC4CECD;
	Thu, 14 Nov 2024 14:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731595083;
	bh=RGNh4jzl+kH1ih7bBrAZ7eWM/S4wEjjd0r+yjtwML7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIDKPgaJcd/74rP03ZBqkobbvO5GYyXyTJCLw6PtM2Cfz4dgXu8GhaFXJzpy1xX4H
	 KeawxI4O8NTJ8i5NYOWe2b2SsWozQ3wuK7vaE7r3WjqhvrJh/08HaBEL6YbL5Z/fZg
	 ydcDqgNtWE6w2DB7EMnZCVU/JBoFYh7+WQ0fSeto=
Date: Thu, 14 Nov 2024 09:38:00 -0500
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
Message-ID: <5rkn65qu2i3kz72hxbmcg25mrq5ehmb4y6xia2p3k4naiogi44@rcaoz3xnqlcf>
References: <20241113232557.29854-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113232557.29854-1-skhan@linuxfoundation.org>

On Wed, Nov 13, 2024 at 04:25:57PM -0700, Shuah Khan wrote:
> +The scope of the ban for a period of time could include:
> +
> +    a. denying patch contributions and pull requests
> +    b. pausing collaboration with the violator by ignoring their
> +       contributions and/or blocking their email account(s)
> +    c. blocking their access to kernel.org accounts and mailing lists

Can we change this to:

    c. restricting their ability to communicate via kernel.org platforms,
       such as mailing lists and social media sites

It makes more sense to phrase it this way, because it's really the
communication that is the focus of this policy, not general access like git,
patchwork, etc.

-K

