Return-Path: <linux-kernel+bounces-411333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA15D9CF652
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 21:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0B61F21FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF4F1E1C32;
	Fri, 15 Nov 2024 20:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDo2lpXH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977C21BF311;
	Fri, 15 Nov 2024 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731703464; cv=none; b=K2ouHBjWsUKySuSsVUvoVM3Al9gHJEOBo1LIClI51s73wYFwsVxXVCFhIne+8R6lgdlH+Ca5SiP35whbaKtHfIualfoXegzmwJA46RE3SMnLEQtIKc4vaL5KUz0qtHLUAZHQq11u3eOt82i+Pjeaoa58m9K8lJwmBYlC5gXtDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731703464; c=relaxed/simple;
	bh=YKv8qlR50k2LC5KO7h2NGGsnEnAHMHmkAu5g9BMeZww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb2fqzPiD12iSTuLzmpEK+mYvN0fG/NJrxmTHO0rE1DaPIl5PoZaVxitH4VYrcJ2OvhXDP+aPow9qGt97mWXqw1PNsFk6lbBJ7Hf1C/hYPiBzBT81B/smFGEzMVm4oAyYh+3povrR8Z68Ry/c/ZlFyqekD578sZvrzq7n0sNqAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDo2lpXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC4EC4CECF;
	Fri, 15 Nov 2024 20:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731703464;
	bh=YKv8qlR50k2LC5KO7h2NGGsnEnAHMHmkAu5g9BMeZww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IDo2lpXHwzAlFdbUb+A9UooiqxzmOF6PwauIWM6BDnkuNPLs0UUH9jjoGWx54/nwK
	 pcB/9x2oYASh5C7VxwhyTUfs6Lxd3GU7/3ytLHdoIvk+vkjhalBd4va7EWTVfTdt+9
	 CvFtZUSXtKGyPdnjUoQl2rFtCCSFypcEKUKMZjaDGsiA7g6MUboKOI7+EaG4h8O//u
	 Zr9KC/RuXbpIH3Wx+y3HMZqan2++JP7MW3cFAkBgFfSr1udnGHU4iUYb9ZPenQvSqG
	 1tbyQNuSkoFZnKsogs9WVbb1MCyxujp1YTbGnE1R2uCHUCUI52Kft7SeiYClfihJzd
	 rEQiDvaj22PCw==
Date: Fri, 15 Nov 2024 12:44:20 -0800
From: Kees Cook <kees@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: gregkh@linuxfoundation.org, corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	rdunlap@infradead.org, daniel@ffwll.ch,
	laurent.pinchart@ideasonboard.com, broonie@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: Re: [PATCH v4] Documentation/CoC: spell out enforcement for
 unacceptable behaviors
Message-ID: <202411151244.CD2F8AC9A@keescook>
References: <20241114205649.44179-1-skhan@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114205649.44179-1-skhan@linuxfoundation.org>

On Thu, Nov 14, 2024 at 01:56:49PM -0700, Shuah Khan wrote:
> The Code of Conduct committee's goal first and foremost is to bring about
> change to ensure our community continues to foster respectful discussions.
> 
> In the interest of transparency, the CoC enforcement policy is formalized
> for unacceptable behaviors.
> 
> Update the Code of Conduct Interpretation document with the enforcement
> information.
> 
> Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
> Acked-by: Jonathan Corbet <corbet@lwn.net>
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Theodore Ts'o <tytso@mit.edu>
> Acked-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks for working on this!

Acked-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

